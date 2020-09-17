package cn.net.colin.service.sync;

import cn.net.colin.common.exception.entity.ResultInfo;

import java.util.Map;

/**
 * @Package: cn.net.colin.service.sync
 * @Author: sxf
 * @Date: 2020-9-7
 * @Description:
 */
public interface ISyncService {
    /**
     * 同步数据-异步
     * @param syncDataId
     */
    void doSyncAsync(Long syncDataId);

    /**
     * 同步数据
     * @param syncDataId
     */
    boolean doSync(Long syncDataId);

    /**
     * 查询子系统同步记录
     * @return
     */
    ResultInfo syncRecordListData(Map<String,Object> paramMap);
}
