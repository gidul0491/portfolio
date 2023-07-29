package com.project1.jsp_blog_project.controller;

import com.project1.jsp_blog_project.model.ManagerDAO;
import com.project1.jsp_blog_project.model.ManagerDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/blog/ManagerController.do")
public class ManagerController extends HttpServlet {
    // doGet으로 에러메세지 표시여부를 전달하는 변수
    private String alert = null;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        // 관리자목록 리스트 관리자페이지에 넘겨주기
        ManagerDAO dao = new ManagerDAO();
        dao.dbOpen();
        List<ManagerDTO> managerList = dao.selectManagerList();
        dao.dbClose();
        req.setAttribute("managerList",managerList);
        System.out.println(req.getParameter("managerList"));
        req.getRequestDispatcher("/view/managerPage.jsp?alert="+alert).forward(req,resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession(true);
        // submit 모드를 확인
        String mode = "";
        if (req.getParameter("mode") != null && req.getParameter("mode") != "") {
            mode = req.getParameter("mode");
        }
        // mode가 login/check인 submit일경우
        if (mode.equals("login") || mode.equals("check")) {
            // 전달된 인자 저장 - 아이디, 패스워드,
            String name = req.getParameter("name");
            String pw = req.getParameter("pw");
            System.out.println(req.getParameter("mode"));
            // dao 인스턴스화 후 로그인 메소드 실행, db 종료
            ManagerDAO dao = new ManagerDAO();
            dao.dbOpen();

            // dto 반환값이 존재할경우 세션에 관리자 정보 저장 후 이전에있던 페이지 주소로 이동
            ManagerDTO dto = dao.managerLogin(name, pw);
            if (dto.getManagerName() != null && dto.getManagerName() != "" && dto.getManagerEmail() != null && dto.getManagerEmail() != "") {
                session.setAttribute("isManager", "yes");
                session.setAttribute("sessionName", name);
                session.setAttribute("sessionEmail", dto.getManagerEmail());
                session.setAttribute("sessionManagerNum", dto.getManagerNumber());
                session.setAttribute("sessionPass", pw);
                session.setMaxInactiveInterval(600);
                if (mode.equals("login")) {
                    // 표 만들러 가기
                    this.doGet(req,resp);

                } else if (mode.equals("check")) {
                    session.setAttribute("isChecked", "yes");
                    System.out.println(session.getAttribute("isChecked"));
                    this.doGet(req,resp);
                    alert = null;
                }
            }
            // dto 반환값이 없을 경우
            else {
                // check모드이면 관리자페이지로 이동
                if(mode.equals("check")){
                    dao.dbClose();
                    // 비밀번호를 확인해주세요 메세지를 출력해라
                    alert = "checkAlert";
                    this.doGet(req,resp);
                    alert = null;
                }
                else {
                    // check모드가 아니면 로그인페이지로 이동
                    session.removeAttribute("isManager");
                    dao.dbClose();
                    resp.sendRedirect("/view/managerLogin.jsp?alert=alert");
                }
            }
        } else if (mode.equals("edit")) {    //mode equals edit인 경우
            int edit = 0;
            ManagerDTO dto = new ManagerDTO();
            // pw로 null값이 들어왔을 경우
            if(req.getParameter("pw")==null){
                req.getRequestDispatcher("/view/managerPage.jsp?alert="+"checkAlert").forward(req,resp);
            }else{
                // 동봉된 이름, 이메일, 패스워드를 변수에 저장
                String name = req.getParameter("name");
                String email = req.getParameter("email");
                String pw = req.getParameter("pw");
                int managerNumber = Integer.parseInt(req.getParameter("managerNumber"));
                dto.setManagerNumber(managerNumber);
                dto.setManagerName(name);
                dto.setManagerEmail(email);
                dto.setManagerPass(pw);

                // 동봉된 아이디, 이메일, 비밀번호를 받아온 관리자번호를 이용하여 저장
                ManagerDAO dao = new ManagerDAO();
                dao.dbOpen();
                edit = dao.editManager(dto);
                dao.dbClose();
            }

            // 업데이트 성공시 새로운 관리자 정보를 세션에 저장
            if(edit==1){
                session.setAttribute("isManager", "yes");
                session.setAttribute("isChecked","no");
                session.setAttribute("sessionName", dto.getManagerName());
                session.setAttribute("sessionEmail", dto.getManagerEmail());
                session.setAttribute("sessionManagerNum", dto.getManagerNumber());
            } else {
                alert="edit";
            }
            // alert=edit인 경우 아이디중복 확인 메세지
            this.doGet(req,resp);
            alert = null;


            // delete 모드일때
        } else if (mode.equals("delete")) {
            int del = 0;
            // 패스워드와 관리자명를 받아와서 저장
            String name = req.getParameter("name");
            String pw = req.getParameter("pw");

            // dao 이용하여 db 에서 관리자 정보 삭제
            ManagerDAO dao = new ManagerDAO();
            dao.dbOpen();
            del = dao.deleteManager(name, pw);
            dao.dbClose();

            // delete 성공시 세션 초기화 후 index.jsp로 이동시키기
            if(del==1){
                session.invalidate();
                resp.sendRedirect("/index.jsp");
            } else{
                // 실패시 관리자페이지로 이동
                alert="edit";
                this.doGet(req,resp);
                alert = null;
            }

            // signUp 모드일때
        } else if (mode.equals("signUp")) {
            // 이름, 이메일, 비밀번호를 받아와서 저장
            String name = req.getParameter("name");
            String email = req.getParameter("email");
            String pw = req.getParameter("pw");
            ManagerDTO dto = new ManagerDTO();
            dto.setManagerName(name);
            dto.setManagerEmail(email);
            dto.setManagerPass(pw);

            // dao이용하여 db에 관리자 추가
            ManagerDAO dao = new ManagerDAO();
            dao.dbOpen();
            int signUp = dao.signUpManager(dto);
            dao.dbClose();
            // doGet으로 이동하여 관리자리스트 불러오고 관리자페이지로 이동
            if(signUp == 1){alert = "signedUp";}else{alert = "signUpFail";}
            this.doGet(req,resp);
            alert=null;
            // 모드 nothing 인 경우 - 정보수정중 취소
        }else if (mode.equals("nothing")) {
            session.setAttribute("isChecked","no");
            doGet(req, resp);
        }
        }
    }


