<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
    <%@ page import="ca.anygroup.database.DatabaseHandler" %>
    <%@ page import="java.util.ArrayList,ca.anygroup.beans.User" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.table-wrapper-scroll-y {
display: block;
max-height: 200px;
overflow-y: auto;
-ms-overflow-style: -ms-autohiding-scrollbar;
}
</style>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
	
	
<%if(session.getAttribute("adminAuth")==null){
	response.sendRedirect("/TimeSheetManagement/login.jsp");
	}%>
<meta charset="ISO-8859-1">

<title>Access Privileges</title>
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


<%if(request.getAttribute("msg")!=null) {%>
 <div class="alert alert-info alert-dismissible">
            <button class="close" type="button" data-dismiss="alert">
                <span>&times;</span>
            </button>
            <strong>Info: </strong>${msg}
        </div>
        <%} %>
<br>
<div class="table-wrapper-scroll-y">
<div class="h5">Unauthorised Users</div>

<table class="table table-hover table-sm">
<thead>

<tr><th>Name</th><th>Company</th><th>Access Permission</th><th>Other Actions</th></tr>
</thead>
<tbody>
<% ArrayList<User> list = new DatabaseHandler().getUnauthorisedUsers();
	for(User u : list){
		out.println("<tr><td>"+u.getName()+"</td><td>"+u.getCompany()+"</td><td><a href='"+application.getContextPath()+"/addAuth/"+u.getEmail()+"/'>Authorize</a></td><td><a href='/deleteUser/"+u.getEmail()+"/'>Delete</a></td></tr>");
	}
%>

</tbody>

</table>
</div>
<br>
<hr>
<br>
<div class="h5">Authorised Users</div>
<div class="table-wrapper-scroll-y">
<table class="table table-hover table-sm">
<thead>

<tr><th>Name</th><th>Company</th><th>Access Permission</th></tr>
</thead>
<tbody>
<% ArrayList<User> list2 = new DatabaseHandler().getAuthorisedUsers();
	for(User u : list2){
		out.println("<tr><td>"+u.getName()+"</td><td>"+u.getCompany()+"</td><td><a href='"+application.getContextPath()+"/revokeAuth/"+u.getEmail()+"/'>Unauthorize</a></td></tr>");
	}
%>

</tbody>
</table>
</div>
</div>
<br>
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