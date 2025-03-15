<%@ page language="java" import="jakarta.servlet.http.*, jakarta.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>  <!-- Ensures session is enabled -->

<html>
<head>
    <title>User Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <%
        // Get the logged-in username from the session
        HttpSession session1 = request.getSession(false);
        String username = (session1 != null) ? (String) session1.getAttribute("username") : null;
        String role = (session1 != null) ? (String) session1.getAttribute("role") : null;

        // If user is not logged in, redirect to login page
        if (username == null) {
            response.sendRedirect("login.jsp?error=Please login first");
            return;
        }
    %>

    <h2 class="text-center">Welcome, <%= username %>!</h2>

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
                <a href="viewServiceReminders.jsp" class="list-group-item list-group-item-action bg-warning">View Service Reminders</a>
            </div>

            <% if ("admin".equals(role)) { %>
                <hr>
                <h5>Admin Controls</h5>
                <div class="list-group">
                    <a href="manageUsers.jsp" class="list-group-item list-group-item-action">Manage Users</a>
                    <a href="manageServices.jsp" class="list-group-item list-group-item-action">Manage Services</a>
                </div>
            <% } %>
        </div>
    </div>

    <!-- Logout Button -->
    <div class="mt-3">
        <a href="LogoutServlet" class="btn btn-danger">Logout</a>
    </div>

</body>
</html>
