<%@ page language="java" import="java.io.*, java.util.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>Manage Service Reminders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <h2 class="text-center">Manage Service Reminders</h2>

    <%
        HttpSession session1 = request.getSession(false);
        String role = (session1 != null) ? (String) session1.getAttribute("role") : null;

        if (role == null || !role.equals("admin")) {
            response.sendRedirect("index.jsp?error=Unauthorized access");
            return;
        }

        List<String> reminders = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader("/F:/SLIIT/Y1S2/OOP/Car_Service_and_Maintenance_Tracker-CRUD/reminders.txt"))) {
            String line;
            while ((line = reader.readLine()) != null) {
                reminders.add(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    %>

    <% if (reminders.isEmpty()) { %>
        <div class="alert alert-warning">No upcoming service reminders found.</div>
    <% } else { %>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Vehicle ID</th>
                    <th>Next Service Date</th>
                    <th>Next Service Mileage</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% for (String reminder : reminders) {
                    String[] parts = reminder.split(",");
                %>
                <tr>
                    <td><%= parts[0] %></td>
                    <td><%= parts[1].isEmpty() ? "N/A" : parts[1] %></td>
                    <td><%= parts[2].isEmpty() ? "N/A" : parts[2] %></td>
                    <td>
                        <!-- Edit Reminder -->
                        <form action="EditReminderServlet" method="GET" style="display:inline;">
                            <input type="hidden" name="vehicleID" value="<%= parts[0] %>">
                            <button type="submit" class="btn btn-warning btn-sm">Edit</button>
                        </form>

                        <!-- Delete Reminder -->
                        <form action="DeleteReminderServlet" method="POST" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this reminder?');">
                            <input type="hidden" name="vehicleID" value="<%= parts[0] %>">
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
