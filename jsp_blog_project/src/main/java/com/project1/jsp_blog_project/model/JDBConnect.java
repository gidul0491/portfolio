package com.project1.jsp_blog_project.model;

import javax.servlet.ServletConfig;
import javax.servlet.annotation.WebServlet;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Stack;


public class JDBConnect {
    protected Connection conn;
    protected Statement stmt;
    protected PreparedStatement pstmt;
    protected ResultSet rs;
    private String dbDriver;
    private String dbUrl;
    private String dbUserId;
    private String dbUserPw;

    String timenow() {
        Date now = new Date(System.currentTimeMillis());
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
        return "[" + sdf1.format(now) + "] ";
    }

    public JDBConnect() {
        dbDriver = "com.mysql.cj.jdbc.Driver";
        dbUrl = "jdbc:mysql://localhost:3306/blog_project?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
        dbUserId = "full505";
        dbUserPw = "full505";

    }
    public void dbOpen(){
        try {
            //JDBC 드라이버 로드
            Class.forName(dbDriver);
            conn = DriverManager.getConnection(dbUrl, dbUserId, dbUserPw);
            System.out.println(timenow() + "DB 연결 성공");
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
    public JDBConnect(String dbDriver, String dbUrl, String dbUserId, String dbUserPw) {
        try {
            //JDBC 드라이버 로드
            Class.forName(dbDriver);
            conn = DriverManager.getConnection(dbUrl, dbUserId, dbUserPw);
            System.out.println("\n\n" + timenow() + "DB 연결 성공");
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    public void dbClose() {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
            System.out.println(timenow() + "DB 연결 해제 \n\n");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
