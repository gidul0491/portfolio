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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/blog/PostListController.do")
public class PostListController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        // category get방식으로 수신, category 변수에 저장, all 이면 최신글(전체 카테고리)
        String category = "all";
        if(req.getParameter("category")!=null){
            category = req.getParameter("category");
            if(category.equals("tempSaved")){
                if(session.getAttribute("isManager")!=null && session.getAttribute("isManager").equals("yes")){
//                    category = "임시저장";
                }
                else{
                    category = "all";
                }
            }
        }
        int pgSize =5;
        if(req.getParameter("pSize")!=null && !req.getParameter("pSize").equals("")){
            pgSize = Integer.parseInt(req.getParameter("pSize"));
        }



        // 페이지네이션 : 페이지 n개가 모여 하나의 페이지블록을 이루고, 한 페이지에서 표시되는 페이지블록은 하나임
        // 한 페이지에서 표시되는 게시글 수
        int pageSize = pgSize;
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
        // 관리자인경우 비공개글까지 불러오기위해 managerReadPass 실행, 매개변수는 세션에 저장된 sessionPw
        // 게시글 리스트를 불러오기윈한 매개변수 : 현재페이지 첫 게시글의 db상 역순의 번호,
        // 페이지당 표시될 게시글 수, 현재 게시판 카테고리, 관리자패스 yes||no
        PostDAO dao = new PostDAO();
        String open = "no";
        if(session.getAttribute("isManager")!=null && session.getAttribute("isManager").equals("yes")){open="yes";}
        dao.dbOpen();
        List<PostDTO> postList = dao.selectPostList(startPost, pageSize, category, open);
        totalPage = (dao.totalPostCount(category, open)-1)/pageSize + 1; // 예시 : 76/5+1=16
        dao.dbClose();

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
        System.out.println("현재 페이지의 category : " + category);

        req.setAttribute("pageBlockArray", pageBlockArray);
        req.setAttribute("pageNow", pageNow);
        req.setAttribute("pageBlockSize", pageBlockSize);
        req.setAttribute("postList", postList);
        req.setAttribute("totalPage",totalPage);
        req.setAttribute("category", category);
        req.getRequestDispatcher("/view/PostList.jsp?pSize="+pgSize).forward(req, resp);
    }
}
