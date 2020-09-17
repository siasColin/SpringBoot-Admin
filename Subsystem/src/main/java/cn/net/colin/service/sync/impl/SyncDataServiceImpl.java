package cn.net.colin.service.sync.impl;

import cn.net.colin.common.aop.DataSourceAnnotation;
import cn.net.colin.common.util.DynamicDataSourceSwitcher;
import cn.net.colin.mapper.sync.SyncDataMapper;
import cn.net.colin.model.sync.SyncData;
import cn.net.colin.model.sync.SyncDataCriteria;
import cn.net.colin.service.sync.ISyncDataService;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SyncDataServiceImpl implements ISyncDataService {
    @Autowired
    private SyncDataMapper syncDataMapper;

    private static final Logger logger = LoggerFactory.getLogger(SyncDataServiceImpl.class);

    @DataSourceAnnotation(DynamicDataSourceSwitcher.portal)
    public long countByExample(SyncDataCriteria example) {
        long count = this.syncDataMapper.countByExample(example);
        logger.debug("count: {}", count);
        return count;
    }

    @DataSourceAnnotation(DynamicDataSourceSwitcher.portal)
    public SyncData selectByPrimaryKey(Long id) {
        return this.syncDataMapper.selectByPrimaryKey(id);
    }

    @DataSourceAnnotation(DynamicDataSourceSwitcher.portal)
    public List<SyncData> selectByExample(SyncDataCriteria example) {
        return this.syncDataMapper.selectByExample(example);
    }

    @DataSourceAnnotation(DynamicDataSourceSwitcher.portal)
    public int deleteByPrimaryKey(Long id) {
        return this.syncDataMapper.deleteByPrimaryKey(id);
    }

    @DataSourceAnnotation(DynamicDataSourceSwitcher.portal)
    public int updateByPrimaryKeySelective(SyncData record) {
        return this.syncDataMapper.updateByPrimaryKeySelective(record);
    }

    @DataSourceAnnotation(DynamicDataSourceSwitcher.portal)
    public int updateByPrimaryKey(SyncData record) {
        return this.syncDataMapper.updateByPrimaryKey(record);
    }

    @DataSourceAnnotation(DynamicDataSourceSwitcher.portal)
    public int deleteByExample(SyncDataCriteria example) {
        return this.syncDataMapper.deleteByExample(example);
    }

    @DataSourceAnnotation(DynamicDataSourceSwitcher.portal)
    public int updateByExampleSelective(SyncData record, SyncDataCriteria example) {
        return this.syncDataMapper.updateByExampleSelective(record, example);
    }

    @DataSourceAnnotation(DynamicDataSourceSwitcher.portal)
    public int updateByExample(SyncData record, SyncDataCriteria example) {
        return this.syncDataMapper.updateByExample(record, example);
    }

    @DataSourceAnnotation(DynamicDataSourceSwitcher.portal)
    public int insert(SyncData record) {
        return this.syncDataMapper.insert(record);
    }

    @DataSourceAnnotation(DynamicDataSourceSwitcher.portal)
    public int insertSelective(SyncData record) {
        return this.syncDataMapper.insertSelective(record);
    }
}