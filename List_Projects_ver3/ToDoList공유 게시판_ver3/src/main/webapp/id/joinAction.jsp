<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트를 사용하기 위함 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 데이터를 UTF-8로 받기위함 -->
<jsp:useBean id="user" class="user.User" scope="page" />  <!-- scope="page" : 현재 페이지 안에서만 beans를 사용 -->
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		// 이미 로그인 되어있다면 또 로그인을 할 수 없게 막는 효과
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if(userID != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = '../main.jsp'");
			script.println("</script>");
		}
	
		String confirmPassword = request.getParameter("confirmPassword");

		if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null
			|| user.getUserGender() == null || user.getUserEmail() == null || confirmPassword == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 부분이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else if (!user.getUserPassword().equals(confirmPassword)) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 일치하지 않습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
			if (result == -1) { // 동일한 아이디가 존재했을 경우
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else { // 생성완료
				/* session.setAttribute("userID", user.getUserID()); */ 
				PrintWriter script = response.getWriter();
				script.println("alert('회원가입이 완료되었습니다. 로그인 페이지로 이동합니다.')");
				script.println("<script>");
				script.println("location.href = 'login.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>
