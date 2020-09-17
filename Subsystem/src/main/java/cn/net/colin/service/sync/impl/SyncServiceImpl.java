package cn.net.colin.service.sync.impl;

import cn.net.colin.common.Constants;
import cn.net.colin.common.aop.DataSourceAnnotation;
import cn.net.colin.common.exception.entity.ResultCode;
import cn.net.colin.common.exception.entity.ResultInfo;
import cn.net.colin.common.helper.RedisLock;
import cn.net.colin.common.util.DynamicDataSourceSwitcher;
import cn.net.colin.common.util.JsonUtils;
import cn.net.colin.model.sync.SyncData;
import cn.net.colin.model.sync.SyncDataItem;
import cn.net.colin.model.sync.SyncDataItemCriteria;
import cn.net.colin.service.common.ICommonservice;
import cn.net.colin.service.sync.ISyncDataItemService;
import cn.net.colin.service.sync.ISyncDataService;
import cn.net.colin.service.sync.ISyncService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @Package: cn.net.colin.service.sync.impl
 * @Author: sxf
 * @Date: 2020-9-7
 * @Description:
 */
@Service
public class SyncServiceImpl implements ISyncService {
    @Value("${spring.application.name}")
    private String applicationName;

    @Autowired
    private ISyncDataItemService syncDataItemService;
    @Autowired
    private ISyncDataService syncDataService;
    @Autowired
    private RedisLock redisLock;
    @Autowired
    private ICommonservice commonservice;

    @Override
    @Async("sentinelSimpleAsync")
    public void doSyncAsync(Long syncDataId) {
        try{
            /**
             * 首先查询同步记录表中是否存在id比当前syncDataId小的同步失败记录
             *      如果有则忽略执行本次同步（说明之前有同步失败的记录未处理，需要人工处理），因为数据同步一定要顺序执行，否则可能出现问题
             */
            SyncDataItemCriteria syncDataItemCriteria = new SyncDataItemCriteria();
            syncDataItemCriteria.createCriteria()
                    .andApplicationNameEqualTo(applicationName)
                    .andIdLessThan(syncDataId)
                    .andSyncStatusEqualTo(2);//同步失败
            SyncDataItemCriteria.Criteria orCriteria = syncDataItemCriteria.createCriteria();
            orCriteria.andApplicationNameEqualTo(applicationName);
            orCriteria.andIdLessThan(syncDataId);
            orCriteria.andSyncStatusEqualTo(3);//推送失败
            syncDataItemCriteria.or(orCriteria);
            DynamicDataSourceSwitcher.setDataSource(DynamicDataSourceSwitcher.portal);
            List<SyncDataItem> syncDataItems = syncDataItemService.selectByExample(syncDataItemCriteria);
            if (syncDataItems == null || (syncDataItems != null && syncDataItems.size() == 0)) {//说明之前没有未处理的失败记录
                //获取当前待同步记录数据
                SyncData syncData = syncDataService.selectByPrimaryKey(syncDataId);
                String jsonData = syncData.getInfoContent().trim();
                if (jsonData != null && !jsonData.equals("")) {
                    List<Map<String,Object>> syncDataList = JsonUtils.nativeRead(jsonData,new TypeReference<List<Map<String, Object>>>() {});
                    boolean lock = false;
                    try {
                        //为了防止多线程同步顺序错乱，这里使用全局锁。设置锁的失效时间为180s，获取锁的等待时间为600s。(一次推送最多1千条记录，180s足够处理了)
                        lock = redisLock.lock(Constants.SYNCDATA_LOCK, 180, 600000);
                    }catch (Exception e){
                        //获取锁失败，则更新同步状态为失败，等待人工干预处理
                        updateSyncDataItemStatus(syncDataId,2);
                        e.printStackTrace();
                        return;
                    }
                    if (lock) {
                        try {
                            //获取到锁之后重新判断该条记录状态，若果是待同步，则执行同步，如果已经被同步（人工处理等）则跳过
                            SyncDataItemCriteria queryCriteria = new SyncDataItemCriteria();
                            queryCriteria.createCriteria()
                                    .andApplicationNameEqualTo(applicationName)
                                    .andDataIdEqualTo(syncDataId);
                            List<SyncDataItem> dataItems = syncDataItemService.selectByExample(queryCriteria);
                            if(dataItems != null && dataItems.size() > 0 && dataItems.get(0).getSyncStatus() != 1){
                                DynamicDataSourceSwitcher.cleanDataSource();
                                //获取锁成功，执行同步业务
                                commonservice.saveSyncData(syncDataList);
                                //同步完成，更新同步记录状态
                                DynamicDataSourceSwitcher.setDataSource(DynamicDataSourceSwitcher.portal);
                                updateSyncDataItemStatus(syncDataId,1);
                            }
                        }catch (Exception e){
                            //本地执行同步sql失败，更新同步状态为失败，等待人工干预处理
                            DynamicDataSourceSwitcher.setDataSource(DynamicDataSourceSwitcher.portal);
                            updateSyncDataItemStatus(syncDataId,2);
                            e.printStackTrace();
                        }finally {
                            //只有获取锁成功才执行释放锁，如果释放锁的操作放到if(lock)之外，可能会造成if(lock)内的业务处理没有执行完;
                            //而另外一个线程获取锁失败执行了释放锁操作，然后再有一个线程又获取到了锁，进入if(lock) 此时if(lock)内有两个线程。
                            //当然，如果if(lock)内部业务处理时间超过了锁的失效时间（expireMsecs），也会出现if(lock)内有多个线程；所以要根据实际情况设置合理的失效时间以及获取锁超时时间。
                            redisLock.unlock(Constants.SYNCDATA_LOCK);
                        }
                    } else {
                        //获取锁失败，则更新同步状态为失败，等待人工干预处理
                        updateSyncDataItemStatus(syncDataId,2);
                    }
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DynamicDataSourceSwitcher.cleanDataSource();
        }
    }
    @Override
    public boolean doSync(Long syncDataId) {
        //同步是否成功
        boolean syncSuccess = false;
        try{
            /**
             * 首先查询同步记录表中是否存在id比当前syncDataId小的同步失败记录
             *      如果有则忽略执行本次同步（说明之前有同步失败的记录未处理，需要人工处理），因为数据同步一定要顺序执行，否则可能出现问题
             */
            SyncDataItemCriteria syncDataItemCriteria = new SyncDataItemCriteria();
            syncDataItemCriteria.createCriteria()
                    .andApplicationNameEqualTo(applicationName)
                    .andIdLessThan(syncDataId)
                    .andSyncStatusEqualTo(2);//同步失败
            SyncDataItemCriteria.Criteria orCriteria = syncDataItemCriteria.createCriteria();
            orCriteria.andApplicationNameEqualTo(applicationName);
            orCriteria.andIdLessThan(syncDataId);
            orCriteria.andSyncStatusEqualTo(3);//推送失败
            syncDataItemCriteria.or(orCriteria);
            DynamicDataSourceSwitcher.setDataSource(DynamicDataSourceSwitcher.portal);
            List<SyncDataItem> syncDataItems = syncDataItemService.selectByExample(syncDataItemCriteria);
            if (syncDataItems == null || (syncDataItems != null && syncDataItems.size() == 0)) {//说明之前没有未处理的失败记录
                //获取当前待同步记录数据
                SyncData syncData = syncDataService.selectByPrimaryKey(syncDataId);
                String jsonData = syncData.getInfoContent().trim();
                if (jsonData != null && !jsonData.equals("")) {
                    List<Map<String,Object>> syncDataList = JsonUtils.nativeRead(jsonData,new TypeReference<List<Map<String, Object>>>() {});
                    boolean lock = false;
                    try {
                        //为了防止多线程同步顺序错乱，这里使用全局锁。设置锁的失效时间为180s，获取锁的等待时间为600s。(一次推送最多1千条记录，180s足够处理了)
                        lock = redisLock.lock(Constants.SYNCDATA_LOCK, 180, 600000);
                    }catch (Exception e){
                        //获取锁失败，则更新同步状态为失败，等待人工干预处理
                        updateSyncDataItemStatus(syncDataId,2);
                        e.printStackTrace();
                        return syncSuccess;
                    }
                    if (lock) {
                        try {
                            //获取到锁之后重新判断该条记录状态，若果是待同步，则执行同步，如果已经被同步（人工处理等）则跳过
                            SyncDataItemCriteria queryCriteria = new SyncDataItemCriteria();
                            queryCriteria.createCriteria()
                                    .andApplicationNameEqualTo(applicationName)
                                    .andDataIdEqualTo(syncDataId);
                            List<SyncDataItem> dataItems = syncDataItemService.selectByExample(queryCriteria);
                            if(dataItems != null && dataItems.size() > 0 && dataItems.get(0).getSyncStatus() != 1){
                                DynamicDataSourceSwitcher.cleanDataSource();
                                //获取锁成功，执行同步业务
                                commonservice.saveSyncData(syncDataList);
                                syncSuccess = true;
                                //同步完成，更新同步记录状态
                                DynamicDataSourceSwitcher.setDataSource(DynamicDataSourceSwitcher.portal);
                                updateSyncDataItemStatus(syncDataId,1);
                            }
                        }catch (Exception e){
                            //本地执行同步sql失败，更新同步状态为失败，等待人工干预处理
                            DynamicDataSourceSwitcher.setDataSource(DynamicDataSourceSwitcher.portal);
                            updateSyncDataItemStatus(syncDataId,2);
                            e.printStackTrace();
                        }finally {
                            //只有获取锁成功才执行释放锁，如果释放锁的操作放到if(lock)之外，可能会造成if(lock)内的业务处理没有执行完;
                            //而另外一个线程获取锁失败执行了释放锁操作，然后再有一个线程又获取到了锁，进入if(lock) 此时if(lock)内有两个线程。
                            //当然，如果if(lock)内部业务处理时间超过了锁的失效时间（expireMsecs），也会出现if(lock)内有多个线程；所以要根据实际情况设置合理的失效时间以及获取锁超时时间。
                            redisLock.unlock(Constants.SYNCDATA_LOCK);
                        }
                    } else {
                        //获取锁失败，则更新同步状态为失败，等待人工干预处理
                        updateSyncDataItemStatus(syncDataId,2);
                    }
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DynamicDataSourceSwitcher.cleanDataSource();
        }
        return syncSuccess;
    }

    @Override
    @DataSourceAnnotation(DynamicDataSourceSwitcher.portal)
    public ResultInfo syncRecordListData(Map<String,Object> paramMap) {
        SyncDataItemCriteria syncDataItemCriteria = new SyncDataItemCriteria();
        syncDataItemCriteria.createCriteria()
                .andApplicationNameEqualTo(applicationName);
        syncDataItemCriteria.setOrderByClause("sync_status desc,id asc");
        int pageNum = paramMap.get("page") == null ? 1 : Integer.parseInt(paramMap.get("page").toString());
        int pageSize = paramMap.get("limit") == null ? 10 : Integer.parseInt(paramMap.get("limit").toString());
        PageHelper.startPage(pageNum,pageSize);
        List<SyncDataItem> syncDataItems = syncDataItemService.selectByExample(syncDataItemCriteria);
        PageInfo<SyncDataItem> result = new PageInfo(syncDataItems);
        return ResultInfo.ofDataAndTotal(ResultCode.SUCCESS,syncDataItems,result.getTotal());
    }

    /**
     * 更新 SyncDataItem 状态
     * @param syncDataId
     * @param status
     */
    public void updateSyncDataItemStatus(Long syncDataId,int status){
        SyncDataItemCriteria updateSyncDataItemCriteria = new SyncDataItemCriteria();
        SyncDataItemCriteria.Criteria updateCriteria = updateSyncDataItemCriteria.createCriteria();
        updateCriteria.andDataIdEqualTo(syncDataId);
        updateCriteria.andApplicationNameEqualTo(applicationName);
        List<SyncDataItem> syncDataItems = syncDataItemService.selectByExample(updateSyncDataItemCriteria);
        if(syncDataItems != null && syncDataItems.size() > 0){
            SyncDataItem syncDataItem = syncDataItems.get(0);
            syncDataItem.setSyncStatus(status);
            syncDataItem.setSyncTime(new Date());
            syncDataItemService.updateByPrimaryKeySelective(syncDataItem);
        }
    }
}
