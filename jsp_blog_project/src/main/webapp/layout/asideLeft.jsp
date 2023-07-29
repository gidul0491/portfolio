<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.project1.jsp_blog_project.model.*" %>
<%@ page import="com.project1.jsp_blog_project.util.JSFunc" %>
<%@ page import="com.project1.jsp_blog_project.util.FileUtils" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: parkj
  Date: 2023-05-22
  Time: 오후 10:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<aside class="float-start w-100 pe-3">
    <%
        List<CategoryDTO> asideCategoryList = new ArrayList<>();
        List<GuestbookDTO> asideGuestbookList = new ArrayList<>();
        CategoryDAO dao = new CategoryDAO();
        PostDAO postDao = new PostDAO();
        GuestbookDAO guestbookDAO = new GuestbookDAO();
        dao.dbOpen();
        int totalCnt = 0;

        postDao.dbOpen();
        if(session.getAttribute("isManager")!=null && session.getAttribute("isManager").equals("yes")){
            asideCategoryList = dao.selectCategoryList(true,true);
            totalCnt = postDao.totalPostCount("all","yes");
        }
        else{
            asideCategoryList = dao.selectCategoryList(false,false);
            totalCnt = postDao.totalPostCount("all","no");
        }
        postDao.dbClose();
        dao.dbClose();
        guestbookDAO.dbOpen();
        asideGuestbookList = guestbookDAO.selectCommentList(1,3);
        guestbookDAO.dbClose();




        %>
    <head>
        <style>
            .leftSidebar{
            }
            aside {
                font-size: 0.8rem;
            }
        </style>
    </head>
    <div class="border p-3 py-4 my-4 leftSidebar">
        <ul class="list-unstyled">

            <li><a href="/index.jsp">전체  (<%= totalCnt %>)</a></li>
            <%
                for(CategoryDTO item : asideCategoryList){
                    String category = item.getCategoryName();
                    if(category.equals("tempSaved")){
                        category = "임시저장";
                    }
            %>
            <li id="<%= item.getCategoryName() %>"><a href="/blog/PostListController.do?category=<%= item.getCategoryName() %>"><%= category %>  (<%= item.getCategoryPostCnt() %>)</a></li>
            <%
                }
            %>
        </ul>
    </div>

    <div class="border p-3 py-4 my-4 leftSidebar text-break">
        <a href="/blog/GuestbookController.do?pageNow=1">방명록</a>  <br>
        <ul class="list-unstyled">
        <%
            SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            SimpleDateFormat sdf2 = new SimpleDateFormat("yy/MM/dd");

            for(GuestbookDTO item : asideGuestbookList){
        %>
        <li class="my-2"><small class=""><%= sdf2.format(sdf1.parse(item.getGuestbookDatetime())) %></small> <br>
            <%= FileUtils.truncateString(item.getGuestbookContent(),15) %>
        </li>
        <%
            }
        %>
        </ul>
    </div>

    <div class="border p-3 py-4 my-4 leftSidebar text-break">
       <span>today</span>
        <%
            VisitorDAO visitorDAO = new VisitorDAO();
            visitorDAO.dbOpen();
        %>
        <span>
            <%= visitorDAO.today() - visitorDAO.lastTotal() %>
        </span>

        <br>
        <span>total</span>
        <span>
            <%= visitorDAO.today() %>
        </span>
        <%
            visitorDAO.dbClose();
        %>
    </div>


</aside>