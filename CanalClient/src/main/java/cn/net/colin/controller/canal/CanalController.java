package cn.net.colin.controller.canal;

import cn.net.colin.common.exception.entity.ResultCode;
import cn.net.colin.common.exception.entity.ResultInfo;
import cn.net.colin.model.sysManage.SysArea;
import cn.net.colin.service.canal.ICanalService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @Package: cn.net.colin.controller.canal
 * @Author: sxf
 * @Date: 2020-9-5
 * @Description:
 */
@Controller
@RequestMapping("/canal")
public class CanalController {
    private static final Logger logger = LoggerFactory.getLogger(CanalController.class);

    @Autowired
    private ICanalService canalService;

    @GetMapping("/helloCanal/{id}")
    @ResponseBody
    public ResultInfo helloCanal(@PathVariable("id") Long id){
        SysArea sysArea = canalService.getAreaById(id);
        return ResultInfo.ofData(ResultCode.SUCCESS,sysArea);
    }

}
