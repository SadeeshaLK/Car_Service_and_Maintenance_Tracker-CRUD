<%@ page language="java" import="java.io.*, java.util.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>Manage Service Reminders | Car Service Tracker</title>

    <!-- Bootstrap & FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        /* Background */
        body {
            background: url('images/5.jpg') no-repeat center center fixed;
            background-size: cover;
            color: #fff;
        }

        /* Card Styling */
        .reminders-container {
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
            background: #17a2b8;
            color: white;
        }

        .table tbody tr:hover {
            background: #d1ecf1;
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
        // Search function for reminders filtering
        function searchReminders() {
            let input = document.getElementById("searchInput").value.toLowerCase();
            let rows = document.querySelectorAll(".reminder-row");

            rows.forEach(row => {
                let vehicleID = row.querySelector(".reminder-vehicle").innerText.toLowerCase();
                row.style.display = vehicleID.includes(input) ? "" : "none";
            });
        }

        // Confirm deletion
        function confirmDelete(vehicleID) {
            return confirm("Are you sure you want to delete the service reminder for Vehicle ID: " + vehicleID + "?");
        }
    </script>

</head>
<body class="container mt-5">

    <div class="reminders-container">
        <h2 class="text-center"><i class="fas fa-bell"></i> Manage Service Reminders</h2>

        <%
            HttpSession session1 = request.getSession(false);
            String role = (session1 != null) ? (String) session1.getAttribute("role") : null;

            if (role == null || !role.equals("admin")) {
                response.sendRedirect("index.jsp?error=Unauthorized access");
                return;
            }

            List<String> reminders = new ArrayList<>();
            try (BufferedReader reader = new BufferedReader(new FileReader("F:/SLIIT/Y1S2/OOP/Car_Service_and_Maintenance_Tracker-CRUD/reminders.txt"))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    reminders.add(line);
                }
            } catch (IOException e) {
                e.printStackTrace();
            }

            if (reminders.isEmpty()) {
        %>
            <div class="alert alert-warning text-center mt-3">No upcoming service reminders found.</div>
        <% } else { %>

        <!-- Search Bar -->
        <div class="input-group my-3">
            <input type="text" id="searchInput" onkeyup="searchReminders()" class="search-bar" placeholder="Search by Vehicle ID...">
            <div class="input-group-append">
                <span class="input-group-text"><i class="fas fa-search"></i></span>
            </div>
        </div>

        <table class="table table-hover mt-3">
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
                <tr class="reminder-row">
                    <td class="reminder-vehicle"><%= parts[0] %></td>
                    <td><%= parts[1].isEmpty() ? "N/A" : parts[1] %></td>
                    <td><%= parts[2].isEmpty() ? "N/A" : parts[2] %> km</td>
                    <td>
                        <!-- Edit Reminder -->
                        <form action="EditReminderServlet" method="GET" style="display:inline;">
                            <input type="hidden" name="vehicleID" value="<%= parts[0] %>">
                            <button type="submit" class="btn btn-warning btn-sm"><i class="fas fa-edit"></i> Edit</button>
                        </form>

                        <!-- Delete Reminder -->
                        <form action="DeleteReminderServlet" method="POST" style="display:inline;" onsubmit="return confirmDelete('<%= parts[0] %>');">
                            <input type="hidden" name="vehicleID" value="<%= parts[0] %>">
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
