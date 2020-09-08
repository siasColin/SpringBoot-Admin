package cn.net.colin.common;

/**
 * @Package: cn.net.colin.common
 * @Author: sxf
 * @Date: 2020-9-8
 * @Description: 公用常量实体类
 */
public class Constants {
    public final static String LOCK_SUFFIX = "_redis_lock";
    //数据同步全局锁 key
    public final static String SYNCDATA_LOCK = "SyncDataLock";
    //用户和角色表全局锁 key
    public final static String USERANDROLE_LOCK = "UserRoleLock";
    //地区表全局锁 key
    public final static String AREA_LOCK = "AreaLock";
    //机构表全局锁 key
    public final static String ORG_LOCK = "OrgLock";
    //角色和菜单表全局锁 key
    public final static String ROLEMENU_LOCK = "RoleMenuLock";
    //角色和权限表全局锁 key
    public final static String ROLEPERMISSION_LOCK = "RolePermissionLock";
}
