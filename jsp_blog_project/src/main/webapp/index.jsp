<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>


<head>
  <title>JSP - Hello World</title>
</head>
<body>
<h1><%= "Hello World!" %></h1>
<br/>
<a href="hello-servlet">Hello Servlet</a>

<%
//  session.setAttribute("sessionName","smart505");
//  session.setAttribute("sessionPw", "full505");
//  session.setMaxInactiveInterval(60);
  response.sendRedirect("/blog/PostListController.do?category=all");
%>
</body>

</html>