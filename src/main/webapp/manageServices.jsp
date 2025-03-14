<%@ page language="java" import="java.util.*, model.ServiceRecord" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.FileReader" %>

<html>
<head>
    <title>Manage Service Records</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <h2 class="text-center">Manage Service Records</h2>

    <%
        // Load service records from services.txt file
        BufferedReader reader = new BufferedReader(new FileReader("/F:/SLIIT/Y1S2/OOP/Car_Service_and_Maintenance_Tracker-CRUD/services.txt"));
        List<ServiceRecord> records = new ArrayList<>();
        String line;
        while ((line = reader.readLine()) != null) {
            String[] parts = line.split(",");
            records.add(new ServiceRecord(parts[0], parts[1], parts[2], Double.parseDouble(parts[3]), Integer.parseInt(parts[4])));
        }
        reader.close();

        if (records.isEmpty()) {
    %>
        <div class="alert alert-warning">
            No service records found.
        </div>
    <%
        } else {
            for (ServiceRecord record : records) {
    %>
    <div class="card mt-3">
        <div class="card-body">
            <p><strong>Vehicle ID:</strong> <%= record.getVehicleID() %></p>
            <p><strong>Service Date:</strong> <%= record.getServiceDateString() %></p>
            <p><strong>Service Type:</strong> <%= record.getServiceType() %></p>
            <p><strong>Cost:</strong> <%= record.getCost() %></p>
            <p><strong>Mileage:</strong> <%= record.getMileage() %></p>
        </div>
    </div>
    <%
            }
        }
    %>

    <div class="mt-3">
        <a href="adminDashboard.jsp" class="btn btn-secondary">Back to Admin Dashboard</a>
    </div>

</body>
</html>
