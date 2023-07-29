<%@ page import="java.util.ArrayList" %>
<%@ page import="com.project1.jsp_blog_project.model.GuestbookDTO" %>
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

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
    <script src="//code.jquery.com/jquery-3.3.1.min.js"></script>


    <style>
        .chk{
            line-height: 1rem;
            margin: 0rem 0.1rem;
        }
        [id^="hidden"]{
            position: absolute;
            left: 0%; /* 가운데 정렬을 위한 X축 위치 설정 */
            width: 100%;
            visibility:hidden;
            background-color: #eee;
            z-index: 9999;
        }

    </style>








    <title>블로그 프로젝트 - 방명록</title>
    <script>
        if( <%= request.getAttribute("err")!=null && request.getAttribute("err").equals("pwErr") %>){
            alert('비밀번호를 확인하세요');
        }
        if( <%= request.getAttribute("err")!=null && request.getAttribute("err").equals("deleteComp") %>){
            alert('삭제 완료');
        }
        $(document).ready(function(){

            $('.chk').click(function() {
                // 클릭한 라벨의 색상 변경
                $(this).addClass('active');

                // 다른 라벨들의 색상 원래대로 복원
                $('.chk').not(this).removeClass('active');
            });
        });
        function toggleHiddenRow(rowId) {
            var hiddenRow = $('#' + rowId);
            if (hiddenRow.css('visibility') === 'hidden') {
                $('.chk').removeClass('active');
                closeHiddenRows();
                hiddenRow.css('visibility', 'visible');
                $('.checked').addClass('active');

            } else {
                hiddenRow.css('visibility', 'hidden');
            }
        }

            function closeHiddenRows() {
                var rows = document.getElementsByTagName('tr');
                for (var i = 0; i < rows.length; i++) {
                    if (rows[i].id.includes('hidden')) {
                        rows[i].style.visibility= 'hidden';
                    }
                    onclick=updateText('등록');
                }
                clearForm();
            }

            function clearForm() {
                var forms = document.querySelectorAll("form.hiddenReplyForm");
                for (var i = 0; i < forms.length; i++) {
                    forms[i].reset();
                    var it = forms[i].querySelectorAll("input[type='text']");
                    it[0].disabled = false;
                    var ta = forms[i].querySelectorAll("textarea");
                    ta[0].disabled = false;
                }
            }

            function resetForm(id) {
                var input = document.getElementById(id);
                input.disabled = false;
                input.value = null;
            }

            function setInputValue(id, value) {
                var input = document.getElementById(id);
                input.disabled = false;
                input.value = value;

            }

            function setValueDisableInput(id, value) {
                document.getElementById(id).value = value;
                var input = document.getElementById(id);
                input.disabled = true;
        }
        function updateText(parameter) {
            var targetElements = document.getElementsByClassName('sbmt');
            for (var i = 0; i < targetElements.length; i++) {
                targetElements[i].textContent = parameter;
            }
        }

    </script>
</head>
<body>
<c:import url="/layout/header.jsp">
    <c:param name="cate"><%= "방명록" %>
    </c:param>
</c:import>

<%boolean isManager = false; if(session.getAttribute("isManager")!=null && session.getAttribute("isManager") != "" && session.getAttribute("isManager").equals("yes")){isManager = true;} %>
<% String id ="";  if(session.getAttribute("sessionName")!=null){ id = session.getAttribute("sessionName").toString();} %>
<% String pw =null; if(session.getAttribute("sessionPass")!=null){pw = session.getAttribute("sessionPass").toString();} %>

<main>
    <div class="container mx-auto row d-flex justify-content-center">
        <div class="col-2">
            <c:import url="/layout/asideLeft.jsp">
            </c:import>
        </div>

        <div class="col">
            <%--        방명록 작성 폼--%>
            <form action="/blog/GuestbookController.do" method="post"  accept-charset="utf-8">
                <div class="">
                    <div class="row w-100 d-flex justify-content-center">
                        <div class="col-4">
                            <input type="text" class="form-control" id="guestbookName" name="guestbookName" placeholder="이름 입력" required
                                <% if(isManager){ %> value="<%= id %>" readonly <% } %> >
                        </div>
                        <div class="col-4">

                            <input type="password" class="form-control" id="guestbookPass" name="guestbookPass" placeholder="비밀번호 입력" required>
                        </div>
                        <div class="col-2 d-flex justify-content-end p-0">
                            <div class="align-self-end">
                                    <button type="submit" class="btn btn-primary small h-100">제출</button>
                            </div>

                        </div>
                    </div>
                    <div class="row d-flex justify-content-center">
                        <div class="my-3 col-10 pe-4">
                            <textarea class="form-control" id="guestbookContent" name="guestbookContent" rows="2" placeholder="방명록을 남겨주세요"
                                      required></textarea>
                        </div>
                    </div>
                </div>

            </form>
            <hr>
            <div class="mx-auto">
                <table class="table text-center" style="position: relative; font-size: 0.8rem">
                    <colgroup>
                        <%--                <col style="width : 8%;">--%>
                        <col style="width : 20%;">
                        <col style="width : 60%;">
                        <col style="width : 20%;">

                    </colgroup>
                    <thead class="bg-dark text-light">
                    <%--            <th>No.</th>--%>
                    <th>이름</th>
                    <th>내용</th>
                    <th>작성시간</th>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty commentList}">
                            <tr>
                                <td colspan="4">등록된 방명록이 없습니다.</td>
                            </tr>
                        </c:when>
                        <%--                otherwise문 : 방명록리스트를 불러내고 각 열마다 숨겨진 열을 하나씩 추가해서 열을 클릭할때마다 숨겨진 열이 나타나 답장/수정/삭제가 가능하게끔--%>
                        <c:otherwise>
                            <c:set var="previousItem" value="" />
                            <% GuestbookDTO prev = new GuestbookDTO();%>
                            <% GuestbookDTO now = new GuestbookDTO();%>
                            <c:forEach items="${commentList}" var="item" varStatus="loop">
                                <c:if test="${loop.index >= 0}">
                                    <c:set var="nowItem" value="${commentList[loop.index]}" />
                                    <% now = (GuestbookDTO) pageContext.findAttribute("nowItem");%>
                                </c:if>
                                <tr onclick="toggleHiddenRow('hidden${item.getGuestbookPk()}');clearForm();
                                        $('#reply${item.getGuestbookPk()}').prop('checked',true);"
                                        <%if(now.getGuestbookReplyCnt()== -1){%>
                                    style="background-color: #efefef;" <%}%>
                                    ${item.getGuestbookContent()}>

                                    <td class="">
                                            <c:if test="${item.getGuestbookManager()!=0}">
                                                <strong>[관리자]</strong>
                                            </c:if>
                                            ${item.getGuestbookName()}
                                    </td>
                                    <td class="text-start" >
                                        <%if(now.getGuestbookReplyCnt()== -1){%>
                                        └ <%}%>
                                            ${item.getGuestbookContent()}
                                    </td>
                                    <td class="text-start">${item.getGuestbookDatetime()}  ${item.getGuestbookEdited()}</td>
                                </tr>

                                <c:if test="${loop.index >= 0}">
                                    <c:set var="previousItem" value="${commentList[loop.index]}" />
                                    <% prev = (GuestbookDTO) pageContext.findAttribute("previousItem");%>
                                </c:if>
                                <%--***************************************위는 보이는 열, 아래는 숨겨진 열********* ****************************** *********** ********--%>
                                <% if(now.getGuestbookDeleted()!=1) { %>
                                <tr id="hidden${item.getGuestbookPk()}">
                                    <td colspan="3"  class="w-100" >
                                        <form class="hiddenReplyForm" action="/blog/GuestbookController.do" method="post" id="guestbookCommentAdd${item.getGuestbookPk()}"  accept-charset="utf-8">
                                            <input type="hidden" name="guestbookAddPk" value="${item.getGuestbookPk()}">
                                                <div class="row d-flex justify-content-start">
                                                        <%--*************** ********** ************* 답변/수정/삭제 선택하는 라디오버튼*************** ************** ************** *************--%>
                                                    <div class="d-flex justify-content-start ">
                                                            <input type="hidden" name="replyTo" value="${item.getGuestbookNum()}">
                                                            <div>
                                                                <input id="reply${item.getGuestbookPk()}" type="radio" name="reply" value="1"    onclick="resetForm('guestbookAddName${item.getGuestbookPk()}');
                                                                resetForm('guestbookAddContent${item.getGuestbookPk()}'); setInputValue('guestbookAddName${item.getGuestbookPk()}','<%= id %>')"  class="d-none">
                                                                <label for="reply${item.getGuestbookPk()}" class="btn chk btn-outline-primary checked" onclick="updateText('등록')">답글</label>
                                                            </div>
                                                            <div>
                                                                <input id="edit${item.getGuestbookPk()}" type="radio" name="reply" value="2"
                                                                       onclick="setInputValue('guestbookAddName${item.getGuestbookPk()}', '${item.getGuestbookName()}'); setInputValue('guestbookAddContent${item.getGuestbookPk()}', '${item.getGuestbookContent()}')"
                                                                       class="d-none">
                                                                <label for="edit${item.getGuestbookPk()}" class="btn chk btn-outline-dark opacity-75" onclick="updateText('수정');">수정</label>
                                                            </div>
                                                            <div>
                                                                <input id="delete${item.getGuestbookPk()}" type="radio" name="reply" value="3"
                                                                       onclick="setValueDisableInput('guestbookAddName${item.getGuestbookPk()}', '${item.getGuestbookName()}'); setValueDisableInput('guestbookAddContent${item.getGuestbookPk()}', '${item.getGuestbookContent()}')" class="d-none">
                                                                <label for="delete${item.getGuestbookPk()}" class="btn chk btn-outline-danger" onclick="updateText('삭제')">삭제</label>
                                                            </div>
                                                    </div>
<%--**************** ****************** **************** d이름 비밀번호 입력 ************* ***********--%>

                                                            <div class="row mx-auto my-1">
                                                                <div class="col-5 p-0">
                                                                        <input type="text" class="form-control" id="guestbookAddName${item.getGuestbookPk()}" name="guestbookAddName" placeholder="이름" required <% if(isManager){ %> value="<%= id %>" readonly <% } %>>
                                                                </div>
                                                                <div class="col-5 p-0">
                                                                        <input type="password" class="form-control" id="guestbookAddPass${item.getGuestbookPk()}" name="guestbookAddPass" placeholder="비밀번호" required>

                                                                </div>
                                                                <div class="col-2 text-end clearfix p-0">
                                                                    <button type="submit" class="btn btn-secondary float-end w-100 sbmt border-0">등록</button>
                                                                </div>
                                                            </div>
                                                            <div>
                                                                <textarea class="form-control" id="guestbookAddContent${item.getGuestbookPk()}" name="guestbookAddContent" rows="2" placeholder="내용을 입력하세요"
                                                                          required></textarea>
                                                            </div>
                                                </div>
                                        </form>
                                    </td>
                                </tr>
                                <% } %>

                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
            <%--            페이지네이션 출력, html 코드에서 ul 리스트임 --%>
            <div class="d-flex justify-content-center">
                <%
                    int pageNow = (Integer) request.getAttribute("pageNow");
                    int pageBlockSize = (Integer) request.getAttribute("pageBlockSize");
                    int totalPage = (Integer) request.getAttribute("totalPage");
//            ArrayList pageBlockArray = (ArrayList<String>) request.getAttribute("pageBlockArray");
                %>
                <c:set var="pageNow">${pageNow}</c:set>
                <ul class="pagination">
                    <%--                pageBlockArray 즉 [이전, 1,2,.., 다음] 리스트를 출력하는데 각각에 링크를 부여함--%>
                    <c:forEach items="${pageBlockArray}" var="item" varStatus="loop">
                        <c:choose>
                            <%--                        '이전' 이 출력될 경우 (현재페이지 -페이지블록사이즈) 의 페이지로 이동하기위해 PosgListController 호출 --%>
                            <c:when test="${item eq '이전'}">
                                <li class="page-item">
                                    <a class="page-link" href="/blog/GuestbookController.do?pageNow=<%= pageNow-pageBlockSize %>">${item}</a>
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
                                    <a class="page-link" href="/blog/GuestbookController.do?pageNow=<%= pageNow %>">${item}</a>
                                </li>
                            </c:when>

                            <c:when test="${item == pageNow}">
                                <li class="page-item"><a class="page-link bg-primary text-white" style="opacity: 90%">${item}</a></li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item">
                                    <a class="page-link" href="/blog/GuestbookController.do?pageNow=${item}">${item}</a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </ul>
            </div>
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
