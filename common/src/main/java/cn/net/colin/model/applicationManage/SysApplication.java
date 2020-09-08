package cn.net.colin.model.applicationManage;

import java.io.Serializable;
import java.util.Date;

/** 
 * 子系统注册表 sys_application
 * @author sxf code generator
 * date:2020/09/08 14:59
 */
public class SysApplication implements Serializable {
    /** 
     * 串行版本ID
    */
    private static final long serialVersionUID = -3630922355034375265L;

    /** 
     * 主键ID
     */ 
    private Long id;

    /** 
     * 子系统名称/编码（唯一）
     */ 
    private String applicationName;

    /** 
     * 子系统中文名称
     */ 
    private String applicationNameZh;

    /** 
     * 子系统地址
     */ 
    private String applicationUrl;

    /** 
     * 子系统用户名
     */ 
    private String loginName;

    /** 
     * 子系统密码
     */ 
    private String password;

    /** 
     * 创建人
     */ 
    private String createUser;

    /** 
     * 创建时间
     */ 
    private Date createTime;

    /** 
     * 排序
     */ 
    private Integer sortNum;

    /** 
     * 获取 主键ID sys_application.id
     * @return 主键ID
     */
    public Long getId() {
        return id;
    }

    /** 
     * 设置 主键ID sys_application.id
     * @param id 主键ID
     */
    public void setId(Long id) {
        this.id = id;
    }

    /** 
     * 获取 子系统名称/编码（唯一） sys_application.application_name
     * @return 子系统名称/编码（唯一）
     */
    public String getApplicationName() {
        return applicationName;
    }

    /** 
     * 设置 子系统名称/编码（唯一） sys_application.application_name
     * @param applicationName 子系统名称/编码（唯一）
     */
    public void setApplicationName(String applicationName) {
        this.applicationName = applicationName == null ? null : applicationName.trim();
    }

    /** 
     * 获取 子系统中文名称 sys_application.application_name_zh
     * @return 子系统中文名称
     */
    public String getApplicationNameZh() {
        return applicationNameZh;
    }

    /** 
     * 设置 子系统中文名称 sys_application.application_name_zh
     * @param applicationNameZh 子系统中文名称
     */
    public void setApplicationNameZh(String applicationNameZh) {
        this.applicationNameZh = applicationNameZh == null ? null : applicationNameZh.trim();
    }

    /** 
     * 获取 子系统地址 sys_application.application_url
     * @return 子系统地址
     */
    public String getApplicationUrl() {
        return applicationUrl;
    }

    /** 
     * 设置 子系统地址 sys_application.application_url
     * @param applicationUrl 子系统地址
     */
    public void setApplicationUrl(String applicationUrl) {
        this.applicationUrl = applicationUrl == null ? null : applicationUrl.trim();
    }

    /** 
     * 获取 子系统用户名 sys_application.login_name
     * @return 子系统用户名
     */
    public String getLoginName() {
        return loginName;
    }

    /** 
     * 设置 子系统用户名 sys_application.login_name
     * @param loginName 子系统用户名
     */
    public void setLoginName(String loginName) {
        this.loginName = loginName == null ? null : loginName.trim();
    }

    /** 
     * 获取 子系统密码 sys_application.password
     * @return 子系统密码
     */
    public String getPassword() {
        return password;
    }

    /** 
     * 设置 子系统密码 sys_application.password
     * @param password 子系统密码
     */
    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    /** 
     * 获取 创建人 sys_application.create_user
     * @return 创建人
     */
    public String getCreateUser() {
        return createUser;
    }

    /** 
     * 设置 创建人 sys_application.create_user
     * @param createUser 创建人
     */
    public void setCreateUser(String createUser) {
        this.createUser = createUser == null ? null : createUser.trim();
    }

    /** 
     * 获取 创建时间 sys_application.create_time
     * @return 创建时间
     */
    public Date getCreateTime() {
        return createTime;
    }

    /** 
     * 设置 创建时间 sys_application.create_time
     * @param createTime 创建时间
     */
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    /** 
     * 获取 排序 sys_application.sort_num
     * @return 排序
     */
    public Integer getSortNum() {
        return sortNum;
    }

    /** 
     * 设置 排序 sys_application.sort_num
     * @param sortNum 排序
     */
    public void setSortNum(Integer sortNum) {
        this.sortNum = sortNum;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append(", id=").append(id);
        sb.append(", applicationName=").append(applicationName);
        sb.append(", applicationNameZh=").append(applicationNameZh);
        sb.append(", applicationUrl=").append(applicationUrl);
        sb.append(", loginName=").append(loginName);
        sb.append(", password=").append(password);
        sb.append(", createUser=").append(createUser);
        sb.append(", createTime=").append(createTime);
        sb.append(", sortNum=").append(sortNum);
        sb.append("]");
        return sb.toString();
    }
}