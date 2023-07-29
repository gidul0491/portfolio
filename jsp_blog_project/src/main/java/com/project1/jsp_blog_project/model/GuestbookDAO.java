package com.project1.jsp_blog_project.model;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class GuestbookDAO extends JDBConnect {

    // newComment시 방명록 넘버를 대입함, 댓글일경우 원글의 넘버를 대입함, num이 대댓달 코멘트 번호임, 대댓이 아니면 기본값인 0임, 대댓글이면 리플라이카운트를 -1로 대입
    public int newComment(GuestbookDTO comment, int num, int manager){
        int result =0;

        String sql="INSERT INTO guestbook ";
        sql += "(guestbook_content, guestbook_name, guestbook_pass,guestbook_datetime, guestbook_manager, guestbook_num ";
        // num==0일때, 즉 대댓달 코멘트 번호가 없는 원글일때 리플라이카운트를 수정할 열에 추가하지않고 괄호를 닫아버림
        if(num==0){ sql += ") "; }
        // num이 0이 아닐때, 즉 대댓일때 리플라이카운트에 -1을 넣기위해 추가하고 괄호를 닫음
        else { sql += ", guestbook_reply_cnt) ";}
        sql += "VALUES (?, ?, ?, NOW(),? ";
        // 원글일 때 코멘트번호에 기존 최댓값+1을 넣음
        if(num == 0){
            sql += ", ifnull((select max(guestbook_num)+1 from guestbook g),1) ";
        }
        // 대댓일때 코멘트번호에 파라미터로 가져온 값인 원글의 코멘트번호 num 을 집어넣음
        else{
            sql+= ", "+ num +", -1 ";
        }
        sql += ") ";
        try{
            pstmt =conn.prepareStatement(sql);
            pstmt.setString(1, comment.getGuestbookContent());
            pstmt.setString(2, comment.getGuestbookName());
            pstmt.setString(3, comment.getGuestbookPass());
            pstmt.setInt(4, manager);

            result=pstmt.executeUpdate();
            System.out.println(timenow()+ "방명록 업로드 : "+result+" 매니저 : "+manager);

        }
        catch (SQLException e){
            System.out.println("****** INSERT문 실행 중 오류 발생 ******");
            System.out.println(timenow()+"Error : "+e.getMessage());
            e.printStackTrace();
        }


        return result;
    }
    public int commentCount(){
        int result=0;
        String sql = "SELECT count(*) AS cnt FROM guestbook ";
        System.out.println(sql);
        try{
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
            while(rs.next()){
                result = rs.getInt("cnt");
            }
            System.out.println(timenow() + "방명록 코멘트 수 " + result );
        }
        catch(SQLException e){
            System.out.println("totalPostCount SELECT명령 사용 중 오류 발생");
            e.printStackTrace();
        }
        return result;
    }

    public List<GuestbookDTO> selectCommentList(int start, int end) {
        List<GuestbookDTO> list = new ArrayList<>();
        String sql = "SELECT * ";
        sql += "FROM guestbook ";
        sql += "ORDER BY guestbook_num DESC, guestbook_pk ASC ";
        sql += "LIMIT ?, ? ";
        System.out.println(sql);
        try{
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, start-1);
            pstmt.setInt(2, end);
            rs = pstmt.executeQuery();

            while(rs.next()){
                GuestbookDTO dto = new GuestbookDTO();
                int i = rs.getInt("guestbook_pk");

                String edited = "";
                int k = rs.getInt("guestbook_edited");
                if(k==1){edited="(수정됨)";}
                dto.setGuestbookPk(i);
                dto.setGuestbookContent(rs.getString("guestbook_content"));
                dto.setGuestbookName(rs.getString("guestbook_name"));
                dto.setGuestbookPass(rs.getString("guestbook_pass"));
                dto.setGuestbookDatetime(rs.getString("guestbook_datetime"));
                dto.setGuestbookNum(rs.getInt("guestbook_num"));
                dto.setGuestbookManager(rs.getInt("guestbook_manager"));
                dto.setGuestbookReplyCnt(rs.getInt("guestbook_reply_cnt"));
                dto.setGuestbookDeleted(rs.getInt("guestbook_deleted"));
                dto.setGuestbookEdited(edited);
                list.add(dto);
                System.out.println(timenow() + i +"번 코멘트 목록에 추가 완료" );
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        return list;
    }

    public int editComment(GuestbookDTO dto){
        int result =0;

        String sql="UPDATE guestbook ";
        sql += "SET guestbook_name=?, guestbook_content=?, guestbook_edited = 1 ";
        sql += "WHERE guestbook_pk = ? AND guestbook_pass = ?";
        try{
            pstmt =conn.prepareStatement(sql);
            pstmt.setString(1, dto.getGuestbookName());
            pstmt.setString(2, dto.getGuestbookContent());
            pstmt.setInt(3, dto.getGuestbookPk());
            pstmt.setString(4, dto.getGuestbookPass());
            result=pstmt.executeUpdate();
            System.out.println(timenow()+ "게시글 수정 : "+result);
        }
        catch (SQLException e){
            System.out.println("****** edit 실행 중 오류 발생 ******");
            System.out.println(timenow()+"Error : "+e.getMessage());
            e.printStackTrace();
        }
        return result;
    }


    public int delete3(GuestbookDTO dto){
        int result = 0;

        String sql = "DELETE FROM blog_project.guestbook where guestbook_deleted is not null and guestbook_reply_cnt < 1 and (guestbook_pk = (select min from (select min(guestbook_pk) as min from blog_project.guestbook where guestbook_num = (select guestbook_num from blog_project.guestbook where guestbook_pk = ?)) tmp) or guestbook_pk = ?) ";

        try{
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, dto.getGuestbookPk());
            pstmt.setInt(2, dto.getGuestbookPk());

            result = pstmt.executeUpdate();
            System.out.println(timenow()+ "게시글 "+ dto.getGuestbookPk()+" 삭제 : " + result);
        }
        catch (SQLException e){
            System.out.println("****** 데이터 삭제 중 오류 발생 ******");
            System.out.println(timenow()+"Error : "+e.getMessage());
            e.printStackTrace();
        }
        return result;
    }

    // delete 1번 : 지우려는 댓글이 비밀번호가 맞는 경우 삭제된 글입니다 표시
    public int delete1(GuestbookDTO dto, boolean isManager) {
        int result = 0;
        String sql = "update blog_project.guestbook set guestbook_content = '삭제된 글입니다.', guestbook_name = '-', guestbook_deleted=1 where guestbook_pk = ? ";

        // 관리자가 아닌 경우 비밀번호를 확인
        if(!isManager) {
            sql += "and guestbook_pass = ? ";
        }

        try{
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, dto.getGuestbookPk());
            if(!isManager){
                pstmt.setString(2, dto.getGuestbookPass());
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
    public int delete2(GuestbookDTO dto) {
        int result = 0;
        String sql = "update blog_project.guestbook set guestbook_reply_cnt = guestbook_reply_cnt-1 ";
        sql += "where guestbook_pk = (select min from (select min(guestbook_pk) as min from blog_project.guestbook ";
        sql += "where guestbook_num = (select guestbook_num from blog_project.guestbook where ";
        sql += "guestbook_pk = ? )) tmp where min != ? ) ";

        try{
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, dto.getGuestbookPk());
            pstmt.setInt(2, dto.getGuestbookPk());

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



    // 대댓글이 생성되었을때 코멘트의 넘버를 이용하여 대댓글과 넘버가 같으면서 코멘트의 pk가 가장 작은, 즉 가장오래된 댓글의 리플라이카운트가 증가함
    public int updateMinPk(int num){
        int result = 0;

        String sql = "update blog_project.guestbook set guestbook_reply_cnt = guestbook_reply_cnt+1 where guestbook_pk = (select min from (select min(guestbook_pk) as min from guestbook where guestbook_num = ? ) as tmp) ";

        try{
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, num);

            result = pstmt.executeUpdate();

            System.out.println(timenow()+"해당 num의 원글 답글수 업데이트 : " + result);

        }
        catch (SQLException e){
            System.out.println("****** 데이터 삭제 중 오류 발생 ******");
            System.out.println(timenow()+"Error : "+e.getMessage());
            e.printStackTrace();
        }
        return result;
    }
    public int updateReCnt(int pk){
        int result = 0;

        String sql = "update blog_project.guestbook set guestbook_reply_cnt = guestbook_reply_cnt-1 where guestbook_pk=? ";

        try{
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, pk);
            result = pstmt.executeUpdate();

            System.out.println(timenow()+"해당 댓글의 reply수 업데이트 : " + result);

        }
        catch (SQLException e){
            System.out.println("****** 데이터 삭제 중 오류 발생 ******");
            System.out.println(timenow()+"Error : "+e.getMessage());
            e.printStackTrace();
        }
        return result;
    }

}
