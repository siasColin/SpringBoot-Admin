package cn.net.colin.controller.syncClient;

import cn.net.colin.common.exception.entity.ResultCode;
import cn.net.colin.common.exception.entity.ResultInfo;
import cn.net.colin.service.common.ICommonservice;
import cn.net.colin.service.sync.ISyncService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @Package: cn.net.colin.controller.syncClient
 * @Author: sxf
 * @Date: 2020-9-6
 * @Description:
 */
@RestController
@RequestMapping("/sync")
public class SyncController {
    @Autowired
    private ISyncService syncService;


    @PostMapping("/client")
    public ResultInfo client(Long syncDataId){
        syncService.doSync(syncDataId);
        return ResultInfo.of(ResultCode.SUCCESS);
    }
}
