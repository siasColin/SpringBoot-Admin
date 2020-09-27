package cn.net.colin.controller.applicationManage;

import cn.net.colin.common.exception.entity.ResultCode;
import cn.net.colin.common.exception.entity.ResultInfo;
import cn.net.colin.common.util.IdWorker;
import cn.net.colin.common.util.SpringSecurityUtil;
import cn.net.colin.model.applicationManage.SysApplication;
import cn.net.colin.model.applicationManage.SysApplicationCriteria;
import cn.net.colin.model.sysManage.SysUser;
import cn.net.colin.service.applicationManage.SysApplicationService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @Package: cn.net.colin.controller.applicationManage
 * @Author: sxf
 * @Date: 2020-9-8
 * @Description: 应用（子系统）
 */
@Controller
@RequestMapping("/applicationManage")
public class ApplicationManageController {
    @Value("${spring.application.name}")
    private String applicationName;
    @Autowired
    private SysApplicationService applicationService;

    @GetMapping("/applicationManageList")
    public String arealist(){
        return "applicationManage/applicationManageList";
    }


    /**
     * 返回应用（子系统）信息列表
     * @param paramMap
     *      applicationNameZh 应用名称（模糊查询）
     *      applicationName 应用编码
     * @return ResultInfo 自定义结果返回实体类
     * @throws IOException
     */
    @GetMapping("/applicationList")
    @ResponseBody
    public ResultInfo userList(@RequestParam Map<String,Object> paramMap) throws IOException {
        int pageNum = paramMap.get("page") == null ? 1 : Integer.parseInt(paramMap.get("page").toString());
        int pageSize = paramMap.get("limit") == null ? 10 : Integer.parseInt(paramMap.get("limit").toString());
        SysApplicationCriteria sysApplicationCriteria = new SysApplicationCriteria();
        sysApplicationCriteria.setOrderByClause("id desc");
        SysApplicationCriteria.Criteria criteria = sysApplicationCriteria.createCriteria();
        if(paramMap.get("applicationNameZh") != null && !paramMap.get("applicationNameZh").toString().trim().equals("")){
            criteria.andApplicationNameZhLike("%"+paramMap.get("applicationNameZh").toString().trim()+"%");
        }
        if(paramMap.get("applicationName") != null && !paramMap.get("applicationName").toString().trim().equals("")){
            criteria.andApplicationNameLike("%"+paramMap.get("applicationName").toString().trim()+"%");
        }
        PageHelper.startPage(pageNum,pageSize);
        List<SysApplication> sysApplications = applicationService.selectByExample(sysApplicationCriteria);
        PageInfo<SysApplication> result = new PageInfo(sysApplications);
        return ResultInfo.ofDataAndTotal(ResultCode.SUCCESS,sysApplications,result.getTotal());
    }

    /**
     * 跳转到应用添加页面
     * @return
     */
    @GetMapping("/application")
    public String application(){
        return "applicationManage/saveOrUpdateApplication";
    }

    /**
     * 保存应用信息
     * @param sysApplication
     * @return
     */
    @PreAuthorize("hasAnyAuthority('ADMIN_AUTH','INSERT_AUTH')")
    @PostMapping("/application")
    @ResponseBody
    public ResultInfo saveApplication(SysApplication sysApplication){
        ResultInfo resultInfo = ResultInfo.of(ResultCode.STATUS_CODE_450);
        SysUser sysUser = SpringSecurityUtil.getPrincipal();
        sysApplication.setId(IdWorker.getInstance().generateId());
        if (sysUser != null) {
            sysApplication.setCreateUser(sysUser.getLoginName());
        }
        sysApplication.setCreateTime(new Date());
        int num = applicationService.insertSelective(sysApplication);
        if(num > 0){
            resultInfo = ResultInfo.ofData(ResultCode.SUCCESS,sysApplication);
        }else{
            resultInfo = ResultInfo.of(ResultCode.UNKNOWN_ERROR);
        }
        return  resultInfo;
    }


    /**
     * 跳转到应用编辑页面
     * @return
     */
    @GetMapping("/application/{id}")
    public String user(@PathVariable("id") String id, Map<String,Object> modelMap){
        SysApplication sysApplication = applicationService.selectByPrimaryKey(Long.parseLong(id));
        modelMap.put("sysApplication",sysApplication);
        return "applicationManage/saveOrUpdateApplication";
    }

    /**
     * 更新应用信息
     * @param sysApplication
     * @return
     */
    @PreAuthorize("hasAnyAuthority('ADMIN_AUTH','UPDATE_AUTH')")
    @PutMapping("/application")
    @ResponseBody
    public ResultInfo updateApplication(SysApplication sysApplication){
        ResultInfo resultInfo = ResultInfo.of(ResultCode.STATUS_CODE_450);
        int num = applicationService.updateByPrimaryKeySelective(sysApplication);
        if(num > 0){
            resultInfo = ResultInfo.ofData(ResultCode.SUCCESS,sysApplication);
        }else{
            resultInfo = ResultInfo.of(ResultCode.UNKNOWN_ERROR);
        }
        return  resultInfo;
    }

    @PreAuthorize("hasAnyAuthority('ADMIN_AUTH','DELETE_AUTH')")
    @DeleteMapping("/application/{id}")
    @ResponseBody
    public ResultInfo deleteApplication(@PathVariable("id") String id){
        ResultInfo resultInfo = ResultInfo.of(ResultCode.STATUS_CODE_450);
        int num = applicationService.deleteByPrimaryKey(Long.parseLong(id));
        if(num > 0){
            resultInfo = ResultInfo.of(ResultCode.SUCCESS);
        }else{
            resultInfo = ResultInfo.of(ResultCode.UNKNOWN_ERROR);
        }
        return  resultInfo;
    }


}
