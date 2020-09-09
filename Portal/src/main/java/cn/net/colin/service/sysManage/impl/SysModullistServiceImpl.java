package cn.net.colin.service.sysManage.impl;

import cn.net.colin.common.util.SpringSecurityUtil;
import cn.net.colin.mapper.sysManage.SysModullistMapper;
import cn.net.colin.mapper.sysManage.SysRoleMapper;
import cn.net.colin.model.common.Role;
import cn.net.colin.model.common.TreeNode;
import cn.net.colin.model.sysManage.SysModulelist;
import cn.net.colin.model.sysManage.SysRole;
import cn.net.colin.model.sysManage.SysUser;
import cn.net.colin.service.sysManage.ISysModullistService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class SysModullistServiceImpl implements ISysModullistService {
    @Value("${spring.application.name}")
    private String applicationName;
    @Autowired
    private SysModullistMapper sysModullistMapper;
    @Autowired
    private SysRoleMapper sysRoleMapper;

    private static final Logger logger = LoggerFactory.getLogger(SysModullistServiceImpl.class);


    public SysModulelist selectByPrimaryKey(Long id) {
        return this.sysModullistMapper.selectByPrimaryKey(id);
    }


    @Transactional(rollbackFor = Exception.class)
    public int deleteByPrimaryKey(Long id) {
        int deleteNum = this.sysModullistMapper.deleteByPrimaryKey(id);
        //同时删除，菜单和角色关联关系
        sysRoleMapper.deleteRoleModulelistByModuleListid(id);
        return deleteNum;
    }

    public int updateByPrimaryKeySelective(SysModulelist record) {
        return this.sysModullistMapper.updateByPrimaryKeySelective(record);
    }

    public int updateByPrimaryKey(SysModulelist record) {
        return this.sysModullistMapper.updateByPrimaryKey(record);
    }

    public int insert(SysModulelist record) {
        return this.sysModullistMapper.insert(record);
    }

    public int insertSelective(SysModulelist record) {
        return this.sysModullistMapper.insertSelective(record);
    }

    public int insertBatch(List<SysModulelist> modulelists) {
        return this.sysModullistMapper.insertBatch(modulelists);
    }

    public int insertBatchSelective(List<SysModulelist> modulelists) {
        return this.sysModullistMapper.insertBatchSelective(modulelists);
    }

    public int updateBatchByPrimaryKey(List<SysModulelist> modulelists) {
        return this.sysModullistMapper.updateBatchByPrimaryKey(modulelists);
    }

    public int updateBatchByPrimaryKeySelective(List<SysModulelist> modulelists) {
        return this.sysModullistMapper.updateBatchByPrimaryKeySelective(modulelists);
    }

    @Override
    public List<TreeNode> selectMenuTreeNodes(Map<String, Object> paramMap) {
        if(!applicationName.trim().equals("Portal")){//门户系统，可以管理所有子系统菜单。非门户系统只查询本系统菜单
            paramMap.put("applicationName",applicationName);
        }
        return this.sysModullistMapper.selectMenuTreeNodes(paramMap);
    }

    @Override
    public List<SysModulelist> selectByPid(long pid) {
        return this.sysModullistMapper.selectByPid(pid);
    }

    @Override
    public List<SysModulelist> selectFirstMenu() {
        List<SysModulelist> firstMuneList = new ArrayList<SysModulelist>();
        SysUser sysUser = SpringSecurityUtil.getPrincipal();
        if(sysUser != null && sysUser.getId() != null){
            //查询用户的系统角色
            List<SysRole> sysRoleList = this.sysRoleMapper.selectByUserId(sysUser.getId());
            if(sysRoleList != null && sysRoleList.size() >0){
                //首先查询系统根节点，这里约定好每个子系统根节点的moduleCode等于该子系统的applicationName转大写
                SysModulelist sysModulelist = sysModullistMapper.selectByModuleCode(applicationName.toUpperCase(),applicationName);
                if(sysModulelist != null){
                    Map<String,Object> menuParams = new HashMap<String,Object>();
                    menuParams.put("sysRoleList",sysRoleList);
                    menuParams.put("pid",sysModulelist.getId());
                    menuParams.put("applicationName",applicationName);
                    firstMuneList = this.sysModullistMapper.selectMenu(menuParams);
                }
            }
        }
        return firstMuneList;
    }

    @Override
    public Map<String, Object> selectChildMenu(String moduleId) {
        Map<String,Object> resultMap = new HashMap<String,Object>();
        List<SysModulelist> secondMuneList = new ArrayList<SysModulelist>();
        SysUser sysUser = SpringSecurityUtil.getPrincipal();
        if(sysUser != null && sysUser.getId() != null){
            //查询用户的系统角色
            List<SysRole> sysRoleList = this.sysRoleMapper.selectByUserId(sysUser.getId());
            if(sysRoleList != null && sysRoleList.size() > 0){
                Map<String,Object> menuParams = new HashMap<String,Object>();
                menuParams.put("sysRoleList",sysRoleList);
                menuParams.put("applicationName",applicationName);
                menuParams.put("pid",Long.parseLong(moduleId));
                secondMuneList = this.sysModullistMapper.selectMenu(menuParams);
                if(secondMuneList != null && secondMuneList.size() > 0){
                    resultMap.put("allSecondMenu",secondMuneList);
                    for (int i=0;i<secondMuneList.size();i++){
                        menuParams.put("pid",secondMuneList.get(i).getId());
                        List<SysModulelist> thirdMuneList = this.sysModullistMapper.selectMenu(menuParams);
                        resultMap.put("secondMenu_"+secondMuneList.get(i).getId(),thirdMuneList);
                    }
                }
            }
        }
        return resultMap;
    }
}