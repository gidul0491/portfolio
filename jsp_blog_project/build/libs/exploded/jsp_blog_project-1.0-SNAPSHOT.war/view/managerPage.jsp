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
    <style>
        svg{
            width: 1.5rem;
            height: 1.5rem;
        }
    </style>
    <title>관리자 페이지</title>
    <script>
        $(document).ready(function() {

            // edit가 null이 아니고 0일때

            if(<%boolean err = false;if(request.getParameter("alert")!=null&&request.getParameter("alert").equals("checkAlert")){err=true;}%> <%= err %> ){
                alert("비밀번호를 확인해주세요");
            }
            if(<%err = false;if(request.getParameter("alert")!=null&&request.getParameter("alert").equals("signedUp")){err=true;}%> <%= err %> ){
                alert("관리자 가입 완료");
            }
            if(<%err = false;if(request.getParameter("alert")!=null&&request.getParameter("alert").equals("edit")){err=true;}%> <%= err %> ){
                alert('정보수정 중 오류발생(아이디 중복 혹은 비밀번호를 확인해주세요)');
            }
            if(<%err = false;if(request.getParameter("alert")!=null&&request.getParameter("alert").equals("signUpFail")){err=true;}%> <%= err %> ){
                alert('관리자 가입 중 오류발생(아이디, 이메일 중복을 확인해주세요)');
            }

            $('#check').click(function() {
                if($('#pass').val()==null || $('#pass').val()=='') {
                    alert('정보를 수정하려면 비밀번호를 입력하세요')
                }
                else {
                    $('#mode').val("check")
                    $('#managerNowForm').submit();
                }
            });


            $('#edit').click(function() {
                if($('#pass').val() == $('#pass2').val()){
                    if($('#pass').val()==null || $('#pass').val()==''){
                        alert('수정할 비밀번호를 입력하세요');
                    }else{
                        $('#mode').val("edit")
                        $('#managerNowForm').submit();
                    }
                }else{
                    alert('비밀번호를 확인하세요')
                }
            });

            $('#delete').click(function() {
                if($('#pass').val() == $('#pass2').val()){
                    if($('#pass').val()==null || $('#pass').val()==''){
                        alert('계정을 삭제하려면 비밀번호를 입력하세요');
                    }else{
                        $('#mode').val("delete")
                        $('#managerNowForm').submit();
                    }
                }else{
                    alert('비밀번호를 확인하세요')
                }
            });

            $('#editCancel').click(function() {
                $('#mode').val("nothing")
                $('#managerNowForm').submit();
            });

        });
    </script>
</head>

<body>


<c:import url="/layout/header.jsp">
    <c:param name="cate"><%= "관리자 페이지" %>
    </c:param>
</c:import>

<%
    if(session.getAttribute("isManager")==null || !session.getAttribute("isManager").equals("yes")){
%>
<div class="text-center my-5">
    <h3>로그인 세션이 만료되었습니다. 다시 로그인해주세요</h3>
</div>

<%
}else{
%>
<main>
    <div class="container mx-auto row d-flex justify-content-center">
        <div class="col-2">
    <c:import url="/layout/asideLeft.jsp">
    </c:import>
</div>
        <div class="col mx-auto">
            <section id="managerInform" class="my-4">
                <h5 class="text-center">현재 관리자 정보</h5>
                <div class="row d-flex justify-content-between">
                    <div class="col-3"></div>
                    <div class="col-6">
                        <form action="/blog/ManagerController.do" method="post" id="managerNowForm">
                            <%-- 사용자가 비밀번호를 입력하고 정보 수정을 눌렀을 때 올바른 비밀번호이면 checked=true가 됨--%>
                            <% boolean checked=false; if(session.getAttribute("isChecked")!=null && session.getAttribute("isChecked").equals("yes")){checked = true;} %>
                            <%--    session에 managerNumber 정보가 있을때 스크립틀릿으로 받아오기--%>
                            <%String managerNumber=null; if(session.getAttribute("sessionManagerNum")!=null && session.getAttribute("sessionManagerNum")!=""){managerNumber = session.getAttribute("sessionManagerNum").toString();}%>
                            <%--    아래 hidden으로 항상 managerNumber를 보내게 됨--%>
                            <input type="hidden" name="managerNumber" value="<%= managerNumber %>">
                            <div class="my-3 mx-auto">
                                <label for="name">관리자명 : </label>
                                <input type="text" required class="form-control" id="name" name="name"
                                       placeholder="관리자명 입력" value="<%= session.getAttribute("sessionName") %>" <%if(!checked){%>readonly<%}%> >
                            </div>
                            <div class="my-3 mx-auto">
                                <label for="name">관리자 이메일 : </label>
                                <input type="text" required class="form-control" id="email" name="email"
                                       placeholder="관리자 이메일 입력" value="<%= session.getAttribute("sessionEmail") %>"<%if(!checked){%>readonly<%}%> >
                            </div>
                            <div class="my-3 mx-auto">
                                <label for="name">비밀번호 : </label>
                                <input required type="password" class="form-control" id="pass" name="pw"
                                       <%if(!checked){%>placeholder="정보를 수정하려면 비밀번호 입력"<%}else{%>placeholder="비밀번호 "<%}%>>
                            </div>
                            <%--    ****** ******** ******* check를 눌러서 관리자임이 확인되면 나오는 정보변경을위한 비밀번호 확인란 --%>
                            <% if(checked){ %>
                            <div class="my-3 mx-auto">
                                <label for="name">비밀번호 확인: </label>
                                <input required type="password" class="form-control" id="pass2"
                                       placeholder="비밀번호를 한 번 더 입력">
                            </div><%}%>
                            <input type="hidden" id="mode" name="mode">

                        </form>
                    </div>
                    <div class="col-3">
                        <div class="h-100 d-flex justify-content-end flex-column">
                            <% if(!checked){ %>
                            <div class="align-self-end">
                                <button type="button" class="btn btn-secondary" id="check">정보 수정</button>
                            </div>
                            <%}else{%>

                            <div class="align-self-end my-1">
                                <button type="button" class="btn btn-warning my-1" id="edit">수정</button>
                                <button type="button" class="btn btn-danger my-1" id="delete">삭제</button>
                                <button type="button" class="btn btn-secondary my-1" id="editCancel">취소</button>
                            </div>


                            <%}%>

                        </div>


                    </div>
                </div>
            </section>
            <section class="my-4 row text-center">
                <h5 class="text-center">관리자 리스트</h5>

                <div class="row mx-auto">
                    <div class="col-2"></div>
                    <div class="col-8 mx-auto">
                        <table class="table table-hover table-striped text-center">
                            <colgroup>
                                <col style="width : 25%;">
                                <col style="width : 45%;">
                                <col style="width : 30%;">

                            </colgroup>
                            <thead class="bg-dark text-light">
                            <th>관리자명</th>
                            <th>이메일</th>
                            <th>가입일</th>
                            </thead>
                            <tbody>
                            <c:forEach items="${managerList}" var="item" varStatus="loop">
                                <tr>
                                    <td class="text-start">${item.getManagerName()}</td>
                                    <td class="text-start">${item.getManagerEmail()}</td>
                                    <td class="text-start">${item.getManagerDatetime()}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>

                    </div>
                    <div class="col-2 text-end pe-0">
                        <a href="/view/managerSignUp.jsp" class="btn btn-primary my-3">관리자 추가</a>
                    </div>
                </div>

            </section>
            <c:import url="/layout/editCategory.jsp">
            </c:import>
        </div>
        <div class="col-2">
            <div></div>
        </div>
    </div>

</main>
<%
    }
%>
<c:import url="/layout/footer.jsp">
</c:import>
</body>
</html>
