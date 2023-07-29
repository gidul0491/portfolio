<%@ page import="com.project1.jsp_blog_project.model.PostDTO" %>
<%@ page import="com.project1.jsp_blog_project.model.CategoryDTO" %>
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
    <script>
        $(document).ready(function () {
            $("#listBtn").on("click", function () {
                history.back();
            });


            $("#closed").on("click", function () {
                $("#private").attr("disabled", true);
            });

            $("#opened").on("click", function () {
                $("#private").attr("disabled", false);
            });
            $("#cancel").on("click", function () {
                history.back();
            });

            $('.chk').click(function () {
                // 클릭한 라벨의 색상 변경
                $(this).addClass('active');

                // 다른 라벨들의 색상 원래대로 복원
                $('.chk').not(this).removeClass('active');
            });
        });

    </script>
</head>
<body>
<c:import url="/layout/header.jsp">
    <c:param name="cate">
        <c:if test="${post.getPostPk()==0}">
            게시글 작성
        </c:if>
        <c:if test="${post.getPostPk() != 0}">
            게시글 수정
        </c:if>
    </c:param>
</c:import>


<%-- EditController에 넘겨주는 파라미터 :
<%--postOpen 공개/비공개(1,3), 공개1일때 privatePass String--%>
<%--제목 postTitle sTring--%>
<%--내용 postContent--%>
<%--카테고리 postCategory--%>
<%--글번호 postPk --%>
<main>
    <%
        // 글쓰기인지 글수정인지 알려면 post 라는 이름으로 넘어온 dto가 null인지 아닌지 확인하면되는듯
        PostDTO dto = new PostDTO();
        boolean isNewPost = false;
        if (request.getAttribute("post") != null) {
            dto = (PostDTO) request.getAttribute("post");
        }
        if (dto.getPostPk() == 0) {
            isNewPost = true;
        }
        String cate = "";
        if (request.getParameter("category") != null && request.getParameter("category") != "") {
            cate = request.getParameter("category");
        }
    %>
    <div class="container mx-auto row d-flex justify-content-center">
        <div class="col-2">
            <c:import url="/layout/asideLeft.jsp">
            </c:import>
        </div>
        <div class="col">
            <%
                if (isNewPost) {
            %>
            <div class="my-4 ms-3">
                <h3 class="d-inline-block">신규 글</h3> <br>

            </div>
            <%
                }
            %>
            <div class="container">
                <form action="/blog/EditController.do" id="editedDto" method="post" accept-charset="utf-8"
                      enctype="multipart/form-data" class="w-100">
                    <div class="w-100 d-flex  align-items-end mt-5">
                        <div class="w-100 row d-flex align-items-end ">
                            <div class="input-group col pe-0">
                                <label for="postCategory" class="input-group-text small text-nowrap">카테고리</label>
                                <select class="form-select" name="postCategory" id="postCategory">
                                    <option value="tempSaved">임시저장</option>
                                    <c:forEach items="${categoryList}" var="item" varStatus="loop">
                                        <option value="${item.getCategoryName()}"
                                                <%
                                                    CategoryDTO item = (CategoryDTO) pageContext.getAttribute("item");
                                                    if (item.getCategoryName().equals(cate)) {
                                                %>
                                                selected
                                                <%
                                                    }
                                                %>
                                        >${item.getCategoryName()}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-5 d-flex align-contents-end pe-0">
                                <label for="closed"
                                       class="btn btn-outline-secondary opacity-75 text-black chk text-nowrap">비공개</label>
                                <input class="d-none" id="closed" type="radio" name="postOpen" value=3>
                                <label for="opened"
                                       class="btn btn-outline-secondary opacity-75 text-black chk text-nowrap active">공개</label>
                                <input class="d-none" id="opened" type="radio" name="postOpen" value=1 checked>

                                <input class="form-control d-inline w-50" type="text" id="private" name="privatePass"
                                       placeholder="암호 입력시 비밀글">
                            </div>

<%--                            <div class="col-5 d-flex align-contents-end pe-0">--%>
<%--                                <label for="closed"--%>
<%--                                       >비공개</label>--%>
<%--                                <input  id="closed" type="radio" name="postOpen" value="3">--%>

<%--                                <label for="opened"--%>
<%--                                >공개</label>--%>
<%--                                <input id="opened" type="radio" name="postOpen" value="1">--%>

<%--                                <input  type="text" id="private" name="privatePass"--%>
<%--                                       placeholder="암호 입력시 비밀글">--%>
<%--                            </div>--%>


                            <%
                                if (!isNewPost) {
                            %>

                            <div class="text-end d-inline-block col" style="font-size: 0.8rem">
                                <small>${post.getPostVisit()} 명 조회</small> <br>
                                <small><i>${post.getPostDatetime().split(" ")[0]} ${post.getPostEdited()}
                                    작성자 ${post.getPostWriter()}</i></small> <br>
                            </div>
                            <%
                            } else {
                            %>
                            <div class="d-inline-block col pe-0">
                                <input type="text" class="form-control"
                                       value="작성자 <%= session.getAttribute("sessionName") %>" readonly>
                            </div>
                            <%
                                }
                            %>
                        </div>
                    </div>

                    <input type="hidden" name="postPk" value="${post.getPostPk()}">


                    <div class="my-3">
                        <input type="text" class="form-control" id="postTitle" name="postTitle" placeholder="제목을 입력하세요"
                               value="${post.getPostTitle()}" required>
                    </div>

                    <div class="my-3">
                        <textarea class="form-control" id="postContent" name="postContent" rows="5"
                                  placeholder="내용을 입력하세요"
                                  required>${post.getPostContent()}</textarea>
                    </div>
                    <%
                        boolean isFileUploaded = false;
                        String uploadedFile = "";
                        if (dto.getPostOfile() != null && dto.getPostOfile() != "") {
                            isFileUploaded = true;
                            uploadedFile = dto.getPostOfile();
                        }
                        if (isFileUploaded) {
                    %>
                    <div class="input-group my-3">
                        <input id="fileNow" type="text" class="form-control" value="<%= uploadedFile %>">
                        <label for="fileNow" class="input-group-text">현재 파일</label>
                    </div>
                    <%
                        }
                    %>
                    <div class="input-group my-3">

                        <input type="file" class="form-control float-end" id="file" name="file"
                               placeholder="글과 함께 등록할 파일을 선택하세요">
                        <label class="input-group-text" for="file"><% if (isFileUploaded) { %> 파일 수정 <% } else { %>
                            업로드 <% } %></label>
                    </div>
                    <div class="d-flex justify-content-between">
                        <div class="">
                            <button class="btn btn-secondary" id="cancel">돌아가기</button>
                        </div>
                        <div class="">
                            <button type="submit" formmethod="post" class="btn btn-primary">작성</button>
                            <button type="reset" class="btn btn-success">초기화</button>
                        </div>
                    </div>
                    <%--        hidden으로 넘겨지는 작성자 이름, 글쓰기일경우 db에 넘어가고 글수정일경우 원본작성자를 유지하기위해 db에 안넘어감 --%>
                    <input type="hidden" name="postWriter" value="<%= session.getAttribute("sessionName") %>">

                </form>
            </div>

        </div>
        <div class="col-2"></div>
    </div>

</main>

<c:import url="/layout/footer.jsp">
</c:import>
</body>
</html>
