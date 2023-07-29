package com.project1.jsp_blog_project.controller;

import com.project1.jsp_blog_project.model.PostDAO;
import com.project1.jsp_blog_project.model.PostDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(value = "/blog/ReadPostController.do")
public class ReadPostController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 전달받은 게시물 번호 가져오기
        int postPk = Integer.parseInt(req.getParameter("postPk"));
        String category = req.getParameter("category");
        HttpSession session = req.getSession();
        System.out.println("게시글 접근 : " +postPk);

        // 2. 데이터베이스에 연결하여 게시물 번호에 맞는 게시물 정보를 가져오기
        PostDAO dao = new PostDAO();
        dao.dbOpen();
        // 관리자가 아니고 세션에 postPk visited 값이 없으면 yes 라고 추가하고 1시간동안으로 세션 종료기간 설정
        if (session.getAttribute("isManager")==null || !session.getAttribute("isManager").toString().equals("yes")){
            if(session.getAttribute(postPk+"visited")==null || !session.getAttribute(postPk+"visited").toString().equals("yes")) {
                session.setAttribute(postPk + "visited", "yes");
                session.setMaxInactiveInterval(3600);
                dao.updatePostVisit(postPk);
            }
        }

        PostDTO post = dao.selectPost(postPk);
        dao.dbClose();


        // 3. 비밀글인 경우 postPk와 함께 secretPass.jsp로 이동
        if(post.getPostOpen().equals("[비밀글]") && (session.getAttribute("isManager")==null || !session.getAttribute("isManager").equals("yes"))){
            req.setAttribute("postPk", postPk);
            req.getRequestDispatcher("/view/privatePass.jsp?category="+category).forward(req, resp);
        }else{
            // 4. 비밀글이 아닌  경우 view 페이지에 데이터 전달(request영역에 데이터 지정)
            req.setAttribute("post", post);
            req.getRequestDispatcher("/view/readPost.jsp?category="+category).forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 전달받은 비밀번호와 게시글번호를 변수에 저장
        String secretPass = "";
        String category = req.getParameter("category");
        int postPk = Integer.parseInt(req.getParameter("postPk"));

        if(req.getParameter("secretPass") != null){
            secretPass = req.getParameter("secretPass");
        }
        PostDTO post = new PostDTO();

        // 2. PostDAO로 비번 맞는지 확인
        PostDAO dao = new PostDAO();
        dao.dbOpen();
        if(dao.privatePass(postPk, secretPass).equals("yes")){
            // 3. 비번 맞으면 PostDTO 변수 리퀘스트에 담아서 readPost.jsp로 이동
            post = dao.selectPost(postPk);
            dao.dbClose();
            req.setAttribute("post", post);
            req.getRequestDispatcher("/view/readPost.jsp").forward(req, resp);
        }
        else {
            // 4. 틀리면 PostPk 담아서 secretPass.jsp로 이동
            req.setAttribute("postPk", postPk);
            req.getRequestDispatcher("/view/privatePass.jsp").forward(req, resp);
        }




    }
}
