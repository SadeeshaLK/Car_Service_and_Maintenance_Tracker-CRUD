<%@ page language="java" import="java.io.*, java.util.*, model.Vehicle" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>View Vehicles | Car Service Tracker</title>

    <!-- Bootstrap & FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        /* Background */
        body {
            background: url('images/6.jpg') no-repeat center center fixed;
            background-size: cover;
            color: #fff;
        }

        /* Card Styling */
        .vehicles-container {
            background: rgba(0, 0, 0, 0.8);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.5);
        }

        /* Search Bar */
        .search-bar {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        /* Table Styling */
        .table {
            background: #fff;
            color: #000;
            border-radius: 5px;
            overflow: hidden;
        }

        .table thead {
            background: #ffc107;
            color: black;
        }

        .table tbody tr:hover {
            background: #ffeb99;
        }

        /* Buttons */
        .btn-custom {
            font-size: 16px;
            font-weight: bold;
            padding: 10px 20px;
            border-radius: 5px;
        }
    </style>

    <script>
        // Search function for vehicle filtering
        function searchVehicles() {
            let input = document.getElementById("searchInput").value.toLowerCase();
            let rows = document.querySelectorAll(".vehicle-row");

            rows.forEach(row => {
                let model = row.querySelector(".vehicle-model").innerText.toLowerCase();
                row.style.display = model.includes(input) ? "" : "none";
            });
        }
    </script>

</head>
<body class="container mt-5">

    <div class="vehicles-container">
        <h2 class="text-center"><i class="fas fa-car"></i> Your Vehicles</h2>

        <%
            HttpSession session1 = request.getSession();
            String loggedInUsername = (String) session1.getAttribute("username");

            if (loggedInUsername == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            List<Vehicle> userVehicles = new ArrayList<>();
            try (BufferedReader reader = new BufferedReader(new FileReader("F:/SLIIT/Y1S2/OOP/Car_Service_and_Maintenance_Tracker-CRUD/vehicles.txt"))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split(",");
                    if (parts.length == 4 && parts[1].equals(loggedInUsername)) { // Compare owner with logged-in user
                        userVehicles.add(new Vehicle(parts[0], parts[1], parts[2], Integer.parseInt(parts[3])));
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
            }

            if (userVehicles.isEmpty()) {
        %>
            <div class="alert alert-warning text-center mt-3">You have no vehicles registered.</div>
        <% } else { %>

        <!-- Search Bar -->
        <div class="input-group my-3">
            <input type="text" id="searchInput" onkeyup="searchVehicles()" class="search-bar" placeholder="Search by Model...">
            <div class="input-group-append">
                <span class="input-group-text"><i class="fas fa-search"></i></span>
            </div>
        </div>

        <table class="table table-hover mt-3">
            <thead>
                <tr>
                    <th>Vehicle ID</th>
                    <th>Model</th>
                    <th>Year</th>
                </tr>
            </thead>
            <tbody>
                <% for (Vehicle vehicle : userVehicles) { %>
                <tr class="vehicle-row">
                    <td><%= vehicle.getVehicleID() %></td>
                    <td class="vehicle-model"><%= vehicle.getModel() %></td>
                    <td><%= vehicle.getYear() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <% } %>

        <!-- Back to Dashboard Button -->
        <div class="text-center mt-3">
            <a href="index.jsp" class="btn btn-warning btn-custom"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
        </div>

    </div>

</body>
</html>
