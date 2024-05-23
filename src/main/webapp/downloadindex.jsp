<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FTP File Transfer</title>
</head>
<body>
    <h1>FTP File Transfer</h1>
    
    <%-- FTP 서버 연결 정보 설정 --%>
    <%@ page import="org.apache.commons.net.ftp.FTPClient,org.apache.commons.net.ftp.FTPFile" %>
    <% String server = "3.38.255.244"; %>
    <% String username = "cat"; %>
    <% String password = "catiscute"; %>
    
    <% FTPClient ftp = new FTPClient(); %>
    <% try { %>
        <%-- FTP 서버에 연결 --%>
        <% ftp.connect(server); %>
        <% ftp.login(username, password); %>
        
        <%-- 작업 디렉토리 설정 (예: "/public_html") --%>
        <% String workingDirectory = "/public_html"; %>
        <% ftp.changeWorkingDirectory(workingDirectory); %>
        
        <%-- 파일 목록 가져오기 --%>
<%--         <% FTPFile[] files = ftp.listFiles(); %>
        
        파일 목록을 화면에 표시
        <h2>Files on FTP Server:</h2>
        <table border="1">
            <tr>
                <th>File Name</th>
                <th>File Size</th>
                <th>Last Modified</th>
                <th>Download</th>
            </tr>
            <% for (FTPFile file : files) { %>
                <tr>
                    <td><%= file.getName() %></td>
                    <td><%= file.getSize() %></td>
                    <td><%= file.getTimestamp().getTime() %></td>
                    <td><a href="download.jsp?filename=<%= file.getName() %>">Download</a></td>
                </tr>
            <% } %>
        </table> --%>
        
        <%-- 파일 업로드 폼 --%>
        <h2>Upload File to FTP Server:</h2>
        <form action="upload.jsp" method="post" enctype="multipart/form-data">
            Select file to upload: <input type="file" name="fileToUpload" id="fileToUpload">
            <input type="submit" value="Upload File" name="submit">
        </form>
        
        <%-- FTP 연결 종료 --%>
        <% ftp.logout(); %>
        <% ftp.disconnect(); %>
    <% } catch (Exception e) { %>
        <p>Error: <%= e.getMessage() %></p>
    <% } %>
</body>
</html>

