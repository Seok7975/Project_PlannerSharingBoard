<%-- <%@page import="java.util.List"%>
<%@page import="com.example.Task"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    String taskId = request.getParameter("taskId");
    List<Task> tasks = (List<Task>) session.getAttribute("tasks");
    if (tasks != null) {
        tasks.removeIf(task -> task.getId().equals(taskId));
    }
    session.setAttribute("tasks", tasks);
    response.sendRedirect("planner.jsp");
%> --%>

<%@page import="java.util.List"%>
<%@page import="com.example.Task"%>
<%@ page import="com.example.TaskDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String userID = (String) session.getAttribute("userID");
    if (userID == null) {
        response.sendRedirect("../id/login.jsp");
    } else {
        String taskId = request.getParameter("taskId");

        TaskDAO taskDAO = new TaskDAO();
        taskDAO.deleteTask(taskId, userID);

        response.sendRedirect("planner.jsp");
    }
%>
