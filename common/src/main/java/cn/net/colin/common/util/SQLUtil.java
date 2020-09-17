package cn.net.colin.common.util;

import com.fasterxml.jackson.core.type.TypeReference;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @Package: cn.net.colin.common.util
 * @Author: sxf
 * @Date: 2020-3-15
 * @Description: SQL处理工具类
 */
public class SQLUtil {
    /**
     * sql中in查询超过1000的处理
     *
     * @param list
     * @param <T>
     * @return
     */
    public static <T> List<List<T>> getSumArrayList(List<T> list) {
        List<List<T>> objectlist = new ArrayList<>();
        int iSize = list.size() / 1000;
        int iCount = list.size() % 1000;
        for (int i = 0; i <= iSize; i++) {
            List<T> newObjList = new ArrayList<>();
            if (i == iSize) {
                for (int j = i * 1000; j < i * 1000 + iCount; j++) {
                    newObjList.add(list.get(j));
                }
            } else {
                for (int j = i * 1000; j < (i + 1) * 1000; j++) {
                    newObjList.add(list.get(j));
                }
            }
            if (newObjList.size() > 0) {
                objectlist.add(newObjList);
            }
        }
        return objectlist;
    }

    public static String getSqlByJson(String jsonData) {
        List<Map<String, Object>> syncDataList = JsonUtils.nativeRead(jsonData, new TypeReference<List<Map<String, Object>>>() {
        });
        StringBuffer sqlSb = new StringBuffer();
        for (int i = 0; i < syncDataList.size(); i++) {
            Map<String, Object> jobData = syncDataList.get(i);
            String tableName = jobData.get("tableName").toString();
            String eventType = jobData.get("eventType").toString();
            String keys = jobData.get("keys").toString();
            List<String> values = (List<String>) jobData.get("values");
            switch (eventType) {
                case "INSERT":
                    sqlSb.append("insert into ");
                    sqlSb.append(tableName);
                    sqlSb.append("(");
                    sqlSb.append(keys);
                    sqlSb.append(")");
                    sqlSb.append(" values (");
                    for (int j = 0; j < values.size(); j++) {
                        if(values.get(j) != null && !"null".equalsIgnoreCase(values.get(j))) {
                            sqlSb.append("'");
                        }
                        sqlSb.append(values.get(j));
                        if(values.get(j) != null && !"null".equalsIgnoreCase(values.get(j))) {
                            sqlSb.append("'");
                        }
                        if (j == values.size() - 1) {
                            sqlSb.append(");");
                            sqlSb.append("\n");
                        } else {
                            sqlSb.append(",");
                        }
                    }
                    break;
                case "UPDATE":
                    String keysPrimary = jobData.get("keysPrimary").toString();
                    List<String> valuesPrimary = (List<String>)jobData.get("valuesPrimary");
                    sqlSb.append("update ");
                    sqlSb.append(tableName);
                    sqlSb.append(" set ");
                    String [] keyArr = keys.split(",");
                    for (int j = 0; j < keyArr.length; j++) {
                        sqlSb.append(keyArr[j]);
                        sqlSb.append("=");
                        if(values.get(j) != null && !"null".equalsIgnoreCase(values.get(j))) {
                            sqlSb.append("'");
                        }
                        sqlSb.append(values.get(j));
                        if(values.get(j) != null && !"null".equalsIgnoreCase(values.get(j))) {
                            sqlSb.append("'");
                        }
                        if(j != keyArr.length -1){
                            sqlSb.append(",");
                        }
                    }
                    sqlSb.append(" where ");
                    String [] primaryKeyArr = keysPrimary.split(",");
                    for (int j = 0; j < primaryKeyArr.length; j++) {
                        sqlSb.append(primaryKeyArr[j]);
                        sqlSb.append("=");
                        if(values.get(j) != null && !"null".equalsIgnoreCase(values.get(j))) {
                            sqlSb.append("'");
                        }
                        sqlSb.append(valuesPrimary.get(j));
                        if(values.get(j) != null && !"null".equalsIgnoreCase(values.get(j))) {
                            sqlSb.append("'");
                        }
                        if(j == primaryKeyArr.length -1){
                            sqlSb.append(";");
                            sqlSb.append("\n");
                        }else {
                            sqlSb.append(",");
                        }
                    }
                    break;
                case "DELETE":
                    sqlSb.append("delete from ");
                    sqlSb.append(tableName);
                    sqlSb.append(" where ");
                    String [] keyArr_del = keys.split(",");
                    for (int j = 0; j < keyArr_del.length; j++) {
                        sqlSb.append(keyArr_del[j]);
                        sqlSb.append("=");
                        if(values.get(j) != null && !"null".equalsIgnoreCase(values.get(j))){
                            sqlSb.append("'");
                        }
                        sqlSb.append(values.get(j));
                        if(values.get(j) != null && !"null".equalsIgnoreCase(values.get(j))) {
                            sqlSb.append("'");
                        }
                        if(j == keyArr_del.length -1){
                            sqlSb.append(";");
                            sqlSb.append("\n");
                        }else{
                            sqlSb.append(" and ");
                        }
                    }
                    break;
                default:
                    break;
            }
        }
        return sqlSb.toString();
    }
}
