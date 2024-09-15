<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// Prevent caching for logged-in pages
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
response.setHeader("Pragma", "no-cache"); // HTTP 1.0
response.setDateHeader("Expires", 0); // Proxies
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap and Font Awesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
    
    <!-- Custom Styles -->
    <link rel="stylesheet" href="styles.css"> 
    <title>User Verification | E-Voter Service Portal</title>

    <style>
        /* Navbar Styling */
        .custom-navbar {
            background-color: #007bff !important; /* Ensure solid blue background */
        }

        .custom-navbar .navbar-brand img {
            width: 50px; /* Adjust logo size */
        }

        .portal p {
            margin: 0;
            font-size: 14px;
        }

        /* General Body Styling */
        body {
            background-position: center;
            background-color: #f8f9fa;
            background-repeat: no-repeat;
            background-image: url('background_img.jpg');
            background-size: cover;
            color: #333;
            font-family: 'Roboto', sans-serif;
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

        /* Form Styling */
        .form-control {
            border-radius: 10px;
            height: 50px;
        }
        .form-group input {
            font-size: 16px;
        }

        /* Button Styling */
         .form-button input {
            width: 100%;
            height: 50px;
            font-size: 18px;
            border-radius:10px;
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
        }
        /* Custom Message Styling */
       .success-message {
    color: green;
    font-weight: bold;
    background-color: #d4edda; /* Light green background */
    border: 1px solid #c3e6cb; /* Darker green border */
    padding: 10px;
    border-radius: 5px;
}


       .error-message {
    color: red;
    font-weight: bold;
    background-color: #f8d7da; /* Light red background */
    border: 1px solid #f5c6cb; /* Darker red border */
    padding: 10px;
    border-radius: 5px;
}

    </style>
</head>
<body>

    <!-- Header Section -->
    <nav class="navbar navbar-expand-lg custom-navbar">
        <div class="container-fluid">
            <a class="navbar-brand" href="index.html">
                <img src="logo.png" alt="E-Voter Logo">
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
                        <a class="nav-link mx-3 text-white" href="registration.jsp">Register</a>                                   
                        <a class="nav-link mx-3 text-white" href="userVerification.jsp">Vote</a>
                        <a class="nav-link mx-3 text-white" href="adminLogin.jsp">Admin</a>
                </div>
            </div>
        </div>
    </nav>

    <!-- User Verification Form -->
    <div class="form-gap"></div>
    <div class="container d-flex justify-content-center align-items-center">
        <div class="col-md-4 mt-5">
            <div class="panel panel-default">
                <div class="panel-body">
			         <h2 class="text-center form-title">Voter Verification</h2>			     			        
			         <% 
					    String message = (String) request.getAttribute("message"); 
					    String messageType = (String) request.getAttribute("messageType"); 
					%>
					<% if (message != null) { %>
					    <div class="<%= (messageType != null && messageType.equals("success")) ? "success-message" : "error-message" %> text-center">
					        <%= message %>
					    </div>
					<% } %>

			        <!-- userVerification.jsp -->        
                    <form action="UserVerificationServlet" method="post" class="mt-5">
			            <div class="mb-3">
			                <label for="aadhaar" class="form-label text-dark">Aadhaar Number</label>
			                <input type="text" class="form-control" id="aadhaar" name="aadhaar" required placeholder="Enter Aadhaar Number"/>
			            </div>
			            <div class="mb-3">
			                <label for="uniqueKey" class="form-label">Unique Key</label>
			                <input type="text" class="form-control" id="uniqueKey" name="uniqueKey" required placeholder="Enter Unique Key"/>
			            </div>
			            <div class="form-group form-button">
                            <input type="submit" class="btn btn-primary btn-lg w-100" value="Verify">
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

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
