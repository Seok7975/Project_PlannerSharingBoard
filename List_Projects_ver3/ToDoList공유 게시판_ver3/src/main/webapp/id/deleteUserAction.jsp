<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원탈퇴</title>
</head>
<body>
    <%
        String userID = (String) session.getAttribute("userID");
        if (userID == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        UserDAO userDAO = new UserDAO();
        int result = userDAO.deleteUser(userID);

        if (result == 1) {
            session.invalidate(); // 세션 무효화
            out.println("<script>alert('회원탈퇴가 완료되었습니다.'); location.href='../main.jsp';</script>");
        } else {
            out.println("<script>alert('회원탈퇴에 실패했습니다. 다시 시도해 주세요.'); history.back();</script>");
        }
    %>
</body>
</html>