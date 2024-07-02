<!--  게시판 -->

<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
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
<title>JSP 게시판 웹 사이트</title>
<style type="text/css">
	a, a:hover {
		color : #000000;
		text-decoration: none;
	}
</style>
</head>
<body>
<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));  
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
					<li class="active"><a href="bbs.jsp">게시판</a></li>
					<li><a href="planner/planner.jsp">플래너</a></li>
				</ul>
				<%
					if(userID == null) {
				%>
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">접속하기 <span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="joinAndLogin/login.jsp">로그인</a></li>
								<li><a href="joinAndLogin/join.jsp">회원가입</a></li>
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
								<li><a href="logoutAction.jsp">로그아웃</a></li>
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
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
						<th style="background-color: #eeeeee; text-align: center;">조회수</th>
					</tr>
				</thead>
				<tbody> <!-- 예시 -->
					<tr>
					<%
						BbsDAO bbsDAO = new BbsDAO();
						ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
						for(int i = 0; i < list.size(); i++) {
					%>
						<td><%= list.get(i).getBbsID() %></td>
						<td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle() %></a></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11,13) + "시" + list.get(i).getBbsDate().substring(14, 16) + "분" %></td>
						<td><%= list.get(i).getViewCount() %></td>
					<tr>
					<%
						}
					%>
				</tbody>
			</table>
			<%
				if(pageNumber != 1) {
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success btn-arraw-left">이전</a>
			<%
				} 
				if(bbsDAO.nextPage(pageNumber + 1)) {
			%>
					<a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success btn-arraw-right">다음</a>
			<%
				}
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
</body>
</html> --%>



<!--  게시판 --> 

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<!-- Optional theme -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<link rel="stylesheet" href="css/bbsStyle.css"> <!-- 외부 CSS 파일 참조 -->
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<!-- Latest compiled and minified JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<link rel="stylesheet" href="css/jumbotronCustom.css">
<title>JSP 게시판 웹 사이트</title>

<style type="text/css">
    a, a:hover {
        color : #000000;
        text-decoration: none;
    }
    .table th.number-col {
        width: 10%;
    }
    .table th.title-col {
        width: 30%;
    }
    .table th.writer-col {
        width: 20%;
    }
    
    .table th.viewCount-col {
    	width: 15%;
    }
    
    .tble th, .table td {
    	white-space: nowrap;
    	overflow: hidden;
    	text-overflow: ellipsis;
    }
</style>

</head>
<body>
<%
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    int pageNumber = 1;
    if (request.getParameter("pageNumber") != null) {
        pageNumber = Integer.parseInt(request.getParameter("pageNumber"));  
    }
    String searchType = request.getParameter("searchType");
    String searchKeyword = request.getParameter("searchKeyword");
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
                    <li class="active"><a href="bbs.jsp">게시판</a></li>
                    <li><a href="planner/planner.jsp">플래너</a></li>
                </ul>
                <%
                    if(userID == null) {
                %>
                    <ul class="nav navbar-nav navbar-right">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">접속하기 <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="joinAndLogin/login.jsp">로그인</a></li>
                                <li><a href="joinAndLogin/join.jsp">회원가입</a></li>
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
                            	<li><a href="profile.jsp">My Profile</a></li>
                                <li><a href="joinAndLogin/logoutAction.jsp">로그아웃</a></li>
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
            <form class="form-inline" method="get" action="bbs.jsp">
                <div class="form-group">
                    <select class="form-control" name="searchType">
                        <option value="title" <%= "title".equals(searchType) ? "selected" : "" %>>제목</option>
                        <option value="content" <%= "content".equals(searchType) ? "selected" : "" %>>내용</option>
                        <option value="writer" <%= "writer".equals(searchType) ? "selected" : "" %>>작성자</option>
                    </select> 
                </div>
                <div class="form-group">
                    <input type="text" class="form-control" name="searchKeyword" placeholder="검색어를 입력하세요" value="<%= (searchKeyword != null && !searchKeyword.equals("")) ? searchKeyword : "" %>">
                </div>
                <button type="submit" class="btn btn-default">검색</button>
            </form>
            <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
                <thead>
                    <tr>
                        <th class="number-col" style="background-color: #eeeeee; text-align: center;">번호</th>
                        <th class="title-col" style="background-color: #eeeeee; text-align: center;">제목</th>
                        <th class="writer-col" style="background-color: #eeeeee; text-align: center;">작성자</th>
                        <th class="date-col"style="background-color: #eeeeee; text-align: center;">작성일</th>
                        <th class="viewCount-col"style="background-color: #eeeeee; text-align: center;">조회수</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        BbsDAO bbsDAO = new BbsDAO();
                        ArrayList<Bbs> list;
                        int totalPage;
                        if (searchKeyword != null && !searchKeyword.equals("")) { // 검색어가 있을 때
                            list = bbsDAO.searchList(pageNumber, searchType, searchKeyword);
                            totalPage = (bbsDAO.getSearchPostCount(searchType, searchKeyword) + 9) / 10; // 검색 결과의 총 페이지 수 계산
                        } else { // 검색어가 없을 때
                            list = bbsDAO.getList(pageNumber);
                            totalPage = bbsDAO.getTotalPageCount(); // 전체 게시물의 총 페이지 수 계산
                        }
                        for(int i = 0; i < list.size(); i++) {
                    %>
                        <tr>
                            <td><%= list.get(i).getBbsID() %></td>
                            <td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle() %></a></td>
                            <td><%= list.get(i).getUserID() %></td>
                            <td><%= list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11,13) + "시" + list.get(i).getBbsDate().substring(14, 16) + "분" %></td>
                            <td><%= list.get(i).getViewCount() %></td>
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <div style="text-align: center;">
                <%
                    int pageBlock = 5;
                    int startPage = ((pageNumber - 1) / pageBlock) * pageBlock + 1;
                    int endPage = startPage + pageBlock - 1;

                    if(pageNumber != 1) {
                %>
                    <a href="bbs.jsp?pageNumber=<%= pageNumber - 1 %>&searchType=<%= searchType %>&searchKeyword=<%= (searchKeyword != null && !searchKeyword.equals("")) ? searchKeyword : "" %>" class="btn btn-default pull-left">이전</a>
                <%
                    }
                    for (int i = startPage; i <= endPage && i <= totalPage; i++) {
                %>
                    <a href="bbs.jsp?pageNumber=<%= i %>&searchType=<%= searchType %>&searchKeyword=<%= (searchKeyword != null && !searchKeyword.equals("")) ? searchKeyword : "" %>" class="btn <%= (i == pageNumber) ? "btn-primary pull-left" : "btn-default pull-left" %>"><%= i %></a>
                <%
                    }
                    if(pageNumber != totalPage) {
                %>
                    <a href="bbs.jsp?pageNumber=<%= pageNumber + 1 %>&searchType=<%= searchType %>&searchKeyword=<%= (searchKeyword != null && !searchKeyword.equals("")) ? searchKeyword : "" %>" class="btn btn-default pull-left">다음</a>
                <%
                    }
                %>
                <a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
            </div>
        </div>
    </div>
</body>
</html>
