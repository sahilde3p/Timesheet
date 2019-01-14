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
	response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "0");
	if (session.getAttribute("adminAuth") == null) {
		response.sendRedirect("login.jsp");
	}
%>

<meta charset="ISO-8859-1">
<title>Welcome</title>
</head>
<body>




<header>
    <h1 class="display-3 text-center my-4"> ${adminAuth}</h1>
    <div class="container">
      <div class="row">
        <div class="col-md-4 mb-2">
          <div class="dropdown">
            <a href="${pageContext.request.contextPath}/authorize.jsp" class="btn btn-primary btn-block" >
              Grant privileges
            </a>
            
          </div>
        </div>
        <div class="col-md-4 mb-2">
          <div class="dropdown">
            <a href="${pageContext.request.contextPath}/addCompanies.jsp" class="btn btn-success btn-block">
              Add Companies
            </a>
          
          </div>
        </div>
        <div class="col-md-4 mb-2">
          <div class="dropdown">
            <button class="btn btn-warning btn-block dropdown-toggle" type="button" data-toggle="dropdown">
              Get Timesheets
            </button>
            <div class="dropdown-menu">
              <a class="dropdown-item" href="${pageContext.request.contextPath}/getTimesheet.jsp">Get Timesheet by Company</a>
              <a class="dropdown-item" href="${pageContext.request.contextPath}/getInfo.jsp">Get Timesheet by Employee</a>
              </div>
          </div>
        </div>
       
      </div>
    </div>
    <hr>
  </header>
  
  
	<div class="container">
		

		<form action="signout" method="post">
			<input type="hidden" name="logout" value="adminAuth" /> <input
				type="submit" class="btn btn-primary" value="Signout" />
		</form>
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