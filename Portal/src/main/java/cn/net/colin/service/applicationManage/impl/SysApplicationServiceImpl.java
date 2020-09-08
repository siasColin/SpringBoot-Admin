package cn.net.colin.service.applicationManage.impl;

import cn.net.colin.mapper.applicationManage.SysApplicationMapper;
import cn.net.colin.model.applicationManage.SysApplication;
import cn.net.colin.model.applicationManage.SysApplicationCriteria;
import cn.net.colin.service.applicationManage.SysApplicationService;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SysApplicationServiceImpl implements SysApplicationService {
    @Autowired
    private SysApplicationMapper sysApplicationMapper;

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

    public int insertSelective(SysApplication record) {
        return this.sysApplicationMapper.insertSelective(record);
    }
}