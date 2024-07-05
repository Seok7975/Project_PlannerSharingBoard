<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <!-- Optional theme -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

    <link rel="stylesheet" href="../css/idStyle.css"> <!-- 외부 CSS 파일 참조 -->
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <!-- Latest compiled and minified JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="css/jumbotronCustom.css">
    <title>아이디 찾기 결과</title>
    <style>
    	/* 작은 화면일 때 스타일 조정 */
/* @media (max-width: 767px) {
    .main-content {
        margin-left: 0;
    }
    .col-xs8 {
        width: 100%;
        padding: 0;
    }
     .jumbotron { 
        padding: 20px;
    }
} */
    </style>
</head>
<body>
    <div class="sidebar">
        <a href="../main.jsp" style="text-align: center;">메인</a>
        <div class="dropdown">
            <a href="../bbs.jsp?bbsCategory=all" style="text-align: center;">게시판 <span class="caret"></span></a>
            <ul class="dropdown-menu">
                <li><a href="../bbs.jsp?bbsCategory=all" style="text-align: center;">전체글보기</a></li>
                <li><a href="../bbs.jsp?bbsCategory=free" style="text-align: center;">자유게시판</a></li>
                <li><a href="../bbs.jsp?bbsCategory=study" style="text-align: center;">공부게시판</a></li>
                <li><a href="../bbs.jsp?bbsCategory=exercise" style="text-align: center;">운동게시판</a></li>
            </ul>
        </div>
        <a href="planner/planner.jsp" style="text-align: center;">플래너</a>
    </div> 
    <nav class="navbar navbar-default">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="../main.jsp">게시판 프로젝트</a>
            </div>
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li><a href="../main.jsp">메인</a></li>
                    <li class="dropdown">
                        <a href="../bbs.jsp" role="button" aria-haspopup="true" aria-expanded="false">게시판 <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="bbs.jsp?bbsCategory=all">전체글보기</a></li>
                            <li><a href="bbs.jsp?bbsCategory=free">자유게시판</a></li>
                            <li><a href="bbs.jsp?bbsCategory=study">공부게시판</a></li>
                            <li><a href="bbs.jsp?bbsCategory=exercise">운동게시판</a></li>
                        </ul>
                    </li>
                    <li><a href="../planner/planner.jsp">플래너</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">접속하기 <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="login.jsp">로그인</a></li>
                            <li><a href="join.jsp">회원가입</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="container main-content">
        <div class="row">

	                <h2>아이디 찾기 결과</h2>
	                <%
	                    String userID = (String) request.getAttribute("userID");
	                    String errorMessage = (String) request.getAttribute("errorMessage");
	
	                    if (userID != null) {
	                        out.println("<div class='alert alert-success'>");
	                        out.println("회원님의 아이디는 <strong>" + userID + "</strong> 입니다.");
	                        out.println("</div>");
	                    } else if (errorMessage != null) {
	                        out.println("<div class='alert alert-danger'>");
	                        out.println(errorMessage);
	                        out.println("</div>");
	                    }
	                %>
	         </div>
	         
        </div>
    </div>
</body>
</html>