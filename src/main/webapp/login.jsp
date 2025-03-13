<%@ page language="java" %>
<html>
<head>
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <h2 class="text-center">Login</h2>
    <form action="LoginServlet" method="POST" class="w-50 mx-auto mt-3">
        <div class="mb-3">
            <label class="form-label">Username:</label>
            <input type="text" class="form-control" name="username" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Password:</label>
            <input type="password" class="form-control" name="password" required>
        </div>
        <button type="submit" class="btn btn-primary">Login</button>
    </form>
    <p class="text-center mt-3">Don't have an account? <a href="register.jsp">Register</a></p>
</body>
</html>
