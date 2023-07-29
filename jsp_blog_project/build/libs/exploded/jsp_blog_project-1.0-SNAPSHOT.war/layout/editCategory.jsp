<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.project1.jsp_blog_project.model.CategoryDTO" %>
<%@ page import="com.project1.jsp_blog_project.model.CategoryDAO" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: parkj
  Date: 2023-05-28
  Time: 오후 5:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    CategoryDAO catedao = new CategoryDAO();
    catedao.dbOpen();
    ArrayList<CategoryDTO> cateList = catedao.selectCategoryList(false, false);
    catedao.dbClose();
    request.setAttribute("categoryList", cateList);
%>
<script>
    $(document).ready(function () {

        // https://gnam.tistory.com/28 select 메소드 모음
        // 이름변경 버튼 클릭시 텍스트 인풋 내의 밸류로 .checked 옵션 밸류와 텍스트 변경
        $('#editNameBtn').on('click', function () {
            var opt = $("#sel option:selected");
            opt.val($('#categoryName').val());
            opt.text($('#categoryName').val());
        });

        // select 태그에서 선택된 option을 제이쿼리 메소드 insertBefore/After로 위치 변경할수 있는거같음
        $("#sel_up").click(function () {
            var opt = $("#sel option:selected");
            if (opt.length == 1) {
                opt.insertBefore(opt.prev());
            }

        });

        $("#sel_down").click(function () {
            var opt = $("#sel option:selected");
            if (opt.length == 1) {
                opt.insertAfter(opt.next());
            }
        });
        $("#del").click(function () {
            var opt = $("#sel option:selected");
            opt.attr('disabled', true)
        });
        $("#cancelDel").click(function () {
            var opt = $("#sel option");
            opt.attr('disabled', false)
        });

        $('#add').click(function () {
            $('#sel').append('<option readonly onclick="sendName(this)" class="chk" value="">새로운 카테고리</option>');
        });

        $('#submitBtn').click(function () {
            $('#sel').val("");
            $('option').not('[disabled]').prop('selected', true);
            $('#categoryForm').submit();
        });

    });

    // 옵션 클릭시 value 가져오기
    function sendName(opt) {
        document.getElementById('categoryName').value = opt.value;
    }

</script>


<section>
    <h5 class="text-center my-4">카테고리 편집</h5>
    <form id="categoryForm" method="post" action="/blog/CategoryController.do" accept-charset="utf-8">
        <div class="row d-flex justify-content-center">
            <div class="col-4">
                <select class="form-select" size="5" multiple name="categoryArr" id="sel">
                    <c:forEach items="${categoryList}" var="item" varStatus="loop">
                        <option readonly onclick="sendName(this)"
                                value="${item.getCategoryName()}">${item.getCategoryName()}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="col-5">
                <div class="d-flex flex-column justify-content-between">
                    <div>
                        <button type="button" id="sel_up" class="btn p-1">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                 class="bi bi-arrow-up-circle-fill" viewBox="0 0 16 16">
                                <path d="M16 8A8 8 0 1 0 0 8a8 8 0 0 0 16 0zm-7.5 3.5a.5.5 0 0 1-1 0V5.707L5.354 7.854a.5.5 0 1 1-.708-.708l3-3a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8.5 5.707V11.5z"/>
                            </svg>
                        </button>
                        <button type="button" id="add" class="btn p-1">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                 class="bi bi-plus-circle-fill" viewBox="0 0 16 16">
                                <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8.5 4.5a.5.5 0 0 0-1 0v3h-3a.5.5 0 0 0 0 1h3v3a.5.5 0 0 0 1 0v-3h3a.5.5 0 0 0 0-1h-3v-3z"/>
                            </svg>
                        </button>
                    </div>
                    <div class="d-flex justify-content-between">
                        <div>
                            <button type="button" id="sel_down" class="btn p-1">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                     class="bi bi-arrow-down-circle-fill" viewBox="0 0 16 16">
                                    <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8.5 4.5a.5.5 0 0 0-1 0v5.793L5.354 8.146a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V4.5z"/>
                                </svg>
                            </button>

                            <button type="button" id="del" class="btn p-1">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                     class="bi bi-x-circle-fill" viewBox="0 0 16 16">
                                    <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM5.354 4.646a.5.5 0 1 0-.708.708L7.293 8l-2.647 2.646a.5.5 0 0 0 .708.708L8 8.707l2.646 2.647a.5.5 0 0 0 .708-.708L8.707 8l2.647-2.646a.5.5 0 0 0-.708-.708L8 7.293 5.354 4.646z"/>
                                </svg>
                            </button>
                            <button type="button" id="cancelDel" class="btn pb-2 pt-1 px-1">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                     class="bi bi-x-circle" viewBox="0 0 16 16">
                                    <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                                    <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
                                </svg>
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                     class="bi bi-arrow-counterclockwise" viewBox="0 0 16 16">
                                    <path fill-rule="evenodd"
                                          d="M8 3a5 5 0 1 1-4.546 2.914.5.5 0 0 0-.908-.417A6 6 0 1 0 8 2v1z"/>
                                    <path d="M8 4.466V.534a.25.25 0 0 0-.41-.192L5.23 2.308a.25.25 0 0 0 0 .384l2.36 1.966A.25.25 0 0 0 8 4.466z"/>
                                </svg>
                            </button>
                        </div>

                        <div>
                            <button type="button" id="submitBtn" class="btn btn-primary">적용</button>
                        </div>
                    </div>


                </div>

                <div class="input-group mt-4">
                    <input type="text" id="categoryName" class="form-control">
                    <button type="button" id="editNameBtn" class="btn btn-outline-dark">이름 변경</button>
                </div>
            </div>

        </div>

    </form>
</section>