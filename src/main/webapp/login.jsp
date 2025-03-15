<%@ page language="java" %>
<html>
<head>
    <title>Login | Car Service & Maintenance Tracker</title>

    <!-- Bootstrap & FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        body {
            background: url('images/4.jpg') no-repeat center center fixed;
            background-size: cover;
            color: #fff;
        }
        .login-container {
            margin-top: 100px;
        }
        .login-card {
            background: rgba(0, 0, 0, 0.85);
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.5);
            animation: fadeIn 1s ease-in-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
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
        .btn-primary {
            background: #1e77e1;
            border: none;
        }
        .btn-primary:hover {
            background: #0848b2;
        }
        .register-link {
            color: #28a745;
        }
        .register-link:hover {
            color: #218838;
        }
    </style>
</head>
<body>

    <div class="container login-container">
        <div class="row justify-content-center">
            <div class="col-md-4">
                <div class="login-card text-center">
                    <h2><i class="fas fa-car"></i> Car Service & Maintenance Tracker</h2>
                    <p class="mb-4">Login to manage your vehicles and service records</p>

                    <!-- Login Form -->
                    <form action="LoginServlet" method="POST">
                        <div class="mb-3">
                            <label class="form-label"><i class="fas fa-user"></i> Username:</label>
                            <input type="text" class="form-control" name="username" placeholder="Enter your username" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label"><i class="fas fa-lock"></i> Password:</label>
                            <input type="password" class="form-control" name="password" placeholder="Enter your password" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100"><i class="fas fa-sign-in-alt"></i> Login</button>
                    </form>

                    <!-- Register Link -->
                    <p class="mt-3">Don't have an account? <a href="register.jsp" class="register-link">Register</a></p>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
