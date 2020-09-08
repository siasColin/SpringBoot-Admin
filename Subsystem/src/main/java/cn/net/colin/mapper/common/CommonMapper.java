package cn.net.colin.mapper.common;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @Package: cn.net.colin.mapper.common
 * @Author: sxf
 * @Date: 2020-3-29
 * @Description:
 */
public interface CommonMapper {
    List<Map<String,Object>> fromVerifyByCode(Map<String,Object> map);
    int insertBatchByParams(@Param("list") List<Map<String, Object>> list);

    int updateBatchByParams(@Param("list") List<Map<String, Object>> list);

    int deleteBatchByParams(@Param("list") List<Map<String, Object>> list);
}
