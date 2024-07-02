<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>


<%
    String userId = request.getParameter("userId");
    String idCheckResult = "";

    // 아이디 중복 체크 로직 (예: 데이터베이스 조회)
    boolean isAvailable = true; // 실제로는 데이터베이스에서 아이디 중복 여부를 체크해야 합니다.

    if (isAvailable) {
        idCheckResult = "사용 가능한 아이디입니다.";
    } else {
        idCheckResult = "이미 사용 중인 아이디입니다.";
    }

    // join.jsp로 리다이렉트
    String redirectURL = "join.jsp?idCheckResult=" + java.net.URLEncoder.encode(idCheckResult, "UTF-8")
                        + "&userId=" + java.net.URLEncoder.encode(userId, "UTF-8");
    response.sendRedirect(redirectURL);
%>