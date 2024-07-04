<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, user.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<!-- Optional theme -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<!-- Latest compiled and minified JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<link rel="stylesheet" href="css/jumbotronCustom.css">
<title>아이디 찾기 결과</title>
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="main.jsp">게시판 프로젝트</a>
			</div>
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li><a href="main.jsp">메인</a></li>
					<li><a href="bbs.jsp">게시판</a></li>
					<li><a href="planner/planner.jsp">플래너</a></li>
					
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">접속하기 <span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="login.jsp">로그인</a></li>
							<li><a href="register.jsp">회원가입</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="container">
		<h2>아이디 찾기 결과</h2>
		<%
			String userName = request.getParameter("userName");
			String userEmail = request.getParameter("userEmail");
			UserDAO userDAO = new UserDAO();
			
			// 디버깅용 정보 출력
			userDAO.printDebugInfo(userName, userEmail);
			
			String userID = userDAO.findUserId(userName, userEmail);
			
			if (userID != null) {
				out.println("<div class='alert alert-success'>");
				out.println("회원님의 아이디는 <strong>" + userID + "</strong> 입니다.");
				out.println("</div>");
			} else {
				out.println("<div class='alert alert-danger'>");
				out.println("입력하신 정보와 일치하는 아이디가 없습니다.");
				out.println("</div>");
			}
		%>
	</div>
</body>
</html> --%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>

<%
    request.setCharacterEncoding("UTF-8");

    String userName = request.getParameter("userName");
    String userEmail = request.getParameter("userEmail");

    if (userName == null || userName.trim().isEmpty()) {
        request.setAttribute("errorMessage", "이름을 입력해주세요.");
        request.getRequestDispatcher("showUserID.jsp").forward(request, response);
        return;
    }

    if (userEmail == null || userEmail.trim().isEmpty()) {
        request.setAttribute("errorMessage", "이메일을 입력해주세요.");
        request.getRequestDispatcher("showUserID.jsp").forward(request, response);
        return;
    }

    UserDAO userDAO = new UserDAO();
    String userID = userDAO.findUserId(userName, userEmail);

    request.setAttribute("userID", userID);

    // 디버깅용 정보 출력
    userDAO.printDebugInfo(userName, userEmail);

    if (userID != null) {
        request.getRequestDispatcher("showUserID.jsp").forward(request, response);
    } else {
        request.setAttribute("errorMessage", "입력하신 정보와 일치하는 아이디가 없습니다.");
        request.getRequestDispatcher("showUserID.jsp").forward(request, response);
    }
%>
