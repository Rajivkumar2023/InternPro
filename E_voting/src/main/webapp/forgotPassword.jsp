<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="styles.css"> <!-- External CSS file for custom styles -->
</head>
<style>
    body {
       background-image: url(background_img.jpg);
       background-position: center;
       background-size: cover;
       font-family: 'Roboto', sans-serif;
    }

    /* Card styling */
    .card {
        border-radius: 15px;
        border: none;
        padding: 10px;
    }

    /* Email input and label */
    input[type="email"] {
        border-radius: 8px;
        height: 50px;
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

    /* Button styling */
    .btn-primary {
        background-color: #007bff;
        border: none;
        font-size: 1.1rem;
        padding: 10px;
    }
</style>
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

<!-- Forgot Password Form Start -->

<div class="container d-flex justify-content-center align-items-center vh-100">
    <div class="col-md-4">
        <div class="card shadow-lg p-4">
            <div class="card-body text-center">
                <h3>
                    <i class="fa fa-envelope fa-4x text-primary mb-3"></i>
                </h3>
                <h2 class="text-center text-primary mb-4">Forgot Password</h2>
                <p class="text-muted mb-4">Enter your registered email address and reset your password.</p>

                <!-- Message Display -->
                <%
                    String message = (String) request.getAttribute("message");
                    String errorMessage = (String) request.getAttribute("errorMessage");
                    if (message != null) {
                %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <%= message %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <% } else if (errorMessage != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <%= errorMessage %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <% } %>

                <form action="forgotPassword" method="POST">
                    <div class="mb-3">
                        <label for="email-for-pass" class="form-label">Email Address</label>
                        <input class="form-control" type="email" name="email" id="email-for-pass" placeholder="Enter your registered email" required>
                    </div>
                    <div class="d-grid">
                        <button class="btn btn-primary btn-lg" type="submit">Get New Password</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- Forgot Password Form End -->

<!-- Footer Start -->
<footer class="bg-dark text-white py-4 mt-5">
    <div class="container text-center">
        <p>&copy; 2024 E-Voter Service Portal. All Rights Reserved.</p>
    </div>
</footer>
<!-- Footer End -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
