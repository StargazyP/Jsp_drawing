<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="java.io.PrintWriter" %>

<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPw"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	if(userID != null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('ALREADY LOGINED');");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		
	}
	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(user.getUserID(), user.getUserPw());
	if (result == 1) {
		session.setAttribute("userID", user.getUserID());
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'main.jsp';");
		script.println("</script>");
	} else if (result == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('wrong password');");
		script.println("history.back();");
		script.println("</script>");
	} else if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('cannot find ID.');");
		script.println("history.back();");
		script.println("</script>");
	} else if (result == -2) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('DB ERROR');");
		script.println("history.back();");
		script.println("</script>");
	}
%>
</body>
</html>
