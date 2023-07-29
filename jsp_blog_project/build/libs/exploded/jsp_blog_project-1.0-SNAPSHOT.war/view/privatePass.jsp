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
    <title>${post.getPostTitle()}</title>
    <c:set var="category"><%= request.getParameter("category") %></c:set>
    <script>
        $(document).ready(function(){
            $("#listBtn").on("click", function(){
                location.href = "/blog/PostListController.do?category=${category}";
            });
        });
    </script>
</head>
<body>
<c:import url="/layout/header.jsp">
    <c:param name="cate">${post.getPostCategory()}
    </c:param>
</c:import>

<main>
    <div class="container">
        <div class="row my-5">
            <div class="col-4 mx-auto my-5 w-50">

                <form action="/blog/ReadPostController.do?category=${category}" method="post" form method="post" accept-charset="utf-8">

                    <div class="d-flex flex-column">
                        <div class="text-center">
                            <h3>비밀글 입니다.</h3>
                        </div>

                        <input type="hidden" name="postPk" value="${postPk}">
                        <div class="d-flex justify-content-center my-4">
                            <label for="secretPass" class="form-label my-auto">게시글 비밀번호 : &nbsp&nbsp</label>
                            <input type="password" name="secretPass" id="secretPass" class="form-control w-50">
                        </div>
                        <div class="d-flex justify-content-center my-4">
                            <button type="submit" class="btn btn-primary mx-2">제출</button>
                            <button type="button" class="btn btn-secondary mx-2" id="listBtn">취소</button>
                        </div>
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
