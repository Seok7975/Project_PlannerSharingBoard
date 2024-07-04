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
            String directory = application.getRealPath("/upload");
            File uploadDir = new File(directory);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs(); // 디렉토리가 존재하지 않으면 생성
            }

            int maxSize = 1024 * 1024 * 10; // 10MB
            String encoding = "UTF-8";
            MultipartRequest multi = new MultipartRequest(request, directory, maxSize, encoding, new DefaultFileRenamePolicy());
            
            String bbsTitle = multi.getParameter("bbsTitle");
            String bbsContent = multi.getParameter("bbsContent");
            String bbsCategory = multi.getParameter("bbsCategory"); // bbsCategory 추가
            String fileName = multi.getFilesystemName("fileName"); // 여기서 "fileName"으로 수정되었습니다.

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
                int result = bbsDAO.write(bbsTitle, userID, bbsContent, fileName, bbsCategory);
                if (result == -1) {
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('글쓰기에 실패했습니다.')");
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
</html>

