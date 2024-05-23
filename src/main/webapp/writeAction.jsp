<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.PrintWriter" %>

<%
    String userID = (String) session.getAttribute("userID"); // 로그인 여부 확인
    
    
    
    // 로그인 여부를 검사하여 처리
    if (userID == null) {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('Please login.');");
        script.println("location.href = 'login.jsp';");
        script.println("</script>");
    } else {
        // 게시물 작성 폼에서 전송된 데이터를 가져오는 부분은 유지
        String bbsTitle = request.getParameter("bbsTitle");
        String bbsContent = request.getParameter("bbsContent");
        
        if (bbsTitle == null || bbsTitle.isEmpty() || bbsContent == null || bbsContent.isEmpty()) {
            // 필수 필드가 비어있는 경우 처리
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('please write the blank.');");
            script.println("history.back();");
            script.println("</script>");
        } else {
            // 게시물을 데이터베이스에 저장하는 부분은 유지
            BbsDAO bbsDAO = new BbsDAO();
            int result = bbsDAO.write(bbsTitle, userID, bbsContent);
            
            if (result == -1) {
                // 게시물 작성 실패 시 처리
                response.setContentType("text/html; charset=UTF-8");
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('Failed to write.');");
                script.println("history.back();");
                script.println("</script>");
            } else {
                // 게시물 작성 성공 시 처리
                response.setContentType("text/html; charset=UTF-8");
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('Success to Write.');");
                script.println("location.href = 'bbs.jsp';");
                script.println("</script>");
            }
        }
    }
%>

