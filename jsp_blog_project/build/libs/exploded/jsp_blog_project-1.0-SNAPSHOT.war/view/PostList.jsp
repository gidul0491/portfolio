<%@ page import="com.project1.jsp_blog_project.model.PostDAO" %>
<%@ page import="com.project1.jsp_blog_project.model.PostDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.project1.jsp_blog_project.util.FileUtils" %>
<%@ page import="java.nio.file.FileStore" %>
<%@ page import="com.project1.jsp_blog_project.model.CommentDAO" %>
<%@ include file="/layout/addCookie.jsp" %>
<%--
  Created by IntelliJ IDEA.
  User: parkj
  Date: 2023-05-22
  Time: 오후 10:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String cate = (String) request.getAttribute("category"); %>
<html>
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
            crossorigin="anonymous"></script>
    <title>블로그 프로젝트</title>

</head>
<body>
<c:import url="/layout/header.jsp">
    <c:param name="cate"><%= cate %>
    </c:param>
</c:import>

<main>
    <div class="container mx-auto row d-flex justify-content-center">
        <div class="col-2">
            <c:import url="/layout/asideLeft.jsp">
            </c:import>
        </div>
        <div class="col my-4">
        <section>
            <div class="mx-auto">
                <form action="/blog/PostListController.do" method="get" id="pageSelect">
                    <%
                        String pgSize = "5";
                        // 서버에서 세션 값을 가져옴
                        if(request.getParameter("pSize")!=null&&request.getParameter("pSize")!="") {
                            pgSize = request.getParameter("pSize");
                        }
                    %>
                    <div class="d-flex align-content-center justify-content-end">
                        <span class="my-auto">표시할 게시글 수 &nbsp&nbsp</span>
                        <select name="pSize" id="pSize" class="form-select-sm" onchange="document.getElementById('pageSelect').submit()">
                            <option value="5" id="ps5"
                                    <%= pgSize.equals("5") ? "selected" : "" %>>5
                            </option>
                            <option value="10" id="ps10"
                                    <%= pgSize.equals("10") ? "selected" : "" %>>10
                            </option>
                            <option value="15" id="ps15"
                                    <%= pgSize.equals("15") ? "selected" : "" %>>15
                            </option>
                            <option value="20" id="ps20"
                                    <%= pgSize.equals("20") ? "selected" : "" %>>20
                            </option>
                            <option value="30" id="ps30"
                                    <%= pgSize.equals("30") ? "selected" : "" %>>30
                            </option>
                        </select>
                    </div>

                </form>

                <table class="table table-hover table-striped text-center" style="font-size: 0.8rem">
                    <colgroup>
                        <col style="width : 12%;">
                        <col style="width : 56%;">
                        <col style="width : 25%;">
                        <col style="width : 7%;">

                    </colgroup>
                    <thead class="bg-dark text-light">
                    <th>작성자</th>
                    <th>제목</th>
                    <th>작성시간</th>
                    <th>조회수</th>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty postList}">
                            <tr>
                                <td colspan="4">등록된 게시물이 없습니다.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
<%--                            게시글당 댓글수를 불러오기위한 commentDAO--%>
                            <%
                                CommentDAO commentDAO = new CommentDAO();
                                commentDAO.dbOpen();
                            %>
                            <c:forEach items="${postList}" var="item" varStatus="loop">
                                <c:set var="itemPk">${item.getPostPk()}</c:set>
                                <tr>
                                    <td>${item.getPostWriter()}</td>
                                    <td class="text-start">
                                        <a href="/blog/ReadPostController.do?postPk=${item.getPostPk()}&category=<%=cate %>"
                                           class="text-decoration-none text-black">
                                                <strong>
                                                    <%
                                                        if(cate.equals("all")){
                                                             %>
                                                    [${item.getPostCategory()}]
                                                            <%
                                                        }
                                                    %>

                                                    <span class="text-danger">${item.getPostOpen()}</span>

                                                </strong>
<%--                                            제목이 길면 ... 으로 표시하는 메소드--%>
                                                ${FileUtils.truncateString(item.getPostTitle(),30) }
<%--                                            item의 pk값으로 commentDAO를 이용, 댓글수를 가져오고 0이아니라면 댓글수 표시--%>
                                            <%
                                                int itemPk = Integer.parseInt(pageContext.getAttribute("itemPk").toString());
                                                int commentNum = commentDAO.commentCount(itemPk);
                                            if(commentNum !=0){
                                        %>
                                            <span class="text-secondary">(<%= commentNum %>)</span>
                                            <%
                                                }
                                            %>
                                        </a>
                                    </td>
                                    <td class="text-start">${item.getPostDatetime()}  ${item.getPostEdited()}</td>
                                    <td>${item.getPostVisit()}</td>

                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
            <c:if test="${sessionScope.isManager == 'yes'}">
                <div class="float-end">
                    <a href="/blog/EditController.do?postPk=0" class="btn btn-primary">글쓰기</a>
                </div>

            </c:if>

            <%--            페이지네이션 출력, html 코드에서 ul 리스트임 --%>
            <div class="d-flex justify-content-center my-5">
                <%
                    int pageNow = (Integer) request.getAttribute("pageNow");
                    int pageBlockSize = (Integer) request.getAttribute("pageBlockSize");
                    int totalPage = (Integer) request.getAttribute("totalPage");
                    ArrayList pageBlockArray = (ArrayList<String>) request.getAttribute("pageBlockArray");
                %>
                <c:set var="pageNow">${pageNow}</c:set>
                <ul class="pagination">
                    <%--                pageBlockArray 즉 [이전, 1,2,.., 다음] 리스트를 출력하는데 각각에 링크를 부여함--%>
                    <c:forEach items="${pageBlockArray}" var="item" varStatus="loop">
                        <c:choose>
                            <%--                        '이전' 이 출력될 경우 (현재페이지 -페이지블록사이즈) 의 페이지로 이동하기위해 PosgListController 호출 --%>
                            <c:when test="${item eq '이전'}">
                                <li class="page-item">
                                    <a class="page-link" href="/blog/PostListController.do?pageNow=<%= pageNow-pageBlockSize %>&category=<%= cate %>">${item}</a>
                                </li>
                            </c:when>
                            <%--                        pageNow 인 경우에는 링크없이 출력--%>

                            <%--                        '다음'일 경우 (현재페이지+페이지블록사이즈)의 페이지로 이동하되, 값이 마지막페이지모다 큰 정수인 경우 마지막 페이지로 링크--%>
                            <c:when test="${item eq '다음'}">
                                <%
                                    if (pageNow + pageBlockSize > totalPage) {
                                        pageNow = totalPage;
                                    } else {
                                        pageNow += pageBlockSize;
                                    }
                                %>
                                <li class="page-item">
                                    <a class="page-link" href="/blog/PostListController.do?pageNow=<%= pageNow %>&category=<%= cate %>&pSize=<%= pgSize %> ">${item}</a>
                                </li>
                            </c:when>

                            <c:when test="${item == pageNow}">
                                <li class="page-item"><a class="page-link bg-primary text-white" style="opacity: 90%">${item}</a></li>
                            </c:when>
<%--                            숫자페이지--%>
                            <c:otherwise>
                                <li class="page-item">
                                    <a class="page-link" href="/blog/PostListController.do?pageNow=${item}&category=<%= cate %>&pSize=<%= pgSize %>">${item}</a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </ul>
            </div>


        </section>
        </div>
        <div class="col-2">
            <div></div>
        </div>
    </div>
</main>
<c:import url="/layout/footer.jsp">
</c:import>
</body>
</html>