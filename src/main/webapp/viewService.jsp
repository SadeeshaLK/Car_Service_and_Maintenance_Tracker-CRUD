<%@ page language="java" import="java.util.*, model.ServiceRecord" %>
<html>
<head>
    <title>View Service History</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <h2 class="text-center">Service History</h2>
    <div class="row mb-3">
        <div class="col-md-6">
            <input type="text" id="searchInput" class="form-control" placeholder="Search Service Records..." onkeyup="searchTable()">
        </div>
        <div class="col-md-3">
            <input type="date" id="dateFilter" class="form-control" onchange="filterTable()">
        </div>
        <div class="col-md-3">
            <select id="serviceTypeFilter" class="form-control" onchange="filterTable()">
                <option value="">All Service Types</option>
                <option value="Oil Change">Oil Change</option>
                <option value="Brake Repair">Brake Repair</option>
                <option value="Battery Replacement">Battery Replacement</option>
            </select>
        </div>
    </div>
    <table class="table table-striped" id="serviceTable">
        <thead>
            <tr>
                <th onclick="sortTable(0)">Vehicle ID</th>
                <th onclick="sortTable(1)">Date</th>
                <th>Service Type</th>
                <th>Cost</th>
                <th>Mileage</th>
            </tr>
        </thead>
        <tbody>
            <%-- Dynamically load service records here --%>
        </tbody>
    </table>
    <script>
        function searchTable() {
            let input = document.getElementById("searchInput").value.toLowerCase();
            let rows = document.querySelectorAll("#serviceTable tbody tr");
            rows.forEach(row => {
                let text = row.innerText.toLowerCase();
                row.style.display = text.includes(input) ? "" : "none";
            });
        }
        function filterTable() {
            let dateInput = document.getElementById("dateFilter").value;
            let serviceType = document.getElementById("serviceTypeFilter").value;
            let rows = document.querySelectorAll("#serviceTable tbody tr");
            rows.forEach(row => {
                let dateMatches = !dateInput || row.cells[1].innerText.includes(dateInput);
                let typeMatches = !serviceType || row.cells[2].innerText.includes(serviceType);
                row.style.display = dateMatches && typeMatches ? "" : "none";
            });
        }
        function sortTable(columnIndex) {
            let table = document.getElementById("serviceTable");
            let rows = Array.from(table.rows).slice(1);
            rows.sort((a, b) => a.cells[columnIndex].innerText.localeCompare(b.cells[columnIndex].innerText));
            rows.forEach(row => table.appendChild(row));
        }
    </script>
</body>
</html>