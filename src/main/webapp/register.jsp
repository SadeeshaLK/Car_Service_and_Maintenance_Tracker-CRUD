<%@ page language="java" %>
<html>
<head>
    <title>Register | Car Service Tracker</title>

    <!-- Bootstrap & FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        /* Background Image from Local Files */
        body {
            background: url('images/5.jpg') no-repeat center center fixed;
            background-size: cover;
            color: #fff;
        }

        /* Centered Register Card */
        .register-container {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .register-card {
            background: rgba(0, 0, 0, 0.85);
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.5);
            animation: fadeIn 1s ease-in-out;
            width: 100%;
            max-width: 400px;
        }

        /* Smooth Fade-in Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Form Styling */
        .form-control {
            background: rgba(255, 255, 255, 0.1);
            border: none;
            color: #fff;
        }
        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }
        .form-control:focus {
            background: rgba(255, 255, 255, 0.2);
            color: #fff;
            box-shadow: none;
        }

        /* Button Styling */
        .btn-success {
            background: #28a745;
            border: none;
        }
        .btn-success:hover {
            background: #218838;
        }

        /* Link Styling */
        .login-link {
            color: #1e77e1;
            text-decoration: none;
        }
        .login-link:hover {
            color: #0848b2;
        }
    </style>
</head>
<body>


    <div class="register-container">
        <div class="register-card text-center">
            <h2><i class="fas fa-car"></i> Car Service Tracker</h2>
            <p class="mb-4">Create an account to manage your vehicles and service records</p>

            <!-- Registration Form -->
            <form action="RegisterServlet" method="POST">
                <div class="mb-3">
                    <label class="form-label"><i class="fas fa-user"></i> Username:</label>
                    <input type="text" class="form-control" name="username" placeholder="Choose a username" required>
                </div>
                <div class="mb-3">
                    <label class="form-label"><i class="fas fa-lock"></i> Password:</label>
                    <input type="password" class="form-control" name="password" placeholder="Enter your password" required>
                </div>
                <button type="submit" class="btn btn-success w-100"><i class="fas fa-user-plus"></i> Register</button>
            </form>

            <!-- Login Link -->
            <p class="mt-3">Already have an account? <a href="login.jsp" class="login-link">Login</a></p>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
