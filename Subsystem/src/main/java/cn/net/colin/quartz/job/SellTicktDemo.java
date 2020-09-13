package cn.net.colin.quartz.job;

import cn.net.colin.common.helper.RedisLock;
import cn.net.colin.common.helper.RedisUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * 多线程模拟售票，多个窗口售票
 * @author ma
 *
 */
//@Component
public class SellTicktDemo implements  Runnable {

    @Autowired
    private RedisLock redisLock;

    /*
     * 需求：多线程模拟售票，多个窗口售票
     *
     * 分析：
     *  A.需要的类
     *      1.建立一个多线程的类SellTicktDemo
     *      2.创建一个测试类SellTicktDemoTest
     *  B.类的关系
     *      1.多线程的类SellTicktDemo，实现Runnable接口，重写run()方法
     *      2.SellTicktDemoTest 测试多线程类
     *  C.实现多线程同步
     *      1.用synchronized()方法实现线程同步
     *  D.在SellTicktDemoTest中实现多数窗口
     *
     */

    //定义票的总数
    private int total = 100;
    public void setTotal(int t){
        total = t;
    }

    //定义票的编号
    private int no = total+1;

    //定义一个线程同步对象
    private Object obj = new Object();

    @Override
    public void run() {

            //同步锁
//            synchronized(this.obj){
                boolean lock = redisLock.lock("SellTicktLock",5,10000l);
                if(lock){
                    try{
                        if(this.total > 0){
                            try {
                                Thread.sleep(100);
                            } catch (InterruptedException e) {
                                e.printStackTrace();
                            }
                            String msg = Thread.currentThread().getName()+" 售出第   "+(this.no -this.total) +"  张票";
                            System.out.println(msg);
                            this.total--;
                        }else{
                            System.out.println(Thread.currentThread().getName()+"票已售完，请下次再来！");
                        }
                    }finally {
                        redisLock.unlock("SellTicktLock");
                    }

                }
//            }

    }
}
