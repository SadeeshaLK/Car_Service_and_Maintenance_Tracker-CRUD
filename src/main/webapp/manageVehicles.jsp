<%@ page language="java" import="java.io.*, java.util.*, model.Vehicle, jakarta.servlet.http.*, jakarta.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>Manage Vehicles</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">

    <h2 class="text-center">Manage Vehicles</h2>

    <%
        HttpSession session1 = request.getSession(false);
        String role = (session1 != null) ? (String) session1.getAttribute("role") : null;

        if (role == null || !role.equals("admin")) {
            response.sendRedirect("index.jsp?error=Unauthorized access");
            return;
        }

        List<Vehicle> vehicles = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader("/F:/SLIIT/Y1S2/OOP/Car_Service_and_Maintenance_Tracker-CRUD/vehicles.txt"))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 4) {
                    vehicles.add(new Vehicle(parts[0], parts[1], parts[2], Integer.parseInt(parts[3])));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    %>

    <% if (vehicles.isEmpty()) { %>
        <div class="alert alert-warning">No vehicles found.</div>
    <% } else { %>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Vehicle ID</th>
                    <th>Owner</th>
                    <th>Model</th>
                    <th>Year</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% for (Vehicle vehicle : vehicles) { %>
                <tr>
                    <td><%= vehicle.getVehicleID() %></td>
                    <td><%= vehicle.getOwner() %></td>
                    <td><%= vehicle.getModel() %></td>
                    <td><%= vehicle.getYear() %></td>
                    <td>
                        <!-- Edit Vehicle -->
                        <form action="EditVehicleServlet" method="GET" style="display:inline;">
                            <input type="hidden" name="vehicleID" value="<%= vehicle.getVehicleID() %>">
                            <button type="submit" class="btn btn-warning btn-sm">Edit</button>
                        </form>

                        <!-- Delete Vehicle -->
                        <form action="DeleteVehicleServlet" method="POST" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this vehicle?');">
                            <input type="hidden" name="vehicleID" value="<%= vehicle.getVehicleID() %>">
                            <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>

    <div class="mt-3">
        <a href="adminDashboard.jsp" class="btn btn-secondary">Back to Admin Dashboard</a>
    </div>

</body>
</html>
