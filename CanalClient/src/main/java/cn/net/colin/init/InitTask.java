package cn.net.colin.init;

import cn.net.colin.service.canal.ICanalService;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.otter.canal.client.CanalConnector;
import com.alibaba.otter.canal.client.CanalConnectors;
import com.alibaba.otter.canal.protocol.CanalEntry;
import com.alibaba.otter.canal.protocol.Message;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import java.net.InetSocketAddress;
import java.util.List;

@Component
@Async()
public class InitTask implements ApplicationRunner {
    private final static Logger logger = LoggerFactory.getLogger(InitTask.class);
    @Autowired
    private ICanalService canalService;

    @Value("${canal.address}")
    private String address;
    @Value("${canal.port}")
    private Integer port;
    @Value("${canal.destination}")
    private String destination;
    @Value("${canal.filter}")
    private String filter;

    @Override
    public void run(ApplicationArguments args) throws Exception {
        CanalConnector connector = CanalConnectors.newSingleConnector(new InetSocketAddress(address,
                port), destination, "", "");
        serverConnect(connector);
    }

    public void serverConnect(CanalConnector connector) {
        try {
            connector.connect();
            logger.info("Connection successful, listening...");
            // 指定filter，格式 {database}.{table}，这里不做过滤，过滤操作留给用户
            connector.subscribe(filter);
            // 回滚寻找上次中断的位置
            connector.rollback();
            int batchSize = 1000;
            try {
                while (true) {
                    Message message = connector.getWithoutAck(batchSize); // 获取指定数量的数据
                    long batchId = message.getId();
                    int size = message.getEntries().size();
                    if (batchId == -1 || size == 0) {
                        try {
                            Thread.sleep(1000);
                        } catch (InterruptedException e) {
                        }
                    } else {
                        try {
                            handlerData(message.getEntries());
                        } catch (RuntimeException e) {
                            connector.rollback(batchId); // 处理失败, 回滚数据
                            e.printStackTrace();
                        }
                    }
                    if (batchId != -1) {
                        connector.ack(batchId); // 提交确认
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            logger.info("Connection lost, reconnect...");
            connector.disconnect();
            try {
                Thread.sleep(1000 * 60);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            serverConnect(connector);
        }
    }


    /**
     * 同步数据
     *
     * @param entries
     * @throws Exception
     */
    private void handlerData(List<CanalEntry.Entry> entries) throws Exception {
        CanalEntry.RowChange rowChange;
        CanalEntry.EventType eventType;
        String tableName;
//        String schemaName;
        JSONArray jarData = new JSONArray();
        JSONObject jobData = null;
        logger.info("开始封装推送数据!!!!");
        for (CanalEntry.Entry entry : entries) {
            if (entry.getEntryType() != CanalEntry.EntryType.ROWDATA) {
                continue;
            }
            rowChange = CanalEntry.RowChange.parseFrom(entry.getStoreValue());
            tableName = entry.getHeader().getTableName();
//                schemaName = entry.getHeader().getSchemaName();
            eventType = rowChange.getEventType();

            logger.info("处理表数据："+tableName);
            for (CanalEntry.RowData rowData : rowChange.getRowDatasList()) {
                switch (eventType) {
                    case INSERT:
                        jobData = getInsertData(rowData.getAfterColumnsList());
                        break;
                    case UPDATE:
                        jobData = getUpdateData(rowData.getBeforeColumnsList(), rowData.getAfterColumnsList());
                        break;
                    case DELETE:
                        jobData = getDeleteData(rowData.getBeforeColumnsList());
                        break;
                    default:
                        break;
                }
                if(jobData == null){
                    continue;
                }
//                    jobData.put("schemaName", schemaName);
                jobData.put("tableName", tableName);
                jarData.add(jobData);
            }
        }
        if(jarData.size() > 0){
            logger.info("数据封装成功【"+jarData.size()+"】");
            logger.info(JSON.toJSONString(jarData));
            long syncDataId = canalService.saveSyncData(jarData);
            //给各系统发布同步命令，该方法可异步执行
            canalService.noticeApplications(syncDataId);
        }else{
            logger.info("没有匹配到有效数据");
        }
    }


    private static int getPrimaryKeyNum(List<CanalEntry.Column> columns) {
        int keyNum = 0;
        for (int i = 0; i < columns.size(); i++) {
            if (columns.get(i).getIsKey()) {
                keyNum++;
            }
        }
        return keyNum;
    }

    private static JSONObject getInsertData(List<CanalEntry.Column> columns){
        JSONObject job = new JSONObject();
        String keys = "";
        String[] values = new String[columns.size()];

        for (int i = 0; i < columns.size(); i++) {
            keys += columns.get(i).getName();
            if("".equals(columns.get(i).getValue())){
                values[i] = null;
            } else {
                values[i] = columns.get(i).getValue();
            }
            if (i < columns.size() - 1) {
                keys += ",";
            }
        }
        job.put("eventType", "INSERT");
        job.put("keys", keys);
        job.put("values", values);
        return job;
    }

    private static JSONObject getUpdateData(List<CanalEntry.Column> columnsBefore, List<CanalEntry.Column> columnsAfter){
        JSONObject job = new JSONObject();
        int primaryKeyNum = getPrimaryKeyNum(columnsBefore);
        String keys = "";
        String keysPrimary = "";
        String[] values = new String[columnsAfter.size()];
        String[] valuesPrimary = new String[primaryKeyNum > 0 ? primaryKeyNum : columnsBefore.size()];

        for (int i = 0; i < columnsAfter.size(); i++) {
            keys += columnsAfter.get(i).getName();
            if("".equals(columnsAfter.get(i).getValue())){
                values[i] = null;
            } else {
                values[i] = columnsAfter.get(i).getValue();
            }
            if (i < columnsAfter.size() - 1) {
                keys += ",";
            }
        }
        for (int i = 0; i < columnsBefore.size(); i++) {
            if(primaryKeyNum > 0){
                if(columnsBefore.get(i).getIsKey()){
                    keysPrimary += columnsBefore.get(i).getName();
                    valuesPrimary[i] = columnsBefore.get(i).getValue();
                    if (i < columnsBefore.size() - 1) {
                        keysPrimary += ",";
                    }
                }
            } else {
                keysPrimary += columnsBefore.get(i).getName();
                valuesPrimary[i] = columnsBefore.get(i).getValue();
                if (i < columnsBefore.size() - 1) {
                    keysPrimary += ",";
                }
            }
        }
        job.put("eventType", "UPDATE");
        job.put("keys", keys);
        job.put("values", values);
        job.put("keysPrimary", keysPrimary);
        job.put("valuesPrimary", valuesPrimary);
        return job;
    }

    private static JSONObject getDeleteData(List<CanalEntry.Column> columns){
        JSONObject job = new JSONObject();
        int primaryKeyNum = getPrimaryKeyNum(columns);
        String keysPrimary = "";
        String[] valuesPrimary = new String[primaryKeyNum > 0 ? primaryKeyNum : columns.size()];

        for (int i = 0; i < columns.size(); i++) {
            if(primaryKeyNum > 0){
                if(columns.get(i).getIsKey()){
                    keysPrimary += columns.get(i).getName();
                    valuesPrimary[i] = columns.get(i).getValue();
                    if (i < columns.size() - 1) {
                        keysPrimary += ",";
                    }
                }
            } else {
                keysPrimary += columns.get(i).getName();
                valuesPrimary[i] = columns.get(i).getValue();
                if (i < columns.size() - 1) {
                    keysPrimary += ",";
                }
            }
        }
        job.put("eventType", "DELETE");
        job.put("keys", keysPrimary);
        job.put("values", valuesPrimary);
        return job;
    }
}