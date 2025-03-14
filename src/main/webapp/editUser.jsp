<%@ page language="java" import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>Edit User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <h2>Edit User</h2>

    <%
        User userToEdit = (User) request.getAttribute("userToEdit");
        if (userToEdit != null) {
    %>
    <form action="UpdateUserServlet" method="POST">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" class="form-control" id="username" name="username" value="<%= userToEdit.getUsername() %>" readonly>
        </div>
        <div class="form-group">
            <label for="role">Role</label>
            <input type="text" class="form-control" id="role" name="role" value="<%= userToEdit.getRole() %>">
        </div>
        <button type="submit" class="btn btn-primary mt-3">Update</button>
    </form>
    <% } else { %>
        <p>User not found!</p>
    <% } %>

</body>
</html>
