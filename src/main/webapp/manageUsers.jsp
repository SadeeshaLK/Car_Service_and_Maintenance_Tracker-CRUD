<%@ page language="java" import="java.io.*, java.util.*, model.User, jakarta.servlet.http.*, jakarta.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>Manage Users | Car Service Tracker</title>

    <!-- Bootstrap & FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        /* Background */
        body {
            background: url('images/11.jpg') no-repeat center center fixed;
            background-size: cover;
            color: #fff;
        }

        /* Card Styling */
        .users-container {
            background: rgba(0, 0, 0, 0.85);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.5);
        }

        /* Search Bar */
        .search-bar {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        /* Table Styling */
        .table {
            background: #fff;
            color: #000;
            border-radius: 5px;
            overflow: hidden;
        }

        .table thead {
            background: #28a745;
            color: white;
        }

        .table tbody tr:hover {
            background: #d4edda;
        }

        /* Delete & Edit Buttons */
        .btn-sm {
            font-size: 14px;
            padding: 5px 10px;
        }

        /* Buttons */
        .btn-custom {
            font-size: 16px;
            font-weight: bold;
            padding: 10px 20px;
            border-radius: 5px;
        }
    </style>

    <script>
        // Search function for users filtering
        function searchUsers() {
            let input = document.getElementById("searchInput").value.toLowerCase();
            let rows = document.querySelectorAll(".user-row");

            rows.forEach(row => {
                let username = row.querySelector(".user-name").innerText.toLowerCase();
                row.style.display = username.includes(input) ? "" : "none";
            });
        }

        // Confirm deletion
        function confirmDelete(username) {
            return confirm("Are you sure you want to delete the user: " + username + "?");
        }
    </script>

</head>
<body class="container mt-5">

    <div class="users-container">
        <h2 class="text-center"><i class="fas fa-users"></i> Manage Users</h2>

        <%
            // Read users from users.txt
            List<User> users = new ArrayList<>();
            try (BufferedReader reader = new BufferedReader(new FileReader("F:/SLIIT/Y1S2/OOP/Car_Service_and_Maintenance_Tracker-CRUD/users.txt"))) {
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
            <div class="alert alert-warning text-center mt-3">No users found.</div>
        <% } else { %>

        <!-- Search Bar -->
        <div class="input-group my-3">
            <input type="text" id="searchInput" onkeyup="searchUsers()" class="search-bar" placeholder="Search by Username...">
            <div class="input-group-append">
                <span class="input-group-text"><i class="fas fa-search"></i></span>
            </div>
        </div>

        <table class="table table-hover mt-3">
            <thead>
                <tr>
                    <th>Username</th>
                    <th>Role</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% for (User user : users) { %>
                <tr class="user-row">
                    <td class="user-name"><%= user.getUsername() %></td>
                    <td><%= user.getRole() %></td>
                    <td>
                        <form action="EditUserServlet" method="GET" style="display:inline;">
                            <input type="hidden" name="username" value="<%= user.getUsername() %>">
                            <button type="submit" class="btn btn-warning btn-sm"><i class="fas fa-edit"></i> Edit</button>
                        </form>

                        <form action="DeleteUserServlet" method="POST" style="display:inline;" onsubmit="return confirmDelete('<%= user.getUsername() %>');">
                            <input type="hidden" name="username" value="<%= user.getUsername() %>">
                            <button type="submit" class="btn btn-danger btn-sm"><i class="fas fa-trash"></i> Delete</button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <% } %>

        <!-- Back to Admin Dashboard Button -->
        <div class="text-center mt-3">
            <a href="adminDashboard.jsp" class="btn btn-info btn-custom"><i class="fas fa-arrow-left"></i> Back to Admin Dashboard</a>
        </div>

    </div>

</body>
</html>
