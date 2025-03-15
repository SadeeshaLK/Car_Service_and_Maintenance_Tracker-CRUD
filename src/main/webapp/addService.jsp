<%@ page language="java" import="java.io.*, java.util.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>Add Service Record</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <h2>Add Service Record</h2>

    <form action="AddServiceServlet" method="POST">
        <label>Vehicle ID:</label>
        <input type="text" class="form-control" name="vehicleID" required>

        <label>Service Date:</label>
        <input type="date" class="form-control" name="serviceDate" required>

        <label>Service Type:</label>
        <select class="form-control" name="serviceType" required>
            <option value="" disabled selected>Select Service Type</option>
            <option value="Oil Change">Oil Change</option>
            <option value="Brake Inspection">Brake Inspection</option>
            <option value="Tire Replacement">Tire Replacement</option>
            <option value="Battery Replacement">Battery Replacement</option>
            <option value="Engine Tune-Up">Engine Tune-Up</option>
            <option value="Wheel Alignment">Wheel Alignment</option>
            <option value="AC Repair">AC Repair</option>
            <option value="General Checkup">General Checkup</option>
            <option value="Other">Other</option>
        </select>

        <label>Cost:</label>
        <input type="number" step="0.01" class="form-control" name="cost" required>

        <label>Mileage:</label>
        <input type="number" class="form-control" name="mileage" required>

        <hr>
        <h5>Set a Service Reminder</h5>

        <label>Next Service Date (Optional):</label>
        <input type="date" class="form-control" name="nextServiceDate">

        <label>Next Service Mileage (Optional):</label>
        <input type="number" class="form-control" name="nextServiceMileage">

        <button type="submit" class="btn btn-primary mt-3">Add Service</button>
    </form>

    <div class="mt-3">
        <a href="index.jsp" class="btn btn-secondary">Back to Dashboard</a>
    </div>
</body>
</html>
