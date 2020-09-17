package cn.net.colin.controller.syncClient;

import cn.net.colin.common.exception.entity.ResultCode;
import cn.net.colin.common.exception.entity.ResultInfo;
import cn.net.colin.common.util.SQLUtil;
import cn.net.colin.model.sync.SyncData;
import cn.net.colin.model.sync.SyncDataItem;
import cn.net.colin.model.sync.SyncDataItemCriteria;
import cn.net.colin.service.sync.ISyncDataItemService;
import cn.net.colin.service.sync.ISyncDataService;
import cn.net.colin.service.sync.ISyncService;
import com.alibaba.druid.sql.SQLUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @Package: cn.net.colin.controller.syncClient
 * @Author: sxf
 * @Date: 2020-9-15
 * @Description:
 */
@Controller
@RequestMapping("/syncRecord")
public class SyncRecordController {
    @Autowired
    private ISyncService syncService;

    @Autowired
    private ISyncDataService syncDataService;
    @Autowired
    private ISyncDataItemService syncDataItemService;
    @Value("${spring.application.name}")
    private String applicationName;

    @GetMapping("/syncRecordList")
    public String syncRecordList(){
        return "syncRecord/syncRecordList";
    }
    @GetMapping("/syncRecordListData")
    @ResponseBody
    public ResultInfo syncRecordListData(@RequestParam Map<String,Object> paramMap){
        return  syncService.syncRecordListData(paramMap);
    }

    @GetMapping("/syncData/{dataId}")
    public String syncData(@PathVariable("dataId") Long dataId, Map<String,Object> modelMap){
        SyncData syncData = syncDataService.selectByPrimaryKey(dataId);
        String sql = SQLUtil.getSqlByJson(syncData.getInfoContent());
        modelMap.put("syncData",syncData);
        modelMap.put("sqlStr",sql);
        return "syncRecord/syncDataDetails";
    }

    /**
     * 执行同步-单条记录
     * @param dataId
     * @return
     */
    @PostMapping("/syncData/{dataId}")
    @ResponseBody
    public ResultInfo syncData(@PathVariable("dataId") Long dataId){
        syncService.doSync(dataId);
        return ResultInfo.of(ResultCode.SUCCESS);
    }

    /**
     * 批量同步所有未同步记录
     * @return
     */
    @PostMapping("/syncDataAll")
    @ResponseBody
    public ResultInfo syncDataAll(){
        //查询所有需要同步的记录
        SyncDataItemCriteria syncDataItemCriteria = new SyncDataItemCriteria();
        syncDataItemCriteria.setOrderByClause("id asc");
        List<Integer> statusList = new ArrayList<Integer>();
        statusList.add(0);//待同步
        statusList.add(2);//同步失败
        statusList.add(3);//推送失败
        syncDataItemCriteria.createCriteria().andApplicationNameEqualTo(applicationName).andSyncStatusIn(statusList);
        List<SyncDataItem> syncDataItems = syncDataItemService.selectByExample(syncDataItemCriteria);
        if(syncDataItems != null && syncDataItems.size() > 0){
            for (int i = 0; i < syncDataItems.size(); i++) {
                boolean syncSuccess = syncService.doSync(syncDataItems.get(i).getDataId());
                if(!syncSuccess){//同步失败
                    return ResultInfo.of(ResultCode.SYNC_ERROR);
                }
            }
        }
        return ResultInfo.of(ResultCode.SUCCESS);
    }
    /**
     * 忽略一条更新记录
     * @param id
     * @return
     */
    @PutMapping("/syncDataItem/{id}")
    @ResponseBody
    public ResultInfo syncDataItem(@PathVariable("id") Long id){
        SyncDataItem syncDataItem = new SyncDataItem();
        syncDataItem.setId(id);
        syncDataItem.setSyncStatus(-1);//已忽略
        syncDataItemService.updateByPrimaryKeySelective(syncDataItem);
        return ResultInfo.of(ResultCode.SUCCESS);
    }
}
