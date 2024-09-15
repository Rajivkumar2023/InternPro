<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<body>
<%
    // Retrieve the session object
    HttpSession session1 = request.getSession(false);
	if(session1 != null){
		session1.invalidate();
        // Redirect to the login page if the session is not valid
        response.sendRedirect("index.html");
    }
%>

<!-- Cache control headers start -->
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!-- Cache control headers end -->

</body>
</html>
