<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="https://cdn.jsdelivr.net/npm/html2canvas@0.4.1/dist/html2canvas.min.js"></script>
    <script>
        function saveAsImage() {
            html2canvas(document.querySelector(".todo-container")).then(canvas => {
                var link = document.createElement('a');
                link.href = canvas.toDataURL("image/png");
                link.download = 'todo-list.png';
                link.click();
            });
        }
    </script>
</head>
<body>
    <button onclick="saveAsImage()">할 일 목록 그림파일 저장</button>
</body>
</html>
 --%>