<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.project1.jsp_blog_project.model.VisitorDAO" %>
<%

    // 오늘 날짜를 23/05/29 방식의 String으로 dateToday에 저장
    Calendar today = Calendar.getInstance();
    SimpleDateFormat dateFormat = new SimpleDateFormat("yy/MM/dd");
    String dateToday = dateFormat.format(today.getTime());


    VisitorDAO dao = new VisitorDAO();


%>
<%
    // 오늘 날짜가 dateToday 쿠키에 저장이 돼있는지 아닌지 검사하고, 없으면 조회수 1 증가
    boolean isThereCookie = false;
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie c : cookies) {
            // 쿠키에 오늘 날짜가 저장된 경우 break
            if ("visitDate".equals(c.getName()) && c.getValue().equals(dateToday)) {

                isThereCookie = true;
                break;
                // 쿠키에 과거 날짜가 저장된 경우 오늘 날짜로 설정하고 조회수 증가
            } else if ("visitDate".equals(c.getName()) && !c.getValue().equals(dateToday)) {
                c.setValue(dateToday);
                isThereCookie = true;
                dao.dbOpen();
                dao.updateTotal();
                dao.dbClose();
                c.setPath(request.getContextPath());
                c.setMaxAge(24 * 60 * 60);
                response.addCookie(c);

                break;
            }
        }
        // 쿠키를 for문으로 다 확인한 이후에도 vistDate 쿠키가 없을경우 쿠키를 생성하고 조회수 증가
        if (!isThereCookie) {
            // Cookie 클래스 타입의 변수 선언과 동시에 객체 생성
            // 쿠키 객체 생성 시 쿠키 이름과 값을 설정
            Cookie cookie = new Cookie("visitDate", dateToday);
            // getContextPath() : 프로젝트명이 경로로 반환됨 -> 프로젝트 내의 모든 경로에서 쿠키를 사용하겠다
            cookie.setPath(request.getContextPath());
            // 쿠키가 유지될 시간, 쿠키 유지시간이 지나면 쿠키가 자동 삭제됨
            cookie.setMaxAge(24 * 60 * 60);
            // 클라이언트에 쿠키를 전송하기 위해서 response 내장객체에 추가
            response.addCookie(cookie);

            dao.dbOpen();
            dao.updateTotal();
            dao.dbClose();
        }
    }
%>
