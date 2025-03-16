<%@ page language="java" import="java.io.*, java.util.*, model.ServiceRecord, jakarta.servlet.http.*, jakarta.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>Your Service Records | Car Service Tracker</title>

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
        .service-container {
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
            background: #17a2b8;
            color: white;
        }

        .table tbody tr:hover {
            background: #b3e5fc;
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
        // Search function for service record filtering
        function searchServices() {
            let input = document.getElementById("searchInput").value.toLowerCase();
            let rows = document.querySelectorAll(".service-row");

            rows.forEach(row => {
                let serviceType = row.querySelector(".service-type").innerText.toLowerCase();
                row.style.display = serviceType.includes(input) ? "" : "none";
            });
        }
    </script>

</head>
<body class="container mt-5">

    <div class="service-container">
        <h2 class="text-center"><i class="fas fa-tools"></i> Your Service Records</h2>

        <%
            HttpSession session2 = request.getSession();
            String loggedInUsername = (String) session2.getAttribute("username");

            if (loggedInUsername == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            // Load user's vehicle IDs
            List<String> userVehicleIDs = new ArrayList<>();
            try (BufferedReader vehicleReader = new BufferedReader(new FileReader("F:/SLIIT/Y1S2/OOP/Car_Service_and_Maintenance_Tracker-CRUD/vehicles.txt"))) {
                String line;
                while ((line = vehicleReader.readLine()) != null) {
                    String[] parts = line.split(",");
                    if (parts.length == 4 && parts[1].equals(loggedInUsername)) { // Compare owner with logged-in user
                        userVehicleIDs.add(parts[0]); // Store vehicle ID
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
            }

            // Load service records only for the user's vehicles
            List<ServiceRecord> userServiceRecords = new ArrayList<>();
            try (BufferedReader serviceReader = new BufferedReader(new FileReader("F:/SLIIT/Y1S2/OOP/Car_Service_and_Maintenance_Tracker-CRUD/services.txt"))) {
                String line;
                while ((line = serviceReader.readLine()) != null) {
                    String[] parts = line.split(",");
                    if (parts.length == 5 && userVehicleIDs.contains(parts[0])) { // Check if service is linked to user's vehicle
                        userServiceRecords.add(new ServiceRecord(parts[0], parts[1], parts[2], Double.parseDouble(parts[3]), Integer.parseInt(parts[4])));
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
            }

            if (userServiceRecords.isEmpty()) {
        %>
            <div class="alert alert-warning text-center mt-3">No service records found for your vehicles.</div>
        <% } else { %>

        <!-- Search Bar -->
        <div class="input-group my-3">
            <input type="text" id="searchInput" onkeyup="searchServices()" class="search-bar" placeholder="Search by Service Type...">
            <div class="input-group-append">
                <span class="input-group-text"><i class="fas fa-search"></i></span>
            </div>
        </div>

        <table class="table table-hover mt-3">
            <thead>
                <tr>
                    <th>Vehicle ID</th>
                    <th>Service Date</th>
                    <th>Service Type</th>
                    <th>Cost</th>
                    <th>Mileage</th>
                </tr>
            </thead>
            <tbody>
                <% for (ServiceRecord record : userServiceRecords) { %>
                <tr class="service-row">
                    <td><%= record.getVehicleID() %></td>
                    <td><%= record.getServiceDateString() %></td>
                    <td class="service-type"><%= record.getServiceType() %></td>
                    <td>Rs. <%= String.format("%.2f", record.getCost()) %></td>
                    <td><%= record.getMileage() %> km</td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <% } %>

        <!-- Back to Dashboard Button -->
        <div class="text-center mt-3">
            <a href="index.jsp" class="btn btn-info btn-custom"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
        </div>

    </div>

</body>
</html>
