<%@ page language="java" import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>  <!-- Ensures that we can use session data -->

<html>
<head>
    <title>User Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <%
        // Check if the user is logged in
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp?error=Please login first");
            return;
        }
    %>

    <h2 class="text-center">Welcome, <%= user.getUsername() %>!</h2>

    <div class="card mt-4">
        <div class="card-header">
            User Dashboard
        </div>
        <div class="card-body">
            <p>Welcome to your dashboard. Here you can manage your vehicle and service records.</p>

            <div class="list-group">
                <!-- Links to manage services and vehicles -->
                <a href="addVehicle.jsp" class="list-group-item list-group-item-action">Add a new Vehicle</a>
                <a href="viewVehicles.jsp" class="list-group-item list-group-item-action">View Your Vehicles</a>
                <a href="addService.jsp" class="list-group-item list-group-item-action">Add a new Service Record</a>
                <a href="viewService.jsp" class="list-group-item list-group-item-action">View Service Records</a>
            </div>
        </div>
    </div>

    <!-- Logout Button -->
    <div class="mt-3">
        <a href="LogoutServlet" class="btn btn-danger">Logout</a>
    </div>

</body>
</html>
