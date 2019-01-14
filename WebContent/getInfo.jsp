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
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">

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

  

  
</head>

<body>
<div class="container">
	<br>
	<div class="row">
		<div class="col-lg-1 mt-3">
			<a class="btn btn-outline-primary mb-3"
				href="${pageContext.request.contextPath}/adminUser.jsp">Home</a>
		</div>
		<div class="col-lg-1 mt-3">
			<a class="btn btn-outline-primary mb-3"
				href="${pageContext.request.contextPath}/getInfo.jsp">Back</a>
		</div>
		<form class="col-lg-1 mt-3"
			action="${pageContext.request.contextPath}/signout" method="post">
			<input type="hidden" name="logout" value="authorisedAuth" /> <input
				type="submit" class="btn btn-outline-primary mb-3" value="Signout" />
		</form>

	</div>

 
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
out.print("</select></div><br>");
out.println("<input type=\"submit\" class=\"btn btn-outline-success\" value=\"Submit\">");
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
	out.print("</select></div><br>");
	out.println("<input type=\"submit\" class=\"btn btn-outline-success\" value=\"Submit\">");
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
	out.print("</select></div><br>");
	out.println("<input type=\"submit\" class=\"btn btn-outline-success\" value=\"Submit\">");
}
%> 
</form>
<% 
DecimalFormat df = new DecimalFormat("#.##");
if(request.getAttribute("timesheet")!=null){
	
	out.println("<div class=\"table-responsive\">");
	out.println("<table class=\"table table-hover\">");
	out.println("<thead><tr>");

	out.println("<th>Day</th><th>Hours</th><th>Overtime</th>");
	out.println("</tr></thead><tbody>");
	double hours=0;
	double overtime=0;
	ArrayList<Timesheet> time =(ArrayList)request.getAttribute("timesheet");
	for(Timesheet t : time)
	{
		hours += t.getHours();
		overtime += t.getOverTime();
		out.println("<tr><td>"+t.getDate()+"</td><td>"+t.getHours()+"</td><td>"+t.getOverTime()+"</td></tr>");
	}
	
	out.println("</tbody></table>");
	out.println("</div>");
	out.println("<br>Total Hours:<b> "+df.format(hours)+"</b><br>");
	out.println("Total Overtime: <b>"+df.format(overtime)+"<b>");
}

%>




  	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"
		integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"
		integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k"
		crossorigin="anonymous"></script>
  </div>
  
</body>
</html>

