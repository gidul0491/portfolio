package com.project1.jsp_blog_project.controller;

import com.project1.jsp_blog_project.model.CommentDAO;
import com.project1.jsp_blog_project.model.CommentDTO;
import com.project1.jsp_blog_project.model.GuestbookDAO;
import com.project1.jsp_blog_project.model.GuestbookDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/blog/CommentController.do")
public class CommentController extends HttpServlet {
    private String err = "";
    private int postPk = 0;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        postPk = Integer.parseInt(req.getParameter("postPk"));
        CommentDAO dao = new CommentDAO();
        dao.dbOpen();

        List<CommentDTO> commentList = dao.selectCommentList(postPk);
        dao.dbClose();

        req.setAttribute("commentList", commentList);
        req.setAttribute("reply",0);
        req.setAttribute("err",err);
        req.setAttribute("postPk",postPk);
        req.getRequestDispatcher("/view/readPost.jsp").forward(req,resp);
        err="";
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        int sessionManagerNum = 0;
        if(session.getAttribute("sessionManagerNum")!=null){
            sessionManagerNum = Integer.parseInt(session.getAttribute("sessionManagerNum").toString());
        }
         postPk = Integer.parseInt(req.getParameter("postPk"));


        // 답변/수정/삭제일때만 전달되는 commentAddPk 파라미터가 null이 아니고 "" 이 아닐때 CommentDTO 생성
        if(req.getParameter("commentAddPk")!=null && req.getParameter("commentAddPk")!=""){
            int commentAddPk = Integer.parseInt(req.getParameter("commentAddPk"));
            int reply = Integer.parseInt(req.getParameter("reply"));
            String CommentContent = req.getParameter("commentAddContent");
            String CommentName = req.getParameter("commentAddName");
            String CommentPass = req.getParameter("commentAddPass");
            int replyTo = 0;
            if(req.getParameter("replyTo")!=null){
                replyTo = Integer.parseInt(req.getParameter("replyTo"));
            }
            CommentDTO commentDTO = new CommentDTO();
            commentDTO.setCommentPk(commentAddPk);
            commentDTO.setCommentName(CommentName);
            commentDTO.setCommentContent(CommentContent);
            commentDTO.setCommentPass(CommentPass);

            //대댓일 때
            if(reply==1){
                CommentDAO dao = new CommentDAO();
                dao.dbOpen();
                dao.updateMinPk(replyTo);
                dao.newComment(commentDTO,replyTo,sessionManagerNum,postPk);
                dao.dbClose();
            }
            // 수정일 때
            else if(reply ==2){
                CommentDAO CommentDao = new CommentDAO();
                CommentDao.dbOpen();
                if(CommentDao.editComment(commentDTO) !=1){
                    err = "pwErr";
                }
                CommentDao.dbClose();
            }
            // 삭제일 때
            else if(reply==3){
                CommentDAO CommentDao = new CommentDAO();
                CommentDao.dbOpen();
                // delete1 이 반환값이 1이면 비밀번호가 맞는것이므로 나머지 delete2,3도 실행
                if(CommentDao.delete1(commentDTO,false)==1) {
                    CommentDao.delete2(commentDTO);
                    if(CommentDao.delete3(commentDTO)>=0){
                        err = "deleteComp";
                    }


                }
                // 비밀번호가 틀린 경우에는 세션으로 관리자인지 체크후 delete1,2,3 모두 실행
                else if ((session.getAttribute("isManager")!=null && session.getAttribute("isManager").equals("yes"))){
                    CommentDao.delete1(commentDTO,true);
                    CommentDao.delete2(commentDTO);
                    if(CommentDao.delete3(commentDTO)>=0){
                        err = "deleteComp";
                    }
                }
                // 둘다 아닐경우는 비번도 틀리고 관리자도 아닌것이므로 에러메세지 출력
                else{err = "pwErr";}
                CommentDao.dbClose();
            }



            //reply값이 전달되지 않을 때는 그냥 글쓰기 이므로, newComment()실행
        }
        else {
            CommentDAO dao = new CommentDAO();
            CommentDTO dto = new CommentDTO();
            dto.setCommentName(req.getParameter("commentName"));
            dto.setCommentPass(req.getParameter("commentPass"));
            dto.setCommentContent(req.getParameter("commentContent"));
            dao.dbOpen();
            dao.newComment(dto,0,sessionManagerNum,postPk);
            dao.dbClose();
        }
        req.setAttribute("reply","no");
        resp.sendRedirect("/blog/ReadPostController.do?postPk="+postPk);
    }

}
