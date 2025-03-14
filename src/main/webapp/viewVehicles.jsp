<%@ page language="java" import="java.util.*, model.Vehicle" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.FileReader" %>
<html>
<head>
    <title>View Vehicles</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <h2 class="text-center">Vehicles</h2>

    <%
        // Load vehicles from vehicles.txt file
        BufferedReader reader = new BufferedReader(new FileReader("/F:/SLIIT/Y1S2/OOP/Car_Service_and_Maintenance_Tracker-CRUD/vehicles.txt"));
        List<Vehicle> vehicles = new ArrayList<>();
        String line;
        while ((line = reader.readLine()) != null) {
            String[] parts = line.split(",");
            vehicles.add(new Vehicle(parts[0], parts[1], parts[2], Integer.parseInt(parts[3])));
        }
        reader.close();

        if (vehicles.isEmpty()) {
    %>
        <div class="alert alert-warning">
            No vehicles found.
        </div>
    <%
        } else {
            for (Vehicle vehicle : vehicles) {
    %>
    <div class="card mt-3">
        <div class="card-body">
            <p><strong>Vehicle ID:</strong> <%= vehicle.getVehicleID() %></p>
            <p><strong>Owner:</strong> <%= vehicle.getOwner() %></p>
            <p><strong>Model:</strong> <%= vehicle.getModel() %></p>
            <p><strong>Year:</strong> <%= vehicle.getYear() %></p>
        </div>
    </div>
    <%
            }
        }
    %>

    <div class="mt-3">
        <a href="addVehicle.jsp" class="btn btn-primary">Add New Vehicle</a>
        <a href="index.jsp" class="btn btn-secondary">Back</a>
    </div>

</body>
</html>
