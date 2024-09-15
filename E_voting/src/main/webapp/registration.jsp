<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="styles.css">
    <title>Register</title>
    <style>
         body {
            background-image: url(background_img.jpg);
            background-position: center;
            background-size: cover;
            font-family: 'Roboto', sans-serif;
        }
        .signup-section {
            margin-top: 50px;
        }
        .signup-form {
            background-color: #ffffff;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }
        .form-title {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 30px;
            text-align: center;
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
        .signup-form {
            padding: 2rem;
            background-color: #e3f2fd; /* Light grey background */
            border-radius:15px;
        }
         /* Footer Styling */
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
                <a class="navbar-brand" href="index.html">
                    <img src="logo.png" alt="logo" style="height: 50px;">
                </a>
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
    <!-- Hidden status for SweetAlert -->
    <input type="hidden" id="status" value="<%= request.getAttribute("status") %>">

    <!-- Registration Form Section -->
    <div class="container signup-section">
        <div class="row justify-content-center">
            <div class="col-lg-6">
                <div class="signup-form">
                    <h2 class="form-title">Sign Up</h2>
                    <form method="post" action="register" id="register-form">
                        <div class="form-group mb-3">
                            <label for="name">Full Name</label>
                            <input type="text" name="name" id="name" class="form-control" placeholder="Your Name" required style="text-transform: uppercase;">
                        </div>
                        <div class="form-group mb-3">
                            <label for="email">Email Address</label>
                            <input type="email" name="email" id="email" class="form-control" placeholder="Your Email" required>
                        </div>
                        <div class="form-group mb-3">
                            <label for="pass">Password</label>
                            <input type="password" name="pass" id="pass" class="form-control" placeholder="Password" required>
                        </div>
                        <div class="form-group mb-3">
                            <label for="re_pass">Repeat Password</label>
                            <input type="password" name="re_pass" id="re_pass" class="form-control" placeholder="Repeat your password" required>
                        </div>
                        <div class="form-group mb-3">
                            <label for="contact">Contact Number</label>
                            <input type="text" name="contact" id="contact" class="form-control" placeholder="Contact no" required>
                        </div>
                        <div class="form-group form-button">
                            <input type="submit" name="signup" id="signup" class="btn btn-primary btn-lg w-100" value="Register">
                        </div>
                    </form>
                </div>
            </div>
            <!-- <div class="col-lg-6 d-flex align-items-center justify-content-center">
                <div class="signup-image">
                    <img src="https://via.placeholder.com/400x400" alt="sign up image">
                    <a href="login.jsp" class="signup-image-link">I am already a member</a>
                </div>
            </div> -->
        </div>
    </div>

    <!-- Footer Start -->
    <footer class="bg-dark text-white py-4">
        <div class="container text-center">
            <p>&copy; 2024 E-Voter Service Portal. All Rights Reserved.</p>
        </div>
    </footer>
    <!-- Footer End -->

    <!-- Bootstrap and JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <!-- SweetAlert JS -->
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

    <!-- SweetAlert for registration status -->
    <script type="text/javascript">
    var status = document.getElementById("status").value;
    if (status === "success") {
        swal("Congrats", "Registration Successful", "success");
    } else if (status === "emailExists") {
        swal("Oops", "This email is already registered!", "error"); 
    } else if (status === "unameExists") {
        swal("Oops", "This username is already registered!", "error");
    } else if (status === "passwordMismatch") {
        swal("Oops", "Passwords do not match.", "error");
    } else if (status === "failed") {
        swal("Oops", "Registration Failed. Please try again!", "error");
    }
    </script>
</body>
</html>
