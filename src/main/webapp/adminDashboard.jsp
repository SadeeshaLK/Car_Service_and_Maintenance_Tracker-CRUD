<%@ page language="java" import="model.User" %>
<html>
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <h2 class="text-center">Admin Dashboard</h2>
    <div class="text-center mt-4">
        <a href="manageUsers.jsp" class="btn btn-danger">Manage Users</a>
        <a href="manageServices.jsp" class="btn btn-warning">Manage Services</a>
        <a href="LogoutServlet" class="btn btn-secondary">Logout</a>
    </div>
</body>
</html>
