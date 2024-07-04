<%@page import="java.util.List"%>
<%@page import="com.example.Task"%>
<%@ page import="com.example.TaskDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String userID = (String) session.getAttribute("userID");
    if (userID == null) {
        response.sendRedirect("../joinAndLogin/login.jsp");
    } else {
        String taskId = request.getParameter("taskId");

        TaskDAO taskDAO = new TaskDAO();
        taskDAO.toggleTaskCompletion(taskId);

        response.sendRedirect("planner.jsp");
    }
%>


 