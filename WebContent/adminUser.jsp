<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<%
response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "0");
if(session.getAttribute("adminAuth")==null){
	response.sendRedirect("login.jsp");
	}%>

<meta charset="ISO-8859-1">
<title>Welcome</title>
</head>
<body>
Hello ${adminAuth}
<ul>
<li><a href="${pageContext.request.contextPath}/authorize.jsp">Grant or forfeit user privileges</a></li>

<li><a href="${pageContext.request.contextPath}/addCompanies.jsp">Add Companies</a></li>

<li>Get Timesheets
	<ul>
		<li><a href="${pageContext.request.contextPath}/getTimesheet.jsp">Get Timesheet by Company</a></li>
		<li><a href="${pageContext.request.contextPath}/getInfo.jsp">Get Timesheet by Employee</a></li>
	</ul>
</li>
</ul>
<form action="signout" method="post">
<input type ="hidden" name="logout" value="adminAuth"/>
<input type ="submit" value="Signout"/>
</form>
</body>
</html>