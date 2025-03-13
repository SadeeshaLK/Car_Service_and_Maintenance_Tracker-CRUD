<%@ page language="java" %>
<html>
<head>
    <title>Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <h2 class="text-center">Register</h2>
    <form action="RegisterServlet" method="POST" class="w-50 mx-auto mt-3">
        <div class="mb-3">
            <label class="form-label">Username:</label>
            <input type="text" class="form-control" name="username" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Password:</label>
            <input type="password" class="form-control" name="password" required>
        </div>
        <button type="submit" class="btn btn-success">Register</button>
    </form>
    <p class="text-center mt-3">Already have an account? <a href="login.jsp">Login</a></p>
</body>
</html>