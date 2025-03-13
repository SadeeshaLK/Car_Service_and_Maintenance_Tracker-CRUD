<%@ page language="java" %>
<html>
<head>
    <title>Add Service Record</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script>
        function confirmSubmission(event) {
            if (!confirm("Are you sure you want to add this service record?")) {
                event.preventDefault();
            }
        }
    </script>
</head>
<body class="container mt-5">
    <h2 class="text-center">Add Service Record</h2>
    <form action="ServiceServlet" method="POST" class="w-50 mx-auto mt-3" onsubmit="confirmSubmission(event)">
        <div class="mb-3">
            <label class="form-label">Vehicle ID:</label>
            <input type="text" class="form-control" name="vehicleID" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Service Date:</label>
            <input type="date" class="form-control" name="serviceDate" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Service Type:</label>
            <input type="text" class="form-control" name="serviceType" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Cost:</label>
            <input type="number" class="form-control" name="cost" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Mileage:</label>
            <input type="number" class="form-control" name="mileage" required>
        </div>
        <button type="submit" class="btn btn-success">Add Service Record</button>
    </form>
    <p class="text-center mt-3"><a href="viewService.jsp">View Service Records</a></p>
</body>
</html>
