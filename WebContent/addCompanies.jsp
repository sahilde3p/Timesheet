<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<%

if(session.getAttribute("adminAuth")==null){
	response.sendRedirect("login.jsp");
	}%>

<meta charset="ISO-8859-1">
<title>Add Company</title>
</head>
<body>
<table><tr><td><a href="${pageContext.request.contextPath}/adminUser.jsp"><button>HOME</button></a>
</td><td><form id="sign" action="${pageContext.request.contextPath}/signout" method="post">
<input type ="hidden" name="logout" value="authorisedAuth"/>
<input type ="submit" class="login100-form-btn" value="Signout"/>
</form></td></tr>


</table>
<br><br>
<form action="registerCompany" method="post">

<table>
	<tr><td>Company Name: </td><td><input type="text" name="companyName"></td></tr>

<tr><td> <input type="submit" value="Submit"></td><td></tr>
</table>

</form>
${msg}
</body>
</html>