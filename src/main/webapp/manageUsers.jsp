<%@ page language="java" import="java.io.*, java.util.*, model.User" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>Manage Users</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <h2 class="text-center">Manage Users</h2>

    <%
        // Read users from users.txt
        List<User> users = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader("/F:/SLIIT/Y1S2/OOP/Car_Service_and_Maintenance_Tracker-CRUD/users.txt"))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 3) { // Ensure correct format
                    users.add(new User(parts[0], parts[1], parts[2])); // username, password, role
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        if (users.isEmpty()) {
    %>
        <div class="alert alert-warning">No users found.</div>
    <% } else { %>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Username</th>
                    <th>Role</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% for (User user : users) { %>
                <tr>
                    <td><%= user.getUsername() %></td>
                    <td><%= user.getRole() %></td>
                    <td>
                        <form action="EditUserServlet" method="GET" style="display:inline;">
                            <input type="hidden" name="username" value="<%= user.getUsername() %>">
                            <button type="submit" class="btn btn-warning btn-sm">Edit</button>
                        </form>

                        <form action="DeleteUserServlet" method="POST" style="display:inline;">
                            <input type="hidden" name="username" value="<%= user.getUsername() %>">
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
