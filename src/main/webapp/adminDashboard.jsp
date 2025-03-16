<%@ page language="java" import="jakarta.servlet.http.*, jakarta.servlet.*, java.io.*, java.util.*" %>
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

    // ✅ Custom file paths (SET YOUR DIRECTORY PATH)
    String BASE_PATH = "F:/SLIIT/Y1S2/OOP/Car_Service_and_Maintenance_Tracker-CRUD/";
    String USERS_FILE = BASE_PATH + "users.txt";
    String VEHICLES_FILE = BASE_PATH + "vehicles.txt";
    String SERVICES_FILE = BASE_PATH + "services.txt";
    String REMINDERS_FILE = BASE_PATH + "reminders.txt";

    // Initialize counters
    int totalUsers = 0, totalVehicles = 0, totalServices = 0, totalReminders = 0, completedServices = 0;

    // Read Users Count
    try (BufferedReader reader = new BufferedReader(new FileReader(USERS_FILE))) {
        while (reader.readLine() != null) totalUsers++;
    } catch (IOException e) { e.printStackTrace(); }

    // Read Vehicles Count
    try (BufferedReader reader = new BufferedReader(new FileReader(VEHICLES_FILE))) {
        while (reader.readLine() != null) totalVehicles++;
    } catch (IOException e) { e.printStackTrace(); }

    // Read Services Count & Completed Services
    try (BufferedReader reader = new BufferedReader(new FileReader(SERVICES_FILE))) {
        String line;
        while ((line = reader.readLine()) != null) {
            totalServices++;
            String[] parts = line.split(",");
            if (parts.length > 2 && parts[2].trim().equalsIgnoreCase("completed")) {
                completedServices++;
            }
        }
    } catch (IOException e) { e.printStackTrace(); }

    // Read Reminders Count
    try (BufferedReader reader = new BufferedReader(new FileReader(REMINDERS_FILE))) {
        while (reader.readLine() != null) totalReminders++;
    } catch (IOException e) { e.printStackTrace(); }

    // Calculate service completion rate
    double serviceCompletionRate = (totalServices > 0) ? ((double) completedServices / totalServices * 100) : 0;
%>

<html>
<head>
    <title>Admin Dashboard | Car Service Tracker</title>
    <!-- Bootstrap & FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        /* Background */
        body {
            background: url('images/11.jpg') no-repeat center center fixed;
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

        /* Dashboard Layout */
        .dashboard-container {
            padding-top: 20px;
            text-align: center;
        }

        .dashboard-card {
            background: rgba(0, 0, 0, 0.85);
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.5);
        }

        /* Circular Progress Container */
        .progress-container {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 30px;
            margin-top: 30px;
        }

        /* Individual Progress Circle */
        .progress-circle {
            width: 150px;
            height: 150px;
            position: relative;
        }

        .progress-circle canvas {
            position: absolute;
            top: 0;
            left: 0;
        }

        .progress-text {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            text-align: center;
            color: white;
            font-size: 16px;
            font-weight: bold;
        }

        /* Admin Buttons */
        .admin-btn {
            width: 100%;
            text-align: center;
            font-size: 18px;
            padding: 12px;
            margin: 10px 0;
            font-weight: bold;
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

        <!-- Progress Circles -->
        <div class="progress-container">
            <div class="progress-circle">
                <canvas id="progressService"></canvas>
                <div class="progress-text">Services<br><%= totalServices %></div>
            </div>
            <div class="progress-circle">
                <canvas id="progressUsers"></canvas>
                <div class="progress-text">Users<br><%= totalUsers %></div>
            </div>
            <div class="progress-circle">
                <canvas id="progressVehicles"></canvas>
                <div class="progress-text">Vehicles<br><%= totalVehicles %></div>
            </div>
            <div class="progress-circle">
                <canvas id="progressReminders"></canvas>
                <div class="progress-text">Reminders<br><%= totalReminders %></div>
            </div>
        </div>

        <!-- Admin Control Buttons -->
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
                options: { cutout: '70%' }
            });
        }

        createProgressCircle('progressService', <%= totalServices %>);
        createProgressCircle('progressUsers', <%= totalUsers %>);
        createProgressCircle('progressVehicles', <%= totalVehicles %>);
        createProgressCircle('progressReminders', <%= totalReminders %>);
    </script>

</body>
</html>
