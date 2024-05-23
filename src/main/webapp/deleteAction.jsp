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
    if (userID == null) {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('Please login.');");
        script.println("location.href = 'login.jsp';");
        script.println("</script>");
    }
    
    int bbsID = 0;
    
    if(request.getParameter("bbsID") != null){
        bbsID = Integer.parseInt(request.getParameter("bbsID"));
    }
    if(bbsID == 0){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('NULL');");
        script.println("location.href = 'bbs.jsp'");
        script.println("</script>");
    }
    
    Bbs bbs = new BbsDAO().getBbs(bbsID);
    
    if(!userID.equals(bbs.getUserID())){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('NO PERMISSION');");
        script.println("location.href = 'bbs.jsp'");
        script.println("</script>");
        
    } else {
        BbsDAO bbsDAO = new BbsDAO();
        int result = bbsDAO.delete(bbsID);
        if(result == -1){
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('FAILED TO DELETE');");
            script.println("history.back()");
            script.println("</script>");
        } else {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("location.href = 'bbs.jsp'");
            script.println("</script>");
        } 
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
        </div>
    </div>
</nav>
<div class="container">
    <div class="row">
        <form method="post" action="writeAction.jsp">
            <table class="table table-striped" style="text-align: center; border: 1px #dddddd;">
                <tr>
                    <th colspan="2" style="background-color: #eeeeee; text-align: center;">Board Write System</th>
                </tr>
                <tr>
                    <td><input type="text" class="form-control" placeholder="Title" name="bbsTitle" maxlength="50"></td>
                </tr>
                <tr>
                    <td><textarea class="form-control" placeholder="Content" name="bbsContent" maxlength="2048" style="height: 350px;"></textarea></td>
                </tr>
                <tr>
                    <td><input type="submit" class="btn btn-primary pull-right" value="submit"></td>
                </tr>
            </table>
        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>