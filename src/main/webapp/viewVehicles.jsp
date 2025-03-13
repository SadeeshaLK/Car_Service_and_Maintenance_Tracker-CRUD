<%@ page language="java" import="java.util.*, model.Vehicle" %>
<html>
<head>
    <title>View Vehicles</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <h2 class="text-center">Vehicle List</h2>
    <input type="text" id="searchInput" class="form-control mb-3" placeholder="Search Vehicles..." onkeyup="searchTable()">
    <table class="table table-striped" id="vehicleTable">
        <thead>
            <tr>
                <th>Vehicle ID</th>
                <th>Owner</th>
                <th>Model</th>
                <th>Year</th>
            </tr>
        </thead>
        <tbody>
            <%-- Dynamically load vehicle records here --%>
        </tbody>
    </table>
    <script>
        function searchTable() {
            let input = document.getElementById("searchInput").value.toLowerCase();
            let rows = document.querySelectorAll("#vehicleTable tbody tr");
            rows.forEach(row => {
                let text = row.innerText.toLowerCase();
                row.style.display = text.includes(input) ? "" : "none";
            });
        }
    </script>
</body>
</html>