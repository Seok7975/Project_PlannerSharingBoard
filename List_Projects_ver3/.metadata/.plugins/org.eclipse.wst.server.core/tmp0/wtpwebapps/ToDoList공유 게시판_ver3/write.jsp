<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<!-- Optional theme -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

<!-- <link rel="stylesheet" href="css/bbsStyle.css"> --> <!-- 외부 CSS 파일 참조 -->
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<!-- Latest compiled and minified JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<link rel="stylesheet" href="css/jumbotronCustom.css">
<style>
	/* 드롭다운 메뉴가 커서를 가져다 대기만 해도 열리도록 설정 */
	.navbar-nav > li.dropdown:hover > .dropdown-menu {
	    display: block;
	}
</style>
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
<%
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    } else if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 해주세요');");
        script.println("location.href='joinAndLogin/login.jsp';");
        script.println("</script>");
        script.close();
        return;
    }
%>
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
                    <li class="dropdown active">
	                    <a href="bbs.jsp?bbsCategory=all" role="button" aria-haspopup="true" aria-expanded="false">게시판 <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="bbs.jsp?bbsCategory=all">전체글보기</a></li>
                            <li><a href="bbs.jsp?bbsCategory=free">자유게시판</a></li>
                            <li><a href="bbs.jsp?bbsCategory=study">공부게시판</a></li>
                            <li><a href="bbs.jsp?bbsCategory=exercise">운동게시판</a></li>
                        </ul>
                    </li>
                    <li><a href="planner/planner.jsp">플래너</a></li>
                </ul>
                <%
                    if(userID == null) {
                %>
                    <ul class="nav navbar-nav navbar-right">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">접속하기 <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="id/login.jsp">로그인</a></li>
                                <li><a href="id/join.jsp">회원가입</a></li>
                            </ul>
                        </li>
                    </ul>
                <%
                    } else {
                %>
                        <ul class="nav navbar-nav navbar-right">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">회원관리<span class="caret"></span></a>
                            <ul class="dropdown-menu">
                            	<li><a href="id/profile.jsp">My Profile</a></li>
                                <li><a href="id/logoutAction.jsp">로그아웃</a></li>
                            </ul>
                        </li>
                    </ul>
                <%
                    }
                %>
            </div>
        </div>
    </nav>
    
    <div class="container">
        <div class="row">
            <form method="post" action="writeAction.jsp" enctype="multipart/form-data">
                <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
                    <thead>
                        <tr>
                            <th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글쓰기 양식</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <select class="form-control" name="bbsCategory">
                                    <option value="free">자유게시판</option>
                                    <option value="study">공부게시판</option>
                                    <option value="exercise">운동게시판</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50"></td>
                        <tr>
                        <tr>
                            <td><input type="file" class="form-control-file" name="fileName"></td>
                        </tr>
                        <tr>    
                            <td><textarea type="text" class="form-control" placeholder="글 내용" name="bbsContent" maxlength="9999" style="height: 350px;"></textarea></td>
                        </tr>
                    </tbody>
                </table>
                <input type="submit" class="btn btn-primary pull-right" value="글쓰기">
            </form>
        </div>
    </div>
</body>
</html>
