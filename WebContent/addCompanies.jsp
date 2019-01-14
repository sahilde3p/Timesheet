<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">

<%
	if (session.getAttribute("adminAuth") == null) {
		response.sendRedirect("login.jsp");
	}
%>

<meta charset="ISO-8859-1">
<title>Add Company</title>
</head>
<body>

<div class="container">
	<div class="row">
	<div class="col-lg-1 mt-3">
	<a class="btn btn-outline-primary mb-3" href="${pageContext.request.contextPath}/adminUser.jsp">Home</a></div>
	<form class="col-lg-1 mt-3" action="${pageContext.request.contextPath}/signout" method="post">
					<input type="hidden" name="logout" value="authorisedAuth" /> <input
						type="submit" class="btn btn-outline-primary mb-3" value="Signout" />
				</form>
				
			</div>
	<br>
	
	<div class="display-4 text-center">Add Company</div>
	<br><hr>
	<br>
	<form class="form-group" action="registerCompany" method="post">

		
				<label for="companyName">Company Name</label>
				<input class="form-control mb-3 col-sm-6" type="text" name="companyName" required>
				
				<input type="submit" class="btn btn-primary" value="Submit">

	</form>
	${msg}
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