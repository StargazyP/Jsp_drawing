<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
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
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	}
	int bbsID = 0;
	if(request.getParameter("bbsID") != null){
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	if(bbsID == 0){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('Please login.');");
        script.println("location.href = 'bbs.jsp';");
        script.println("</script>");
	}
	Bbs bbs = new BbsDAO().getBbs(bbsID);
		
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
    <div class="row">
            <table class="table table-striped" style="text-align: center; border: 1px #dddddd;">
              <thead>
                <tr>
                    <th colspan="3" style="background-color: #eeeeee; text-align: center;">Board Write System</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                    <td style="width: 20%">title</td>
                    <td colspan="2" style="min-height: 200px; text-align: left;"><%= bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
                </tr>
                <tr>
                   <td>Writer</td>
                   <td colspan="2" style="min-height: 200px; text-align: left;"><%= bbs.getUserID() %>
                </tr>
           		<tr>
                   <td>Write Date</td>
                   <td colspan="2" style="min-height: 200px; text-align: left;"><%= bbs.getBbsDate().substring(0,11) +  bbs.getBbsDate().substring(11,13) + " : " + bbs.getBbsDate().substring(14,16)%></td>
                </tr>
                <tr>
                   <td>Content</td>
                   <td colspan="2" style="min-height: 200px; text-align: left;"><%= bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
                </tr>
              </tbody>
             </table>
            <a href="bbs.jsp" class="btn btn-primary">list</a>	
			<%
			if (userID != null && userID.equals(bbs.getUserID())) {
			%>
				<a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">ReWrite</a>
				<a href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">Delete</a>
			<%
			}
			%>
       
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>