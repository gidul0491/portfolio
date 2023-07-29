<%@ page import="com.project1.jsp_blog_project.model.CommentDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.project1.jsp_blog_project.model.CommentDAO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: parkj
  Date: 2023-05-27
  Time: 오후 11:47
  To change this template use File | Settings | File Templates.
--%>
<head>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
  <!-- JavaScript Bundle with Popper -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
  <script src="//code.jquery.com/jquery-3.3.1.min.js"></script>


</head>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%boolean isManager = false; if(session.getAttribute("isManager")!=null && session.getAttribute("isManager") != "" && session.getAttribute("isManager").equals("yes")){isManager = true;} %>
<% String id ="";  if(session.getAttribute("sessionName")!=null){ id = session.getAttribute("sessionName").toString();} %>
<section>

  <%
    int postPk = Integer.parseInt(request.getParameter("postPk"));
    CommentDAO dao = new CommentDAO();
    dao.dbOpen();
    List<CommentDTO> commentList = dao.selectCommentList(postPk);
    dao.dbClose();
    request.setAttribute("commentList",commentList);
  %>
  <div class="mx-auto">
    <table class="table text-center border-top" style="position: relative; font-size: 0.8rem">
      <colgroup>
        <col style="width : 20%;">
        <col style="width : 60%;">
        <col style="width : 20%;">

      </colgroup>
      <thead class="bg-light">
      <th colspan="3" class="text-start">댓글</th>
<%--      <th>내용</th>--%>
<%--      <th>작성시간</th>--%>
      </thead>
      <tbody>
      <c:choose>
        <c:when test="${empty commentList}">
          <tr>
            <td colspan="4">등록된 댓글이 없습니다.</td>
          </tr>
        </c:when>
        <%--                otherwise문 : 방명록리스트를 불러내고 각 열마다 숨겨진 열을 하나씩 추가해서 열을 클릭할때마다 숨겨진 열이 나타나 답장/수정/삭제가 가능하게끔--%>
        <c:otherwise>
          <c:set var="previousItem" value="" />
          <% CommentDTO prev = new CommentDTO();%>
          <% CommentDTO now = new CommentDTO();%>
          <c:forEach items="${commentList}" var="item" varStatus="loop">
            <c:if test="${loop.index >= 0}">
              <c:set var="nowItem" value="${commentList[loop.index]}" />
              <% now = (CommentDTO) pageContext.findAttribute("nowItem");%>
            </c:if>
            <tr onclick="toggleHiddenRow('hidden${item.getCommentPk()}');clearForm();
                    $('#reply${item.getCommentPk()}').prop('checked',true);"
                    <%if(now.getCommentReplyCnt()== -1){%>
                style="background-color: #efefef;" <%}%>
              ${item.getCommentContent()}>

              <td>
                <c:if test="${item.getCommentManager()!=0 and item.getCommentDeleted()!=1}">
                  <strong>[관리자]</strong>
                </c:if>
                  ${item.getCommentName()}
              </td>
              <td class="text-start" >
                <%if(now.getCommentReplyCnt()== -1){%>
                └ <%}%>
                  ${item.getCommentContent()}
              </td>
              <td class="text-start">${item.getCommentDatetime()}  ${item.getCommentEdited()}</td>
            </tr>

            <c:if test="${loop.index >= 0}">
              <c:set var="previousItem" value="${commentList[loop.index]}" />
              <% prev = (CommentDTO) pageContext.findAttribute("previousItem");%>
            </c:if>
            <%--***************************************위는 보이는 열, 아래는 숨겨진 열********* ****************************** *********** ********--%>
            <% if(now.getCommentDeleted()!=1) { %>
            <tr id="hidden${item.getCommentPk()}">
              <td colspan="3"  class="w-100" >
                <form class="hiddenReplyForm" action="/blog/CommentController.do?" method="post" id="CommentCommentAdd${item.getCommentPk()}"  accept-charset="utf-8">
                  <input type="hidden" name="commentAddPk" value="${item.getCommentPk()}">
                  <input type="hidden" name="postPk" value="<%= postPk %>">
                  <div class="row d-flex justify-content-start">
                      <%--*************** ********** ************* 답변/수정/삭제 선택하는 라디오버튼*************** ************** ************** *************--%>
                    <div class="d-flex justify-content-start ">
                      <input type="hidden" name="replyTo" value="${item.getCommentNum()}">
                      <div>
                        <input id="reply${item.getCommentPk()}" type="radio" name="reply" value="1" onclick="resetForm('commentAddContent${item.getCommentPk()}');setInputValue('commentAddName${item.getCommentPk()}','<%= id %>');"
                               class="d-none">
                        <label for="reply${item.getCommentPk()}" class="btn chk btn-outline-primary checked" onclick="updateText('등록'); ">답글</label>
                      </div>
                      <div>
                        <input id="edit${item.getCommentPk()}" type="radio" name="reply" value="2"
                               onclick="setInputValue('commentAddName${item.getCommentPk()}', '${item.getCommentName()}'); setInputValue('commentAddContent${item.getCommentPk()}', '${item.getCommentContent()}')"
                               class="d-none">
                        <label for="edit${item.getCommentPk()}" class="btn chk btn-outline-dark opacity-75" onclick="updateText('수정');">수정</label>
                      </div>
                      <div>
                        <input id="delete${item.getCommentPk()}" type="radio" name="reply" value="3"
                               onclick="setValueDisableInput('commentAddName${item.getCommentPk()}', '${item.getCommentName()}'); setValueDisableInput('commentAddContent${item.getCommentPk()}', '${item.getCommentContent()}');" class="d-none">
                        <label for="delete${item.getCommentPk()}" class="btn chk btn-outline-danger" onclick="updateText('삭제')">삭제</label>
                      </div>
                    </div>
                      <%--**************** ****************** **************** 이름 비밀번호 입력 ************* ***********--%>

                    <div class="row mx-auto my-1">
                      <div class="col-5 p-0">
                        <input type="text" class="form-control" id="commentAddName${item.getCommentPk()}" name="commentAddName" placeholder="이름" required <% if(isManager){ %> value="<%= id %>" readonly <% } %>>
                      </div>
                      <div class="col-5 p-0">
                        <input type="password" class="form-control" id="commentAddPass${item.getCommentPk()}" name="commentAddPass" placeholder="비밀번호" required>

                      </div>
                      <div class="col-2 text-end clearfix p-0">
                        <button type="submit" class="btn btn-secondary float-end w-100 sbmt border-0">등록</button>
                      </div>
                    </div>
                    <div>
                      <textarea class="form-control" id="commentAddContent${item.getCommentPk()}" name="commentAddContent" rows="2" placeholder="내용을 입력하세요" required></textarea>
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
    <hr class="mt-5 ">
    <form action="/blog/CommentController.do" method="post"  accept-charset="utf-8">
      <input type="hidden" name="postPk" value="<%= postPk %>">
      <div class="">
        <div class="row w-100 d-flex justify-content-center m-0">
          <div class="col-4 p-0">
            <input type="text" class="form-control" id="commentName" name="commentName" placeholder="이름 입력" required
              <% if(isManager){ %> value="<%= id %>" readonly <% } %> >
          </div>
          <div class="col-4 py-0 px-1">

            <input type="password" class="form-control" id="commentPass" name="commentPass" placeholder="비밀번호 입력" required>
          </div>
          <div class="col-2 d-flex justify-content-end p-0">
            <div class="align-self-end m-0 w-100">
              <button type="submit" class="btn btn-primary small h-100 w-100">제출</button>
            </div>

          </div>
        </div>
        <div class="row d-flex justify-content-center w-100 my-1 mx-0">
          <div class="col-10 p-0">
                            <textarea class="form-control" id="commentContent" name="commentContent" rows="2" placeholder="댓글을 남겨주세요"
                                      required></textarea>
          </div>
        </div>
      </div>

    </form>
  </div>
</section>
