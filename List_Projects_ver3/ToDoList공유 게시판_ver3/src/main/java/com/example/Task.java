package com.example;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

public class Task {
    private String id;
    private String userID;
    private String item;
    private String startDateTime;
    private String dueDateTime;
    private String completed; // 변경: boolean -> String

    // getter 및 setter 메서드
    
    public Task() {
        this.id = UUID.randomUUID().toString(); // UUID를 사용하여 고유한 ID 생성
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        this.startDateTime = LocalDateTime.now().format(formatter); // 현재 날짜와 시간으로 기본값 설정
//        this.dueDateTime = LocalDateTime.now().plusDays(1).format(formatter); // 기본값을 현재 날짜와 시간 + 1일로 설정
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getItem() {
        return item;
    }

    public void setItem(String item) {
        this.item = item;
    }

    public String getStartDateTime() {
        return startDateTime;
    }

    public void setStartDateTime(String startDateTime) {
        this.startDateTime = startDateTime;
    }

    public String getDueDateTime() {
        return dueDateTime;
    }

    public void setDueDateTime(String dueDateTime) {
        this.dueDateTime = dueDateTime;
    }

    public String getCompleted() {
        return completed;
    }

    public void setCompleted(String completed) {
        this.completed = completed;
    }
}
