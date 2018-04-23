package com.shop.primary.controller;

import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

@Controller
@RequestMapping("img")
public class UploadController {

    @RequestMapping("upload")
    public String upload(){
        return "upload";
    }

    @RequestMapping("toUpload")
    @ResponseBody
    public Map imgUpload(HttpServletRequest request){
        Map map = new HashMap();
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());
        if (multipartResolver.isMultipart(request)) {
            //转换成多部分request
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
            //取得request中的所有文件名
            Iterator<String> iterator = multiRequest.getFileNames();
            while (iterator.hasNext()) {
                //取得上传文件
                MultipartFile file = multiRequest.getFile(iterator.next());
                if (file != null) {
                    //原始文件名
                    String oldFileName = file.getOriginalFilename();
                    if (StringUtils.isEmpty(oldFileName)) {
                        map.put("status", "false");
                        map.put("msg", "");
                        return map;
                    }
                    //后缀名
                    String extName = oldFileName.substring(oldFileName.lastIndexOf("."));
                    //新的文件
                    //文件上传
                    try (InputStream inputStream=  file.getInputStream()){
                        File file1 = new File("d:/xth/shop/target/shop/static/upload");///Users/xuzhiyun/project
                        if (!file1.exists()) {
                            file1.mkdirs();
                        }
                        OutputStream os = new FileOutputStream(new File("d:/xth//shop/target/shop/static/upload/"+oldFileName));
                        int bytesRead = 0;
                        byte[] buffer = new byte[8192];
                        while ((bytesRead = inputStream.read(buffer, 0, 8192)) != -1) {
                            os.write(buffer, 0, bytesRead);
                        }
                        os.close();
                        map.put("code", "true");
                        map.put("msg", "上传成功!");
                        map.put("url", "http://localhost:8080/static/upload/"+oldFileName);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                } else {
                    map.put("code", "false");
                    map.put("msg", "文件为空！");
                }
            }
        } else {
            map.put("code","false");
            map.put("msg","文件为空！");
        }
        return map;
    }

}
