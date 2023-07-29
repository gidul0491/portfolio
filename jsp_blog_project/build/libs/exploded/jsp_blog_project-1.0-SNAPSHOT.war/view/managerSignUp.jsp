<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: parkj
  Date: 2023-05-22
  Time: 오후 10:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
            crossorigin="anonymous"></script>
    <title>관리자 계정 추가</title>
    <script>
        $(document).ready(function() {

        });
    </script>
</head>
<body>
<c:import url="/layout/header.jsp">
    <c:param name="cate"><%= "관리자 계정 추가" %>
    </c:param>
</c:import>
<main>
    <%
        if(session.getAttribute("isManager")==null || !session.getAttribute("isManager").equals("yes")){
    %>
    <div class="text-center my-5">
        <h3>로그인 세션이 만료되었습니다. 다시 로그인해주세요</h3>
    </div>

    <%
        }else{
    %>
    <div class="container my-4 py-4">
        <div class="my-3 row">
            <div class="col-sm-4 mx-auto">
                <form action="/blog/ManagerController.do" method="post" id="signUpForm" accept-charset="utf-8">
                    <input type="hidden" name="mode" value="signUp">
                    <input type="hidden" name="mode" value="login">
                    <div class="my-3 mx-auto">
                        <label for="name">관리자명 : </label>
                        <input required type="text" class="form-control" id="name" name="name"
                               placeholder="관리자명을 입력하세요">
                    </div>
                    <div class="my-3 mx-auto">
                        <label for="email">이메일 : </label>
                        <input required type="text" class="form-control" id="email" name="email"
                               placeholder="이메일을 입력하세요">
                    </div>
                    <div class="my-3 mx-auto">
                        <label for="pass">비밀번호 : </label>
                        <input required type="password" class="form-control" id="pass" name="pw"
                               placeholder="비밀번호를 입력하세요">
                    </div>
                    <div class="my-3 mx-auto">
                        <label for="pass2">비밀번호 확인 : </label>
                        <input required type="password" class="form-control" id="pass2"
                               placeholder="비밀번호를 한 번 더 입력하세요">
                    </div>
                    <div class="my-3 d-flex justify-content-center">
                        <button type="submit" class="btn btn-success mx-1" id="signUpBtn">확인</button>
                        <button type="reset" class="btn btn-secondary mx-1" id="btn-cancel">취소</button>
                    </div>

                </form>
            </div>
        </div>

    </div>
    <%
        }
    %>
</main>
<c:import url="/layout/footer.jsp">
</c:import>
</body>
</html>
