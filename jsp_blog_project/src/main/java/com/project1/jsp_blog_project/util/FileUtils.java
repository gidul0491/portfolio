package com.project1.jsp_blog_project.util;

import com.oreilly.servlet.MultipartRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

public class FileUtils {
    static String timenow() {
        Date now = new Date(System.currentTimeMillis());
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
        return "[" + sdf1.format(now) + "] ";
    }
    public static MultipartRequest uploadFile(HttpServletRequest req, String saveDir, int maxSize) {
        try {
            return new MultipartRequest(req, saveDir, maxSize, "UTF-8");
        } catch (Exception e) {
            System.out.println("****** 파일 업로드 중 오류 발생 ******");
            System.out.println(timenow() + "Error : " + e.getMessage());
            e.printStackTrace();

        }
        return null;
    }
    public static void download(HttpServletRequest req, HttpServletResponse resp, String saveDir, String sfileName, String ofileName){
        try{
            File file = new File(saveDir, sfileName);
            InputStream iStream = new FileInputStream(file);

            String client = req.getHeader("User-Agent");
            if(client.indexOf("WOW64")==-1){
                ofileName = new String(ofileName.getBytes("UTF-8"), "ISO-8859-1");
            }
            else{
                ofileName = new String(ofileName.getBytes("KSC5601"), "ISO-8859-1");
            }
            resp.reset();
            resp.setContentType("application/octet-stream");
            resp.setHeader("Content-Disposition", "attachment; filename=\""+ofileName+"\"");
            resp.setHeader("Content-Length", ""+file.length());
            OutputStream oStream = resp.getOutputStream();

            byte[] b = new byte[(int)file.length()];
            int readBuffer = 0;
            while((readBuffer = iStream.read(b))>0){
                oStream.write(b,0,readBuffer);
            }
        }
        catch (Exception e){
            System.out.println("****** 파일 다운로드 중 오류 발생 ******");
            System.out.println(timenow() + "Error : " + e.getMessage());
            e.printStackTrace();
//            JSFunc.alertBack("다운로드 중 오류 발생");
        }
    }
    public static String truncateString(String input, int num) {
        if (input.length() > num) {
            input = input.substring(0, num) + "..."; // 30글자 이후로 "..." 추가
        }
        return input;
    }
}
