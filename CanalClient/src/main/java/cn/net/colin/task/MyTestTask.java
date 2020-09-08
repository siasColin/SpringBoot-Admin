package cn.net.colin.task;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @Package: cn.net.colin.task
 * @Author: sxf
 * @Date: 2020-9-5
 * @Description:
 */
@Component
public class MyTestTask {
    @Autowired
    private JobBean jobBean;

    private static final SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

//    @Scheduled(fixedDelay = 1000)
    public void executeUpdateYqTask() {
        System.out.println(Thread.currentThread().getName() + " >>> task one " + format.format(new Date()));
    }

//    @Scheduled(fixedDelay = 1000)
    public void executeRepaymentTask() throws InterruptedException {
        Thread thread = Thread.currentThread();
        System.out.println(thread + " >>> task two " + format.format(new Date()));
        Thread.sleep(5000);
        jobBean.dojob(thread.getName());
    }
}