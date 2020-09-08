package cn.net.colin.common.util;

import javax.servlet.http.HttpServletRequest;

/**
 * @Package: cn.net.colin.common.util
 * @Author: sxf
 * @Date: 2020-9-7
 * @Description:
 */
public class RequestUtil {
    public static String getBaseUrl(HttpServletRequest request){
        String path = request.getContextPath();
        String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
        return basePath;
    }
}
