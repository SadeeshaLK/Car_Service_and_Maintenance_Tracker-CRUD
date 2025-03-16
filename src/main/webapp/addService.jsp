<%@ page language="java" import="java.io.*, java.util.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>Add Service Record | Car Service Tracker</title>

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
        .service-form-container {
            background: rgba(0, 0, 0, 0.85);
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
        // Validate cost and mileage inputs
        function validateNumberInput(input) {
            if (input.value < 0) {
                alert("Value cannot be negative!");
                input.value = "";
            }
        }
    </script>

</head>
<body class="container mt-5">

    <div class="service-form-container">
        <h2 class="text-center"><i class="fas fa-tools"></i> Add Service Record</h2>

        <form action="AddServiceServlet" method="POST">
            <div class="mb-3">
                <label class="form-label"><i class="fas fa-car"></i> Vehicle ID:</label>
                <input type="text" class="form-control" name="vehicleID" required placeholder="Enter vehicle ID">
            </div>

            <div class="mb-3">
                <label class="form-label"><i class="fas fa-calendar-alt"></i> Service Date:</label>
                <input type="date" class="form-control" name="serviceDate" required>
            </div>

            <div class="mb-3">
                <label class="form-label"><i class="fas fa-wrench"></i> Service Type:</label>
                <select class="form-control" name="serviceType" required>
                    <option value="" disabled selected>Select Service Type</option>
                    <option value="Oil Change">Oil Change</option>
                    <option value="Brake Inspection">Brake Inspection</option>
                    <option value="Tire Replacement">Tire Replacement</option>
                    <option value="Battery Replacement">Battery Replacement</option>
                    <option value="Engine Tune-Up">Engine Tune-Up</option>
                    <option value="Wheel Alignment">Wheel Alignment</option>
                    <option value="AC Repair">AC Repair</option>
                    <option value="General Checkup">General Checkup</option>
                    <option value="Other">Other</option>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label"><i class="fas fa-money-bill-wave"></i> Cost (Rs.):</label>
                <input type="number" step="0.01" class="form-control" name="cost" required placeholder="Enter cost" onblur="validateNumberInput(this)">
            </div>

            <div class="mb-3">
                <label class="form-label"><i class="fas fa-tachometer-alt"></i> Mileage (km):</label>
                <input type="number" class="form-control" name="mileage" required placeholder="Enter mileage" onblur="validateNumberInput(this)">
            </div>

            <hr>
            <h5><i class="fas fa-bell"></i> Set a Service Reminder (Optional)</h5>

            <div class="mb-3">
                <label class="form-label"><i class="fas fa-calendar-plus"></i> Next Service Date:</label>
                <input type="date" class="form-control" name="nextServiceDate">
            </div>

            <div class="mb-3">
                <label class="form-label"><i class="fas fa-tachometer-alt"></i> Next Service Mileage (km):</label>
                <input type="number" class="form-control" name="nextServiceMileage" placeholder="Enter estimated mileage" onblur="validateNumberInput(this)">
            </div>

            <button type="submit" class="btn btn-primary w-100 btn-custom"><i class="fas fa-plus"></i> Add Service</button>
        </form>

        <!-- Back to Dashboard Button -->
        <div class="text-center mt-3">
            <a href="index.jsp" class="btn btn-warning btn-custom"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
        </div>
    </div>

</body>
</html>
