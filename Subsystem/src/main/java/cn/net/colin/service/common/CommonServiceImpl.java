package cn.net.colin.service.common;

import cn.net.colin.mapper.common.CommonMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Package: cn.net.colin.service.common
 * @Author: sxf
 * @Date: 2020-3-29
 * @Description:
 */
@Service
public class CommonServiceImpl implements ICommonservice{

    @Autowired
    private CommonMapper commonMapper;

    @Override
    public boolean fromVerifyByCode(Map<String, Object> map) {
        List<Map<String,Object>> listCode = commonMapper.fromVerifyByCode(map);
        if(listCode.size()>0){
            return false;
        }
        return true;
    }
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveSyncData(List<Map<String,Object>> syncDataList){
        List<Map<String, Object>> listInsertMap = new ArrayList<>();
        List<Map<String, Object>> listUpdateMap = new ArrayList<>();
        List<Map<String, Object>> listDeleteMap = new ArrayList<>();
        int m;
        String eventTypeNext = null;//下一条sql类型
        for (int i = 0; i < syncDataList.size(); i++) {
            Map<String, String> fields = new HashMap<>();
            Map<String, String> wheres = new HashMap<>();
            Map<String, Object> params = new HashMap<>();

            Map<String,Object> jobData  = syncDataList.get(i);
            if(i< (syncDataList.size() -1)){
                Map<String,Object> jobDataNext  = syncDataList.get(i+1);
                eventTypeNext = jobDataNext.get("eventType").toString();
            }
//            String schemaName = jobData.get("schemaName").toString();
            String tableName = jobData.get("tableName").toString();
            String eventType = jobData.get("eventType").toString();
            String keys = jobData.get("keys").toString();
            List<Object> values = (List<Object>)jobData.get("values");

//            params.put("tableName", schemaName + "." + tableName);
            params.put("tableName", tableName);
            switch (eventType){
                case "INSERT":
                    params.put("allKey", keys);
                    params.put("valueList", values);
                    listInsertMap.add(params);
                    if(eventTypeNext != null && !eventTypeNext.equals("INSERT")){//下一条sql类型不是插入，则先执行已解析的插入sql
                        commonMapper.insertBatchByParams(listInsertMap);
                        listInsertMap.clear();
                    }
                    break;
                case "UPDATE":
                    String keysPrimary = jobData.get("keysPrimary").toString();
                    List<Object> valuesPrimary = (List<Object>)jobData.get("valuesPrimary");

                    fields.clear();
                    wheres.clear();
                    m = 0;
                    for(String s : keys.split(",")){
                        Object o = values.get(m++);
                        fields.put(s, o == null ? null : o.toString());
                    }
                    m = 0;
                    for(String s : keysPrimary.split(",")){
                        Object o = valuesPrimary.get(m++);
                        wheres.put(s, o == null ? null : o.toString());
                    }
                    params.put("fields", fields);
                    params.put("wheres", wheres);
                    listUpdateMap.add(params);
                    if(eventTypeNext != null && !eventTypeNext.equals("UPDATE")) {//下一条sql类型不是更新，则先执行已解析的更新sql
                        commonMapper.updateBatchByParams(listUpdateMap);
                        listUpdateMap.clear();
                    }
                    break;
                case "DELETE":
                    wheres.clear();
                    m = 0;
                    for(String s : keys.split(",")){
                        Object o = values.get(m++);
                        wheres.put(s, o == null ? null : o.toString());
                    }
                    params.put("wheres", wheres);
//                    params.put("tableName", schemaName + "." + tableName);
                    params.put("tableName", tableName);
                    listDeleteMap.add(params);
                    if(eventTypeNext != null && !eventTypeNext.equals("DELETE")) {//下一条sql类型不是删除，则执行已解析的删除sql
                        commonMapper.deleteBatchByParams(listDeleteMap);
                        listDeleteMap.clear();
                    }
                    break;
                default:
                    break;
            }
            if (listInsertMap.size() == 200) {
                commonMapper.insertBatchByParams(listInsertMap);
                listInsertMap.clear();
            }
            if (listUpdateMap.size() == 500) {
                commonMapper.updateBatchByParams(listUpdateMap);
                listUpdateMap.clear();
            }
            if (listDeleteMap.size() == 500) {
                commonMapper.deleteBatchByParams(listDeleteMap);
                listDeleteMap.clear();
            }
        }
        if(listInsertMap.size() > 0){
            commonMapper.insertBatchByParams(listInsertMap);
        }
        if(listUpdateMap.size() > 0) {
            commonMapper.updateBatchByParams(listUpdateMap);
        }
        if(listDeleteMap.size() > 0) {
            commonMapper.deleteBatchByParams(listDeleteMap);
        }
    }
}
