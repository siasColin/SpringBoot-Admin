package cn.net.colin.task.common;

import cn.net.colin.common.config.RsaKeyProperties;
import cn.net.colin.common.util.IdWorker;
import cn.net.colin.common.util.JwtUtils;
import cn.net.colin.common.util.RsaUtils;
import cn.net.colin.model.sysManage.SysUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;

import java.io.File;

/**
 * @Package: cn.net.colin.task.common
 * @Author: sxf
 * @Date: 2020-10-14
 * @Description: 项目启动后执行一些初始化任务
 */
@Component
public class Init implements ApplicationRunner {
    @Value("${snowflake.workerId:0}")
    private long workerId;
    @Autowired
    private RsaKeyProperties prop;

    @Override
    public void run(ApplicationArguments args) throws Exception {
        //初始化id生成器
        IdWorker.init(workerId);
        generateKeyInit();
        JwtUtils.generateTokenExpireInSeconds(new SysUser(), prop.getPrivateKey(), 3);
    }

    public void generateKeyInit() {
        File pubKeyFile = new File(prop.getPubKeyFile());
        File priKeyFile = new File(prop.getPriKeyFile());
        if (!pubKeyFile.exists() || !priKeyFile.exists()) {
            File pubKeyFilePath = pubKeyFile.getParentFile();
            File priKeyFilePath = priKeyFile.getParentFile();
            if (!pubKeyFilePath.exists()) {
                pubKeyFilePath.mkdirs();
            }
            if (priKeyFilePath.exists()) {
                priKeyFilePath.mkdirs();
            }
            try {
                RsaUtils.generateKey(prop.getPubKeyFile(), prop.getPriKeyFile(), "colin", 2048);
                prop.createRsaKey();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
