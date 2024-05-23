<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>

<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPw"/>
<jsp:setProperty name="user" property="userEmail"/>
<jsp:setProperty name="user" property="userGender"/>
<jsp:setProperty name="user" property="userName"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	// Initialize UserDAO instance
	UserDAO userDAO = new UserDAO();

	if(user.getUserID() == null || user.getUserPw() == null || user.getUserName() == null || 
	user.getUserEmail() == null || user.getUserGender() == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('NULL')");
		script.println("history.back();");
		script.println("</script>");
		
	} else{
		int result = userDAO.register(user);
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('ALREADY EXGIST ID.');");
			script.println("location.href = 'register.jsp'");
			script.println("</script>");
		} else{
			session.setAttribute("userID", user.getUserID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
		}
	}
%>
</body>
</html>
