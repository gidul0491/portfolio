package com.project1.jsp_blog_project.controller;

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

@WebServlet("/blog/GuestbookController.do")
public class GuestbookController extends HttpServlet {
    private String err = "";
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        session.getAttribute("isManager");
        // 페이지네이션 : 페이지 n개가 모여 하나의 페이지블록을 이루고, 한 페이지에서 표시되는 페이지블록은 하나임
        // 한 페이지에서 표시되는 게시글 수
        int pageSize = 10;
        // 페이지블록에서 표시할 최대 페이지 수
        int pageBlockSize = 5;
        // 총 페이지 수
        int totalPage = 1;
        // 페이지블록에서 첫 번째 페이지
        int firstPageInPageBlock = 1;

        // 현재 페이지 수 기본값 1
        int pageNow = 1;

        // 몇페이지로 이동해줘~ 라고 request로 요청이 온 경우, pageNow를 요청된 페이지로 설정
        if(req.getParameter("pageNow") != null){
            pageNow = Integer.parseInt(req.getParameter("pageNow"));
        }

        // 현재 페이지 i가 페이지블록사이즈 k 의 n배+1 이면 n*k+1 (k=5, i=1,6을 대입해봐라)
        // k이면 (k-1)/k의 정수부 * k +1 (k=5, i=5,10을 대입해봐라)
        firstPageInPageBlock = ((pageNow-1)/pageBlockSize)*pageBlockSize+1;

        // 현재 페이지에서 첫 번째로 보이는 게시글의 번호, db에서 가장 높은 pk의 게시글이 1번 게시글이라고 가정
        int startPost = (pageNow-1) * pageSize +1;  //0*5 +1 = 1

        // start 부터 pageSize 개수만큼 데이터 불러오기
        // 관리자인경우 비공개글까지 불러오기위해 managerReadPass 실행, 매개변수는 세션에 저장된 sessionPw - 페이지리스트에서 복붙해온거라그렇지 관리자패스는 필요없음
        // 게시글 리스트를 불러오기윈한 매개변수 : 현재페이지 첫 게시글의 db상 역순의 번호,
        // 페이지당 표시될 게시글 수, 현재 게시판 카테고리, 관리자패스 yes||no
        GuestbookDAO dao = new GuestbookDAO();
        dao.dbOpen();

        List<GuestbookDTO> commentList = dao.selectCommentList(startPost, pageSize);
        totalPage = (dao.commentCount()-1)/pageSize + 1; // 예시 : 76/5+1=16
        dao.dbClose();
        System.out.println("총 페이지 "+totalPage);
        // 이전, 1, 2, 3, .., 다음 으로 이루어진 String 리스트
        List<String> pageBlockArray = new ArrayList<>();


        //  pageNow=(pageNow-pageBlockSize)
        //  즉 현재 페이지에서 pageBlockSize만큼 뺀 페이지로 이동하는 '이전' String을 리스트에 추가
        if (firstPageInPageBlock > 1) {
            pageBlockArray.add("이전");
        }

        // 현재 페이지블록의 첫 번째 페이지부터 시작하여 페이지수를 가리키는 temp 변수
        int temp = firstPageInPageBlock;

        // temp가 현재 페이지블록에 포함되는 페이지이고, 전체 페이지수 이하일때
        while (temp < firstPageInPageBlock + pageBlockSize && temp <= totalPage){
            pageBlockArray.add(String.valueOf(temp));
            temp++;
        }
        pageBlockArray.add("다음");
        // 현재 페이지블록 리스트가 마지막페이지(=전체페이지수) 를 포함할때 다음 String을 없앰
        if(pageBlockArray.contains(String.valueOf(totalPage)))
            pageBlockArray.remove("다음");

        System.out.println("현재 페이지의 pageBlockArray : " + pageBlockArray);



        req.setAttribute("pageBlockArray", pageBlockArray);
        req.setAttribute("pageNow", pageNow);
        req.setAttribute("pageBlockSize", pageBlockSize);
        req.setAttribute("commentList", commentList);
        req.setAttribute("totalPage",totalPage);
        req.setAttribute("reply",0);
        req.setAttribute("err",err);
        req.getRequestDispatcher("/view/guestBook.jsp").forward(req,resp);
        err="";
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        int sessionmanagerNum = 0;
        if(session.getAttribute("sessionManagerNum")!=null){
            sessionmanagerNum = Integer.parseInt(session.getAttribute("sessionManagerNum").toString());
        }

        // 답변/수정/삭제일때만 전달되는 guestbookAddPk 파라미터가 null이 아니고 "" 이 아닐때 guestbookDTO 생성
        if(req.getParameter("guestbookAddPk")!=null && req.getParameter("guestbookAddPk")!=""){
            int guestbookAddPk = Integer.parseInt(req.getParameter("guestbookAddPk"));
            int reply = Integer.parseInt(req.getParameter("reply"));
            String guestbookContent = req.getParameter("guestbookAddContent");
            String guestbookName = req.getParameter("guestbookAddName");
            String guestbookPass = req.getParameter("guestbookAddPass");
            int replyTo = 0;
            if(req.getParameter("replyTo")!=null){
                replyTo = Integer.parseInt(req.getParameter("replyTo"));
            }
            GuestbookDTO guestbookDTO = new GuestbookDTO();
            guestbookDTO.setGuestbookPk(guestbookAddPk);
            guestbookDTO.setGuestbookName(guestbookName);
            guestbookDTO.setGuestbookContent(guestbookContent);
            guestbookDTO.setGuestbookPass(guestbookPass);

            //대댓일 때
            if(reply==1){
                GuestbookDAO dao = new GuestbookDAO();
                dao.dbOpen();
                dao.updateMinPk(replyTo);
                dao.newComment(guestbookDTO,replyTo,sessionmanagerNum);
                dao.dbClose();
            }
            // 수정일 때
            if(reply ==2){
                GuestbookDAO guestbookDao = new GuestbookDAO();
                guestbookDao.dbOpen();
                if(guestbookDao.editComment(guestbookDTO) !=1){
                    err = "pwErr";
                }
                guestbookDao.dbClose();
            }
            // 삭제일 때
            if(reply==3){
                GuestbookDAO guestbookDao = new GuestbookDAO();
                guestbookDao.dbOpen();
                // delete1 이 반환값이 1이면 비밀번호가 맞는것이므로 나머지 delete2,3도 실행
                if(guestbookDao.delete1(guestbookDTO,false)==1) {
                    guestbookDao.delete2(guestbookDTO);
                    if(guestbookDao.delete3(guestbookDTO)>=0){
                        err = "deleteComp";
                    }


                }
                // 비밀번호가 틀린 경우에는 세션으로 관리자인지 체크후 delete1,2,3 모두 실행
                else if ((session.getAttribute("isManager")!=null && session.getAttribute("isManager").equals("yes"))){
                    guestbookDao.delete1(guestbookDTO,true);
                    guestbookDao.delete2(guestbookDTO);
                    if(guestbookDao.delete3(guestbookDTO)>=0){
                        err = "deleteComp";
                    }
                }
                // 둘다 아닐경우는 비번도 틀리고 관리자도 아닌것이므로 에러메세지 출력
                else{err = "pwErr";}
                guestbookDao.dbClose();
                }



            //reply값이 전달되지 않을 때는 그냥 글쓰기 이므로, newComment()실행
        }
        else {
            GuestbookDAO dao = new GuestbookDAO();
            GuestbookDTO dto = new GuestbookDTO();
            dto.setGuestbookName(req.getParameter("guestbookName"));
            dto.setGuestbookPass(req.getParameter("guestbookPass"));
            dto.setGuestbookContent(req.getParameter("guestbookContent"));
            dao.dbOpen();
            dao.newComment(dto,0,sessionmanagerNum);
            dao.dbClose();
        }
        req.setAttribute("reply","no");
        resp.sendRedirect("/blog/GuestbookController.do");
//        this.doGet(req, resp);
    }

}
