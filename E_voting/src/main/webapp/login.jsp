<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Disable caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setDateHeader("Expires", 0); // Proxies.
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="styles.css">
    <title>Login</title>
    <style>
       html, body {
            height: 100%;
            margin: 0;
        }

        body {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            font-family: 'Roboto', sans-serif;
            background-image: url('background_img.jpg');
            background-position: center;
            background-size: cover;
        }

        .main {
            flex-grow: 1;
        }

        .sign-in {
            margin-top: 50px;
        }

        .signin-form {
            background-color: #e3f2fd;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }

        .form-title {
            font-size: 28px;
            font-weight: 700;
            text-align: center;
            margin-bottom: 20px;
        }

        .form-group input {
            height: 45px;
            font-size: 16px;
        }

        .form-button input {
            width: 100%;
            height: 50px;
            font-size: 18px;
        }
        form a {
        text-decoration: none;
        color:black;
        }

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
<input type="hidden" id="status" value="<%= request.getAttribute("status") != null ? request.getAttribute("status") : "" %>">

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
                        <a class="nav-link mx-3 text-white" href="registration.jsp">Register</a>                                   
                        <a class="nav-link mx-3 text-white" href="userVerification.jsp">Vote</a>
                        <a class="nav-link mx-3 text-white" href="adminLogin.jsp">Admin</a>
                    </div>
                </div>
            </div>
        </nav>
    </section>

    <div class="main">
        <section class="sign-in">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-4">
                        <div class="signin-form">
                            <h2 class="form-title">Sign In</h2>

                            <!-- Success Message -->
                            <% if ("loggedout".equals(request.getParameter("message"))) { %>
                                <div class="alert alert-success text-center">
                                    You have successfully logged out.
                                </div>
                            <% } %>

                            <!-- Error Message -->
                            <% if ("failed".equals(request.getAttribute("status"))) { %>
                                <div class="alert alert-danger text-center">
                                    Invalid username or password. Please try again.
                                </div>
                            <% } %>

                            <form method="post" action="login" class="register-form" id="login-form">
                                <div class="form-group mb-3">
                                    <label for="username">Email Address</label>
                                    <input type="email" name="username" id="username" class="form-control" placeholder="Enter Your Email" required>
                                </div>
                                <div class="form-group mb-3">
                                    <label for="password">Password</label>
                                    <input type="password" name="password" id="password" class="form-control" placeholder="Password" required>
                                </div>
                                <a href="forgotPassword.jsp" class="d-block mb-3">Forgot Password?</a>
                                <div class="form-group form-button">
                                    <input type="submit" name="signin" id="signin" class="btn btn-primary btn-lg w-100" value="Log in">
                                </div>
                                <a href="registration.jsp" class="d-block mt-3 text-end">Create new account !</a>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4">
        <div class="container text-center">
            <p>&copy; 2024 E-Voter Service Portal. All Rights Reserved.</p>
        </div>
    </footer>

    <!-- JS Scripts -->
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    
    
    <!-- SweetAlert Script -->
    <script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function() {
        var status = document.getElementById("status").value;

        if (status === "resetSuccess") {
            swal("Congrats", "Password reset successfully. You can now log in with your new password!", "success");
        } else if (status === "resetFailed") {
            swal("Oops", "Password reset failed. Please try again!", "error");
        } else if (status === "passwordMismatch") {
            swal("Oops", "Passwords do not match. Please try again!", "error");
        }
    });
    </script>
</body>
</html>
