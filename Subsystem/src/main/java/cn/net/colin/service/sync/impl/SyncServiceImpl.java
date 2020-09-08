package cn.net.colin.service.sync.impl;

import cn.net.colin.common.Constants;
import cn.net.colin.common.helper.RedisLock;
import cn.net.colin.common.util.DynamicDataSourceSwitcher;
import cn.net.colin.common.util.JsonUtils;
import cn.net.colin.model.sync.SyncData;
import cn.net.colin.model.sync.SyncDataItem;
import cn.net.colin.model.sync.SyncDataItemCriteria;
import cn.net.colin.service.common.CommonServiceImpl;
import cn.net.colin.service.common.ICommonservice;
import cn.net.colin.service.sync.ISyncDataItemService;
import cn.net.colin.service.sync.ISyncDataService;
import cn.net.colin.service.sync.ISyncService;
import com.fasterxml.jackson.core.type.TypeReference;
import org.springframework.aop.framework.AopContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

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
    public void doSync(Long syncDataId) {
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
            orCriteria.andSyncStatusEqualTo(-1);//推送失败
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
                            DynamicDataSourceSwitcher.cleanDataSource();
                            //获取锁成功，执行同步业务
                            commonservice.saveSyncData(syncDataList);
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
            syncDataItemService.updateByPrimaryKeySelective(syncDataItem);
        }
    }
}
