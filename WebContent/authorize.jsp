<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
    <%@ page import="ca.anygroup.database.DatabaseHandler" %>
    <%@ page import="java.util.ArrayList,ca.anygroup.beans.User" %>
<!DOCTYPE html>
<html>
<head>
<%if(session.getAttribute("adminAuth")==null){
	response.sendRedirect("/TimeSheetManagement/login.jsp");
	}%>
<meta charset="ISO-8859-1">
<style>
table, th, td {
    border: 1px solid black;
    padding: 5px;
}
table {
    border-spacing: 15px;
}
</style>
<title>Access Privileges</title>
</head>
<body>
<table><tr><td><a href="${pageContext.request.contextPath}/adminUser.jsp"><button>HOME</button></a>
</td><td><form id="sign" action="${pageContext.request.contextPath}/signout" method="post">
<input type ="hidden" name="logout" value="authorisedAuth"/>
<input type ="submit" class="login100-form-btn" value="Signout"/>
</form></td></tr>


</table>
<br><br>
<table>
<tr><th>Unauthorised Users</th></tr>
<tr><th>Name</th><th>Company</th><th>Access Permission</th></tr>
<% ArrayList<User> list = new DatabaseHandler().getUnauthorisedUsers();
	for(User u : list){
		out.println("<tr><td>"+u.getName()+"</td><td>"+u.getCompany()+"</td><td><a href='/addAuth/"+u.getEmail()+"/'>Authorize</a></td><td><a href='/deleteUser/"+u.getEmail()+"/'>Delete</a></td></tr>");
	}
%>
<br>
<font color="red"><b>${msg}</b></font>
</table>

<br><br>

<table>
<tr><th>Authorised Users</th></tr>
<tr><th>Name</th><th>Company</th><th>Access Permission</th></tr>
<% ArrayList<User> list2 = new DatabaseHandler().getAuthorisedUsers();
	for(User u : list2){
		out.println("<tr><td>"+u.getName()+"</td><td>"+u.getCompany()+"</td><td><a href='/revokeAuth/"+u.getEmail()+"/'>Unauthorize</a></td></tr>");
	}
%>
<br>
</table>
</body>
</html>