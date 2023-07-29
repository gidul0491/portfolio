package com.project1.jsp_blog_project.model;

import javax.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ManagerDAO extends JDBConnect {
    public ManagerDTO managerLogin(String name, String pw){
        ManagerDTO dto = new ManagerDTO();
        String sql = "SELECT manager_name, manager_email, manager_number FROM manager ";
        sql += "WHERE manager_name = ? AND manager_pw = ? ";
        try{
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, pw);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                dto.setManagerName(rs.getString("manager_name"));
                dto.setManagerEmail(rs.getString("manager_email"));
                dto.setManagerNumber(rs.getInt("manager_number"));
            }
            System.out.println("관리자 확인 : "+dto.getManagerName());
        }
        catch (SQLException e){
            System.out.println("****** 로그인 중 오류 발생 ******");
            System.out.println(timenow()+"Error : "+e.getMessage());
            e.printStackTrace();
        }
        return dto;
    }
    public int editManager(ManagerDTO dto){
        int result =0;
        String sql="UPDATE manager ";
        sql += "SET manager_name=?, manager_email=?, manager_pw=? ";
        sql += "WHERE manager_number = ? ";
        try{
            pstmt =conn.prepareStatement(sql);
            pstmt.setString(1, dto.getManagerName());
            pstmt.setString(2, dto.getManagerEmail());
            pstmt.setString(3, dto.getManagerPass());
            pstmt.setInt(4, dto.getManagerNumber());
            result=pstmt.executeUpdate();
            System.out.println(timenow()+ "관리자정보 수정 완료");
        }
        catch (SQLException e){
            System.out.println("****** INSERT문 실행 중 오류 발생 ******");
            System.out.println(timenow()+"Error : "+e.getMessage());
            e.printStackTrace();
        }
        return result;
    }
    public int deleteManager(String name, String pw){
        int result = 0;
        String sql = "DELETE FROM manager WHERE manager_name=? AND manager_pw=? ";

        try{
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, pw);

            result = pstmt.executeUpdate();
            System.out.println(timenow()+ "삭제 쿼리 실행결과 : " + result);
        }
        catch (SQLException e){
            System.out.println("****** 관리자 삭제 중 오류 발생 ******");
            System.out.println(timenow()+"Error : "+e.getMessage());
            e.printStackTrace();
        }
        return result;
    }
    public List<ManagerDTO> selectManagerList() {
        List<ManagerDTO> list = new ArrayList<>();
        String sql = "SELECT manager_name, manager_email, manager_datetime ";
        sql += "FROM manager ORDER BY manager_number ASC ";

        System.out.println(sql);
        try{
           stmt= conn.createStatement();
            rs = stmt.executeQuery(sql);

            while(rs.next()){
                ManagerDTO dto = new ManagerDTO();
                dto.setManagerName(rs.getString("manager_name"));
                dto.setManagerEmail(rs.getString("manager_email"));
                dto.setManagerDatetime(rs.getString("manager_datetime"));
                list.add(dto);

            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        System.out.println("관리자 목록 불러오기 완료" );
        return list;
    }
    public int signUpManager(ManagerDTO dto){
        int result =0;
        String sql="INSERT INTO manager ";
        sql += "(manager_name, manager_email, manager_pw, manager_datetime) ";
        sql += "VALUES (?, ?,?,  NOW()) ";
        try{
            pstmt =conn.prepareStatement(sql);
            pstmt.setString(1, dto.getManagerName());
            pstmt.setString(2, dto.getManagerEmail());
            pstmt.setString(3, dto.getManagerPass());
            result=pstmt.executeUpdate();
            System.out.println(timenow()+ "관리자 가입 완료");
        }
        catch (SQLException e){
            System.out.println("****** INSERT문 실행 중 오류 발생 ******");
            System.out.println(timenow()+"Error : "+e.getMessage());
            e.printStackTrace();
        }
        return result;
    }
}
