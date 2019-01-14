<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" errorPage="error.jsp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="ca.anygroup.beans.*"%>
<%@page import="ca.anygroup.database.*"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.time.format.DateTimeFormatter"%>

<!DOCTYPE html>
<html>
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
	if (session.getAttribute("adminAuth") == null) {
		response.sendRedirect("login.jsp");
	}
%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">



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
				href="${pageContext.request.contextPath}/getTimesheet.jsp">Back</a>
		</div>
		<form class="col-lg-1 mt-3"
			action="${pageContext.request.contextPath}/signout" method="post">
			<input type="hidden" name="logout" value="authorisedAuth" /> <input
				type="submit" class="btn btn-outline-primary mb-3" value="Signout" />
		</form>

	</div>

	
		<form action="getPeriodByCompany" method="get">



			<%
				if (request.getAttribute("timesheet") == null && request.getAttribute("periods") == null) {
					out.println("<h1>Select Company</h1>");
					out.println("<div class=\"select\">");
					out.print("<select name=\"companyId\" id=\"slct\">");
					DatabaseHandler db = new DatabaseHandler();
					ArrayList<Company> list = db.returnCompanies();
					for (Company c : list) {
						out.print("<option value='" + c.getId() + "'>" + c.getName() + "</option>");
					}
					out.println("</select></div><br><input class=\"btn btn-outline-success\" type=\"submit\" value=\"Submit\"></center>");
				}
			%>

		</form>
		<form action="getAllTimesheets" method="get">
			<%
				if (request.getAttribute("periods") != null) {
					out.println("<h1>Select Period</h1>");
					out.print("<input type='hidden' name='companyId' value=" + request.getAttribute("companyId") + ">");
					out.println("<div class=\"select\">");
					out.print("<select name=\"periodId\" id=\"slct\">");
					ArrayList<Period> period = (ArrayList) request.getAttribute("periods");
					for (Period p : period) {
						out.print("<option value='" + p.getPeriodId() + "'>"
								+ p.getPeriodFrom().format(DateTimeFormatter.ofPattern("MMM dd,yyyy")) + " to "
								+ p.getPeriodTo().format(DateTimeFormatter.ofPattern("MMM dd,yyyy")) + "</option>");
					}
					out.print("</select></div><br>");
					out.println("<input type=\"submit\" class=\"btn btn-outline-success\" value=\"Submit\">");
				}
			%>
		</form>

		<div class="table-responsive">
			<table class="table table-hover table-light">

				<%
					DecimalFormat df = new DecimalFormat("#.##");
					if (request.getAttribute("timesheet") != null) {
						Map<String, UpdatedTimesheetWithNameAndDate> map = (Map) request.getAttribute("timesheet");
						out.println("<thead><tr><th colspan=\"3\">"
								+ ((UpdatedTimesheetWithNameAndDate) map.get(map.entrySet().iterator().next().getKey())).period
								+ "</th></tr>");
						out.println(
								"<tr><th>Name</th><th>Monday</th><th>Tuesday</th><th>Wednesday</th><th>Thursday</th><th>Friday</th><th>Saturday</th><th>Sunday</th><th>Total Regular Hours</th><th>Total Overtime</th></tr></thead>");

						double total = 0;
						double ot = 0;
						for (Map.Entry<String, UpdatedTimesheetWithNameAndDate> m : map.entrySet()) {
							total = 0;
							ot = 0;
							for (int i = 0; i < 7; i++) {
								total += ((UpdatedTimesheetWithNameAndDate) m.getValue()).day[i][0];
							}
							for (int i = 0; i < 7; i++) {
								ot += ((UpdatedTimesheetWithNameAndDate) m.getValue()).day[i][1];
							}
							out.println(
									"<tbody><tr><td>" + m.getKey() + "</td><td>"
											+ df.format((((UpdatedTimesheetWithNameAndDate) m.getValue()).day[0][0]
													+ ((UpdatedTimesheetWithNameAndDate) m.getValue()).day[0][1]))
											+ "</td><td>"
											+ df.format(
													(((UpdatedTimesheetWithNameAndDate) m.getValue()).day[1][0]
															+ ((UpdatedTimesheetWithNameAndDate) m.getValue()).day[1][1]))
											+ "</td><td>"
											+ df.format((((UpdatedTimesheetWithNameAndDate) m.getValue()).day[2][0]
													+ ((UpdatedTimesheetWithNameAndDate) m.getValue()).day[2][1]))
											+ "</td><td>"
											+ df.format(
													(((UpdatedTimesheetWithNameAndDate) m.getValue()).day[3][0]
															+ ((UpdatedTimesheetWithNameAndDate) m.getValue()).day[3][1]))
											+ "</td><td>"
											+ df.format((((UpdatedTimesheetWithNameAndDate) m.getValue()).day[4][0]
													+ ((UpdatedTimesheetWithNameAndDate) m.getValue()).day[4][1]))
											+ "</td><td>"
											+ df.format(
													(((UpdatedTimesheetWithNameAndDate) m.getValue()).day[5][0]
															+ ((UpdatedTimesheetWithNameAndDate) m.getValue()).day[5][1]))
											+ "</td><td>"
											+ df.format((((UpdatedTimesheetWithNameAndDate) m.getValue()).day[6][0]
													+ ((UpdatedTimesheetWithNameAndDate) m.getValue()).day[6][1]))
											+ "</td><td>" + df.format(total) + "</td><td>" + df.format(ot)
											+ "</td></tr></tbody>");
						}
					}
				%>
			</table>
		</div>

</div>
	
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

</body>
</html>


