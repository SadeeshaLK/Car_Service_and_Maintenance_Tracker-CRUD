<%@ page language="java" import="jakarta.servlet.http.*, jakarta.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>

<%
    // Ensure only admins can access
    HttpSession session1 = request.getSession(false);
    String username = (session1 != null) ? (String) session1.getAttribute("username") : null;
    String role = (session1 != null) ? (String) session1.getAttribute("role") : null;

    if (username == null || !"admin".equals(role)) {
        response.sendRedirect("login.jsp?error=Unauthorized access");
        return;
    }

    // Dummy Data (Replace with actual values from your database or files)
    int totalUsers = 120;
    int totalVehicles = 85;
    int totalServices = 220;
    int totalReminders = 30;
    int completedServices = 180; // Services marked as completed

    double serviceCompletionRate = (double) completedServices / totalServices * 100;
%>

<html>
<head>
    <title>Admin Dashboard | Car Service Tracker</title>

    <!-- Bootstrap & FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <!-- Chart.js for Progress Circles -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        /* Background */
        body {
            background: url('images/admin-bg.jpg') no-repeat center center fixed;
            background-size: cover;
            color: #fff;
        }

        /* Navbar */
        .navbar-custom {
            background: rgba(0, 0, 0, 0.9);
            padding: 10px;
        }
        .navbar-brand {
            font-size: 24px;
            font-weight: bold;
            color: #ffc107;
        }
        .logout-btn {
            color: #ff4d4d;
            font-size: 18px;
        }
        .logout-btn:hover {
            color: #ff9999;
        }

        /* Admin Dashboard Styling */
        .dashboard-container {
            padding-top: 20px;
            text-align: center;
        }

        .dashboard-card {
            background: rgba(0, 0, 0, 0.85);
            border-radius: 10px;
            padding: 20px;
            width: 100%;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.5);
            animation: fadeIn 1s ease-in-out;
        }

        /* Smooth Fade-in Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Admin Buttons */
        .admin-btn {
            width: 100%;
            text-align: center;
            font-size: 18px;
            padding: 15px;
            margin: 10px 0;
            transition: 0.3s;
        }
        .admin-btn i {
            margin-right: 10px;
        }
        .admin-btn:hover {
            background: #ffc107;
            color: #000;
        }

        /* Progress Circle Container */
        .progress-container {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        /* Progress Circle */
        .progress-circle {
            width: 120px;
            height: 120px;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }

        .progress-circle canvas {
            position: absolute;
            top: 0;
            left: 0;
        }

        .progress-value {
            font-size: 20px;
            font-weight: bold;
            color: white;
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar navbar-dark navbar-custom">
        <div class="container-fluid">
            <a class="navbar-brand"><i class="fas fa-tools"></i> Admin Dashboard</a>
            <a href="LogoutServlet" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </nav>

    <div class="container dashboard-container">
        <h2 class="mb-4">Welcome, Admin <%= username %>!</h2>

        <!-- Dashboard Cards -->
        <div class="row text-center">
            <div class="col-md-3">
                <div class="dashboard-card p-3">
                    <i class="fas fa-users fa-3x text-warning"></i>
                    <h4>Total Users</h4>
                    <h2><%= totalUsers %></h2>
                </div>
            </div>
            <div class="col-md-3">
                <div class="dashboard-card p-3">
                    <i class="fas fa-car fa-3x text-warning"></i>
                    <h4>Total Vehicles</h4>
                    <h2><%= totalVehicles %></h2>
                </div>
            </div>
            <div class="col-md-3">
                <div class="dashboard-card p-3">
                    <i class="fas fa-tools fa-3x text-warning"></i>
                    <h4>Total Services</h4>
                    <h2><%= totalServices %></h2>
                </div>
            </div>
            <div class="col-md-3">
                <div class="dashboard-card p-3">
                    <i class="fas fa-bell fa-3x text-warning"></i>
                    <h4>Pending Reminders</h4>
                    <h2><%= totalReminders %></h2>
                </div>
            </div>
        </div>

        <!-- Progress Circles -->
        <div class="progress-container mt-5">
            <div class="progress-circle">
                <canvas id="progressService"></canvas>
                <div class="progress-value"><%= String.format("%.0f", serviceCompletionRate) %>%</div>
            </div>
            <div class="progress-circle">
                <canvas id="progressUsers"></canvas>
                <div class="progress-value"><%= totalUsers %></div>
            </div>
            <div class="progress-circle">
                <canvas id="progressVehicles"></canvas>
                <div class="progress-value"><%= totalVehicles %></div>
            </div>
        </div>

        <!-- Admin Controls -->
        <div class="row mt-5">
            <div class="col-md-6">
                <a href="manageUsers.jsp" class="btn btn-danger admin-btn"><i class="fas fa-users"></i> Manage Users</a>
            </div>
            <div class="col-md-6">
                <a href="manageServices.jsp" class="btn btn-warning admin-btn"><i class="fas fa-tools"></i> Manage Services</a>
            </div>
            <div class="col-md-6 mt-3">
                <a href="manageVehicles.jsp" class="btn btn-danger admin-btn"><i class="fas fa-car"></i> Manage Vehicles</a>
            </div>
            <div class="col-md-6 mt-3">
                <a href="manageServiceReminders.jsp" class="btn btn-warning admin-btn"><i class="fas fa-bell"></i> Manage Service Reminders</a>
            </div>
        </div>

    </div>

    <!-- JavaScript for Progress Circles -->
    <script>
        function createProgressCircle(id, percentage) {
            const ctx = document.getElementById(id).getContext('2d');
            new Chart(ctx, {
                type: 'doughnut',
                data: {
                    datasets: [{
                        data: [percentage, 100 - percentage],
                        backgroundColor: ['#28a745', '#ddd']
                    }]
                },
                options: { cutout: '75%' }
            });
        }

        createProgressCircle('progressService', <%= serviceCompletionRate %>);
        createProgressCircle('progressUsers', 100);
        createProgressCircle('progressVehicles', 100);
    </script>

</body>
</html>
