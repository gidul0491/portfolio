<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/layout/addCookie.jsp" %>
<%--
  Created by IntelliJ IDEA.
  User: parkj
  Date: 2023-05-22
  Time: 오후 10:14
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
    <script>
        <c:set var="postPk">${post.getPostPk()}</c:set>

        <%
            int postPk = Integer.parseInt(pageContext.getAttribute("postPk").toString());
            String likemode = "";
            if(request.getParameter("like")!=null){
                likemode = request.getParameter("like");
            }
        %>
        <c:set var="likeMode"> <%= likemode %> </c:set>
        <c:set var="category"><%= request.getParameter("category") %></c:set>


        $(document).ready(function(){
            $("#listBtn").on("click", function(){
                location.href = "/blog/PostListController.do?category=${category}";
            });

            $("#editBtn").on("click", function () {
                const postPk = ${post.getPostPk()};

                location.href = "/blog/EditController.do?&postPk=" + postPk+"&mode=edit&category=${post.getPostCategory()}";
            });

            $("#deleteBtn").on("click", function () {
                const postPk = ${post.getPostPk()};
                if(confirm("게시글을 삭제하시겠습니까?")){
                    location.href = "/blog/EditController.do?&postPk=" + postPk+"&mode=delete&category=${post.getPostCategory()}";
                }
            });
            //  버튼클릭시 색상변경, 클릭시 active 클래스가 추가됨
            $('.chk').click(function() {
                // 현재 클릭된 라벨에 active 클래스 추가
                $(this).addClass('active');

                // 다른 라벨에서 active 클래스 제거
                $('.chk').not(this).removeClass('active');
            });


            $('.chk').click(function() {
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
    <c:param name="cate">${post.getPostCategory()}</c:param>
</c:import>


<main>
    <div class="container mx-auto row d-flex justify-content-center">
    <div class="col-2">
        <c:import url="/layout/asideLeft.jsp">
        </c:import>
    </div>
        <div class="col">
        <div class="d-flex flex-column">
            <div class="w-100">
                <br>
                <p class="h4"> ${post.getPostOpen()} ${post.getPostTitle()}</p>
                <%--            <p>좋아요 : ${post.getPostLike()}</p>--%>


            </div>

            <div class="d-flex justify-content-between">
                <div>
                    <small><i>&nbsp&nbsp ${post.getPostDatetime()} ${post.getPostEdited()} 작성자 ${post.getPostWriter()}</i></small>
                </div>


            </div>
            <div class="d-flex justify-content-between align-items-end">
                <form action="/blog/PostLikeController.do?category=${category}" method="get" id="postLike"  class="mb-0">
                    <input type="hidden" name="likeMode" value="likePlus">
                    <input type="hidden" name="postPk" value="${post.getPostPk()}">
                    <input type="hidden" name="category" value="${category}">
                    <button id="postLikeBtn" type="submint" class="btn mb-0 ms-2 p-1">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
                            <path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"/>
                        </svg>
                        ${post.getPostLike()}
                    </button>

                </form>
                <form action="/blog/PostLikeController.do?category=${category}" method="get" id="postLikeCancel" class="mb-0">
                    <input type="hidden" name="likeMode" value="likeMinus">
                    <input type="hidden" name="postPk" value="${post.getPostPk()}">
                    <input type="hidden" name="category" value="${category}">
                    <button id="postLikeCancelBtn" type="submit" class="btn mb-0 ms-2 p-1">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
                            <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
                        </svg>
                        ${post.getPostLike()}
                    </button>
                </form>
                <div class="text-end mb-2">
                    <small>${post.getPostVisit()} 명 조회</small>
                </div>
            </div>
            <hr class="my-1">
        </div>
            <c:if test="${not empty post.postOfile}">
            <div class="mb-4">
                <a href="/blog/Download.do?ofile=${post.postOfile}&sfile=${post.postSfile}" class="text-dark text-decoration-none">첨부파일 : ${post.getPostOfile()}</a>
            </div>
            </c:if>
            <p>${post.getPostContent()}</p>

            <div class="d-flex justify-content-between mt-5">
                <div>
                    <button type="button" id="listBtn" class="btn btn-secondary">목록</button>

                </div>


                    <div>
                    <c:if test="${sessionScope.isManager == 'yes'}">
                        <button type="button" id="editBtn" class="btn btn-primary">수정</button>
                        <button type="button" id="deleteBtn" class="btn btn-primary">삭제</button>
                    </c:if>
                    </div>

            </div>

            <hr>
            <c:import url="/layout/postComment.jsp?postPk=${post.getPostPk()}">
            </c:import>
        </div>
<div class="col-2"></div>
    </div>
    <div class="container">
        <a class="float-end" type="button" href="#" id="upperBtn"> 위로 </a>
    </div>

</main>



<c:import url="/layout/footer.jsp">
</c:import>
<script>
    if( <%= request.getAttribute("err")!=null && request.getAttribute("err").equals("pwErr") %>){
        alert('비밀번호를 확인하세요');
    }
    if( <%= request.getAttribute("err")!=null && request.getAttribute("err").equals("deleteComp") %>){
        alert('삭제 완료');
    }


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
    // ********** ********* ****** 좋아요 누를시 쿠키 업데이트********* ********* ********** *****
    function updateLike(postPk){
        // 좋아요 버튼 클릭 시
        var likedPost = getLikedPost(); // 기존의 likedPost 쿠키 값 (배열)
        // 쿠키로 가져온 배열에 postPk가 없다면, 즉 좋아요를 누르는게 처음이라면
        if(!likedPost.includes(postPk)){
            likedPost.push(postPk); // 쿠키에 게시글 번호 추가
            setLikedPost(likedPost); // likedPost 쿠키 업데이트
        }
    }
    function cancelLike(postPk){
        // 취소 버튼 클릭 시
        var likedPost = getLikedPost(); // 기존의 likedPost 쿠키 값 (배열)
        // 쿠키로 가져온 배열에 postPk가 있다면
        if(likedPost.includes(postPk)){
            likedPost.splice(likedPost.indexOf(postPk),1); // 쿠키에 게시글 번호 삭제
            setLikedPost(likedPost); // likedPost 쿠키 업데이트
        }
    }
    // likedPost 쿠키 값을 가져오는 함수
    function getLikedPost() {
        var likedPostCookie = getCookie("likedPost"); // likedPost라는 이름의 쿠키의 값을 likedPostCookie에 저장
        return likedPostCookie ? JSON.parse(likedPostCookie) : []; // 불러온 값을 배열로 변환
    }
    // likedPost 쿠키에 값을 설정하는 함수
    function setLikedPost(likedPost) {
        var likedPostCookie = JSON.stringify(likedPost); // 매개변수로 받은 배열을 string으로 변환
        setCookie("likedPost", likedPostCookie,30); // likedPost라는 이름의 쿠키에 string으로 변환한 postPk 배열 저장
    }
    // 쿠키 설정 함수
    function setCookie(name, value, days) {
        var expires = "";
        if (days) {
            var date = new Date();
            date.setTime(date.getTime() + days * 24 * 60 * 60 * 1000);
            expires = "; expires=" + date.toUTCString();
        }
        // document.cookie를 사용하여 쿠키설정, "name=value; expires=유효기간; path=/" 형식으로 작성, path=/는 쿠키가 사이트 전체에서 사용 가능함을 의미
        document.cookie = name + "=" + (value || "") + expires + "; path=/blog";
    }

    // 쿠키 가져오기 함수
    function getCookie(name) {
        var nameEQ = name + "=";
        // document.cookie로 모든 쿠키 문자열을 가져와서 ; 으로 분리하고 배열로 cookie에 저장
        var cookies = document.cookie.split(";");
        for (var i = 0; i < cookies.length; i++) {
            var cookie = cookies[i];
            // 배열의 맨앞에 공백이 있을시 공백을 제거
            while (cookie.charAt(0) === " ") {
                cookie = cookie.substring(1, cookie.length);
            }
            // indexOf()는 특정 문자열의 인덱스를 반환하는 함수, likedPost= 로 시작하는 배열이 있다면 likedPost= 의 문자열은 0으로 반환됨
            if (cookie.indexOf(nameEQ) === 0) {
                // likedPost= 이후부터 쿠키 끝까지의 문자열을 반환함
                return cookie.substring(nameEQ.length, cookie.length);
            }
        }
        return null;
    }
    function likeButton(postPk) {
        var likedPost = getLikedPost(); // 기존의 likedPost 쿠키 값 (배열)
        // 쿠키로 가져온 배열에 postPk가 없다면, 즉 좋아요를 누르는게 처음이라면
        if (likedPost.includes(postPk)) {
            document.getElementById('postLike').style.display = 'none';
            document.getElementById('postLikeCancel').style.display = 'visible';

        } else {
            document.getElementById('postLikeCancel').style.display = 'none';
            document.getElementById('postLike').style.display = 'visible';

        }
    }

    function ifLikeMinus(postPk){
        var likeMode = '${likeMode}';
        if(likeMode == 'likeMinus'){
            cancelLike(${postPk});
        }
        if(likeMode == 'likePlus'){
            updateLike(${postPk});
        }
        console.log(likeMode);
    }
    // 쿠키를 찾아보고 좋아요를 표시할지 취소를 표시할지
    document.addEventListener('DOMContentLoaded', function (){
        ifLikeMinus(${postPk});
        likeButton(${postPk});
    });

</script>
</body>

</html>
