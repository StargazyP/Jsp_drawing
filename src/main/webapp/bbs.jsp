<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
<title>Insert title here</title>
</head>
<body>
<%
	String userID = null;
	if(session.getAttribute("userID") == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('PLEASE LOGIN');");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
		
	}
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	}
	int pageNumber = 1;
	if(request.getParameter("pageNumber") != null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
<!--                 <li><a href="main.jsp">MAIN</a></li>
                <li class="active"><a href="bbs.jsp">PAGE</a></li> -->
            </ul>
            <%
           		 if(userID == null){
            %>
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
            <%
            	} else {
            %>
      
            <ul class="navbar-nav ml-auto mb-2 mb-lg-0">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
                    role="button" data-bs-toggle="dropdown"
                    aria-expanded="false">USER CONTROL</a>
                <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <li><a class="dropdown-item" href="logoutAction.jsp">LOGOUT</a></li>
                </ul>
            </li>
        </ul>
        <%
            	}
        %>
           
        </div>
    </div>
</nav>
<div class="container">
	<table class="table table-striped" style="text-align: center; border: 1px #dddddd;">
	<thead>
		<tr>
			<th th style="background-color : #eeeeee; text-align: center;">User's Board</th>
		</tr>	
	</thead>
    <div class="row">
        <table class="table table-striped" style="text-align: center; border: 1px #dddddd;">
            <thead>
                <tr>
                    <th style="background-color : #eeeeee; text-align: center;">Number</th>
                    <th style="background-color : #eeeeee; text-align: center;">Title</th>
                    <th style="background-color : #eeeeee; text-align: center;">Writer</th>
                    <th style="background-color : #eeeeee; text-align: center;">Date</th>
                </tr>
            </thead>
            <tbody>
            	<%
            		BbsDAO bbsDAO = new BbsDAO();
            		ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
            		for(int i = 0; i < list.size(); i++){
            	%>
            	<tr>
                    <td><%= list.get(i).getBbsID()%></td>
                    <td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID()%>"><%= list.get(i).getBbsTitle()%></td>
                    <td><%= list.get(i).getUserID()%></td>
                    <td><%= list.get(i).getBbsDate().substring(0,11) +  list.get(i).getBbsDate().substring(11,13) + " : " + list.get(i).getBbsDate().substring(14,16)%></td>
                </tr>
            	
            	<% 
            		}
            	%>

            </tbody>
        </table>
        <a href="write.jsp" class="btn btn-primary pull-right">Write</a>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>