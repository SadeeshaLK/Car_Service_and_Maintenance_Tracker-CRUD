<%@ page language="java" import="java.io.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>Edit Reminder</title>
</head>
<body>
    <h2>Edit Service Reminder</h2>

    <% String reminderToEdit = (String) request.getAttribute("reminderToEdit");
       String[] parts = reminderToEdit.split(",");
    %>

    <form action="UpdateReminderServlet" method="POST">
        <input type="hidden" name="vehicleID" value="<%= parts[0] %>">

        <label>Next Service Date:</label>
        <input type="date" name="nextServiceDate" value="<%= parts[1] %>">

        <label>Next Service Mileage:</label>
        <input type="number" name="nextServiceMileage" value="<%= parts[2] %>">

        <button type="submit">Update</button>
    </form>

    <a href="manageServiceReminders.jsp">Back</a>
</body>
</html>
