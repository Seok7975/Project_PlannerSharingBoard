<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String userID = request.getParameter("userID");
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String dbURL = "jdbc:mysql://localhost:3306/bbs";
    String dbID = "root";
    String dbPassword = "1234";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        String SQL = "SELECT * FROM users WHERE userID = ?";
        pstmt = conn.prepareStatement(SQL);
        pstmt.setString(1, userID);
        rs = pstmt.executeQuery();
        if(rs.next()) {
            response.getWriter().write("false");
        } else {
            response.getWriter().write("true");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if(rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
        try { if(pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
        try { if(conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
    }
%>
