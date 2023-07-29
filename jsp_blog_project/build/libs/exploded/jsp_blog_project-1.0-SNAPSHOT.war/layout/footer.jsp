<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: parkj
  Date: 2023-05-22
  Time: 오후 10:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>


<footer class="mt-5">
    <hr>
    <div class="container my-5 text-center">
        <span>smart505</span> <br> <br>
        <%
            if(session.getAttribute("isManager") !=null && session.getAttribute("isManager").equals("yes")){
        %>
        <a href="/blog/ManagerController.do" class="text-decoration-none">[관리자 모드]</a> <br><br>
        <a href="/blog/LogoutController.do" class="text-decoration-none">[로그아웃]</a>
        <%
        }else {
        %>
        <a href="/view/managerLogin.jsp" class="text-decoration-none">[관리자 로그인]</a>
        <%
            }
        %>

    </div>




</footer>