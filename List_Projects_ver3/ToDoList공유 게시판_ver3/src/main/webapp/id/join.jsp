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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
    <link rel="stylesheet" href="../css/idStyle.css">
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="css/jumbotronCustom.css">
    <title>회원가입</title>
    <script src="../js/loginToggleSidbar.js"></script>
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
                    <li><a href="../bbs.jsp">게시판</a></li>
                    <li><a href="../planner/planner.jsp">플래너</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">접속하기<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="login.jsp">로그인</a></li>
                            <li class="active"><a href="join.jsp">회원가입</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="container">
        <div class="row">
            <div class="col-lg-4 col-md-3 col-sm-2 col-xs-1"></div>
            <div class="col-lg-4 col-md-6 col-sm-8 col-xs-10">
                <div class="jumbotron" style="padding-top: 20px;">
                    <form method="post" action="joinAction.jsp" onsubmit="return validatePassword()">
                        <h3 style="text-align: center;">회원가입 화면</h3>
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="아이디" name="userID" id="userID" required maxlength="20" onkeyup="checkID()">
                            <span id="idCheck"></span>
                        </div>
                        <div class="form-group">
                            <input type="password" class="form-control" placeholder="비밀번호" name="userPassword" id="userPassword" required maxlength="20">
                        </div>
                        <div class="form-group">
                            <input type="password" class="form-control" placeholder="비밀번호 확인" name="confirmPassword" id="confirmPassword" required maxlength="20">
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="이름" name="userName" required maxlength="20">
                        </div>
                        <div class="form-group" style="text-align: center;">
                            <div class="btn-group" data-toggle="buttons">
                                <label class="btn btn-primary">
                                    <input type="radio" name="userGender" value="남자" autocomplete="off" required> 남자
                                </label>
                                <label class="btn btn-primary">
                                    <input type="radio" name="userGender" value="여자" autocomplete="off" required> 여자
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <input type="email" class="form-control" placeholder="이메일" name="userEmail" required maxlength="50">
                        </div>
                        <input type="submit" class="btn btn-primary form-control" value="회원가입">
                    </form>
                </div>
            </div>
            <div class="col-lg-4 col-md-3 col-sm-2 col-xs-1"></div>
        </div>
    </div>
</body>
</html>

