package cn.net.colin;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.EnableAspectJAutoProxy;


/**
 * 使用注解事务时
 * @EnableTransactionManagement
 * 		springboot在TransactionAutoConfiguration已经启用，无需重复开启。
 */
@SpringBootApplication()
@MapperScan(value = "cn.net.colin.mapper.*")
public class SubsystemApplication {

	public static void main(String[] args) {
		SpringApplication.run(SubsystemApplication.class, args);
	}

}
