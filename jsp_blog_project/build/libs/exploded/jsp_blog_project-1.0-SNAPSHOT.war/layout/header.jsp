

<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.project1.jsp_blog_project.model.VisitorDAO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: parkj
  Date: 2023-05-22
  Time: 오후 10:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%
    String cate = request.getParameter("cate");
    if( cate.equals("all") ){
        cate = "전체 게시글";
    } else if (cate.equals("") || cate.equals("tempSaved")) {
        cate = "임시저장";
    }
%>
<style>
    .btn{
        opacity: 90%;
    }
</style>
<header>

    <div class="container my-4 mt-5 ps-5">
        <a href="/index.jsp" class="text-decoration-none text-dark mt-4"><h4>개인 블로그 프로젝트</h4></a>
        <a class="text-decoration-none text-dark" href="/blog/PostListController.do?category=<%= request.getParameter("cate") %>"><h6><i><%= cate %></i></h6></a>
    </div>
    <hr>
</header>
