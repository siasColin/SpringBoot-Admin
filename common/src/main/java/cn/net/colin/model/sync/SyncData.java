package cn.net.colin.model.sync;

import java.io.Serializable;
import java.util.Date;

/** 
 * DML数据记录表 sys_sync_data
 * @author sxf code generator
 * date:2020/09/06 11:45
 */
public class SyncData implements Serializable {
    /** 
     * 串行版本ID
    */
    private static final long serialVersionUID = -8954910704673416260L;

    /** 
     * 主键ID
     */ 
    private Long id;

    /** 
     * 创建时间
     */ 
    private Date createTime;

    /** 
     * DML数据内容
     */ 
    private String infoContent;

    /** 
     * 获取 主键ID sys_sync_data.id
     * @return 主键ID
     */
    public Long getId() {
        return id;
    }

    /** 
     * 设置 主键ID sys_sync_data.id
     * @param id 主键ID
     */
    public void setId(Long id) {
        this.id = id;
    }

    /** 
     * 获取 创建时间 sys_sync_data.create_time
     * @return 创建时间
     */
    public Date getCreateTime() {
        return createTime;
    }

    /** 
     * 设置 创建时间 sys_sync_data.create_time
     * @param createTime 创建时间
     */
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    /** 
     * 获取 DML数据内容 sys_sync_data.info_content
     * @return DML数据内容
     */
    public String getInfoContent() {
        return infoContent;
    }

    /** 
     * 设置 DML数据内容 sys_sync_data.info_content
     * @param infoContent DML数据内容
     */
    public void setInfoContent(String infoContent) {
        this.infoContent = infoContent == null ? null : infoContent.trim();
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append(", id=").append(id);
        sb.append(", createTime=").append(createTime);
        sb.append(", infoContent=").append(infoContent);
        sb.append("]");
        return sb.toString();
    }
}