<%@ page import="com.example.TaskDAO" %>
<%@ page import="com.example.Task" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String userID = (String) session.getAttribute("userID");
    if (userID == null) {
        response.sendRedirect("../joinAndLogin/login.jsp");
    } else {
        String id = request.getParameter("id");
        String item = request.getParameter("item");
        String startDateTime = request.getParameter("startDateTime");
        String dueDateTime = request.getParameter("dueDateTime");
        String completed = request.getParameter("completed") != null ? "yes" : "no";

        Task task = new Task();
        task.setId(id);
        task.setUserID(userID);
        task.setItem(item);
        task.setStartDateTime(startDateTime);
        task.setDueDateTime(dueDateTime);
        task.setCompleted(completed);

        TaskDAO taskDAO = new TaskDAO();
        taskDAO.updateTask(task);

        response.sendRedirect("planner.jsp");
    }
%>
