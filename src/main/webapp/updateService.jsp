<%@ page language="java" %>
<html>
<head>
    <title>Update Service Record</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script>
        function confirmUpdate(event) {
            if (!confirm("Are you sure you want to update this service record?")) {
                event.preventDefault();
            }
        }
    </script>
</head>
<body class="container mt-5">
    <h2 class="text-center">Update Service Record</h2>
    <form action="ServiceServlet" method="POST" class="w-50 mx-auto mt-3" onsubmit="confirmUpdate(event)">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="vehicleID" value="<%= request.getParameter("vehicleID") %>">
        <input type="hidden" name="serviceDate" value="<%= request.getParameter("serviceDate") %>">
        <div class="mb-3">
            <label class="form-label">Service Type:</label>
            <input type="text" class="form-control" name="serviceType" value="<%= request.getParameter("serviceType") %>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Cost:</label>
            <input type="number" class="form-control" name="cost" value="<%= request.getParameter("cost") %>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Mileage:</label>
            <input type="number" class="form-control" name="mileage" value="<%= request.getParameter("mileage") %>" required>
        </div>
        <button type="submit" class="btn btn-warning">Update Service Record</button>
    </form>
    <p class="text-center mt-3"><a href="viewService.jsp">Back to Service Records</a></p>
</body>
</html>