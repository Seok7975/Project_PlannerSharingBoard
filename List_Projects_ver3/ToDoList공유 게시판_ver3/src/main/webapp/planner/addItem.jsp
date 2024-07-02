
<%-- <%
    String userID = (String) session.getAttribute("userID");
    if (userID == null) {
        response.sendRedirect("../login.jsp");
    } else {
        String id = UUID.randomUUID().toString();
        String item = request.getParameter("item");
        String startDateTime = request.getParameter("startDateTime");
        String dueDateTime = request.getParameter("dueDateTime");
        String completed = "no";

        Task task = new Task();
        task.setId(id);
        task.setUserID(userID);
        task.setItem(item);
        task.setStartDateTime(startDateTime);
        task.setDueDateTime(dueDateTime);
        task.setCompleted(completed);

        TaskDAO taskDAO = new TaskDAO();
        taskDAO.addTask(task);

        response.sendRedirect("planner.jsp");
    }
%> --%>

<%@page import="java.util.UUID"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.example.Task"%>
<%@ page import="com.example.TaskDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");
    String userID = (String) session.getAttribute("userID");
    if (userID == null) {
        response.sendRedirect("../joinAndLogin/login.jsp");
    } else {
        String item = request.getParameter("item");
        String startDateTime = request.getParameter("startDateTime");
        String dueDateTime = request.getParameter("dueDateTime");

        Task task = new Task();
        task.setUserID(userID);
        task.setItem(item);
        task.setStartDateTime(startDateTime);
        task.setDueDateTime(dueDateTime);
        task.setCompleted("no");

        TaskDAO taskDAO = new TaskDAO();
        taskDAO.addTask(task);

        response.sendRedirect("planner.jsp");
    }
%>

