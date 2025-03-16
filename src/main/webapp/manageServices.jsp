<%@ page language="java" import="java.io.*, java.util.*, model.ServiceRecord, jakarta.servlet.http.*, jakarta.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>Manage Service Records | Car Service Tracker</title>

    <!-- Bootstrap & FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        /* Background */
        body {
            background: url('images/5.jpg') no-repeat center center fixed;
            background-size: cover;
            color: #fff;
        }

        /* Card Styling */
        .services-container {
            background: rgba(0, 0, 0, 0.85);
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
            background: #dc3545;
            color: white;
        }

        .table tbody tr:hover {
            background: #f8d7da;
        }

        /* Delete & Edit Buttons */
        .btn-sm {
            font-size: 14px;
            padding: 5px 10px;
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
        // Search function for service records filtering
        function searchServices() {
            let input = document.getElementById("searchInput").value.toLowerCase();
            let rows = document.querySelectorAll(".service-row");

            rows.forEach(row => {
                let serviceType = row.querySelector(".service-type").innerText.toLowerCase();
                row.style.display = serviceType.includes(input) ? "" : "none";
            });
        }

        // Confirm deletion
        function confirmDelete(vehicleID, serviceDate) {
            return confirm("Are you sure you want to delete the service record for Vehicle ID: " + vehicleID + " on " + serviceDate + "?");
        }
    </script>

</head>
<body class="container mt-5">

    <div class="services-container">
        <h2 class="text-center"><i class="fas fa-tools"></i> Manage Service Records</h2>

        <%
            // Load service records from services.txt
            List<ServiceRecord> records = new ArrayList<>();
            try (BufferedReader reader = new BufferedReader(new FileReader("F:/SLIIT/Y1S2/OOP/Car_Service_and_Maintenance_Tracker-CRUD/services.txt"))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split(",");
                    if (parts.length == 5) {  // Ensure the correct format
                        records.add(new ServiceRecord(parts[0], parts[1], parts[2], Double.parseDouble(parts[3]), Integer.parseInt(parts[4])));
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
            }

            if (records.isEmpty()) {
        %>
            <div class="alert alert-warning text-center mt-3">No service records found.</div>
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
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% for (ServiceRecord record : records) { %>
                <tr class="service-row">
                    <td><%= record.getVehicleID() %></td>
                    <td><%= record.getServiceDateString() %></td>
                    <td class="service-type"><%= record.getServiceType() %></td>
                    <td>Rs. <%= String.format("%.2f", record.getCost()) %></td>
                    <td><%= record.getMileage() %> km</td>
                    <td>
                        <!-- Edit Service Button -->
                        <form action="EditServiceServlet" method="GET" style="display:inline;">
                            <input type="hidden" name="vehicleID" value="<%= record.getVehicleID() %>">
                            <input type="hidden" name="serviceDate" value="<%= record.getServiceDateString() %>">
                            <button type="submit" class="btn btn-warning btn-sm"><i class="fas fa-edit"></i> Edit</button>
                        </form>

                        <!-- Delete Service Button -->
                        <form action="DeleteServiceServlet" method="POST" style="display:inline;" onsubmit="return confirmDelete('<%= record.getVehicleID() %>', '<%= record.getServiceDateString() %>');">
                            <input type="hidden" name="vehicleID" value="<%= record.getVehicleID() %>">
                            <input type="hidden" name="serviceDate" value="<%= record.getServiceDateString() %>">
                            <button type="submit" class="btn btn-danger btn-sm"><i class="fas fa-trash"></i> Delete</button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <% } %>

        <!-- Back to Admin Dashboard Button -->
        <div class="text-center mt-3">
            <a href="adminDashboard.jsp" class="btn btn-info btn-custom"><i class="fas fa-arrow-left"></i> Back to Admin Dashboard</a>
        </div>

    </div>

</body>
</html>
