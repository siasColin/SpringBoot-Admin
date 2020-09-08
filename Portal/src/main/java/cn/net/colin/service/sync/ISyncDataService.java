package cn.net.colin.service.sync;

import cn.net.colin.model.sync.SyncData;
import cn.net.colin.model.sync.SyncDataCriteria;

import java.util.List;

public interface ISyncDataService {
    long countByExample(SyncDataCriteria example);

    SyncData selectByPrimaryKey(Long id);

    List<SyncData> selectByExample(SyncDataCriteria example);

    int deleteByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(SyncData record);

    int updateByPrimaryKey(SyncData record);

    int deleteByExample(SyncDataCriteria example);

    int updateByExampleSelective(SyncData record, SyncDataCriteria example);

    int updateByExample(SyncData record, SyncDataCriteria example);

    int insert(SyncData record);

    int insertSelective(SyncData record);
}