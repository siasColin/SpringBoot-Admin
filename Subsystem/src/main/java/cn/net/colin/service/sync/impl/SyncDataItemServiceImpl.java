package cn.net.colin.service.sync.impl;

import cn.net.colin.common.aop.DataSourceAnnotation;
import cn.net.colin.common.util.DynamicDataSourceSwitcher;
import cn.net.colin.mapper.sync.SyncDataItemMapper;
import cn.net.colin.model.sync.SyncDataItem;
import cn.net.colin.model.sync.SyncDataItemCriteria;
import cn.net.colin.service.sync.ISyncDataItemService;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SyncDataItemServiceImpl implements ISyncDataItemService {
    @Autowired
    private SyncDataItemMapper syncDataItemMapper;

    private static final Logger logger = LoggerFactory.getLogger(SyncDataItemServiceImpl.class);

    @DataSourceAnnotation(DynamicDataSourceSwitcher.portal)
    public long countByExample(SyncDataItemCriteria example) {
        long count = this.syncDataItemMapper.countByExample(example);
        logger.debug("count: {}", count);
        return count;
    }

    @DataSourceAnnotation(DynamicDataSourceSwitcher.portal)
    public SyncDataItem selectByPrimaryKey(Long id) {
        return this.syncDataItemMapper.selectByPrimaryKey(id);
    }

    @DataSourceAnnotation(DynamicDataSourceSwitcher.portal)
    public List<SyncDataItem> selectByExample(SyncDataItemCriteria example) {
        return this.syncDataItemMapper.selectByExample(example);
    }

    @DataSourceAnnotation(DynamicDataSourceSwitcher.portal)
    public int deleteByPrimaryKey(Long id) {
        return this.syncDataItemMapper.deleteByPrimaryKey(id);
    }

    @DataSourceAnnotation(DynamicDataSourceSwitcher.portal)
    public int updateByPrimaryKeySelective(SyncDataItem record) {
        return this.syncDataItemMapper.updateByPrimaryKeySelective(record);
    }

    @DataSourceAnnotation(DynamicDataSourceSwitcher.portal)
    public int updateByPrimaryKey(SyncDataItem record) {
        return this.syncDataItemMapper.updateByPrimaryKey(record);
    }

    @DataSourceAnnotation(DynamicDataSourceSwitcher.portal)
    public int deleteByExample(SyncDataItemCriteria example) {
        return this.syncDataItemMapper.deleteByExample(example);
    }

    @DataSourceAnnotation(DynamicDataSourceSwitcher.portal)
    public int updateByExampleSelective(SyncDataItem record, SyncDataItemCriteria example) {
        return this.syncDataItemMapper.updateByExampleSelective(record, example);
    }

    @DataSourceAnnotation(DynamicDataSourceSwitcher.portal)
    public int updateByExample(SyncDataItem record, SyncDataItemCriteria example) {
        return this.syncDataItemMapper.updateByExample(record, example);
    }

    @DataSourceAnnotation(DynamicDataSourceSwitcher.portal)
    public int insert(SyncDataItem record) {
        return this.syncDataItemMapper.insert(record);
    }

    @DataSourceAnnotation(DynamicDataSourceSwitcher.portal)
    public int insertSelective(SyncDataItem record) {
        return this.syncDataItemMapper.insertSelective(record);
    }
}