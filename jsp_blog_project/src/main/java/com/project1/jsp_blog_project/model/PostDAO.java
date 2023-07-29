package com.project1.jsp_blog_project.model;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

public class PostDAO extends JDBConnect{

    public int deletePost(int postPk){
        int result = 0;

        String sql = "DELETE FROM board_post WHERE post_pk=? ";

        try{
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, postPk);

            result = pstmt.executeUpdate();
            System.out.println(timenow()+ "게시글 "+ postPk+" 삭제 완료");
        }
        catch (SQLException e){
            System.out.println("****** 데이터 삭제 중 오류 발생 ******");
            System.out.println(timenow()+"Error : "+e.getMessage());
            e.printStackTrace();
        }
        return result;
    }
    public PostDAO(){super();}
    public int editPost(PostDTO post){
        int result =0;

        String sql="UPDATE board_post ";
        sql += "SET post_category=?, post_title=?, post_content=?,post_open=?, post_edited = 1 , post_pass = ? , post_ofile = ?, post_sfile = ? ";
        sql += "WHERE post_pk = ? ";
        try{
            pstmt =conn.prepareStatement(sql);
            pstmt.setString(1, post.getPostCategory());
            pstmt.setString(2, post.getPostTitle());
            pstmt.setString(3, post.getPostContent());
            pstmt.setString(4, post.getPostOpen());
            pstmt.setString(5, post.getPostPass());
            pstmt.setString(6, post.getPostOfile());
            pstmt.setString(7, post.getPostSfile());
            pstmt.setInt(8, post.getPostPk());

            result=pstmt.executeUpdate();
            System.out.println(timenow()+ "게시글 수정 완료");
        }
        catch (SQLException e){
            System.out.println("****** update문 실행 중 오류 발생 ******");
            System.out.println(timenow()+"Error : "+e.getMessage());
            e.printStackTrace();
        }
        return result;
    }
    public int newPost(PostDTO post){
        int result =0;

        String sql="INSERT INTO board_post ";
        sql += "(post_category, post_title, post_content, post_writer,post_open, post_datetime, post_pass,post_ofile, post_sfile) ";
        sql += "VALUES (?, ?, ?, ?,?, NOW(), ?,?,?) ";
        try{
            pstmt =conn.prepareStatement(sql);
            pstmt.setString(1, post.getPostCategory());
            pstmt.setString(2, post.getPostTitle());
            pstmt.setString(3, post.getPostContent());
            pstmt.setString(4, post.getPostWriter());
            pstmt.setString(5, post.getPostOpen());
            pstmt.setString(6, post.getPostPass());
            pstmt.setString(7, post.getPostOfile());
            pstmt.setString(8, post.getPostSfile());
            result=pstmt.executeUpdate();
            System.out.println(timenow()+ "게시글 업로드 완료");

        }
        catch (SQLException e){
            System.out.println("****** INSERT문 실행 중 오류 발생 ******");
            System.out.println(timenow()+"Error : "+e.getMessage());
            e.printStackTrace();
        }


        return result;
    }


    // 게시글 개수 가져오기
    public int totalPostCount(String category, String includeClosed){

        String where = "";
        if(category.equals("all")){
            if(where.equals("")){where = "WHERE ";}
            where += "post_category != 'tempSaved' ";
        }
        else{
            if(where.equals("")){where = "WHERE ";}
            where += "post_category = '"+category+"' ";
            if(category.equals("tempSaved")){where+="OR post_category is null";}}
        // 매개변수 open이 yes가 아니면 비공개 글은 제외
        if (!includeClosed.equals("yes")){
            if(where.equals("")){where += "WHERE ";}
            else{where+="AND ";}
            where += "post_open != 3 ";
        }
        int result=0;
        String sql = "SELECT count(*) AS cnt FROM board_post ";
        sql+= where;
        System.out.println(sql);
        try{
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
            while(rs.next()){
                result = rs.getInt("cnt");
            }
            System.out.println(timenow() + "게시글 수 가져오기 완료" );
        }
        catch(SQLException e){
            System.out.println("totalPostCount SELECT명령 사용 중 오류 발생");
            e.printStackTrace();
        }
        return result;
    }

    // start부터 end까지 게시글 출력
    public List<PostDTO> selectPostList(int start, int end, String category, String open) {
        String where = "";
        if(category.equals("all")){
            if(where.equals("")){where = "WHERE ";}
            where += "post_category != 'tempSaved' ";
        }
        else{
            if(where.equals("")){where = "WHERE ";}
            where += "post_category = '"+category+"' ";
            if(category.equals("tempSaved")){
                where += "OR post_category is null ";
            }
        }
        if (!open.equals("yes")){
            if(where.equals("")){where += "WHERE ";}
            else{where+="AND ";}
            where += "post_open != 3 ";
        }

        List<PostDTO> list = new ArrayList<>();
        String sql = "SELECT post_pk, post_category, post_open, post_title, post_writer ";
        sql += ", post_datetime,post_edited, post_comment_cnt, post_visit ";
        sql += "FROM board_post ";
        sql += where;
        sql += "ORDER BY post_pk DESC ";
        sql += "LIMIT ?, ? ";
        System.out.println(sql);
        try{
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, start-1);
            pstmt.setInt(2, end);
            rs = pstmt.executeQuery();

            while(rs.next()){
                PostDTO dto = new PostDTO();
                int i = rs.getInt("post_pk");
                dto.setPostPk(i);
                int j = rs.getInt("post_open");
                String openType = "";
                if (j==2){openType+="[비밀글]";}
                else if (j==3){openType+="[비공개]";}
                String edited = "";
                int k = rs.getInt("post_edited");
                if(k==1){edited+="(수정됨)";}
                dto.setPostCategory(rs.getString("post_category"));
                dto.setPostOpen(openType);
                dto.setPostTitle(rs.getString("post_title"));
                dto.setPostCommentCnt(rs.getInt("post_comment_cnt"));
                dto.setPostWriter(rs.getString("post_writer"));
                dto.setPostDatetime(rs.getString("post_datetime"));
                dto.setPostEdited(edited);
                dto.setPostVisit(rs.getInt("post_visit"));
                list.add(dto);
                System.out.println(timenow() + i +"번 게시글 목록에 추가 완료" );
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        return list;
    }


    //  지정한 게시물 내용 출력
    public PostDTO selectPost(int postPk) {
        PostDTO dto = new PostDTO();
        String sql = "SELECT post_pk, post_category, post_title ";
        sql += ", post_content, post_writer, post_datetime,post_edited, post_visit ";
        sql += ", post_ofile, post_sfile, post_like, post_open FROM board_post ";
        sql += "WHERE post_pk = " + postPk +" ";
        try {
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);

            while(rs.next()){
                int i = rs.getInt("post_pk");
                dto.setPostPk(i);
                int j = rs.getInt("post_open");
                String openType = "";
                if (j==2){openType+="[비밀글]";}
                else if (j==3){openType+="[비공개]";}
                String edited = "";
                int k = rs.getInt("post_edited");
                if(k==1){edited+="(수정됨)";}
                dto.setPostOpen(openType);
                dto.setPostEdited(edited);
                dto.setPostCategory(rs.getString("post_category"));
                dto.setPostTitle(rs.getString("post_title"));
                dto.setPostContent(rs.getString("post_content"));
                dto.setPostWriter(rs.getString("post_writer"));
                dto.setPostDatetime(rs.getString("post_datetime"));
                dto.setPostVisit(rs.getInt("post_visit"));
                dto.setPostLike(rs.getInt("post_like"));
                dto.setPostOfile(rs.getString("post_ofile"));
                dto.setPostSfile(rs.getString("post_sfile"));
                System.out.println(timenow() + i +"번 게시글 로딩완료" );
            }
        }
        catch (SQLException e){
            System.out.println("게시글 조회 중 오류 발생");
            e.printStackTrace();
        }
        return dto;
    }
    public void updatePostVisit(int postPk){
        String sql = "UPDATE board_post SET post_visit=post_visit+1 WHERE post_pk=?";

        try{
            pstmt =conn.prepareStatement(sql);
            pstmt.setInt(1,postPk);
            pstmt.executeUpdate();
            System.out.println(timenow()+"게시글 조회수 업데이트 완료");
        }
        catch (SQLException e){
            System.out.println("****** 조회수 업데이트 중 오류 발생 ******");
            System.out.println(timenow()+"Error : "+e.getMessage());
            e.printStackTrace();
        }
    }
    public String privatePass(int postPk, String givenPass){
        String pass = "no";
        String sql = "SELECT count(*) AS cnt FROM board_post WHERE post_pk = ? AND post_pass = ? ";
        try {
            int result = 0;
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, postPk);
            pstmt.setString(2, givenPass);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                result += rs.getInt("cnt");
            }
            if(result >=1 ){
                pass="yes";
            }
            System.out.println(sql);
            System.out.println("secretPass 확인 : "+pass);
        }
        catch (SQLException e){
            System.out.println("****** secretPass 확인 중 오류 발생 ******");
            System.out.println(timenow()+"Error : "+e.getMessage());
            e.printStackTrace();
        }

        return pass;
    }

    public int updateLike(int postPk){
        int result = 0;
        String sql = "UPDATE blog_project.board_post SET post_like = post_like + 1 WHERE post_pk = ? ";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, postPk);
            result = pstmt.executeUpdate();
            System.out.println(timenow() + " updateLike : " + result);
        } catch (SQLException e) {
            System.out.println("****** 조회수 업데이트 중 오류 발생 ******");
            System.out.println(timenow() + "Error : " + e.getMessage());
            e.printStackTrace();
        }
        return result;
    }

    public int deleteLike(int postPk){
        int result = 0;
        String sql = "UPDATE blog_project.board_post SET post_like = post_like -1 WHERE post_pk = ? ";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, postPk);
            result = pstmt.executeUpdate();
            System.out.println(timenow() + " deleteLike : " + result);
        } catch (SQLException e) {
            System.out.println("****** 조회수 업데이트 중 오류 발생 ******");
            System.out.println(timenow() + "Error : " + e.getMessage());
            e.printStackTrace();
        }
        return result;
    }

}
