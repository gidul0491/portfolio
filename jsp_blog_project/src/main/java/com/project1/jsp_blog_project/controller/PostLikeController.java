package com.project1.jsp_blog_project.controller;

import com.project1.jsp_blog_project.model.CommentDAO;
import com.project1.jsp_blog_project.model.PostDAO;
import com.project1.jsp_blog_project.model.PostDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/blog/PostLikeController.do")
public class PostLikeController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 전달받은 게시물 번호, 좋아요모드(좋아요인지 취소인지) 가져오기, 쿠키배열에 postPk가 있는지없는지 검사
        String postPk = req.getParameter("postPk");
        String likeMode = req.getParameter("likeMode");
        String category = req.getParameter("category");


        // 2. 데이터베이스에 연결하여 게시물 번호에 맞는 게시물 정보를 가져오기
        PostDAO dao = new PostDAO();
        dao.dbOpen();
        // 좋아요를 눌렀을때(mode.equals( likeplus )일 때)
        if (likeMode.equals("likePlus")) {
            dao.updateLike(Integer.parseInt(postPk));
        }
        // 취소를 눌렀을때(mode.equals( likeminus )일 때)
        else if (likeMode.equals("likeMinus") ) {
            dao.deleteLike(Integer.parseInt(postPk));
        }

        dao.dbClose();

        resp.sendRedirect("/blog/ReadPostController.do?postPk="+ postPk +"&like="+ likeMode+"&category="+category);
    }
}
