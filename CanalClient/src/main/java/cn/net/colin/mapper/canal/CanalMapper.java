package cn.net.colin.mapper.canal;

import cn.net.colin.model.sysManage.SysArea;
import org.apache.ibatis.annotations.Mapper;

/**
 * @author sxf
 * date:2020/03/04 17:48
 */
public interface CanalMapper {
    SysArea selectByPrimaryKey(Long id);
}