<%@ page language="java" import="java.io.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>Edit Service Reminder</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <h2>Edit Service Reminder</h2>

    <% String reminderToEdit = (String) request.getAttribute("reminderToEdit");
       String[] parts = reminderToEdit.split(",");
    %>

    <form action="UpdateReminderServlet" method="POST">
        <input type="hidden" name="vehicleID" value="<%= parts[0] %>">

        <label>Next Service Date:</label>
        <input type="date" class="form-control" name="nextServiceDate" value="<%= parts[1].equals("N/A") ? "" : parts[1] %>">

        <label>Next Service Mileage:</label>
        <input type="number" class="form-control" name="nextServiceMileage" value="<%= parts[2].equals("N/A") ? "" : parts[2] %>">

        <button type="submit" class="btn btn-primary mt-3">Update Reminder</button>
    </form>

    <div class="mt-3">
        <a href="manageServiceReminders.jsp" class="btn btn-secondary">Back to Manage Service Reminders</a>
    </div>
</body>
</html>
