<!--  다운로드 액션 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.net.URLEncoder" %>
<%
    // 요청 파라미터로부터 파일 이름을 가져옴
    String fileName = request.getParameter("fileName");
    if (fileName == null || fileName.equals("")) {
        out.println("<script>alert('파일 이름이 유효하지 않습니다.'); history.back();</script>");
        return;
    }

    // 파일 경로 설정 (실제 파일이 저장된 경로로 변경해야 함)
    String filePath = application.getRealPath("/upload/") + File.separator + fileName;

    File file = new File(filePath);
    if (!file.exists()) {
        out.println("<script>alert('파일이 존재하지 않습니다.'); history.back();</script>");
        return;
    }

    // 파일 다운로드를 위한 응답 설정
    response.setContentType("application/octet-stream");
    response.setContentLength((int) file.length());
    String encodedFileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
    response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFileName + "\";");

    // 파일을 읽어와서 응답 출력 스트림에 씀
    FileInputStream fileInputStream = null;
    OutputStream outputStream = null;
    try {
        fileInputStream = new FileInputStream(file);
        outputStream = response.getOutputStream();
        byte[] buffer = new byte[4096];
        int bytesRead = -1;
        while ((bytesRead = fileInputStream.read(buffer)) != -1) {
            outputStream.write(buffer, 0, bytesRead);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (fileInputStream != null) {
            try {
                fileInputStream.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (outputStream != null) {
            try {
                outputStream.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
%>

 
<%--  <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.net.URLEncoder" %>
<%
    // 요청 파라미터로부터 파일 이름을 가져옴
    String uploadFile = request.getParameter("uploadFile");
    if (uploadFile == null || uploadFile.equals("")) {
        out.println("<script>alert('파일 이름이 유효하지 않습니다.'); history.back();</script>");
        return;
    }

    // 파일 경로 설정 (실제 파일이 저장된 경로로 변경해야 함)
    String filePath = application.getRealPath("/upload/") + File.separator + uploadFile;

    File file = new File(filePath);
    if (!file.exists()) {
        out.println("<script>alert('파일이 존재하지 않습니다.'); history.back();</script>");
        return;
    }

    // 파일 다운로드를 위한 응답 설정
    response.setContentType("application/octet-stream");
    response.setContentLength((int) file.length());
    String encodedFileName = URLEncoder.encode(uploadFile, "UTF-8").replaceAll("\\+", "%20");
    response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFileName + "\";");

    // 파일을 읽어와서 응답 출력 스트림에 씀
    FileInputStream fileInputStream = null;
    OutputStream outputStream = null;
    try {
        fileInputStream = new FileInputStream(file);
        outputStream = response.getOutputStream();
        byte[] buffer = new byte[4096];
        int bytesRead = -1;
        while ((bytesRead = fileInputStream.read(buffer)) != -1) {
            outputStream.write(buffer, 0, bytesRead);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (fileInputStream != null) {
            try {
                fileInputStream.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (outputStream != null) {
            try {
                outputStream.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
%>
  --%>