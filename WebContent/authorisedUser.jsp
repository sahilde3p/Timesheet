<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
    <%@page import="java.time.*" %> 
    <%@page import="ca.anygroup.beans.UpdatedTimesheet" %>
     <%@page import="ca.anygroup.beans.User" %>
    <%@page import="java.time.format.*" %>
    <%@page import="java.util.TimeZone" %>



<!DOCTYPE html>
<html>
<head>

<title>Update Timesheet</title>
<script type="text/javascript">
        function noBack()
         {
             window.history.forward()
         }
        noBack();
        window.onload = noBack;
        window.onpageshow = function(evt) { if (evt.persisted) noBack() }
        window.onunload = function() { void (0) }
    </script>
<%
response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "0");
if(session.getAttribute("authorisedAuth")==null){
	response.sendRedirect("login.jsp");
	}
	%>
	
	<style>
	
	input[type=number]{
    width: 60px;
} 

table, th, td {
    border: 1px solid black;
    padding: 5px;
}
table {
    border-spacing: 15px;
}
</style>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Roboto'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel='stylesheet prefetch' href='https://fonts.googleapis.com/css?family=Lato|Quicksand'>
<link rel='stylesheet prefetch' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css'>

	<link rel="icon" type="image/png" href="resources/images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="resources/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="resources/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/css/util.css">
	<link rel="stylesheet" type="text/css" href="resources/css/main.css">
<!--========================================================================-->




<style>
html,body,h1,h2,h3,h4,h5,h6 {font-family: "Roboto", sans-serif}
</style>

</head>
<body class="w3-light-grey">

<!-- Page Container -->
<div class="w3-content w3-margin-top" style="max-width:1400px;">

  <!-- The Grid -->
  <div class="w3-row-padding">
  
    <!-- Left Column -->
    <div class="w3-third">
    
      <div class="w3-white w3-text-grey w3-card-4">
        <div class="w3-display-container">
          <img src="http://www.fmclinic.co.uk/assets/unknown_user_large.png" style="width:100%" alt="Avatar">
         
         
          <div class="w3-display-bottomleft w3-container w3-text-black">
          
            <h2>${authorisedAuth.name}</h2>
          </div>
          
        </div>
         <br>
         
        <div class="w3-container">
          <p><i class="fa fa-briefcase fa-fw w3-margin-right w3-large w3-text-teal"></i>${authorisedAuth.company}</p>
          <p><i class="fa fa-envelope fa-fw w3-margin-right w3-large w3-text-teal"></i>${authorisedAuth.email}</p>
          
          <hr>
 			<form action="signout" method="post">
<input type ="hidden" name="logout" value="authorisedAuth"/>
<input type ="submit" class="login100-form-btn" value="Signout"/>
</form>
          <br>
        </div>
      </div><br>

    <!-- End Left Column -->
    </div>

    <!-- Right Column -->
    <div class="w3-twothird">
    
      <div class="w3-container w3-card w3-white w3-margin-bottom">
       	
       		<% LocalDate dateNow = LocalDate.now(TimeZone.getTimeZone("America/New_York").toZoneId());
		LocalDate week2D1 = dateNow.minusDays(dateNow.getDayOfWeek().compareTo(DayOfWeek.MONDAY));
		LocalDate week2D2 = week2D1.plusDays(6);
		
		String week2Date1 = week2D1.format(
			      DateTimeFormatter.ofPattern(
			    	        "dd-MMM-yyyy"));
		String week2Date2 = week2D2.format(
			      DateTimeFormatter.ofPattern(
			    	        "dd-MMM-yyyy"));
		
		
		LocalDate week1D1= week2D1.minusDays(7);
		LocalDate week1D2= week2D1.minusDays(1);
		
		String week1Date1 = week1D1.format(
			      DateTimeFormatter.ofPattern(
			    	        "dd-MMM-yyyy"));
		String week1Date2 = week1D2.format(
			      DateTimeFormatter.ofPattern(
			    	        "dd-MMM-yyyy"));
		
		LocalDate today =LocalDate.now(TimeZone.getTimeZone("America/New_York").toZoneId());
		int i = today.getDayOfWeek().compareTo(DayOfWeek.WEDNESDAY);
		
	
		
		out.println("<form action=\"getweek\" method=\"post\">");
		if(i>0)
		{
			out.println("<input type='hidden' name='week2.periodFrom' value='"+week2Date1+"'>");
			out.println("<input type='hidden' name='week2.periodTo' value='"+week2Date2+"'>");
			out.println("Select Period");
		
			out.println("<select name=\"week\" class=\"input100\">");
			out.println("<option value=\"week2\">"+ week2Date1+" to " +week2Date2+"</option>");
			
			out.println("</select>");
			
			
		}
		else{
			out.println("<input type='hidden' name='week2.periodFrom' value='"+week2Date1+"'>");
			out.println("<input type='hidden' name='week2.periodTo' value='"+week2Date2+"'>");
			out.println("<input type='hidden' name='week1.periodFrom' value='"+week1Date1+"'>");
			out.println("<input type='hidden' name='week1.periodTo' value='"+week1Date2+"'>");
			out.println("Select Period");
	
			out.println("<select name=\"week\" class='input100'>");
			out.println("<option value=\"week1\">"+ week1Date1+" to " +week1Date2+"</option>");
			out.println("<option value=\"week2\">"+ week2Date1+" to " +week2Date2+"</option>");
			out.println("</select>");
			
		}
		out.println("</br><center><input type=\"submit\" class=\"login100-form-btn\" value=\"Submit\"></center>");
		out.println("</form></br></br>");
		
		UpdatedTimesheet update = (UpdatedTimesheet)request.getAttribute("update");
		if(request.getAttribute("period")!=null && request.getAttribute("period").equals("week1"))
		{
			out.println("<form action='submitTimesheet' method='post'>");
			out.println("<input type='hidden' name='periodFrom' value='"+week1Date1+"'>");
			out.println("<input type='hidden' name='periodTo' value='"+week1Date2+"'>");
			
			out.println("<center><table>");
			out.println("<tr><th colspan=\"2\">"+ week1Date1+" to " +week1Date2+"</th><th>"+((User)request.getSession().getAttribute("authorisedAuth")).getCompany()+"</th><th>"+((User)request.getSession().getAttribute("authorisedAuth")).getName()+"</th></tr>");
			out.println("<tr><th>Date</th><th>Day</th><th>Hours</th><th>Over-Time</th></tr>");
			
			for(int j =0;j<7;j++)
			{
				int d = week1D1.getDayOfMonth();
				int m = week1D1.getMonth().getValue();
				int y = week1D1.getYear();
				LocalDate week1Date = LocalDate.of(y,m,d);
				int v = week1Date.getDayOfWeek().getValue() - 1;
			out.println("<tr><td>"+week1Date+"</td>"+"<td>"+week1Date.getDayOfWeek()+"<td><input type ='number' step='0.01' min='0' name='"+week1Date.getDayOfWeek().name().toLowerCase()+"Hours' value='"+update.day[v][0]+"'></td><td><input type ='number' step='0.01' min='0' name='"+week1Date.getDayOfWeek().name().toLowerCase()+"Overtime' value='"+update.day[v][1]+"'></td></tr>");
			
			week1D1 = week1D1.plusDays(1);
			}
			out.println("</table></br>");
			out.println("<input type=\"submit\" class=\"login100-form-btn\" value=\"Update\"></center>");
			out.println("</form>");
		}
		else if(request.getAttribute("period")!=null &&request.getAttribute("period").equals("week2"))
		{
			out.println("<form action='submitTimesheet' method='post'>");
			out.println("<input type='hidden' name='periodFrom' value='"+week2Date1+"'>");
			out.println("<input type='hidden' name='periodTo' value='"+week2Date2+"'>");
			LocalDate date = LocalDate.now(TimeZone.getTimeZone("America/New_York").toZoneId());
			LocalDate date1 = date.minusDays(date.getDayOfWeek().compareTo(DayOfWeek.MONDAY));
			out.println("<center><table>");
			out.println("<tr><th colspan=\"2\">"+ week2Date1+" to " +week2Date2+"</th><th>"+((User)request.getSession().getAttribute("authorisedAuth")).getCompany()+"</th><th>"+((User)request.getSession().getAttribute("authorisedAuth")).getName()+"</th></tr>");
			out.println("<tr><th>Date</th><th>Day</th><th>Hours</th><th>Over-Time</th></tr>");
			for(int j =0;j<=date.getDayOfWeek().compareTo(DayOfWeek.MONDAY);j++)
			{
				int v = date1.getDayOfWeek().getValue() - 1;
				
				if(date1.equals(date)){

					out.println("<tr><td>"+date1+"</td>"+"<td><b>"+date1.getDayOfWeek()+"</b></td><td><input type ='number' step='0.01' min='0' name='"+date1.getDayOfWeek().name().toLowerCase()+"Hours'  value='"+update.day[v][0]+"'></td><td><input type ='number' step='0.01' min='0' name='"+date1.getDayOfWeek().name().toLowerCase()+"Overtime' value='"+update.day[v][1]+"'></td></tr>");
					
					}
					else{
						
						out.println("<tr><td>"+date1+"</td>"+"<td>"+date1.getDayOfWeek()+"</td><td><input type ='number' step='0.01' min='0' name='"+date1.getDayOfWeek().name().toLowerCase()+"Hours' value='"+update.day[v][0]+"'></td><td><input type ='number' step='0.01' min='0' name='"+date1.getDayOfWeek().name().toLowerCase()+"Overtime'  value='"+update.day[v][1]+"'></td></tr>");
						
					}
				
				
				date1 = date1.plusDays(1);
			}
			out.println("</table></br>");
			
			out.println("<input type=\"submit\" class=\"login100-form-btn\" value=\"Update\"></center>");
			out.println("</form>");
		}
	
		%>
       
      <center> <font color="red"><b>${msg}</b></font></center>
      </div>

      

    <!-- End Right Column -->
    </div>
    
  <!-- End Grid -->
  </div>
  
  <!-- End Page Container -->
</div>

<footer class="w3-container w3-teal w3-center w3-margin-top">
  <p>Find me on social media.</p>
  <i class="fa fa-facebook-official w3-hover-opacity"></i>
  <i class="fa fa-instagram w3-hover-opacity"></i>
  <i class="fa fa-snapchat w3-hover-opacity"></i>
  <i class="fa fa-pinterest-p w3-hover-opacity"></i>
  <i class="fa fa-twitter w3-hover-opacity"></i>
  <i class="fa fa-linkedin w3-hover-opacity"></i>
  <p>Powered by <a href="https://www.w3schools.com/w3css/default.asp" target="_blank">w3.css</a></p>
</footer>
<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.min.js'></script>

    
</body>
</html>
