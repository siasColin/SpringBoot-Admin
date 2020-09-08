package cn.net.colin.service.canal;

import cn.net.colin.model.sysManage.SysArea;
import com.alibaba.fastjson.JSONArray;
import org.springframework.stereotype.Service;

/**
 * @Package: cn.net.colin.service
 * @Author: sxf
 * @Date: 2020-9-5
 * @Description:
 */
public interface ICanalService {
    SysArea getAreaById(Long id);

    /**
     * 保存操作数据
     * @param jarData
     * @return
     */
    long saveSyncData(JSONArray jarData);

    /**
     * 通知各子系统执行数据同步
     * @param syncDataId
     */
    void noticeApplications(long syncDataId);
}
