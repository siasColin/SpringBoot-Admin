package cn.net.colin.common.properties;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * @Package: cn.net.colin.common.properties
 * @Author: sxf
 * @Date: 2020-9-13
 * @Description: 项目中自定义的一些公用属性
 */
@Component
@ConfigurationProperties(prefix = "custom-common")
public class CustomCommonProperties {
    // 子系统操作门户公用数据后等待时长
    private long subsystemWaitMillis = 1000;

    public long getSubsystemWaitMillis() {
        return subsystemWaitMillis;
    }

    public void setSubsystemWaitMillis(long subsystemWaitMillis) {
        this.subsystemWaitMillis = subsystemWaitMillis;
    }
}
