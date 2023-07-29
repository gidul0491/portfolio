package com.project1.jsp_blog_project.model;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO extends JDBConnect {
    public int newComment(CommentDTO comment, int num, int manager, int postPk){
        int result =0;

        String sql="INSERT INTO board_comment ";
        sql += "(comment_content, comment_name, comment_pass, comment_datetime, comment_manager,comment_post, comment_num ";
        // num==0일때, 즉 대댓달 코멘트 번호가 없는 원글일때 리플라이카운트를 수정할 열에 추가하지않고 괄호를 닫아버림
        if(num==0){ sql += ") "; }
        // num이 0이 아닐때, 즉 대댓일때 리플라이카운트에 -1을 넣기위해 추가하고 괄호를 닫음
        else { sql += ", comment_reply_cnt) ";}
        sql += "VALUES (?, ?, ?, NOW(),?, ? ";
        // 원글일 때 코멘트번호에 기존 최댓값+1을 넣음
        if(num == 0){
            sql += ", ifnull((select max(comment_num)+1 from board_comment c),1) ";
        }
        // 대댓일때 코멘트번호에 파라미터로 가져온 값인 원글의 코멘트번호 num 을 집어넣고, 리플라이카운트는 -1을 집어넣음
        else{
            sql+= ", "+ num +", -1 ";
        }
        sql += ") ";
        try{
            pstmt =conn.prepareStatement(sql);
            pstmt.setString(1, comment.getCommentContent());
            pstmt.setString(2, comment.getCommentName());
            pstmt.setString(3, comment.getCommentPass());
            pstmt.setInt(4, manager);
            pstmt.setInt(5, postPk);
            System.out.println(sql);
            result=pstmt.executeUpdate();
            System.out.println(timenow()+ "댓글 업로드 : "+result+" 매니저 : "+manager+"게시글 : "+postPk);

        }
        catch (SQLException e){
            System.out.println("****** 코멘트 INSERT문 오류 발생 ******");
            System.out.println(timenow()+"Error : "+e.getMessage());
            e.printStackTrace();
        }


        return result;
    }
    public int commentCount(int postPk){
        int result=0;
        String sql = "SELECT count(*) AS cnt FROM board_comment WHERE comment_post = ? ";
        System.out.println(sql);
        try{
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, postPk);
            rs = pstmt.executeQuery();
            while(rs.next()){
                result = rs.getInt("cnt");
            }
            System.out.println(timenow() + postPk +"번글 코멘트 수 " + result );
        }
        catch(SQLException e){
            System.out.println("totalPostCount SELECT명령 사용 중 오류 발생");
            e.printStackTrace();
        }
        return result;
    }

    public List<CommentDTO> selectCommentList(int commentPost) {
        List<CommentDTO> list = new ArrayList<>();
        String sql = "SELECT * ";
        sql += "FROM board_comment WHERE comment_post = ? ";
        sql += "ORDER BY comment_num ASC, comment_pk ASC ";
        System.out.println(sql);
        try{
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, commentPost);

            rs = pstmt.executeQuery();

            while(rs.next()){
                CommentDTO dto = new CommentDTO();
                int i = rs.getInt("comment_pk");
                String edited = "";
                int k = rs.getInt("comment_edited");
                if(k==1){edited="(수정됨)";}
                dto.setCommentPk(i);
                dto.setCommentContent(rs.getString("comment_content"));
                dto.setCommentName(rs.getString("comment_name"));
                dto.setCommentPass(rs.getString("comment_pass"));
                dto.setCommentDatetime(rs.getString("comment_datetime"));
                dto.setCommentNum(rs.getInt("comment_num"));
                dto.setCommentManager(rs.getInt("comment_manager"));
                dto.setCommentReplyCnt(rs.getInt("comment_reply_cnt"));
                dto.setCommentDeleted(rs.getInt("comment_deleted"));
                dto.setCommentEdited(edited);
                list.add(dto);
                System.out.println(timenow() + i +"번 코멘트 목록에 추가 완료" );
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        return list;
    }

    public int editComment(CommentDTO dto){
        int result =0;

        String sql="UPDATE board_comment ";
        sql += "SET comment_name=?, comment_content=?, comment_edited = 1 ";
        sql += "WHERE comment_pk = ? AND comment_pass = ?";
        try{
            pstmt =conn.prepareStatement(sql);
            pstmt.setString(1, dto.getCommentName());
            pstmt.setString(2, dto.getCommentContent());
            pstmt.setInt(3, dto.getCommentPk());
            pstmt.setString(4, dto.getCommentPass());
            result=pstmt.executeUpdate();
            System.out.println(timenow()+ "댓글 수정 : "+result);
        }
        catch (SQLException e){
            System.out.println("****** edit 실행 중 오류 발생 ******");
            System.out.println(timenow()+"Error : "+e.getMessage());
            e.printStackTrace();
        }
        return result;
    }


    // delete 1번 : 지우려는 댓글이 비밀번호가 맞는 경우 삭제된 글입니다 표시
    public int delete1(CommentDTO dto, boolean isManager) {
        int result = 0;
        String sql = "update board_comment set comment_content = '삭제된 글입니다.', comment_name = '-', comment_deleted=1 where comment_pk = ? ";

        // 관리자가 아닌 경우 비밀번호를 확인
        if(!isManager) {
            sql += "and comment_pass = ? ";
        }

        try{
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, dto.getCommentPk());
            if(!isManager){
                pstmt.setString(2, dto.getCommentPass());
            }


            result = pstmt.executeUpdate();

            System.out.println(timenow()+"해당 num의 원글 답글수 업데이트 : " + result);

        }
        catch (SQLException e){
            System.out.println("****** delete2 실행 중 오류 발생 ******");
            System.out.println(timenow()+"Error : "+e.getMessage());
            e.printStackTrace();
        }
        return result;
    }


    // delete 2번 : 대댓을 지우려고 하는 경우 원글의 cnt가 -1, 원글을 지우려고 하는 경우 원글의 cnt에 변화없음, 지우려는 댓글의 비밀번호가 맞아아먄 작동
    public int delete2(CommentDTO dto) {
        int result = 0;
        String sql = "update board_comment set comment_reply_cnt = comment_reply_cnt-1 ";
        sql += "where comment_pk = (select min from (select min(comment_pk) as min from board_comment ";
        sql += "where comment_num = (select comment_num from board_comment where ";
        sql += "comment_pk = ? )) tmp where min != ? ) ";

        try{
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, dto.getCommentPk());
            pstmt.setInt(2, dto.getCommentPk());

            result = pstmt.executeUpdate();

            System.out.println(timenow()+"해당 num의 원글 답글수 업데이트 : " + result);

        }
        catch (SQLException e){
            System.out.println("****** delete2 실행 중 오류 발생 ******");
            System.out.println(timenow()+"Error : "+e.getMessage());
            e.printStackTrace();
        }
        return result;
    }

    // delete 3번 : 답글의 경우 곧바로 삭제되고, 원댓글에 남은 답글이 없는경우 원댓글이 삭제됨
    public int delete3(CommentDTO dto){
        int result = 0;

        String sql = "DELETE FROM board_comment where comment_deleted is not null and comment_reply_cnt < 1 and (comment_pk = (select min from (select min(comment_pk) as min from board_comment where comment_num = (select comment_num from board_comment where comment_pk = ?)) tmp) or comment_pk = ?) ";

        try{
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, dto.getCommentPk());
            pstmt.setInt(2, dto.getCommentPk());

            result = pstmt.executeUpdate();
            System.out.println(timenow()+ "게시글 "+ dto.getCommentPk()+" 삭제 : " + result);
        }
        catch (SQLException e){
            System.out.println("****** 데이터 삭제 중 오류 발생 ******");
            System.out.println(timenow()+"Error : "+e.getMessage());
            e.printStackTrace();
        }
        return result;
    }

    // 대댓글이 생성되었을때 코멘트의 넘버를 이용하여 대댓글과 넘버가 같으면서 코멘트의 pk가 가장 작은, 즉 원댓글의 리플라이카운트가 증가함
    public int updateMinPk(int num){
        int result = 0;

        String sql = "update board_comment set comment_reply_cnt = comment_reply_cnt+1 where comment_pk = (select min from (select min(comment_pk) as min from board_comment where comment_num = ? ) as tmp) ";

        try{
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, num);

            result = pstmt.executeUpdate();

            System.out.println(timenow()+"해당 num의 원글 답글수 업데이트 : " + result);

        }
        catch (SQLException e){
            System.out.println("****** update 중 오류 발생 ******");
            System.out.println(timenow()+"Error : "+e.getMessage());
            e.printStackTrace();
        }
        return result;
    }

}
