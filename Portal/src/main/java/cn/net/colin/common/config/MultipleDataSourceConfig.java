package cn.net.colin.common.config;

import cn.net.colin.common.util.DynamicDataSource;
import com.alibaba.druid.spring.boot.autoconfigure.DruidDataSourceBuilder;
import com.alibaba.druid.support.http.StatViewServlet;
import com.alibaba.druid.support.http.WebStatFilter;
import com.alibaba.druid.wall.WallConfig;
import com.alibaba.druid.wall.WallFilter;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

import javax.sql.DataSource;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

/**
 * 多数据源bean的配置类
 * Created by sxf on 2020-3-1.
 */
@Configuration
public class MultipleDataSourceConfig {
    @Bean("portal")
    @ConfigurationProperties("spring.datasource.druid.portal")
    public DataSource dataSourceOne(){
        return DruidDataSourceBuilder.create().build();
    }

    /**
     * 设置动态数据源，通过@Primary 来确定主DataSource
     * @return
     */
    @Bean
    @Primary
    public DataSource createDynamicDataSource(@Qualifier("portal") DataSource portal){
        DynamicDataSource dynamicDataSource = new DynamicDataSource();
        //设置默认数据源
        dynamicDataSource.setDefaultTargetDataSource(portal);
        //配置多数据源
        Map<Object, Object> map = new HashMap<>();
        map.put("portal",portal);
        dynamicDataSource.setTargetDataSources(map);
        return  dynamicDataSource;
    }


    //配置Druid的监控
    //1、配置一个管理后台的Servlet
    @Bean
    public ServletRegistrationBean statViewServlet(){
        ServletRegistrationBean bean = new ServletRegistrationBean(new StatViewServlet(), "/druid/*");
        Map<String,String> initParams = new HashMap<>();

        initParams.put("loginUsername","admin");
        initParams.put("loginPassword","123456");
        initParams.put("allow","");//默认就是允许所有访问
//        禁止访问
//        initParams.put("deny","192.168.15.21");

        bean.setInitParameters(initParams);
        return bean;
    }


    //2、配置一个web监控的filter
    @Bean
    public FilterRegistrationBean webStatFilter(){
        FilterRegistrationBean bean = new FilterRegistrationBean();
        bean.setFilter(new WebStatFilter());

        Map<String,String> initParams = new HashMap<>();
        initParams.put("exclusions","*.js,*.css,/druid/*");

        bean.setInitParameters(initParams);

        bean.setUrlPatterns(Arrays.asList("/*"));

        return  bean;
    }
    @Bean
    public WallFilter wallFilter(){
        WallConfig wc = new WallConfig ();
        // 解决 sql批量执行报错 java.sql.SQLException: sql injection violation, multi-statement not allow
        wc.setMultiStatementAllow(true);
        WallFilter wfilter = new WallFilter ();
        wfilter.setConfig(wc);
        return wfilter;
    }
}
