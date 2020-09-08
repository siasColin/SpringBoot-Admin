package cn.net.colin.model.sync;

import java.io.Serializable;
import java.util.Date;

/** 
 * 子系统同步DML数据记录表 sys_sync_data_item
 * @author sxf code generator
 * date:2020/09/06 11:45
 */
public class SyncDataItem implements Serializable {
    /** 
     * 串行版本ID
    */
    private static final long serialVersionUID = 2943585454563769462L;

    /** 
     * 主键ID
     */ 
    private Long id;

    /** 
     * DML数据记录表id
     */ 
    private Long dataId;

    /** 
     * 项目名称
     */ 
    private String applicationName;

    /** 
     * 状态（-1 推送失败 、0 待同步、1 已同步、2 同步失败）  默认：0
     */ 
    private Integer syncStatus;

    /** 
     * 数据同步时间
     */ 
    private Date syncTime;

    /** 
     * 创建时间
     */ 
    private Date createTime;

    /** 
     * 获取 主键ID sys_sync_data_item.id
     * @return 主键ID
     */
    public Long getId() {
        return id;
    }

    /** 
     * 设置 主键ID sys_sync_data_item.id
     * @param id 主键ID
     */
    public void setId(Long id) {
        this.id = id;
    }

    /** 
     * 获取 DML数据记录表id sys_sync_data_item.data_id
     * @return DML数据记录表id
     */
    public Long getDataId() {
        return dataId;
    }

    /** 
     * 设置 DML数据记录表id sys_sync_data_item.data_id
     * @param dataId DML数据记录表id
     */
    public void setDataId(Long dataId) {
        this.dataId = dataId;
    }

    /** 
     * 获取 项目名称 sys_sync_data_item.application_name
     * @return 项目名称
     */
    public String getApplicationName() {
        return applicationName;
    }

    /** 
     * 设置 项目名称 sys_sync_data_item.application_name
     * @param applicationName 项目名称
     */
    public void setApplicationName(String applicationName) {
        this.applicationName = applicationName == null ? null : applicationName.trim();
    }

    /** 
     * 获取 状态（0 待同步、1 已同步、2 同步失败） sys_sync_data_item.sync_status
     * @return 状态（0 待同步、1 已同步、2 同步失败）
     */
    public Integer getSyncStatus() {
        return syncStatus;
    }

    /** 
     * 设置 状态（0 待同步、1 已同步、2 同步失败） sys_sync_data_item.sync_status
     * @param syncStatus 状态（0 待同步、1 已同步、2 同步失败）
     */
    public void setSyncStatus(Integer syncStatus) {
        this.syncStatus = syncStatus;
    }

    /** 
     * 获取 数据同步时间 sys_sync_data_item.sync_time
     * @return 数据同步时间
     */
    public Date getSyncTime() {
        return syncTime;
    }

    /** 
     * 设置 数据同步时间 sys_sync_data_item.sync_time
     * @param syncTime 数据同步时间
     */
    public void setSyncTime(Date syncTime) {
        this.syncTime = syncTime;
    }

    /** 
     * 获取 创建时间 sys_sync_data_item.create_time
     * @return 创建时间
     */
    public Date getCreateTime() {
        return createTime;
    }

    /** 
     * 设置 创建时间 sys_sync_data_item.create_time
     * @param createTime 创建时间
     */
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append(", id=").append(id);
        sb.append(", dataId=").append(dataId);
        sb.append(", applicationName=").append(applicationName);
        sb.append(", syncStatus=").append(syncStatus);
        sb.append(", syncTime=").append(syncTime);
        sb.append(", createTime=").append(createTime);
        sb.append("]");
        return sb.toString();
    }
}