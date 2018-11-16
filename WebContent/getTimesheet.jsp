<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="error.jsp"%>
    <%@page import="java.util.ArrayList" %>
    <%@page import="java.util.Map" %>
	<%@page import="ca.anygroup.beans.*" %>
	<%@page import="ca.anygroup.database.*" %>
	<%@page import="java.text.DecimalFormat" %>
	<%@page import="java.time.format.DateTimeFormatter" %>
	
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
<a href="${pageContext.request.contextPath}/getTimesheet.jsp"><button>BACK</button></a>
<form id="sign" action="signout" method="post">
<input type ="hidden" name="logout" value="authorisedAuth"/>
<input type ="submit" class="login100-form-btn" value="Signout"/>
</form>
  <div class="center-on-page">
 <form action="getPeriodByCompany" method="get">



<% 
if(request.getAttribute("timesheet")==null && request.getAttribute("periods")==null)
{	out.println("<h1>Select Company</h1>");
	out.println("<div class=\"select\">");
	out.print("<select name=\"companyId\" id=\"slct\">");
DatabaseHandler db = new DatabaseHandler();
ArrayList<Company> list = db.returnCompanies();
for(Company c :list){
out.print("<option value='"+c.getId()+"'>"+c.getName()+"</option>");
}
out.println("</select></div><br><center><input type=\"submit\" value=\"Submit\"></center>");
}
%>

</form>
<form action="getAllTimesheets" method="get">
<%
if(request.getAttribute("periods")!=null){
	out.println("<h1>Select Period</h1>");
	out.print("<input type='hidden' name='companyId' value="+request.getAttribute("companyId")+">");
	out.println("<div class=\"select\">");
	out.print("<select name=\"periodId\" id=\"slct\">");
	ArrayList<Period> period = (ArrayList)request.getAttribute("periods");
	for(Period p : period){
		out.print("<option value='"+p.getPeriodId()+"'>"+p.getPeriodFrom().format(DateTimeFormatter.ofPattern("MMM dd,yyyy"))+" to "+p.getPeriodTo().format(DateTimeFormatter.ofPattern("MMM dd,yyyy"))+"</option>");
	}
	out.print("</select></div><br><center>");
	out.println("<input type=\"submit\" value=\"Submit\"></center>");
}
%>
</form>
<div class="table-container">
<table>

<%
DecimalFormat df = new DecimalFormat("#.##");
if(request.getAttribute("timesheet")!=null){
	Map<String,UpdatedTimesheetWithNameAndDate> map = (Map)request.getAttribute("timesheet");
	out.println("<tr><th colspan=\"3\">"+((UpdatedTimesheetWithNameAndDate)map.get(map.entrySet().iterator().next().getKey())).period+"</th></tr>");
	out.println("<tr><th>Name</th><th>Monday</th><th>Tuesday</th><th>Wednesday</th><th>Thursday</th><th>Friday</th><th>Saturday</th><th>Sunday</th><th>Total Regular Hours</th><th>Total Overtime</th></tr>");


double total =0;
double ot =0;
for(Map.Entry<String,UpdatedTimesheetWithNameAndDate> m : map.entrySet()){
	total=0;
	ot=0;
	for(int i=0;i<7;i++){
		total += ((UpdatedTimesheetWithNameAndDate)m.getValue()).day[i][0];
	}
	for(int i=0;i<7;i++){
		ot += ((UpdatedTimesheetWithNameAndDate)m.getValue()).day[i][1];
	}
out.println("<tr><td>"+m.getKey()+"</td><td>"+df.format((((UpdatedTimesheetWithNameAndDate)m.getValue()).day[0][0]+((UpdatedTimesheetWithNameAndDate)m.getValue()).day[0][1]))+"</td><td>"+df.format((((UpdatedTimesheetWithNameAndDate)m.getValue()).day[1][0]+((UpdatedTimesheetWithNameAndDate)m.getValue()).day[1][1]))+"</td><td>"+df.format((((UpdatedTimesheetWithNameAndDate)m.getValue()).day[2][0]+((UpdatedTimesheetWithNameAndDate)m.getValue()).day[2][1]))+"</td><td>"+df.format((((UpdatedTimesheetWithNameAndDate)m.getValue()).day[3][0]+((UpdatedTimesheetWithNameAndDate)m.getValue()).day[3][1]))+"</td><td>"+df.format((((UpdatedTimesheetWithNameAndDate)m.getValue()).day[4][0]+((UpdatedTimesheetWithNameAndDate)m.getValue()).day[4][1]))+"</td><td>"+df.format((((UpdatedTimesheetWithNameAndDate)m.getValue()).day[5][0]+((UpdatedTimesheetWithNameAndDate)m.getValue()).day[5][1]))+"</td><td>"+df.format((((UpdatedTimesheetWithNameAndDate)m.getValue()).day[6][0]+((UpdatedTimesheetWithNameAndDate)m.getValue()).day[6][1]))+"</td><td>"+df.format(total)+"</td><td>"+df.format(ot)+"</td></tr>");
}
}
%>
</table>
  </div>
 
</div>
  
  
</body>
</html>


