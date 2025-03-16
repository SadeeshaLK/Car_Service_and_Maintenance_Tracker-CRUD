<%@ page language="java" %>
<html>
<head>
    <title>Add Vehicle | Car Service Tracker</title>

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
        .vehicle-form-container {
            background: rgba(0, 0, 0, 0.8);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.5);
            max-width: 500px;
            margin: auto;
        }

        /* Input Fields */
        .form-control {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            border: 1px solid #ccc;
        }

        .form-control::placeholder {
            color: #ddd;
        }

        /* Buttons */
        .btn-custom {
            font-size: 16px;
            font-weight: bold;
            padding: 10px 20px;
            border-radius: 5px;
        }

        .btn-custom:hover {
            opacity: 0.9;
        }
    </style>

    <script>
        // Function to validate vehicle year
        function validateYear() {
            let yearInput = document.getElementById("year");
            let currentYear = new Date().getFullYear();
            if (yearInput.value > currentYear || yearInput.value < 1900) {
                alert("Please enter a valid year between 1900 and " + currentYear);
                yearInput.value = "";
            }
        }
    </script>

</head>
<body class="container mt-5">

    <div class="vehicle-form-container">
        <h2 class="text-center"><i class="fas fa-car"></i> Add Vehicle</h2>

        <form action="VehicleServlet" method="POST">
            <div class="mb-3">
                <label class="form-label"><i class="fas fa-id-badge"></i> Vehicle ID:</label>
                <input type="text" class="form-control" name="vehicleID" required placeholder="Enter vehicle ID">
            </div>
            <div class="mb-3">
                <label class="form-label"><i class="fas fa-user"></i> Owner:</label>
                <input type="text" class="form-control" name="owner" required placeholder="Enter owner name">
            </div>
            <div class="mb-3">
                <label class="form-label"><i class="fas fa-car-side"></i> Model:</label>
                <input type="text" class="form-control" name="model" required placeholder="Enter vehicle model">
            </div>
            <div class="mb-3">
                <label class="form-label"><i class="fas fa-calendar-alt"></i> Year:</label>
                <input type="number" class="form-control" name="year" id="year" required placeholder="Enter vehicle year" onblur="validateYear()">
            </div>
            <button type="submit" class="btn btn-success w-100 btn-custom"><i class="fas fa-plus"></i> Add Vehicle</button>
        </form>

        <!-- Back to View Vehicles Button -->
        <div class="text-center mt-3">
            <a href="index.jsp" class="btn btn-warning btn-custom"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
            <a href="viewVehicles.jsp" class="btn btn-warning btn-custom"><i class="fas fa-solid-car"></i> View Vehicles</a>
        </div>
    </div>

</body>
</html>
