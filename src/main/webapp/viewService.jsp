<%@ page language="java" import="java.io.*, java.util.*, model.ServiceRecord" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>Your Service Records</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">

    <h2 class="text-center">Your Service Records</h2>

    <%
        HttpSession session2 = request.getSession();
        String loggedInUsername = (String) session2.getAttribute("username");

        if (loggedInUsername == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Load user's vehicle IDs
        List<String> userVehicleIDs = new ArrayList<>();
        try (BufferedReader vehicleReader = new BufferedReader(new FileReader("/F:/SLIIT/Y1S2/OOP/Car_Service_and_Maintenance_Tracker-CRUD/vehicles.txt"))) {
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
        try (BufferedReader serviceReader = new BufferedReader(new FileReader("/F:/SLIIT/Y1S2/OOP/Car_Service_and_Maintenance_Tracker-CRUD/services.txt"))) {
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
        <div class="alert alert-warning">No service records found for your vehicles.</div>
    <% } else { %>
        <table class="table table-striped">
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
                <tr>
                    <td><%= record.getVehicleID() %></td>
                    <td><%= record.getServiceDateString() %></td>
                    <td><%= record.getServiceType() %></td>
                    <td><%= record.getCost() %></td>
                    <td><%= record.getMileage() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>

    <div class="mt-3">
        <a href="index.jsp" class="btn btn-secondary">Back to Dashboard</a>
    </div>

</body>
</html>
