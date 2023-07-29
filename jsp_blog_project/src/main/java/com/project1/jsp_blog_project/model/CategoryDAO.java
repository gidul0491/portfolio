package com.project1.jsp_blog_project.model;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;

public class CategoryDAO extends JDBConnect {
    public ArrayList<CategoryDTO> selectCategoryList(boolean includeTemporarySaved, boolean isManager) {
        String doesIncludeClosed = "no";
        ArrayList<CategoryDTO> categoryList = new ArrayList<>();
        String sql = "SELECT category_name, category_post_cnt, category_num ";
        sql += "FROM board_category ";
        if (!includeTemporarySaved) {
            sql += "WHERE category_num != 0 ";
        }
        sql += "ORDER BY category_num ASC ";
        System.out.println(sql);
        if (isManager) {
            doesIncludeClosed = "yes";
        }
        try {
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                CategoryDTO dto = new CategoryDTO();
                PostDAO postDao = new PostDAO();
                postDao.dbOpen();
                dto.setCategoryName(rs.getString("category_name"));
                dto.setCategoryPostCnt(postDao.totalPostCount(dto.getCategoryName(), doesIncludeClosed));
                dto.setCategoryNum(rs.getInt("category_num"));
                categoryList.add(dto);
                postDao.dbClose();
                System.out.println(timenow() + dto.categoryNum + "번 카테고리" + dto.categoryName + " 확인" + dto.categoryPostCnt);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categoryList;
    }

    public int insertOrUpdate(String[] arr) {
        int result = 0;

        String sql = "INSERT INTO blog_project.board_category (category_name, category_num) ";
        sql += "VALUES ( ? , ? ) ON DUPLICATE KEY UPDATE category_name = ? , category_num = ? ";

        int i = 1;
        for (String cate : arr) {
            try {
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, cate);
                pstmt.setInt(2, i);
                pstmt.setString(3, cate);
                pstmt.setInt(4, i);
                System.out.println(sql);
                result += pstmt.executeUpdate();
                System.out.println(timenow() + "insert : " + result);
            }
            catch (SQLException e) {
                System.out.println("****** 카테고리 INSERT문 오류 발생 ******");
                System.out.println(timenow() + "Error : " + e.getMessage());
                e.printStackTrace();
            }
            i++;
        }
        return result;
    }

    public int deleteNotIn(String[] arr) {
        int result = 0;
        String sql = "DELETE FROM board_category ";
        if (arr.length > 0) {
            sql += "WHERE category_name not in ('tempSaved', ";
            for (String category : arr) {
                sql += "'" + category + "',";
            }
            sql = sql.substring(0, sql.length() - 1);
            sql += ") ";
            System.out.println(sql);
        }
        try {
            stmt = conn.createStatement();
            result = stmt.executeUpdate(sql);
            System.out.println(timenow() + "삭제 쿼리 실행결과 : " + result);
        } catch (SQLException e) {
            System.out.println("****** 관리자 삭제 중 오류 발생 ******");
            System.out.println(timenow() + "Error : " + e.getMessage());
            e.printStackTrace();
        }
        return result;
    }

}
