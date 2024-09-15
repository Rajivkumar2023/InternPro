<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String message = request.getParameter("message");
    String error = request.getParameter("error"); // Capture the error from URL parameters
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="styles.css">
    <style>
    
    html, body {
        height: 100%;
        margin: 0;
    }

    body {
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        background-image: url(background_img.jpg);
        background-position: center;
        background-size: cover;
        font-family: 'Roboto', sans-serif;
    }

    .main {
        flex-grow: 1;
        display: flex;
        justify-content: center;
        border-radius:15px;
        align-items: center;
    }

    .login-box {
        max-width: 400px;
        width: 100%;
        background-color: #e3f2fd;  
        border-radius: 15px;
        
    }
	.form-group input {
            height: 45px;
            font-size: 16px;
        }

    h2 {
        font-weight: bold;
        font-size: 1.8rem;
    }

    .btn-primary {
        background-color: #007bff;
        border-color: #007bff;
        padding: 6px;
        font-size: 1.1rem;
    }

    /* Success and Error Messages */
    .alert {
        margin-bottom: 20px;
    }

    /* Footer styling */
    footer {
        background-color: #333;
        color: #fff;
        padding: 1rem;
        text-align: center;
    }

    footer p {
        margin: 0;
        font-size: 1rem;
    }
</style>
    
</head>
<body>

<!-- Header Section -->
    <section>
        <nav class="navbar navbar-expand-lg navbar-light bg-primary">
            <div class="container-fluid">
                <a class="navbar-brand" href="index.html"><img src="logo.png" alt="logo"></a>
                <div class="portal text-white">
                    <p>E-मतदाता सेवा पोर्टल</p>
                    <p>E-VOTER'S SERVICE PORTAL</p>
                </div>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                    <div class="navbar-nav ms-auto text-center mx-5 fs-5">
                        <a class="nav-link mx-3 text-white" href="index.html">Home</a>
                        <a class="nav-link mx-3 text-white" href="login.jsp">Login</a>
                        <a class="nav-link mx-3 text-white" href="userVerification.jsp">Vote</a>
                        <a class="nav-link mx-3 text-white" href="adminLogin.jsp">Admin</a>
                    </div>
                </div>
            </div>
        </nav>
    </section>

<!-- Admin Login Form Start -->
<div class="main">
    <div class="login-box p-5">
        <h2 class="text-center mb-4 text-title">Admin Login</h2>

        <!-- Success Message -->
        <% if ("loggedout".equals(message)) { %>
            <div class="alert alert-success text-center">
                You have successfully logged out.
            </div>
        <% } %>

        <!-- Error Messages -->
        <% if ("invalid".equals(error)) { %>
            <div class="alert alert-danger text-center">
                Invalid username or password. Please try again.
            </div>
        <% } else if ("error".equals(error)) { %>
            <div class="alert alert-danger text-center">
                An error occurred while processing your request. Please try again.
            </div>
        <% } %>

        <!-- Login Form -->
        <form action="AdminLoginServlet" method="post">
            <div class="form-group mb-3">
                <label for="username" class="form-label">Username</label>
                <input type="text" class="form-control" id="username" name="username" placeholder="Enter your username" required>
            </div>
            <div class="form-group mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
            </div>
            <div class="form-group form-button">
                <input type="submit" class="btn btn-primary btn-lg w-100" value="Login">
            </div>
        </form>
    </div>
</div>
<!-- Admin Login Form End -->

<!-- Footer Start -->
<footer class="bg-dark text-white py-4 mt-5">
    <div class="container text-center">
        <p>&copy; 2024 E-Voter Service Portal. All Rights Reserved.</p>
    </div>
</footer>
<!-- Footer End -->

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
