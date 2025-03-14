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
        // Load users from users.txt file
        BufferedReader reader = new BufferedReader(new FileReader("users.txt"));
        List<User> users = new ArrayList<>();
        String line;
        while ((line = reader.readLine()) != null) {
            String[] parts = line.split(",");
            users.add(new User(parts[0], parts[1], parts[2]));  // Assuming User has a constructor with username, password, and role
        }
        reader.close();

        if (users.isEmpty()) {
    %>
        <div class="alert alert-warning">
            No users found.
        </div>
    <%
        } else {
            for (User user : users) {
    %>
    <div class="card mt-3">
        <div class="card-body">
            <p><strong>Username:</strong> <%= user.getUsername() %></p>
            <p><strong>Role:</strong> <%= user.getRole() %></p>

            <!-- Edit and Delete buttons -->
            <form action="EditUserServlet" method="GET" style="display:inline;">
                <input type="hidden" name="username" value="<%= user.getUsername() %>">
                <button type="submit" class="btn btn-warning btn-sm">Edit</button>
            </form>

            <form action="DeleteUserServlet" method="POST" style="display:inline;">
                <input type="hidden" name="username" value="<%= user.getUsername() %>">
                <button type="submit" class="btn btn-danger btn-sm">Delete</button>
            </form>
        </div>
    </div>
    <%
            }
        }
    %>

    <div class="mt-3">
        <a href="adminDashboard.jsp" class="btn btn-secondary">Back to Admin Dashboard</a>
    </div>

</body>
</html>
