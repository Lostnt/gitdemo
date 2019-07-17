package com.bin.controller;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.URLEncoder;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;


import com.bin.pojo.choice;
import lab.DBUtils;
import lab.ScalaMain;
import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import com.bin.pojo.FileSource;

import static org.apache.catalina.startup.ExpandWar.deleteDir;

@Controller
public class ClassController {
    @RequestMapping(value = "/uploadSource")
    @ResponseBody
    public Map<String, Object> uploadSource(@RequestParam(value = "file1", required = false)List<MultipartFile> uploadfile,
                                            HttpServletRequest request) {
        List<FileSource> fileSources = new ArrayList<>();
        // 判断所上传文件是否存在
        if (!uploadfile.isEmpty() && uploadfile.size() > 0) {
            //循环输出上传的文件
            for (MultipartFile file : uploadfile) {
                // 获取上传文件的原始名称

                String originalFilename = file.getOriginalFilename();
                // 设置上传文件的保存地址目录
                String dirPath =
                        request.getServletContext().getRealPath("/upload/");//下载文件夹
                File filePath = new File(dirPath);
                if (!filePath.exists()) {
                    filePath.mkdirs();
                }
                String analyzePath =
                        request.getServletContext().getRealPath("/analyze/");//分析文件夹
                File Path = new File(analyzePath);
                // 如果保存文件的地址不存在，就先创建目录
                if (!Path.exists()) {
                    Path.mkdirs();
                }
                try {
                    // 使用MultipartFile接口的方法完成文件上传到指定位置
                    file.transferTo(new File(dirPath + originalFilename));
                    InputStream input = new FileInputStream(dirPath+ originalFilename);
                    FileOutputStream output = new FileOutputStream(analyzePath+ originalFilename);
                    FileCopyUtils.copy(input, output);
                    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
                    String date = df.format(new Date());// new Date()为获取当前系统时间，也可使用当前时间戳
                    FileSource fileSource = new FileSource();
                    fileSource.setFileName(originalFilename);
                    fileSource.setFileTime(date);
                    fileSources.add(fileSource);
                } catch (Exception e) {
                    e.printStackTrace();
                    return null;
                }
            }
        }
        ScalaMain scala = new ScalaMain();
        scala.startAnalyze();
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("fileSources", fileSources);
        return map;
    }

    @RequestMapping(value = "/downFile")
    public ResponseEntity<byte[]> fileDownload(HttpServletRequest request,
                                               String[] choice) throws Exception{

        // 指定要下载的文件所在路径
        String path = request.getServletContext().getRealPath("/download/");
        File filePath = new File(path);
        // 如果保存文件的地址不存在，就先创建目录
        if (!filePath.exists()) {
            filePath.mkdirs();
        }
        //需要压缩的文件
        List<String> list = new ArrayList<String>();
        int i = 0;
        if(choice[0].equals("on")) {
            i = 1;
        }
        for(;i<choice.length;i++) {
            list.add(choice[i]);
        }

        //压缩后的文件
        String resourcesName = "download.zip";
        ZipOutputStream zipOut = new ZipOutputStream(new FileOutputStream(path+resourcesName));//压缩包路径
        InputStream input = null;
        String dirPath =
                request.getServletContext().getRealPath("/upload/");
        for (String str : list) {
            String name = dirPath+str;
            input = new FileInputStream(new File(name));
            zipOut.putNextEntry(new ZipEntry(str));
            int temp = 0;
            while((temp = input.read()) != -1){
                zipOut.write(temp);
            }
            input.close();
        }
        zipOut.close();
        File file = new File(path+resourcesName);
        HttpHeaders headers = new HttpHeaders();
        resourcesName = this.getFilename(request, resourcesName);
        headers.setContentDispositionFormData("attachment", resourcesName);
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),headers,HttpStatus.OK);
    }

    /**
     * 根据浏览器的不同进行编码设置，返回编码后的文件名
     */
    public String getFilename(HttpServletRequest request, String filename) throws Exception {
        // IE不同版本User-Agent中出现的关键词
        String[] IEBrowserKeyWords = { "MSIE", "Trident", "Edge" };
        // 获取请求头代理信息
        String userAgent = request.getHeader("User-Agent");
        for (String keyWord : IEBrowserKeyWords) {
            if (userAgent.contains(keyWord)) {
                // IE内核浏览器，统一为UTF-8编码显示
                return URLEncoder.encode(filename, "UTF-8");
            }
        }
        // 火狐等其它浏览器统一为ISO-8859-1编码显示
        return new String(filename.getBytes("UTF-8"), "ISO-8859-1");
    }
    @RequestMapping("/select")
    @ResponseBody
    public choice getResult(@RequestBody choice choice){
        String result = null;
        Connection conn = DBUtils.getConnection();
        String sql = "select lessonInfo from "+choice.getChoose()+" where selectType = '"+choice.getText()+"'";
        try {
            Statement statement = conn.createStatement();
            ResultSet rs = statement.executeQuery(sql);
            while(rs.next()){
                result = rs.getString(1);
            }
            rs.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        choice results = new choice();
        results.setText(result);
        return results;
    }

    @RequestMapping("/deleteSource")
    @ResponseBody
    public int deleteSource(){
        int flag = 0;
        Connection conn = DBUtils.getConnection();
        String sql1 = "truncate table class";
        String sql2 = "truncate table classroom";
        String sql3 = "truncate table teacher";
        try {
            Statement statement = conn.createStatement();
            flag = statement.executeUpdate(sql1);
            flag = statement.executeUpdate(sql2);
            flag = statement.executeUpdate(sql3);
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        String path = "D:\\IntelliJ IDEA 2018.1.8\\workplace\\ClassSchedule\\src\\main\\webapp\\upload\\";
        File file = new File(path);
        if (file.isDirectory()) {
            String[] children = file.list();
            //递归删除目录中的子目录下
            for (int i = 0; i < children.length; i++) {
                deleteDir(new File(file, children[i]));
            }
        }
        file.delete();
        flag=1;
        return flag;
    }

    @RequestMapping("/")
    public String getIndexs() {
        return "index";

    }
    @RequestMapping("/index")
    public String getIndex() {
        return "index";
    }

    @RequestMapping("/selectHome")
    public String getSelect() {
        return "select";
    }

}

