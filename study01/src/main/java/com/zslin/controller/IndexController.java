package com.zslin.controller;

import com.aliyun.oss.OSSClient;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.Iterator;

/**
 * Created by zslin.com on 2016/10/13.
 */
@RestController
@RequestMapping(value = "/ajax/aili")
public class IndexController {

    private static final Logger logger = LoggerFactory.getLogger(IndexController.class);

    @RequestMapping(value = "index")
    public String index() {

        return "Hello World!!!";
    }



    @RequestMapping(value = {"/uploadFile"}, method = RequestMethod.POST, produces = {"text/javascript;charset=UTF-8"})
    @ResponseBody
    public String uploadFile(HttpServletRequest request, HttpServletResponse response)
            throws IllegalStateException, IOException
    {
        // 创建一个通用的多部分解析器
        CommonsMultipartResolver multipartResolver =
                new CommonsMultipartResolver(request.getSession().getServletContext());
        // 判断 request 是否有文件上传,即多部分请求
        if (multipartResolver.isMultipart(request))
        {
            // 转换成多部分request
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest)request;
            // 取得request中的所有文件名
            Iterator<String> iter = multiRequest.getFileNames();
            //此处只上传单个文件，如果需要多个文件只需要改为while循环上传
            if (iter.hasNext())
            {
                // 记录上传过程起始时的时间，用来计算上传时间
                int pre = (int)System.currentTimeMillis();
                // 取得上传文件
                MultipartFile file = multiRequest.getFile(iter.next());
                if (file != null)
                {
                    // 取得当前上传文件的文件名称
                    String myFileName = file.getOriginalFilename();
                    // 如果名称不为“”,说明该文件存在，否则说明该文件不存在
                    if (StringUtils.isNotEmpty(myFileName.trim()))
                    {
                        String endpoint = "http://oss-cn-shanghai.aliyuncs.com";
                        // accessKey请登录https://ak-console.aliyun.com/#/查看
                        String accessKeyId = "LTAIsUgqzKs3huub";
                        String accessKeySecret = "9Y68gpgPc23PbhDaOujLqOqDCMcCRe";

                        // 创建OSSClient实例
                        OSSClient ossClient = new OSSClient(endpoint, accessKeyId, accessKeySecret);
                        ossClient.putObject("oss对象存储的空间名称", file.getOriginalFilename(), file.getInputStream());
                        // 使用访问OSS

                        // 关闭ossClient
                        ossClient.shutdown();
                    }
                }
                // 记录上传该文件后的时间
                int finaltime = (int)System.currentTimeMillis();

                logger.info("上传花费时间：" + (finaltime - pre));
            }

        }
        return "success";
    }



    @RequestMapping("/now")
    String hehe() {
        return "现在时间：" + (new Date()).toLocaleString();
    }
}
