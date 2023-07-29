package com.project1.jsp_blog_project.controller;
import com.project1.jsp_blog_project.model.PostDAO;
import com.project1.jsp_blog_project.util.FileUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/blog/Download.do")
public class DownloadController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        String ofile = req.getParameter("ofile");
        String sfile = req.getParameter("sfile");

        // 파일 다운로드
        FileUtils.download(req, resp, "C:\\upload", sfile, ofile);

    }
}
