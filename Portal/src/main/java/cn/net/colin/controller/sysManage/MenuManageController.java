package cn.net.colin.controller.sysManage;

import cn.net.colin.common.Constants;
import cn.net.colin.common.exception.entity.ResultCode;
import cn.net.colin.common.exception.entity.ResultInfo;
import cn.net.colin.common.helper.RedisLock;
import cn.net.colin.common.util.IdWorker;
import cn.net.colin.common.util.SpringSecurityUtil;
import cn.net.colin.model.common.TreeNode;
import cn.net.colin.model.sysManage.SysModulelist;
import cn.net.colin.model.sysManage.SysUser;
import cn.net.colin.service.sysManage.ISysModullistService;
import io.swagger.annotations.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Package: cn.net.colin.controller.sysManage
 * @Author: sxf
 * @Date: 2020-3-6
 * @Description: 菜单管理
 */
@Controller
@RequestMapping("/menuManage")
@ApiSort(value = 3)
@Api(tags = "菜单管理")
public class MenuManageController {
    Logger logger = LoggerFactory.getLogger(MenuManageController.class);
    @Value("${spring.application.name}")
    private String applicationName;

    @Autowired
    private ISysModullistService sysModullistService;

    @Autowired
    private RedisLock redisLock;


    @GetMapping("/menulist")
    public String menulist(HttpServletRequest request) {
        request.setAttribute("applicationName", applicationName);
        return "sysManage/menuManage/menuManageList";
    }

    /**
     * 返回满足zTree结构的菜单信息
     *
     * @param menuName 菜单名字（模糊查询）
     * @return ResultInfo 自定义结果返回实体类
     * @throws IOException
     */
    @GetMapping("/menuListTree")
    @ResponseBody
    @ApiOperationSupport(order = 1)
    @ApiOperation(value = "获取菜单树", notes = "返回满足zTree结构的菜单信息",
            consumes = "application/x-www-form-urlencoded", produces = "application/json")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "menuName", value = "菜单名称", required = false, paramType = "query")
    })
    public ResultInfo menuListTree(String menuName) throws IOException {
        Map<String, Object> paramMap = new HashMap<String, Object>();
        if (menuName != null && !menuName.equals("")) {
            paramMap.put("moduleName", menuName);
        }
        List<TreeNode> treeNodeList = sysModullistService.selectMenuTreeNodes(paramMap);
        return ResultInfo.ofData(ResultCode.SUCCESS, treeNodeList);
    }

    /**
     * 跳转到菜单树页面
     *
     * @param type
     * @return
     */
    @GetMapping("/menutree/{type}")
    public String menulist(@PathVariable("type") String type) {
        /**
         * type:
         *      none 普通ztree页面
         *      radio 单选框ztree页面
         *      check 复选框ztree页面
         */
        String targetPage = "sysManage/menuManage/menutree";
        if (type.equals("radio")) {//跳转到普通ztree页面
            targetPage = "sysManage/menuManage/menutreeRadio";
        } else if (type.equals("check")) {
            targetPage = "sysManage/menuManage/menutreeCheck";
        }
        return targetPage;
    }

    /**
     * 保存菜单信息
     *
     * @param sysModulelist
     * @return
     */
    @PreAuthorize("hasAnyAuthority('ADMIN_AUTH','INSERT_AUTH')")
    @PostMapping("/menu")
    @ResponseBody
    @ApiOperationSupport(order = 2)
    @ApiOperation(value = "保存菜单信息", notes = "保存菜单信息",
            consumes = "application/x-www-form-urlencoded", produces = "application/json")
    public ResultInfo saveMenu(SysModulelist sysModulelist) {
        ResultInfo resultInfo = ResultInfo.of(ResultCode.STATUS_CODE_450);
        sysModulelist.setApplicationName(applicationName);
        SysUser sysUser = SpringSecurityUtil.getPrincipal();
        //父级ID为空，查询pid=-1的记录，默认pid=-1为根节点。如果没有记录那么新增节点作为根节点
        if (sysModulelist.getPid() == null) {
            List<SysModulelist> moduleLists = sysModullistService.selectByPid(-1l);
            if (moduleLists != null && moduleLists.size() > 0) {
                sysModulelist.setPid(moduleLists.get(0).getId());
            } else {
                sysModulelist.setPid(-1l);
            }
            sysModulelist.setApplicationName(applicationName);
        } else {
            SysModulelist sysModulelistP = sysModullistService.selectByPrimaryKey(sysModulelist.getPid());
            sysModulelist.setApplicationName(sysModulelistP.getApplicationName());
        }
        sysModulelist.setId(IdWorker.getInstance().generateId());
        sysModulelist.setCreateTime(new Date());
        sysModulelist.setCreateUser(sysUser.getLoginName());
        //使用全局锁，防止出现死锁
        boolean lock = false;
        try {
            //设置锁的失效时间为3s，获取锁的等待时间为30s
            lock = redisLock.lock(Constants.ROLEMENU_LOCK, 3, 30000);
        } catch (Exception e) {
            e.printStackTrace();
            return resultInfo;
        }
        if (lock) {
            try {
                int num = sysModullistService.insertSelective(sysModulelist);
                if (num > 0) {
                    resultInfo = ResultInfo.ofData(ResultCode.SUCCESS, sysModulelist);
                } else {
                    resultInfo = ResultInfo.of(ResultCode.UNKNOWN_ERROR);
                }
            } catch (Exception e) {
                resultInfo = ResultInfo.of(ResultCode.UNKNOWN_ERROR);
                e.printStackTrace();
            } finally {
                redisLock.unlock(Constants.ROLEMENU_LOCK);
            }
        }
        return resultInfo;
    }

    /**
     * 根据菜单id，查询菜单信息
     *
     * @param id
     * @return
     */
    @GetMapping("/menu/{id}")
    @ResponseBody
    @ApiOperationSupport(order = 3)
    @ApiOperation(value = "根据菜单id，查询菜单信息", notes = "根据菜单id，查询菜单信息",
            consumes = "application/x-www-form-urlencoded", produces = "application/json")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id", value = "菜单ID", required = true, paramType = "path")
    })
    public ResultInfo menu(@PathVariable("id") String id) {
        SysModulelist sysModulelist = sysModullistService.selectByPrimaryKey(Long.parseLong(id));
        return ResultInfo.ofData(ResultCode.SUCCESS, sysModulelist);
    }

    /**
     * 更新菜单信息
     *
     * @param sysModulelist
     * @return
     */
    @PreAuthorize("hasAnyAuthority('ADMIN_AUTH','UPDATE_AUTH')")
    @PutMapping("/menu")
    @ResponseBody
    @ApiOperationSupport(order = 4)
    @ApiOperation(value = "更新菜单信息", notes = "更新菜单信息",
            consumes = "application/x-www-form-urlencoded", produces = "application/json")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id", value = "菜单ID", required = true, paramType = "query"),
            @ApiImplicitParam(name = "moduleName", value = "菜单名称", required = false, paramType = "query"),
            @ApiImplicitParam(name = "moduleCode", value = "菜单编码", required = false, paramType = "query")
    })
    public ResultInfo updateMenu(SysModulelist sysModulelist) {
        ResultInfo resultInfo = ResultInfo.of(ResultCode.STATUS_CODE_450);
        //父级ID为空，查询pid=-1的记录，默认pid=-1为根节点。如果没有记录那么新增节点作为根节点
        if (sysModulelist.getPid() == null) {
            List<SysModulelist> moduleLists = sysModullistService.selectByPid(-1l);
            if (moduleLists != null && moduleLists.size() > 0) {
                sysModulelist.setPid(moduleLists.get(0).getId());
            } else {
                sysModulelist.setPid(-1l);
            }
        }
        //使用全局锁，防止出现死锁
        boolean lock = false;
        try {
            //设置锁的失效时间为3s，获取锁的等待时间为30s
            lock = redisLock.lock(Constants.ROLEMENU_LOCK, 3, 30000);
        } catch (Exception e) {
            e.printStackTrace();
            return resultInfo;
        }
        if (lock) {
            try {
                int num = sysModullistService.updateByPrimaryKeySelective(sysModulelist);
                if (num > 0) {
                    resultInfo = ResultInfo.ofData(ResultCode.SUCCESS, sysModulelist);
                } else {
                    resultInfo = ResultInfo.of(ResultCode.UNKNOWN_ERROR);
                }
            } catch (Exception e) {
                e.printStackTrace();
                resultInfo = ResultInfo.of(ResultCode.UNKNOWN_ERROR);
            } finally {
                redisLock.unlock(Constants.ROLEMENU_LOCK);
            }
        }
        return resultInfo;
    }

    /**
     * 根据id，删除菜单
     *
     * @param id
     * @return
     */
    @PreAuthorize("hasAnyAuthority('ADMIN_AUTH','DELETE_AUTH')")
    @DeleteMapping("/menu/{id}")
    @ResponseBody
    @ApiOperationSupport(order = 4)
    @ApiOperation(value = "根据id删除菜单", notes = "根据id删除菜单",
            consumes = "application/x-www-form-urlencoded", produces = "application/json")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id", value = "菜单ID", required = true, paramType = "path")
    })
    public ResultInfo deleteMenu(@PathVariable("id") Long id) {
        ResultInfo resultInfo = ResultInfo.of(ResultCode.STATUS_CODE_450);
        //使用全局锁，防止出现死锁
        boolean lock = false;
        try {
            //设置锁的失效时间为3s，获取锁的等待时间为30s
            lock = redisLock.lock(Constants.ROLEMENU_LOCK, 3, 30000);
        } catch (Exception e) {
            e.printStackTrace();
            return resultInfo;
        }
        if (lock) {
            try {
                int num = sysModullistService.deleteByPrimaryKey(id);
                if (num > 0) {
                    resultInfo = ResultInfo.of(ResultCode.SUCCESS);
                } else {
                    resultInfo = ResultInfo.of(ResultCode.UNKNOWN_ERROR);
                }
            } catch (Exception e) {
                e.printStackTrace();
                resultInfo = ResultInfo.of(ResultCode.UNKNOWN_ERROR);
            } finally {
                redisLock.unlock(Constants.ROLEMENU_LOCK);
            }
        }
        return resultInfo;
    }
}
