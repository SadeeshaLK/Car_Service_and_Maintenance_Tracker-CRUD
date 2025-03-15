<%@ page language="java" import="java.io.*, java.util.*, model.Vehicle" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>View Vehicles</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">

    <h2 class="text-center">Your Vehicles</h2>

    <%
        HttpSession session1 = request.getSession();
        String loggedInUsername = (String) session1.getAttribute("username");

        if (loggedInUsername == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Vehicle> userVehicles = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader("/F:/SLIIT/Y1S2/OOP/Car_Service_and_Maintenance_Tracker-CRUD/vehicles.txt"))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 4 && parts[1].equals(loggedInUsername)) { // Compare owner with logged-in user
                    userVehicles.add(new Vehicle(parts[0], parts[1], parts[2], Integer.parseInt(parts[3])));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        if (userVehicles.isEmpty()) {
    %>
        <div class="alert alert-warning">You have no vehicles registered.</div>
    <% } else { %>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Vehicle ID</th>
                    <th>Model</th>
                    <th>Year</th>
                </tr>
            </thead>
            <tbody>
                <% for (Vehicle vehicle : userVehicles) { %>
                <tr>
                    <td><%= vehicle.getVehicleID() %></td>
                    <td><%= vehicle.getModel() %></td>
                    <td><%= vehicle.getYear() %></td>
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
