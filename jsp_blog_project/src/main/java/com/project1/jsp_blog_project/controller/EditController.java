package com.project1.jsp_blog_project.controller;

import com.oreilly.servlet.MultipartRequest;
import com.project1.jsp_blog_project.model.CategoryDAO;
import com.project1.jsp_blog_project.model.CategoryDTO;
import com.project1.jsp_blog_project.model.PostDAO;
import com.project1.jsp_blog_project.model.PostDTO;
import com.project1.jsp_blog_project.util.FileUtils;
import com.project1.jsp_blog_project.util.JSFunc;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;

@WebServlet("/blog/EditController.do")
public class EditController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        // 0. 변수설정 : 전달할 게시글 정보 dto, 전달할 카테고리
        PostDTO post = new PostDTO();
        String mode = req.getParameter("mode");
        String cate = req.getParameter("category");


        // 1. 전달받은 게시물 번호 가져오기
        int postPk = Integer.parseInt(req.getParameter("postPk"));

        System.out.println("게시글 쓰기/수정 : " + postPk);
        // (관리자인지 확인)
        HttpSession session = req.getSession(true);
        boolean isManager = false;
        // 관리자가 아니면
        if (session.getAttribute("isManager") == null || !session.getAttribute("isManager").equals("yes")) {
            if (postPk == 0) {
                resp.sendRedirect("/index.jsp");
            } else {
                resp.sendRedirect("/blog/ReadPostController.do?postPk=" + postPk);
            }
        }
        // 관리자이면
        else if (session.getAttribute("isManager") == null || !session.getAttribute("isManager").equals("yes")) {
            isManager = true;
        }

        if (postPk == 0) {
            // 전달받은 게시물 번호가 0이면(글쓰기 버튼을 누른 경우) dto는 양식을 넣거나 비워둔 채 저장
            post.setPostPk(0);
        }

            // 2. 데이터베이스에 연결하여 게시물 번호에 맞는 게시물 정보를 가져오기
            PostDAO dao = new PostDAO();
            dao.dbOpen();


            // 삭제 모드일때
            if (mode!=null && mode!="" && mode.equals("delete")) {
                int del = dao.deletePost(postPk);
                dao.dbClose();
                req.setAttribute("category", cate);
                req.getRequestDispatcher("/blog/PostListController.do").forward(req, resp);
            }
            else {
                post = dao.selectPost(postPk);
                dao.dbClose();
                // 수정/작성시 select 폼에 필요한 카테고리 리스트 불러오기,
                CategoryDAO catedao = new CategoryDAO();
                catedao.dbOpen();
                ArrayList<CategoryDTO> cateList = catedao.selectCategoryList(false, isManager);
                catedao.dbClose();


                // 3. write 페이지에 데이터 전달(request영역에 데이터 지정)
                req.setAttribute("post", post);
                req.setAttribute("categoryList", cateList);
                req.getRequestDispatcher("/view/write.jsp?category="+cate).forward(req, resp);

            }


        }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // post로 수정/작성된 게시글의 dto를 받아와서 새로 인스턴스화한 dto에 저장
        req.setCharacterEncoding("UTF-8");
        PostDTO post = new PostDTO();


        // 파일 정보를 가져오는 처리
        //서버에 저장할 위치
//        String saveDir = req.getServletContext().getRealPath("/upload"); 현재프로젝트폴더에 upload폴더를 쓸수있음
        String saveDir = "c:\\upload";
        // 업로드파일 최대용량 제한
        int maxSize = 10 * 1024 * 1024; // 10메가바이트
        MultipartRequest mr = FileUtils.uploadFile(req,saveDir,maxSize);

        if(mr==null){
            JSFunc.alertLocation(resp, "첨부파일의 크기가 큽니다", "/blog/EditController.do");
            return;
        }
        String fileName = mr.getFilesystemName("file");
        if(fileName != null){
            String now = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
            String ext = fileName.substring(fileName.lastIndexOf("."));
            String newFilename = now + ext;

            File oldFile = new File(saveDir + File.separator+fileName);
            File newfile = new File(saveDir+File.separator+newFilename);
            oldFile.renameTo(newfile);

            post.setPostOfile(fileName);
            post.setPostSfile(newFilename);
        }
        // 파일 정보를 가져오는 처리 ************** 이후 req가 아닌 mr에 저장됨 ******** ******* ******
        // 비밀글인지 공개인지 설정, 비밀글이면 암호 설정
        String privatePass = null;
        String postOpen = mr.getParameter("postOpen");
        if (mr.getParameter("privatePass") != null && !mr.getParameter("privatePass").equals("")) {
            privatePass = mr.getParameter("privatePass");
            postOpen = "2";
            System.out.println("비밀글 암호 " + privatePass);
        }

        int postPk = Integer.parseInt(mr.getParameter("postPk"));

        String postCategory = mr.getParameter("postCategory");


        post.setPostPk(postPk);
        post.setPostOpen(postOpen);
        post.setPostTitle(mr.getParameter("postTitle"));
        post.setPostContent(mr.getParameter("postContent"));
        post.setPostCategory(postCategory);
        post.setPostWriter(mr.getParameter("postWriter"));
        post.setPostPass(privatePass);



        // 새로 작성인 경우, postPk = 0 인 경우 dao.newPost()
        if (postPk == 0) {
            PostDAO dao = new PostDAO();
            dao.dbOpen();
            dao.newPost(post);
            dao.dbClose();
        }

        // 수정인경우, postPk != 0 인 경우 dao.editPost()
        else {
            PostDAO dao = new PostDAO();
            dao.dbOpen();
            dao.editPost(post);
            dao.dbClose();
        }
        // 카테고리 정보와 함께 PostListController로 리다이렉트, 임시저장한경우 전체글
        if (postCategory.equals("tempSaved")) {
            postCategory = "all";
        }
        resp.sendRedirect("/blog/PostListController.do?category=" + postCategory);


    }
}
