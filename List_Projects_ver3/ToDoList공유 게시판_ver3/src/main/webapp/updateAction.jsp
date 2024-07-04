<!-- 로그인 시도를 처리하는 페이지 -->

<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트를 사용하기 위함 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 데이터를 UTF-8로 받기위함 -->

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
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
		if (!userID.equals(bbs.getUserID())) {// 게시글 작성자와 보는사람이 같은지
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		} else { 
			// bbs.getBbsTitle() : usebean은 쓰지않기때문에 직접 값을 비교해야함
			if(request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null
					|| request.getParameter("bbsTitle").equals("") || request.getParameter("bbsContent").equals("")) { 
						// null값이나 빈칸이 있으면 입력이 안된 사항이 있다고 띄움
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 수정에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'bbs.jsp'");
					script.println("</script>");
				}
			}
		}

	%>
</body>
</html> --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
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
            script.println("alert('로그인을 해주세요')");
            script.println("location.href = 'id/login.jsp'");
            script.println("</script>");
        } else {
            try {
                String directory = application.getRealPath("/upload");
                File uploadDir = new File(directory);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs(); // 디렉토리가 존재하지 않으면 생성
                }

                int maxSize = 1024 * 1024 * 10; // 10MB
                String encoding = "UTF-8";
                MultipartRequest multi = new MultipartRequest(request, directory, maxSize, encoding, new DefaultFileRenamePolicy());

                String bbsID = multi.getParameter("bbsID");
                String bbsTitle = multi.getParameter("bbsTitle");
                String bbsContent = multi.getParameter("bbsContent");
                String bbsCategory = multi.getParameter("bbsCategory"); // bbsCategory 추가
                String fileName = multi.getFilesystemName("fileName");

                // 업로드된 파일 경로를 이클립스 콘솔에 출력
                System.out.println("Uploaded file path: " + directory + File.separator + fileName);

                if(bbsTitle == null || bbsTitle.trim().isEmpty() || bbsContent == null || bbsContent.trim().isEmpty() || bbsCategory == null || bbsCategory.trim().isEmpty()) {
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('입력이 안된 사항이 있습니다.')");
                    script.println("history.back()");
                    script.println("</script>");
                } else {
                    BbsDAO bbsDAO = new BbsDAO();
                    int result = bbsDAO.update(Integer.parseInt(bbsID), bbsTitle, bbsContent, fileName, bbsCategory);
                    if (result == -1) {
                        PrintWriter script = response.getWriter();
                        script.println("<script>");
                        script.println("alert('글수정에 실패했습니다.')");
                        script.println("history.back()");
                        script.println("</script>");
                    } else {
                        PrintWriter script = response.getWriter();
                        script.println("<script>");
                        script.println("location.href = 'bbs.jsp'");
                        script.println("</script>");
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('오류가 발생했습니다. 다시 시도해주세요.')");
                script.println("history.back()");
                script.println("</script>");
            }
        }
    %>
</body>
</html>
