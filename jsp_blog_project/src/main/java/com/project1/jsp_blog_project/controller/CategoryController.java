package com.project1.jsp_blog_project.controller;

import com.project1.jsp_blog_project.model.CategoryDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/blog/CategoryController.do")
public class CategoryController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String[] categoryArr;
        if (req.getParameterValues("categoryArr") != null) {
            categoryArr = req.getParameterValues("categoryArr");
            System.out.println(categoryArr);
            CategoryDAO dao = new CategoryDAO();
            dao.dbOpen();
            dao.deleteNotIn(categoryArr);
            dao.insertOrUpdate(categoryArr);
            dao.dbClose();
        }
        resp.sendRedirect("/blog/ManagerController.do");
    }
}
