<%@ page language="java" import="jakarta.servlet.http.*, jakarta.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>

<%
    // Get session attributes
    HttpSession session1 = request.getSession(false);
    String username = (session1 != null) ? (String) session1.getAttribute("username") : null;
    String role = (session1 != null) ? (String) session1.getAttribute("role") : null;

    // If user is not logged in, redirect to login page
    if (username == null) {
        response.sendRedirect("login.jsp?error=Please login first");
        return;
    }
%>

<html>
<head>
    <title>User Dashboard | Car Service Tracker</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        body {
            background: url('images/11.jpg') no-repeat center center fixed;
            background-size: cover;
            background-color: #1e77e1;
            color: #ffffff;
        }
        .dashboard-container {
            margin-top: 50px;
        }
        .dashboard-card {
            background: #1e1e1e;
            border-radius: 10px;
            padding: 20px;
            transition: transform 0.3s ease-in-out;
        }
        .dashboard-card:hover {
            transform: scale(1.05);
        }
        .btn-custom {
            width: 100%;
            text-align: left;
            font-size: 18px;
            transition: 0.3s;
        }
        .btn-custom:hover {
            background: #1e77e1;
            color: #000;
        }
        .navbar-custom {
            background: #222;
            padding: 10px;
        }
        .navbar-brand {
            font-size: 24px;
            font-weight: bold;
            color: #1e77e1;
        }
        .logout-btn {
            color: #ff4d4d;
            font-size: 18px;
        }
        .logout-btn:hover {
            color: #ff9999;
        }
    </style>

</head>
<body>

    <!-- Navbar -->
    <nav class="navbar navbar-dark navbar-custom">
        <div class="container-fluid">
            <a class="navbar-brand" href="#"><i class="fas fa-car"></i> Car Service Tracker</a>
            <a href="LogoutServlet" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </nav>

    <div class="container dashboard-container">
        <div class="row">
            <div class="col-md-3">
                <!-- Sidebar -->
                <div class="list-group">
                    <h5 class="text-center mb-3">Welcome, <%= username %>!</h5>
                    <a href="addVehicle.jsp" class="list-group-item list-group-item-action btn-custom"><i class="fas fa-plus-circle"></i> Add Vehicle</a>
                    <a href="viewVehicles.jsp" class="list-group-item list-group-item-action btn-custom"><i class="fas fa-car"></i> View Vehicles</a>
                    <a href="addService.jsp" class="list-group-item list-group-item-action btn-custom"><i class="fas fa-wrench"></i> Add Service</a>
                    <a href="viewService.jsp" class="list-group-item list-group-item-action btn-custom"><i class="fas fa-list"></i> View Service Records</a>
                    <a href="viewServiceReminders.jsp" class="list-group-item list-group-item-action btn-custom bg-primary text-dark"><i class="fas fa-bell"></i> Service Reminders</a>

                    <% if ("admin".equals(role)) { %>
                        <hr class="text-light">
                        <h5 class="text-center">Admin Controls</h5>
                        <a href="manageUsers.jsp" class="list-group-item list-group-item-action btn-custom"><i class="fas fa-users"></i> Manage Users</a>
                        <a href="manageServices.jsp" class="list-group-item list-group-item-action btn-custom"><i class="fas fa-tools"></i> Manage Services</a>
                        <a href="manageServiceReminders.jsp" class="list-group-item list-group-item-action btn-custom"><i class="fas fa-tasks"></i> Manage Reminders</a>
                    <% } %>
                </div>
            </div>

            <div class="col-md-9">
                <!-- Dashboard Content -->
                <div class="row">
                    <div class="col-md-4">
                        <div class="dashboard-card text-center p-3">
                            <i class="fas fa-car fa-3x text-primary"></i>
                            <h4>Vehicles</h4>
                            <p>Manage your registered vehicles.</p>
                            <a href="viewVehicles.jsp" class="btn btn-primary">View Vehicles</a>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="dashboard-card text-center p-3">
                            <i class="fas fa-tools fa-3x text-warning"></i>
                            <h4>Services</h4>
                            <p>Track all service records.</p>
                            <a href="viewService.jsp" class="btn btn-warning">View Services</a>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="dashboard-card text-center p-3">
                            <i class="fas fa-bell fa-3x text-danger"></i>
                            <h4>Reminders</h4>
                            <p>Upcoming service alerts.</p>
                            <a href="viewServiceReminders.jsp" class="btn btn-danger">View Reminders</a>
                        </div>
                    </div>
                </div>

                <div class="row mt-4">
                    <div class="col-md-12">
                        <div class="dashboard-card text-center p-4">
                            <h3>Keep Your Vehicle in Top Shape!</h3>
                            <p>Stay on top of maintenance with automated service tracking and reminders.</p>
                            <a href="addService.jsp" class="btn btn-outline-warning"><i class="fas fa-plus"></i> Add a Service Record</a>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- Bootstrap & FontAwesome JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
