//package com.project1.jsp_blog_project.controller;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.Cookie;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import java.io.IOException;
//import java.text.SimpleDateFormat;
//import java.util.Calendar;
//
//@WebServlet("/blog/VisitorController.do")
//public class VisitorController extends HttpServlet {
//    @Override
//    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        Calendar today = Calendar.getInstance();
//        SimpleDateFormat dateFormat = new SimpleDateFormat("yy/MM/dd/hhmm");
//        // today.getTime() Calendar 객체의 날짜/시간을 date 객체류 변환
//        String dateString = dateFormat.format(today.getTime());
//        System.out.println(dateString);
//
//        boolean isFirstVisitor = true;
//
//
//        // 쿠키 가져오기
//        Cookie[] cookies = req.getCookies();
//        if (cookies != null) {
//            for (Cookie cookie : cookies) {
//                // 이미 쿠키가 존재하는 경우
//                if (cookie.getName().equals("todayVisitor")) {
//                    if(cookie.getValue().equals(""))
//
//                    isFirstVisitor = false;
//                    break;
//                }
//            }
//        }
//    }
//}
