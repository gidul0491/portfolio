package com.project1.jsp_blog_project.model;

import java.sql.SQLException;

public class VisitorDAO extends JDBConnect{
    public int updateTotal(){
        int result = 0;
        String sql = "insert into blog_project.visitor (date, total) values(date_format(now(), '%y%m%d'),  ";
        sql += "(SELECT total FROM blog_project.visitor v WHERE date=(select max(date) AS date ";
        sql += "FROM blog_project.visitor v2 WHERE date != (date_format(now(),'%y%m%d'))) )+1) ";
        sql += "on duplicate key update date = date_format(now(), '%y%m%d'), total = (select total from blog_project.visitor v ";
        sql += "where date = date_format(now(), '%y%m%d'))+1 ";
        try {
            stmt = conn.createStatement();
            result = stmt.executeUpdate(sql);
            System.out.println(timenow() + "조회수 쿼리 실행결과 : " + result);
        } catch (SQLException e) {
            System.out.println("****** 조회수 업데이트 중 오류 발생 ******");
            System.out.println(timenow() + "Error : " + e.getMessage());
            e.printStackTrace();
        }
        return result;
    }
    public int lastTotal(){
        int result = 0;
        String sql = "SELECT total FROM blog_project.visitor WHERE date=(select max(date) AS date FROM blog_project.visitor WHERE date != (date_format(now(),'%y%m%d'))) ";
        try {
            stmt = conn.createStatement();
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
            while(rs.next()){
                result = rs.getInt("total");
            }
            System.out.println(timenow() + " lastTotal : " + result);
        } catch (SQLException e) {
            System.out.println("****** 조회수 업데이트 중 오류 발생 ******");
            System.out.println(timenow() + "Error : " + e.getMessage());
            e.printStackTrace();
        }
        return result;
    }

    public int today(){
        int result = 0;
        String sql = "SELECT total FROM blog_project.visitor WHERE date = date_format(now(), '%y%m%d') ";
        try {
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
            while(rs.next()){
                result = rs.getInt("total");
            }
            System.out.println(timenow() + " todayTotal : " + result);
        } catch (SQLException e) {
            System.out.println("****** 조회수 업데이트 중 오류 발생 ******");
            System.out.println(timenow() + "Error : " + e.getMessage());
            e.printStackTrace();
        }
        return result;
    }
}
