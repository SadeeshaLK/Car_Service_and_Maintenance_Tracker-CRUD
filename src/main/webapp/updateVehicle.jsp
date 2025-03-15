<%@ page language="java" import="model.Vehicle" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>Edit Vehicle</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <h2>Edit Vehicle</h2>

    <% Vehicle vehicleToEdit = (Vehicle) request.getAttribute("vehicleToEdit"); %>

    <form action="UpdateVehicleServlet" method="POST">
        <input type="hidden" name="vehicleID" value="<%= vehicleToEdit.getVehicleID() %>">

        <label>Owner:</label>
        <input type="text" class="form-control" name="owner" value="<%= vehicleToEdit.getOwner() %>">

        <label>Model:</label>
        <input type="text" class="form-control" name="model" value="<%= vehicleToEdit.getModel() %>">

        <label>Year:</label>
        <input type="number" class="form-control" name="year" value="<%= vehicleToEdit.getYear() %>">

        <button type="submit" class="btn btn-primary mt-3">Update</button>
    </form>

    <div class="mt-3">
        <a href="manageVehicles.jsp" class="btn btn-secondary">Back to Manage Vehicles</a>
    </div>
</body>
</html>
