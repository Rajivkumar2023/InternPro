<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enter New Password</title>
    
    <!-- Bootstrap and Font Awesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
    
    <!-- Custom Styles -->
    <link rel="stylesheet" href="styles.css"> 

    <style>
    
    	html, body {
            height: 100%;
            margin: 0;
        }
        /* Additional Spacing for Form */
        .form-gap {
            padding-top: 100px;
        }

        /* General Body Styling */
        body {
            background-position: center;
            background-color: #f8f9fa;
            background-repeat: no-repeat;
            background-image: url('background_img.jpg');
            background-size: cover;
            color: #333;
            font-family: "Rubik", Helvetica, Arial, sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Card Styling */
        .panel {
            background-color: #e3f2fd;
            border-radius: 15px;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.2);
        }

        .panel-body {
            padding: 30px;
        }

        /* Input field styling */
        .form-control {
            border-radius: 0 10px 10px 0;
            font-family: "FontAwesome", Arial;
        }

        /* Footer Styling */
        footer {
            background-color: #333;
            color: #fff;
            padding: 1rem;
            text-align: center;
            margin-top: auto;
        }

        footer p {
            margin: 0;
            font-size: 1rem;
        }

        /* Button Styling */
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            border-radius: 25px;
            transition: background-color 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            transition: background-color 0.3s ease;
        }

        /* Responsiveness */
        @media(max-width: 768px) {
            .form-gap {
                padding-top: 50px;
            }
        }
    </style>
</head>

<body>
    <!-- Header Section -->
    <section>
        <nav class="navbar navbar-expand-lg navbar-light bg-primary">
            <div class="container-fluid">
                <a class="navbar-brand" href="index.html"><img src="logo.png" alt="logo"></a>
                <div class="portal text-white text-center">
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
                        <a class="nav-link mx-3 text-white">Hello Admin</a>
                    </div>
                </div>
            </div>
        </nav>
    </section>

    <!-- Password Reset Form Section -->
    <div class="form-gap"></div>
    <div class="container d-flex justify-content-center align-items-center">
        <div class="col-md-4">
            <div class="panel panel-default">
                <div class="panel-body text-center">
                    <h3>
                        <i class="fa fa-lock fa-4x  text-primary mb-3"></i>
                    </h3>
                    <h2 class="text-primary mb-4">Enter New Password</h2>

                    <!-- Display Message if Available -->
                    <% if (request.getAttribute("message") != null) { %>
                        <p class="text-danger"><%= request.getAttribute("message") %></p>
                    <% } %>

                    <!-- New Password Form -->
                    <form id="reset-form" action="newPassword" method="POST">
                        <div class="mb-4">
                            <div class="input-group">
                                <input id="password" name="password" placeholder="&#xf084; &nbsp; New Password" class="form-control" type="password" required>
                            </div>
                        </div>
                        <div class="mb-4">
                            <div class="input-group">
                                <input id="confPassword" name="confPassword" placeholder="&#xf084; &nbsp; Confirm New Password" class="form-control" type="password" required>
                            </div>
                        </div>
                        <div class="d-grid mb-3">
                            <button type="submit" class="btn btn-primary btn-lg">Reset Password</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer Start -->
    <footer class="bg-dark text-white py-4">
        <div class="container text-center">
            <p>&copy; 2024 E-Voter Service Portal. All Rights Reserved.</p>
        </div>
    </footer>
    <!-- Footer End -->

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
