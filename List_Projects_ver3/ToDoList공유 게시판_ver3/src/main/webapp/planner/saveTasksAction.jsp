<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.ParseException"%>
<%@page import="com.example.Task"%>
<%@page import="com.example.TaskDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String userID = (String) session.getAttribute("userID");
    if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 하세요')");
        script.println("location.href = '../id/login.jsp'");
        script.println("</script>");
    } else {
        String fileName = request.getParameter("fileName");
        String filePath = request.getParameter("filePath");

        if (fileName == null || fileName.trim().isEmpty()) {
            fileName = "tasks_" + userID + ".txt";
        } else {
            fileName = fileName.trim() + ".txt";
        }

        if (filePath == null || filePath.trim().isEmpty()) {
            filePath = getServletContext().getRealPath("/") + fileName;
        } else {
            filePath = filePath.trim() + File.separator + fileName;
        }

        TaskDAO taskDAO = new TaskDAO();
        List<Task> tasks = taskDAO.getTasks(userID);
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");

        try (FileWriter fileWriter = new FileWriter(filePath, false)) {
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

                fileWriter.write("할 일: " + task.getItem() + "\n");
                fileWriter.write("시작: " + (startDate != null ? outputFormat.format(startDate) : "N/A") + "\n");
                fileWriter.write("마감: " + (dueDate != null ? outputFormat.format(dueDate) : "N/A") + "\n");
                fileWriter.write("완료: " + (task.getCompleted().equals("yes") ? "완료됨" : "미완료") + "\n");
                fileWriter.write("\n");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        response.setContentType("application/octet-stream; charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename=\"" + new String(fileName.getBytes("UTF-8"), "ISO-8859-1") + "\"");
        java.io.File file = new java.io.File(filePath);
        java.io.FileInputStream fileInputStream = new java.io.FileInputStream(file);
        int i;
        while ((i = fileInputStream.read()) != -1) {
            response.getOutputStream().write(i);
        }
        fileInputStream.close();
    }
%>
