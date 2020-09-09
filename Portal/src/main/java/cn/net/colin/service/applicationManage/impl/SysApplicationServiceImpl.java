package cn.net.colin.service.applicationManage.impl;

import cn.net.colin.common.util.SnowflakeIdWorker;
import cn.net.colin.mapper.applicationManage.SysApplicationMapper;
import cn.net.colin.mapper.sysManage.SysModullistMapper;
import cn.net.colin.mapper.sysManage.SysOperatetypeMapper;
import cn.net.colin.mapper.sysManage.SysRoleMapper;
import cn.net.colin.model.applicationManage.SysApplication;
import cn.net.colin.model.applicationManage.SysApplicationCriteria;
import cn.net.colin.model.sysManage.SysModulelist;
import cn.net.colin.service.applicationManage.SysApplicationService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.net.colin.service.sysManage.ISysModullistService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class SysApplicationServiceImpl implements SysApplicationService {
    @Autowired
    private SysApplicationMapper sysApplicationMapper;
    @Autowired
    private SysModullistMapper sysModullistMapper;
    @Autowired
    private SysOperatetypeMapper sysOperatetypeMapper;
    @Autowired
    private SysRoleMapper sysRoleMapper;

    @Value("${spring.application.name}")
    private String applicationName;

    private static final Logger logger = LoggerFactory.getLogger(SysApplicationServiceImpl.class);

    public long countByExample(SysApplicationCriteria example) {
        long count = this.sysApplicationMapper.countByExample(example);
        logger.debug("count: {}", count);
        return count;
    }

    public SysApplication selectByPrimaryKey(Long id) {
        return this.sysApplicationMapper.selectByPrimaryKey(id);
    }

    public List<SysApplication> selectByExample(SysApplicationCriteria example) {
        return this.sysApplicationMapper.selectByExample(example);
    }

    public int deleteByPrimaryKey(Long id) {
        return this.sysApplicationMapper.deleteByPrimaryKey(id);
    }

    public int updateByPrimaryKeySelective(SysApplication record) {
        return this.sysApplicationMapper.updateByPrimaryKeySelective(record);
    }

    public int updateByPrimaryKey(SysApplication record) {
        return this.sysApplicationMapper.updateByPrimaryKey(record);
    }

    public int deleteByExample(SysApplicationCriteria example) {
        return this.sysApplicationMapper.deleteByExample(example);
    }

    public int updateByExampleSelective(SysApplication record, SysApplicationCriteria example) {
        return this.sysApplicationMapper.updateByExampleSelective(record, example);
    }

    public int updateByExample(SysApplication record, SysApplicationCriteria example) {
        return this.sysApplicationMapper.updateByExample(record, example);
    }

    public int insert(SysApplication record) {
        return this.sysApplicationMapper.insert(record);
    }

    @Transactional(rollbackFor = Exception.class)
    public int insertSelective(SysApplication record) {
        int num = this.sysApplicationMapper.insertSelective(record);
        if(num > 0){
            //查询菜单表，是否存在该子系统的根菜单，如不存在进行子系统菜单的初始化
            SysModulelist sysModulelist = sysModullistMapper.selectByModuleCode(record.getApplicationName().toUpperCase(),record.getApplicationName());
            if(sysModulelist == null){
                int moduleAttr = 2;//共享菜单
                //查询门户系统中的共享菜单，用于给新建的子系统初始化
                List<SysModulelist> sysModulelists = sysModullistMapper.selectByApplicationNameAndAttr(applicationName,moduleAttr);
                Map<String,String> idMapping = new HashMap<String,String>();
                if(sysModulelists != null && sysModulelists.size() >0){
                    //查询门户系统的根菜单
                    SysModulelist portalRootMenu = sysModullistMapper.selectByModuleCode(applicationName.toUpperCase(),applicationName);
                    //创建一个子系统的根菜单
                    SysModulelist rootSysModulelist = new SysModulelist();
                    rootSysModulelist.setId(SnowflakeIdWorker.generateId());
                    rootSysModulelist.setApplicationName(record.getApplicationName());
                    rootSysModulelist.setPid(1l);
                    rootSysModulelist.setModuleName(record.getApplicationNameZh());
                    rootSysModulelist.setModuleCode(record.getApplicationName().toUpperCase());
                    rootSysModulelist.setCreateUser(record.getCreateUser());
                    rootSysModulelist.setCreateTime(record.getCreateTime());
                    rootSysModulelist.setModuleStatus(1);
                    rootSysModulelist.setModuleType(0);
                    rootSysModulelist.setModuleTarget("navTab");
                    idMapping.put(portalRootMenu.getId()+"",rootSysModulelist.getId()+"");
                    //处理ID
                    for (SysModulelist sysModule:sysModulelists) {
                        long newID = SnowflakeIdWorker.generateId();
                        idMapping.put(sysModule.getId()+"",newID+"");
                        sysModule.setId(newID);
                        sysModule.setApplicationName(record.getApplicationName());
                    }
                    //处理pid
                    for (SysModulelist sysModule:sysModulelists) {
                        String key = sysModule.getPid()+"";
                        sysModule.setPid(Long.parseLong(idMapping.get(key)));
                    }
                    sysModulelists.add(rootSysModulelist);
                    //保存子系统初始化菜单
                    sysModullistMapper.insertBatchSelective(sysModulelists);
                    /**
                     * 给管理员权限的角色绑定初始化菜单
                     */
                    //查询管理员权限的角色
                    String operateCode = "ADMIN_AUTH";
                    List<Long> roles = sysOperatetypeMapper.selectRoleIdsByOperateCode(operateCode);
                    List<Map<String,Long>> roleAndMenuList = new ArrayList<Map<String,Long>>();
                    for (Long roleid : roles) {
                        for (SysModulelist sysModule:sysModulelists) {
                            Map<String,Long> roleAndMenu = new HashMap<String,Long>();
                            roleAndMenu.put("roleId",roleid);
                            roleAndMenu.put("moduleListId",sysModule.getId());
                            roleAndMenuList.add(roleAndMenu);
                        }
                    }

                    this.sysRoleMapper.insertRoleMenuBatch(roleAndMenuList);
                }
            }
        }
        return num;
    }
}