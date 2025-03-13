<%@ page language="java" %>
<html>
<head>
    <title>Add Vehicle</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <h2 class="text-center">Add Vehicle</h2>
    <form action="VehicleServlet" method="POST" class="w-50 mx-auto mt-3">
        <div class="mb-3">
            <label class="form-label">Vehicle ID:</label>
            <input type="text" class="form-control" name="vehicleID" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Owner:</label>
            <input type="text" class="form-control" name="owner" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Model:</label>
            <input type="text" class="form-control" name="model" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Year:</label>
            <input type="number" class="form-control" name="year" required>
        </div>
        <button type="submit" class="btn btn-success">Add Vehicle</button>
    </form>
    <p class="text-center mt-3"><a href="viewVehicles.jsp">View Vehicles</a></p>
</body>
</html>