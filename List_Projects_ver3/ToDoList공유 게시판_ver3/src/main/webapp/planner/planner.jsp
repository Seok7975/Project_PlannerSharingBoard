<%-- <%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.ParseException"%>
<%@page import="com.example.Task"%> <!-- Task 클래스 import -->

<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트를 사용하기 위함 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
    <link rel="stylesheet" href="../css/todolistStyle.css"> <!-- 외부 CSS 파일 참조 -->
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="../css/jumbotronCustom.css">
    <title>투두리스트 페이지</title>
    <script>
        $(document).ready(function() {
            $('#startButton').click(function() {
                $('#startDateTime').focus().click();
            });
            $('#dueButton').click(function() {
                $('#dueDateTime').focus().click();
            });
        });
    </script>
</head>
<body>
	<%
		String userID = null;	
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		
		if(userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
			script.println("location.href = '../login.jsp'");
			script.println("</script>");
		} else { 
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
	                <a class="navbar-brand" href="../main.jsp">게시판 프로젝트</a>
	            </div>
	            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	                <ul class="nav navbar-nav">
	                    <li><a href="../main.jsp">메인</a></li>
	                    <li><a href="../bbs.jsp">게시판</a></li>
	                    <li class="active"><a href="planner.jsp">플래너</a></li> <!-- 플래너 메뉴 추가 -->
	                </ul>
	                <%
	                    if(userID == null) {
	                %>
	                    <ul class="nav navbar-nav navbar-right">
	                        <li class="dropdown">
	                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">접속하기 <span class="caret"></span></a>
	                            <ul class="dropdown-menu">
	                                <li><a href="../login.jsp">로그인</a></li>
	                                <li><a href="../join.jsp">회원가입</a></li>
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
	                                <li><a href="../logoutAction.jsp">로그아웃</a></li>
	                            </ul>
	                        </li>
	                    </ul>
	                <%
	                    }
	                %>
	            </div>
	        </div>
	    </nav>

	    <div class="todo-container">
	        <h1>할 일 목록</h1>
	        <form class="add-item" action="addItem.jsp" method="post">
	            <div class="form-group">
	                <input type="text" class="form-control" name="item" placeholder="새로운 할 일 추가" required>
	            </div>
	            <div class="form-group">
	                <button type="button" id="startButton" class="btn btn-primary">시작</button>
	                <input type="datetime-local" class="form-control" id="startDateTime" name="startDateTime" required>
	                <button type="button" id="dueButton" class="btn btn-primary">마감</button>
	                <input type="datetime-local" class="form-control" id="dueDateTime" name="dueDateTime" required>
	                <button type="submit" class="btn btn-primary">추가</button>
	            </div>
	        </form>
	        <ul>
	            <%
	                List<Task> tasks = (List<Task>) session.getAttribute("tasks");
	                if (tasks == null) {
	                    tasks = new ArrayList<>();
	                }
	                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	                SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");

	                for (Task task : tasks) {
	                    Date startDate = null;
	                    Date dueDate = null;
	                    try {
	                        startDate = inputFormat.parse(task.getStartDateTime());
	                        dueDate = inputFormat.parse(task.getDueDateTime());
	                    } catch (ParseException e) {
	                        e.printStackTrace();
	                    }
	            %>
	                <li class="<%= task.isCompleted() ? "completed" : "" %>">
	                    <form action="toggleComplete.jsp" method="post" style="margin: 0;">
	                        <input type="hidden" name="taskId" value="<%= task.getId() %>">
	                        <input type="checkbox" name="completed" <%= task.isCompleted() ? "checked" : "" %> onChange="this.form.submit()">
	                    </form>
	                    <span><%= task.getItem() %> (시작: <%= dateFormat.format(startDate) %>, 마감: <%= dateFormat.format(dueDate) %>)</span>
	                    <form action="deleteItem.jsp" method="post" style="margin: 0;">
	                        <input type="hidden" name="taskId" value="<%= task.getId() %>">
	                        <button class="delete btn btn-danger" type="submit">삭제</button>
	                    </form>
	                </li>
	            <%
	                }
	            %>

	
	<%	
		}

	%>

        </ul>
    </div>
</body>
</html> --%>

<%-- <%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.ParseException"%>
<%@page import="com.example.Task"%> <!-- Task 클래스 import -->

<%@ page import="com.example.TaskDAO" %>
<%@ page import="com.example.Task" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트를 사용하기 위함 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
    <link rel="stylesheet" href="../css/todolistStyle.css"> <!-- 외부 CSS 파일 참조 -->
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</head>
<body>
    <div class="container">
        <h2>할 일 목록</h2>
        <form action="addItem.jsp" method="post">
            <input type="text" name="item" placeholder="할 일" required>
            <input type="datetime-local" name="startDateTime" required>
            <input type="datetime-local" name="dueDateTime" required>
            <button type="submit" class="btn btn-primary">추가</button>
        </form>
        <hr>
        <%
            String userID = (String) session.getAttribute("userID");
            if (userID == null) {
                response.sendRedirect("../login.jsp");
            } else {
                TaskDAO taskDAO = new TaskDAO();
                List<Task> tasks = taskDAO.getTasks(userID);
        %>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>할 일</th>
                    <th>시작 시간</th>
                    <th>마감 시간</th>
                    <th>완료 여부</th>
                    <th>작업</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Task task : tasks) {
                %>
                <tr>
                    <td><%= task.getItem() %></td>
                    <td><%= task.getStartDateTime() %></td>
                    <td><%= task.getDueDateTime() %></td>
                    <td><%= task.getCompleted().equals("yes") ? "완료" : "미완료" %></td>
                    <td>
                        <form action="updateItem.jsp" method="post" style="display:inline;">
                            <input type="hidden" name="id" value="<%= task.getId() %>">
                            <input type="text" name="item" value="<%= task.getItem() %>" required>
                            <input type="datetime-local" name="startDateTime" value="<%= task.getStartDateTime() %>" required>
                            <input type="datetime-local" name="dueDateTime" value="<%= task.getDueDateTime() %>" required>
                            <input type="checkbox" name="completed" <%= task.getCompleted().equals("yes") ? "checked" : "" %>> 완료
                            <button type="submit" class="btn btn-success">수정</button>
                        </form>
                        <form action="deleteItem.jsp" method="post" style="display:inline;">
                            <input type="hidden" name="id" value="<%= task.getId() %>">
                            <button type="submit" class="btn btn-danger">삭제</button>
                        </form>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <%
            }
        %>
    </div>
</body>
</html> --%>

<%-- <%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.ParseException"%>
<%@page import="com.example.Task"%>
<%@page import="com.example.TaskDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
    <link rel="stylesheet" href="../css/todolistStyle.css"> <!-- 외부 CSS 파일 참조 -->
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="../css/jumbotronCustom.css">
    <title>투두리스트 페이지</title>
    <script>
        $(document).ready(function() {
            $('#startButton').click(function() {
                $('#startDateTime').focus().click();
            });
            $('#dueButton').click(function() {
                $('#dueDateTime').focus().click();
            });
        });
    </script>
</head>
<body>
    <%
        String userID = null;
        if(session.getAttribute("userID") != null) {
            userID = (String) session.getAttribute("userID");
        }

        if(userID == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('로그인을 하세요')");
            script.println("location.href = '../login.jsp'");
            script.println("</script>");
        } else {
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
                    <a class="navbar-brand" href="../main.jsp">게시판 프로젝트</a>
                </div>
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li><a href="../main.jsp">메인</a></li>
                        <li><a href="../bbs.jsp">게시판</a></li>
                        <li class="active"><a href="planner.jsp">플래너</a></li> <!-- 플래너 메뉴 추가 -->
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">회원관리<span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="../logoutAction.jsp">로그아웃</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="todo-container">
            <h1>할 일 목록</h1>
            <form class="add-item" action="addItem.jsp" method="post">
                <div class="form-group">
                    <input type="text" class="form-control" name="item" placeholder="새로운 할 일 추가" required>
                </div>
                <div class="form-group">
                    <button type="button" id="startButton" class="btn btn-primary">시작</button>
                    <input type="datetime-local" class="form-control" id="startDateTime" name="startDateTime" required>
                    <button type="button" id="dueButton" class="btn btn-primary">마감</button>
                    <input type="datetime-local" class="form-control" id="dueDateTime" name="dueDateTime" required>
                    <button type="submit" class="btn btn-primary">추가</button>
                </div>
            </form>
            <ul>
                <%
                    TaskDAO taskDAO = new TaskDAO();
                    List<Task> tasks = taskDAO.getTasks(userID);
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");

                    for (Task task : tasks) {
                        Date startDate = null;
                        Date dueDate = null;
                        try {
                            if (task.getStartDateTime() != null && !task.getStartDateTime().isEmpty()) {
                                startDate = dateFormat.parse(task.getStartDateTime());
                            }
                            if (task.getDueDateTime() != null && !task.getDueDateTime().isEmpty()) {
                                dueDate = dateFormat.parse(task.getDueDateTime());
                            }
                        } catch (ParseException e) {
                            e.printStackTrace();
                        }
                %>
                    <li class="<%= task.getCompleted().equals("yes") ? "completed" : "" %>">
                        <form action="toggleComplete.jsp" method="post" style="margin: 0;">
                            <input type="hidden" name="taskId" value="<%= task.getId() %>">
                            <input type="checkbox" name="completed" <%= task.getCompleted().equals("yes") ? "checked" : "" %> onChange="this.form.submit()">
                        </form>
                        <span><%= task.getItem() %> 
                            (시작: <%= startDate != null ? outputFormat.format(startDate) : "N/A" %>, 
                            마감: <%= dueDate != null ? outputFormat.format(dueDate) : "N/A" %>)
                        </span>
                        <form action="deleteItem.jsp" method="post" style="margin: 0;">
                            <input type="hidden" name="taskId" value="<%= task.getId() %>">
                            <button class="delete btn btn-danger" type="submit">삭제</button>
                        </form>
                    </li>
                <%
                    }
                %>
            </ul>
        </div>
    <%
        }
    %>
</body>
</html>
 --%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.Comparator"%>
<%@page import="com.example.Task"%>
<%@page import="com.example.TaskDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
    <link rel="stylesheet" href="../css/bbsStle.css">
    <link rel="stylesheet" href="../css/todolistStyle.css"> <!-- 외부 CSS 파일 참조 -->
    
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <script src="../js/html2canvas.js"></script> <!-- 스크린샷 저장용 -->
    <!-- <script src="https://cdn.jsdelivr.net/npm/html2canvas@0.4.1/dist/html2canvas.min.js"> -->
    <link rel="stylesheet" href="../css/jumbotronCustom.css">
    <style>
        .equal-width-button {
            width: 100%;
            max-width: 200px; /* 원하는 최대 너비로 설정 */
        }
    </style>
    <script> // 이미지 저장 스크립트 코드
	    document.addEventListener("DOMContentLoaded", function() {
	        document.getElementById("saveImageButton").addEventListener("click", function() {
	            html2canvas(document.querySelector(".todo-container"), {
	                useCORS: true, // CORS 문제 해결
	                backgroundColor: null, // 배경 투명하게
	                scale: 2 // 고해상도 이미지 생성
	            }).then(canvas => {
	                // 캔버스를 이미지로 변환
	                let imgData = canvas.toDataURL("image/png");
	
	                // 새로운 캔버스 생성 및 크기 조정
	                let newCanvas = document.createElement('canvas');
	                let ctx = newCanvas.getContext('2d');
	                
	                // 원본 캔버스 크기
	                let originalWidth = canvas.width;
	                let originalHeight = canvas.height;
	                
	                // 원하는 크기로 조정 (예: 50% 크기로 줄이기)
	                let scaleFactor = 0.5;
	                newCanvas.width = originalWidth * scaleFactor;
	                newCanvas.height = originalHeight * scaleFactor;
	
	                // 원본 캔버스를 새로운 캔버스로 그리기 (크기 조정 포함)
	                ctx.drawImage(canvas, 0, 0, newCanvas.width, newCanvas.height);
	
	                // 새로운 캔버스를 이미지로 변환
	                let resizedImgData = newCanvas.toDataURL("image/png");
	
	                // 이미지 다운로드 링크 생성
	                let link = document.createElement('a');
	                link.href = resizedImgData;
	                link.download = 'todo_list.png'; 
	                link.click();
	            }).catch(function(error) {
	                console.error('Error capturing the image:', error);
	            });
	        });
	    });
    </script>
    <title>투두리스트 페이지</title>
</head>
<body>
    <%
        String userID = null;
        if(session.getAttribute("userID") != null) {
            userID = (String) session.getAttribute("userID");
        }

        if(userID == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('로그인을 하세요')");
            script.println("location.href = '../id/login.jsp'");
            script.println("</script>");
        } else {
    %>
    <div class="sidebar">
        <a href="../main.jsp" style="text-align: center;" >메인</a>
        <div class="dropdown">
            <a href="../bbs.jsp?bbsCategory=all" style="text-align: center;" >게시판 <span class="caret"></span></a>
            <ul class="dropdown-menu">
                <li><a href="../bbs.jsp?bbsCategory=all" style="text-align: center;">전체글보기</a></li>
                <li><a href="../bbs.jsp?bbsCategory=free" style="text-align: center;">자유게시판</a></li>
                <li><a href="../bbs.jsp?bbsCategory=study" style="text-align: center;">공부게시판</a></li>
                <li><a href="../bbs.jsp?bbsCategory=exercise" style="text-align: center;">운동게시판</a></li>
            </ul>
        </div>
        <a href="planner/planner.jsp" style="text-align: center;">플래너</a>
    </div>
    <nav class="navbar navbar-default navbar-fixed-top">
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
                        <a href="../bbs.jsp?bbsCategory=all" role="button" aria-haspopup="true" aria-expanded="false">게시판 <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="../bbs.jsp?bbsCategory=all">전체글보기</a></li>
                            <li><a href="../bbs.jsp?bbsCategory=free">자유게시판</a></li>
                            <li><a href="../bbs.jsp?bbsCategory=study">공부게시판</a></li>
                            <li><a href="../bbs.jsp?bbsCategory=exercise">운동게시판</a></li>
                        </ul>
                    </li>
                    <li class="active"><a href="planner.jsp">플래너</a></li> <!-- 플래너 메뉴 추가 -->
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">회원관리<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="../id/profile.jsp">My Profile</a></li>
                            <li><a href="../id/logoutAction.jsp">로그아웃</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="todo-container">
        <h1>할 일 목록</h1>
        <form class="add-item" action="addItem.jsp" method="post">
            <div class="form-group">
                <input type="text" class="form-control" name="item" placeholder="새로운 할 일 추가" required>
            </div>
            <div class="form-group">
                <button type="button" id="startButton" class="btn btn-primary">시작</button>
                <input type="datetime-local" class="form-control" id="startDateTime" name="startDateTime" required>
                <button type="button" id="dueButton" class="btn btn-primary">마감</button>
                <input type="datetime-local" class="form-control" id="dueDateTime" name="dueDateTime" required>
                <button type="submit" class="btn btn-primary">추가</button>
            </div>
        </form>
        <ul>
            <%
                TaskDAO taskDAO = new TaskDAO();
                List<Task> tasks = taskDAO.getTasks(userID);
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");

                // 시간 순서대로 정렬
                Collections.sort(tasks, new Comparator<Task>() {
                    public int compare(Task t1, Task t2) {
                        try {
                            Date startDate1 = dateFormat.parse(t1.getStartDateTime());
                            Date startDate2 = dateFormat.parse(t2.getStartDateTime());
                            return startDate1.compareTo(startDate2);
                        } catch (ParseException e) {
                            e.printStackTrace();
                            return 0;
                        }
                    }
                });

                for (Task task : tasks) {
                    Date startDate = null;
                    Date dueDate = null;
                    try {
                        if (task.getStartDateTime() != null && !task.getStartDateTime().isEmpty()) {
                            startDate = dateFormat.parse(task.getStartDateTime());
                        }
                        if (task.getDueDateTime() != null && !task.getDueDateTime().isEmpty()) {
                            dueDate = dateFormat.parse(task.getDueDateTime());
                        }
                    } catch (ParseException e) {
                        e.printStackTrace();
                    }
            %>
                <li class="<%= task.getCompleted().equals("yes") ? "completed" : "" %>">
                    <form action="toggleComplete.jsp" method="post" style="margin: 0;">
                        <input type="hidden" name="taskId" value="<%= task.getId() %>">
                        <input type="checkbox" name="completed" <%= task.getCompleted().equals("yes") ? "checked" : "" %> onChange="this.form.submit()">
                    </form>
                    <span><%= task.getItem() %> 
                        (시작: <%= startDate != null ? outputFormat.format(startDate) : "N/A" %>, 
                        마감: <%= dueDate != null ? outputFormat.format(dueDate) : "N/A" %>)
                    </span>
                    <form action="deleteItem.jsp" method="post" style="margin: 0;">
                        <input type="hidden" name="taskId" value="<%= task.getId() %>">
                        <button class="delete btn btn-danger" type="submit">삭제</button>
                    </form>
                </li>
            <%
                }
            %>
        </ul>
        <form action="saveTasksAction.jsp" method="post" style="margin-top: 20px;">
            <button type="submit" class="btn btn-info equal-width-button">할 일 목록 텍스트파일 저장</button>
        </form>
        <button id="saveImageButton" class="btn btn-info equal-width-button" style="margin-top: 10px;">할 일 목록 그림파일 저장</button>
    </div>
    <%
        }
    %>
</body>
</html>

