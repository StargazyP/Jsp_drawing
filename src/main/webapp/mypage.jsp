<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Information</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
</head>
<body>
<%
    String userID = null;
    User user = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
        UserDAO userDAO = new UserDAO();
        user = userDAO.getUserInfo(userID);
    }
%>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <button type="button" class="navbar-toggler"
            data-bs-toggle="collapse"
            data-bs-target="#bs-example-navbar-collapse-1"
            aria-controls="bs-example-navbar-collapse-1"
            aria-expanded="false"
            aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <a class="navbar-brand" href="index.jsp">Web</a>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="active"><a class="nav-link" href="main.jsp">Main</a></li>
                <li class="nav-item"><a class="nav-link" href="bbs.jsp">Page</a></li>
                <li class="nav-item"><a class="nav-link" href="chat.jsp">Chat</a></li>
            </ul>
            <% if (userID == null) { %>
                <ul class="navbar-nav ml-auto mb-2 mb-lg-0">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
                            role="button" data-bs-toggle="dropdown"
                            aria-expanded="false">CONNECT</a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" href="login.jsp">LOGIN</a></li>
                            <li><a class="dropdown-item" href="register.jsp">SIGNUP</a></li>
                        </ul>
                    </li>
                </ul>
            <% } else { %>
                <ul class="navbar-nav ml-auto mb-2 mb-lg-0">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
                            role="button" data-bs-toggle="dropdown"
                            aria-expanded="false">USER CONTROL</a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" href="logoutAction.jsp">LOGOUT</a></li>
                            <li><a class="dropdown-item" href="mypage.jsp">MYPAGE</a></li>
                        </ul>
                    </li>
                </ul>
            <% } %>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row">
        <h1>User Information</h1>
    </div>
    <div class="row">
        <table class="table table-striped" style="text-align: center; border: 1px #dddddd;">
            <thead>
                <tr>
                    <th>User ID</th>
                    <th>User Name</th>
                    <th>User Email</th>
                    <th>User Gender</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><%= user.getUserID() %></td>
                    <td><%= user.getUserName() %></td>
                    <td><%= user.getUserEmail() %></td>
                    <td><%= user.getUserGender() %></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
