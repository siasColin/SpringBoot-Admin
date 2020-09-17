package cn.net.colin.service.canal.impl;

import cn.net.colin.common.exception.entity.ResultInfo;
import cn.net.colin.common.util.IdWorker;
import cn.net.colin.mapper.applicationManage.SysApplicationMapper;
import cn.net.colin.mapper.canal.CanalMapper;
import cn.net.colin.mapper.sync.SyncDataItemMapper;
import cn.net.colin.mapper.sync.SyncDataMapper;
import cn.net.colin.model.applicationManage.SysApplication;
import cn.net.colin.model.applicationManage.SysApplicationCriteria;
import cn.net.colin.model.sync.SyncData;
import cn.net.colin.model.sync.SyncDataItem;
import cn.net.colin.model.sync.SyncDataItemCriteria;
import cn.net.colin.model.sysManage.SysArea;
import cn.net.colin.service.canal.ICanalService;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.util.*;

/**
 * @Package: cn.net.colin.service.canal.impl
 * @Author: sxf
 * @Date: 2020-9-5
 * @Description:
 */
@Service
public class CanalServiceImpl implements ICanalService {
    private static final Logger logger = LoggerFactory.getLogger(CanalServiceImpl.class);
    @Autowired
    private CanalMapper canalMapper;
    @Autowired
    private SyncDataMapper syncDataMapper;
    @Autowired
    private SyncDataItemMapper syncDataItemMapper;
    @Autowired
    private SysApplicationMapper sysApplicationMapper;

    @Autowired
    private RestTemplate restTemplate;


    @Override
    public SysArea getAreaById(Long id) {
        Thread thread = Thread.currentThread();
        System.out.println("++++++++++++++++++++++++++++++"+thread.getName());
        return canalMapper.selectByPrimaryKey(id);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public long saveSyncData(JSONArray jarData) {
        long syncDataId = IdWorker.getInstance().nextId();
        SyncData syncData = new SyncData();
        syncData.setId(syncDataId);
        syncData.setInfoContent(JSON.toJSONString(jarData));
        syncData.setCreateTime(new Date());
        syncDataMapper.insert(syncData);
        //查询子系统，保存子系统同步记录表
        SysApplicationCriteria sysApplicationCriteria = new SysApplicationCriteria();
        List<SysApplication> sysApplications = sysApplicationMapper.selectByExample(sysApplicationCriteria);
        List<SyncDataItem> syncDataItems = new ArrayList<SyncDataItem>();
        if(sysApplications != null && sysApplications.size() > 0){
            for (SysApplication sysApplication : sysApplications) {
                SyncDataItem syncDataItem = new SyncDataItem();
                syncDataItem.setId(IdWorker.getInstance().nextId());
                syncDataItem.setDataId(syncDataId);
                syncDataItem.setApplicationName(sysApplication.getApplicationName());
                syncDataItem.setSyncStatus(0);
                syncDataItem.setCreateTime(new Date());
                syncDataItems.add(syncDataItem);
            }
        }
        if(syncDataItems != null && syncDataItems.size() > 0){
            syncDataItemMapper.insertBatchSelective(syncDataItems);
        }
        return syncDataId;
    }

    @Override
    @Async("sentinelSimpleAsync")
    public void noticeApplications(long syncDataId) {
        SysApplicationCriteria sysApplicationCriteria = new SysApplicationCriteria();
        List<SysApplication> sysApplications = sysApplicationMapper.selectByExample(sysApplicationCriteria);
        if(sysApplications != null && sysApplications.size() > 0){
            // 封装参数，千万不要替换为Map与HashMap，否则参数无法传递
            MultiValueMap<String, Object> paramMap = new LinkedMultiValueMap<String, Object>();
            paramMap.add("syncDataId", syncDataId);
            for (SysApplication sysApplication : sysApplications) {
                String applicationUrl = sysApplication.getApplicationUrl();
                try{
                    ResultInfo resultInfo = restTemplate.postForObject(applicationUrl+"/sync/client", paramMap, ResultInfo.class);
                    if(!"0".equals(resultInfo.getReturnCode())){//0 成功，非0失败
                        updateSyncDataItemStatus(syncDataId,sysApplication.getApplicationName(),3);
                    }
                }catch (Exception e){
                    updateSyncDataItemStatus(syncDataId,sysApplication.getApplicationName(),3);
                    e.printStackTrace();
                }
            }

        }
    }

    /**
     * 更新 SyncDataItem 状态
     * @param syncDataId
     * @param status
     */
    public void updateSyncDataItemStatus(Long syncDataId,String applicationName,int status){
        SyncDataItemCriteria updateSyncDataItemCriteria = new SyncDataItemCriteria();
        SyncDataItemCriteria.Criteria updateCriteria = updateSyncDataItemCriteria.createCriteria();
        updateCriteria.andDataIdEqualTo(syncDataId);
        updateCriteria.andApplicationNameEqualTo(applicationName);
        List<SyncDataItem> syncDataItems = syncDataItemMapper.selectByExample(updateSyncDataItemCriteria);
        if(syncDataItems != null && syncDataItems.size() > 0){
            SyncDataItem syncDataItem = syncDataItems.get(0);
            syncDataItem.setSyncStatus(status);
            syncDataItemMapper.updateByPrimaryKeySelective(syncDataItem);
        }
    }
}
