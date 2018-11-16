<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    	<%@page import="java.util.ArrayList" %>
	<%@page import="ca.anygroup.beans.Company" %>
	<%@page import="ca.anygroup.beans.Timesheet" %>
	<%@page import="ca.anygroup.beans.User" %>
	<%@page import="ca.anygroup.beans.Period" %>
	<%@page import="ca.anygroup.database.*" %>
	<%@page import="java.text.DecimalFormat" %>

<!DOCTYPE html>
<html >
<head>
<style>



 table {
 	
    border-collapse: collapse;
    border-spacing: 0;
    width: 100%;
    border: 1px solid #ddd;
    
}

th, td {
    text-align: left;
    padding: 8px;
    color: black;
}
tr:nth-child(even){background-color: #f2f2f2}
tr:nth-child(odd){background-color: #ffffff}
th { 
  background: #333; 
  color: white; 
  font-weight: bold; 
}

#sign 
{
 position: relative;
 float: right;
 padding-right : 20px;
}

</style>
  <meta charset="UTF-8">
    <title>Get Timesheet</title>
  <%
response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "0");
if(session.getAttribute("adminAuth")==null){
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
<a href="${pageContext.request.contextPath}/adminUser.jsp"><button>HOME</button></a>
<a href="${pageContext.request.contextPath}/getInfo.jsp"><button>BACK</button></a>
<form id="sign" action="signout" method="post">
<input type ="hidden" name="logout" value="authorisedAuth"/>
<input type ="submit" class="login100-form-btn" value="Signout"/>
</form>
  <div class="center-on-page">
 <form action="getUser" method="get">



<% 
if(request.getAttribute("users")==null && request.getAttribute("period")==null && request.getAttribute("timesheet")==null)
{	out.println("<h1>Select Company</h1>");
	out.println("<div class=\"select\">");
	out.print("<select name=\"companyId\" id=\"slct\">");

DatabaseHandler db = new DatabaseHandler();
ArrayList<Company> list = db.returnCompanies();
for(Company c :list){
out.print("<option value='"+c.getId()+"'>"+c.getName()+"</option>");
}
out.print("</select></div><br><center>");
out.println("<input type=\"submit\" value=\"Submit\"></center>");
}
%>

</form>
<form action="getPeriod" method="get">
<%
if(request.getAttribute("users")!=null){
	
	out.println("<h1>Select Employee</h1>");
	out.println("<div class=\"select\">");
	out.print("<select name=\"userId\" id=\"slct\">");
	ArrayList<User> user =(ArrayList)request.getAttribute("users");
	for(User u : user){
		out.print("<option value='"+u.getEmail()+"'>"+u.getName()+"</option>");
	}
	out.print("</select></div><br><center>");
	out.println("<input type=\"submit\" value=\"Submit\"></center>");
	}
%>
</form>
<form action="getHours" >
<% 
if(request.getAttribute("period")!=null){
	out.println("<h1>Select Period</h1>");
	out.println("<div class=\"select\">");
	out.print("<select name=\"periodId\" id=\"slct\">");
	
	ArrayList<Period> period =(ArrayList)request.getAttribute("period");
	
	
	for(Period p : period){
		
		out.print("<option value='"+p.getPeriodId()+"'>"+p.getPeriodFrom() +" to "+p.getPeriodTo()+"</option>");
	}
	out.print("</select></div><br><center>");
	out.println("<input type=\"submit\" value=\"Submit\"></center>");
}
%> 
</form>
<% 
DecimalFormat df = new DecimalFormat("#.##");
if(request.getAttribute("timesheet")!=null){
	
	out.println("<div style=\"overflow-x:auto;\">");
	out.println("<table>");
	out.println("<tr>");

	out.println("<th>Day</th><th>Hours</th><th>Overtime</th>");
	out.println("</tr>");
	double hours=0;
	double overtime=0;
	ArrayList<Timesheet> time =(ArrayList)request.getAttribute("timesheet");
	for(Timesheet t : time)
	{
		hours += t.getHours();
		overtime += t.getOverTime();
		out.println("<tr><td>"+t.getDate()+"</td><td>"+t.getHours()+"</td><td>"+t.getOverTime()+"</td></tr>");
	}
	
	out.println("</table>");
	out.println("</div>");
	out.println("<br>Total Hours:<b> "+df.format(hours)+"</b><br>");
	out.println("Total Overtime: <b>"+df.format(overtime)+"<b>");
}

%>



</div>
  
  
</body>
</html>

