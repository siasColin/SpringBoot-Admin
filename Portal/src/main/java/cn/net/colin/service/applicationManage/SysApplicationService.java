package cn.net.colin.service.applicationManage;

import cn.net.colin.model.applicationManage.SysApplication;
import cn.net.colin.model.applicationManage.SysApplicationCriteria;

import java.util.List;

public interface SysApplicationService {
    long countByExample(SysApplicationCriteria example);

    SysApplication selectByPrimaryKey(Long id);

    List<SysApplication> selectByExample(SysApplicationCriteria example);

    int deleteByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(SysApplication record);

    int updateByPrimaryKey(SysApplication record);

    int deleteByExample(SysApplicationCriteria example);

    int updateByExampleSelective(SysApplication record, SysApplicationCriteria example);

    int updateByExample(SysApplication record, SysApplicationCriteria example);

    int insert(SysApplication record);

    int insertSelective(SysApplication record);
}