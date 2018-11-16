<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
    <%@page import="ca.anygroup.database.*" %>
	<%@page import="java.util.ArrayList" %>
	<%@page import="ca.anygroup.beans.Company" %>

<!DOCTYPE html>
<html >
<head>
<style>
#sign 
{
 position: relative;
 float: right;
 padding-right : 20px;
}

</style>
  <meta charset="UTF-8">
    <title>Select Company</title>
  <%
response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "0");
if(session.getAttribute("underProcess")==null){
	response.sendRedirect("login.jsp");
	}%>
  <meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">

  <link rel='stylesheet prefetch' href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,700'>
<link rel='stylesheet prefetch' href='https://raubarrera.neocities.org/cdpn/style.css'>

      <link rel="stylesheet" href="resources/css/style.css">

  
</head>

<body>
<br>
<form id="sign" action="signout" method="post">
<input type ="hidden" name="logout" value="authorisedAuth"/>
<input type ="submit" class="login100-form-btn" value="Signout"/>
</form>
  <div class="center-on-page">
  
  <h1>Select Company</h1>
  <form action="selectCompany" method="post">
  <div class="select">
  
    <select name="company" id="slct">
     <% DatabaseHandler db = new DatabaseHandler();
				ArrayList<Company> list = db.returnCompanies();
			for(Company c :list){
				out.print("<option value='"+c.getId()+"'>"+c.getName()+"</option>");
			}
			%>
    </select>
    
    <br><font color='red'><b>${msg}</b></font>
   
  </div>
  <br><center>
  <input type="submit" value="Submit"></center>
   </form>
</div>
  
  
</body>
</html>

