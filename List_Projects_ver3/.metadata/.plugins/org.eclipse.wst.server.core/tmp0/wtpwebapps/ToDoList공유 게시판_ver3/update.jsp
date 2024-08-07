 <!-- 수정화면 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
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
    }
    if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 해주세요.')");
        script.println("location.href = 'login.jsp'");
        script.println("</script>");
    }
    int bbsID = 0;
    if (request.getParameter("bbsID") != null) {
        bbsID = Integer.parseInt(request.getParameter("bbsID"));
    }
    if (bbsID == 0) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 글입니다.')");
        script.println("location.href = 'bbs.jsp'");
        script.println("</script>");
    }
    Bbs bbs = new BbsDAO().getBbs(bbsID); 
    if (!userID.equals(bbs.getUserID())) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('권한이 없습니다.')");
        script.println("location.href = 'bbs.jsp'");
        script.println("</script>");
    }
    
    String categoryDisplayName = "";
    switch(bbs.getBbsCategory()) {
        case "free":
            categoryDisplayName = "자유게시판";
            break;
        case "study":
            categoryDisplayName = "공부게시판";
            break;
        case "exercise":
            categoryDisplayName = "운동게시판";
            break;
        default:
            categoryDisplayName = "기타";
            break;
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
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">회원관리<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                    	<li><a href="id/profile.jsp">My Profile</a></li>
                        <li><a href="id/logoutAction.jsp">로그아웃</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
<div class="container">
    <div class="row">
        <form method="post" action="updateAction.jsp?bbsID=<%= bbsID %>" enctype="multipart/form-data">
            <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
                <thead>
                    <tr>
                        <th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글쓰기 양식</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <input type="text" class="form-control" name="bbsCategoryDisplay" readonly value="<%= categoryDisplayName %>">
                            <input type="hidden" name="bbsCategory" value="<%= bbs.getBbsCategory() %>">
                        </td>
                    </tr>
                    <tr>
                        <td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%= bbs.getBbsTitle() %>"></td>
                    </tr>
                    <tr>
                        <td>
                            <%
                                String fileName = bbs.getFileName();
                                if (fileName != null && !fileName.isEmpty()) {
                            %>
                                <p>현재 첨부 파일: <a href="download.jsp?fileName=<%= fileName %>"><%= fileName %></a></p>
                                <p>새 파일로 교체하려면 아래에서 파일을 선택하세요.</p>
                            <% 
                                } else {
                            %>
                                <p>첨부 파일 없음</p>
                            <%
                                }
                            %>
                            <input type="file" class="form-control" name="fileName">
                        </td>
                    </tr>
                    <tr>    
                        <td><textarea type="text" class="form-control" placeholder="글 내용" name="bbsContent" maxlength="9999" style="height: 350px;"><%= bbs.getBbsContent() %></textarea></td>
                    </tr>
                </tbody>
            </table>
            <input type="submit" class="btn btn-primary pull-right" value="글수정">
        </form>
    </div>
</div>
</body>
</html>
