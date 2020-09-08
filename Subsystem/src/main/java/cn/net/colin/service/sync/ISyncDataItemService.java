package cn.net.colin.service.sync;

import cn.net.colin.model.sync.SyncDataItem;
import cn.net.colin.model.sync.SyncDataItemCriteria;

import java.util.List;

public interface ISyncDataItemService {
    long countByExample(SyncDataItemCriteria example);

    SyncDataItem selectByPrimaryKey(Long id);

    List<SyncDataItem> selectByExample(SyncDataItemCriteria example);

    int deleteByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(SyncDataItem record);

    int updateByPrimaryKey(SyncDataItem record);

    int deleteByExample(SyncDataItemCriteria example);

    int updateByExampleSelective(SyncDataItem record, SyncDataItemCriteria example);

    int updateByExample(SyncDataItem record, SyncDataItemCriteria example);

    int insert(SyncDataItem record);

    int insertSelective(SyncDataItem record);
}