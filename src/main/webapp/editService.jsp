<%@ page language="java" import="model.ServiceRecord" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>Edit Service Record</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <h2>Edit Service Record</h2>

    <% ServiceRecord recordToEdit = (ServiceRecord) request.getAttribute("recordToEdit"); %>

    <form action="UpdateServiceServlet" method="POST">
        <input type="hidden" name="vehicleID" value="<%= recordToEdit.getVehicleID() %>">
        <input type="hidden" name="oldServiceDate" value="<%= recordToEdit.getServiceDateString() %>">

        <label>Service Date:</label>
        <input type="date" name="serviceDate" value="<%= recordToEdit.getServiceDateString() %>" class="form-control">

        <label>Service Type:</label>
        <input type="text" name="serviceType" value="<%= recordToEdit.getServiceType() %>" class="form-control">

        <label>Cost:</label>
        <input type="number" name="cost" value="<%= recordToEdit.getCost() %>" class="form-control">

        <label>Mileage:</label>
        <input type="number" name="mileage" value="<%= recordToEdit.getMileage() %>" class="form-control">

        <button type="submit" class="btn btn-primary mt-3">Update</button>
    </form>
</body>
</html>
