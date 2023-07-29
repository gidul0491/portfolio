<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: parkj
  Date: 2023-05-22
  Time: 오후 10:15
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
    <title>관리자 로그인</title>
    <script>
        $(document).ready(function() {
            if (<%boolean err = false;if(request.getParameter("alert")!=null&&request.getParameter("alert").equals("alert")){err=true;}%> <%= err %>) {
                alert("관리자명 또는 비밀번호를 확인해주세요");
            }
            $('#btn-cancel').on('click',function (){
               history.back();
            });
        });
    </script>
</head>
<body>
<c:import url="/layout/header.jsp">
    <c:param name="cate"><%= "로그인" %>
    </c:param>
</c:import>
<main>

    <div class="container my-4 py-4">
        <div class="my-3 row">
            <div class="col-sm-4 mx-auto">
                <form action="/blog/ManagerController.do" method="post" id="frm" form method="post" accept-charset="utf-8" >
                    <input type="hidden" name="mode" value="login">
                    <div class="my-3 mx-auto">
                        <label for="name">관리자명 : </label>
                        <input type="text" class="form-control" id="name" name="name"
                               placeholder="관리자명을 입력하세요" required>
                    </div>
                    <div class="my-3 mx-auto">
                        <label for="pw">비밀번호 : </label>
                        <input type="password" class="form-control" id="pw" name="pw"
                                placeholder="비밀번호를 입력하세요" required>
                    </div>
                    <div class="my-3 d-flex justify-content-center">
                        <button type="submit" class="btn btn-primary mx-1">확인</button>
                        <button type="reset" class="btn btn-secondary mx-1" id="btn-cancel">취소</button>
                    </div>
                </form>
            </div>
        </div>

    </div>
</main>
<c:import url="/layout/footer.jsp">
</c:import>
</body>

</html>
