<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Unauthorised User</title>
<%
response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "0");
if(session.getAttribute("unauthorisedAuth")==null){
	response.sendRedirect("login.jsp");
	}
	%>
</head>
<body>
<h3>You are not permitted to access timesheet yet. Please Come back later. </h3>
<br/>	
		<form action="signout" method="post">
<input type ="hidden" name="logout" value="unauthorisedAuth"/>
<input type ="submit"  value="Signout"/>
</form>
</body>
</html>