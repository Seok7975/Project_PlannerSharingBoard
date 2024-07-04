package com.example;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TaskDAO {
    private Connection conn;

    public TaskDAO() {
        try {
            String dbURL = "jdbc:mysql://localhost:3306/bbs";
            String dbID = "root";
            String dbPassword = "1234";
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Task> getTasks(String userID) {
        List<Task> tasks = new ArrayList<>();
        String SQL = "SELECT * FROM tasks WHERE userID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Task task = new Task();
                task.setId(rs.getString("id"));
                task.setUserID(rs.getString("userID"));
                task.setItem(rs.getString("item"));
                task.setStartDateTime(rs.getString("startDateTime"));
                task.setDueDateTime(rs.getString("dueDateTime"));
                task.setCompleted(rs.getString("completed")); // 변경: boolean -> String
                tasks.add(task);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tasks;
    }

    public int addTask(Task task) {
        if (task.getStartDateTime() == null || task.getDueDateTime() == null) {
            throw new NullPointerException("startDateTime and dueDateTime must not be null");
        }
        
        String SQL = "INSERT INTO tasks (id, userID, item, startDateTime, dueDateTime, completed) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, task.getId());
            pstmt.setString(2, task.getUserID());
            pstmt.setString(3, task.getItem());
            pstmt.setString(4, task.getStartDateTime());
            pstmt.setString(5, task.getDueDateTime());
            pstmt.setString(6, task.getCompleted()); // 변경: boolean -> String
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public int updateTask(Task task) {
        if (task.getStartDateTime() == null || task.getDueDateTime() == null) {
            throw new NullPointerException("startDateTime and dueDateTime must not be null");
        }

        String SQL = "UPDATE tasks SET item = ?, startDateTime = ?, dueDateTime = ?, completed = ? WHERE id = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, task.getItem());
            pstmt.setString(2, task.getStartDateTime());
            pstmt.setString(3, task.getDueDateTime());
            pstmt.setString(4, task.getCompleted()); // 변경: boolean -> String
            pstmt.setString(5, task.getId());
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public int deleteTask(String taskId, String userID) {
        String SQL = "DELETE FROM tasks WHERE id = ? AND userID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, taskId);
            pstmt.setString(2, userID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    // 추가: 할 일 완료 상태 토글 메서드
    public int toggleTaskCompletion(String taskId) {
        String SQL = "UPDATE tasks SET completed = CASE WHEN completed = 'yes' THEN 'no' ELSE 'yes' END WHERE id = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, taskId);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
}
