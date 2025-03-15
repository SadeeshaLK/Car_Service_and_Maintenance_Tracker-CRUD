<%@ page language="java" import="java.io.*, java.util.*, model.ServiceRecord" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>Manage Service Records</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <h2 class="text-center">Manage Service Records</h2>

    <%
        // Load service records from services.txt
        List<ServiceRecord> records = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader("/F:/SLIIT/Y1S2/OOP/Car_Service_and_Maintenance_Tracker-CRUD/services.txt"))) {
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
        <div class="alert alert-warning">No service records found.</div>
    <% } else { %>
        <table class="table table-striped">
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
                <tr>
                    <td><%= record.getVehicleID() %></td>
                    <td><%= record.getServiceDateString() %></td>
                    <td><%= record.getServiceType() %></td>
                    <td><%= record.getCost() %></td>
                    <td><%= record.getMileage() %></td>
                    <td>
                        <!-- Edit Service Button -->
                        <form action="EditServiceServlet" method="GET" style="display:inline;">
                            <input type="hidden" name="vehicleID" value="<%= record.getVehicleID() %>">
                            <input type="hidden" name="serviceDate" value="<%= record.getServiceDateString() %>">
                            <button type="submit" class="btn btn-warning btn-sm">Edit</button>
                        </form>

                        <!-- Delete Service Button -->
                        <form action="DeleteServiceServlet" method="POST" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this service record?');">
                            <input type="hidden" name="vehicleID" value="<%= record.getVehicleID() %>">
                            <input type="hidden" name="serviceDate" value="<%= record.getServiceDateString() %>">
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
