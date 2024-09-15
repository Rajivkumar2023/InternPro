<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>

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
    <title>User Form</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            background-image: url(background_img.jpg);
            background-position: center;
            background-size: cover;
            font-family: 'Roboto', sans-serif;
        }
         .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
        }
        .card-body {
            padding: 2rem;
            background-color: #e3f2fd; /* Light grey background */
            border-radius:15px;
        }
        .form-control {
            border-radius: 8px;
            padding: 10px 15px;
            background-color: #ffffff; /* White background for inputs */
        }
        .btn-primary {
            background-color: #007bff;
            border: none;
            border-radius: 8px;
            padding: 12px;
            font-size: 16px;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            
        }
        .form-label {
            font-weight: 500;
        }
        .container {
            max-width: 1200px; /* Increased max-width */
        }
        .card-title {
            font-size: 1.75rem;
            font-weight: 600;
        }
        .mb-3 {
            margin-bottom: 1rem;
        }
        .d-grid {
            margin-top: 20px;
        }
         /* Footer Styling */
        footer {
            background-color: #333;
            color: #fff;
            padding: 1rem;
            text-align: center;
            margin-top: auto; /* Push the footer to the bottom */
        }

        footer p {
            margin: 0;
            font-size: 1rem;
        }
        
    </style>
</head>
<body>
<input type="hidden" id="status" value="<%= request.getParameter("status") %>">


     <!-- header part start -->
        <section>

            <nav class="navbar navbar-expand-lg navbar-light bg-primary">
                <div class="container-fluid">
                  <a class="navbar-brand" href="index.html"><img src="logo.png" alt="logo"></a>
                  <div class="portal"><p>E-मतदाता सेवा पोर्टल</p>
                    <p>E-VOTER'S SERVICE PORTAL</p>
                     </div>
                  <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                  </button>
                  <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                   <div class="navbar-nav ms-auto text-center mx-5 fs-5">
                 <a class="nav-link mx-3 text-white" aria-current="page" href="index.html">Welcome to E-Voting -</a>
					<%
					    // Retrieve the session object
					    HttpSession session1 = request.getSession(false);
					
					    // Check if the session is not null and the username attribute is set
					    if (session1 != null && session1.getAttribute("name") != null) {
					        // Get the username from the session
					        String username = (String) session1.getAttribute("name");
					%>
					 <p style="color:white; margin-top:7px;"><%= username %></p>
					 <button class="btn btn-warning m-2 " onclick="window.location.href='logout.jsp'">Logout</button>
					
					<%
					    } else {
					        // Redirect to the login page if the session is not valid
					        response.sendRedirect("login.jsp");
					    }
					%>
                 
                </div>
                  </div>
                </div>
              </nav>
         </section>
         <!-- header part End -->


<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-body">
                    <h3 class="card-title text-center mb-4">E-Voting Request Form</h3>
                    <form action="UserFormServlet" method="post">
                        <!-- Row for Title, Name, Gender, and DOB -->
                        <div class="row mb-3">
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label for="title" class="form-label">Title</label>
                                    <select class="form-select" id="title" name="title" required>
                                        <option value="" disabled selected>Select your title</option>
                                        <option value="Mr">Mr.</option>
                                        <option value="Mrs">Mrs.</option>
                                        <option value="Miss">Miss</option>
                                        <option value="Ms">Ms.</option>
                                        <option value="Dr">Dr.</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-8">
                                <div class="mb-3">
                                    <label for="name" class="form-label">Full Name</label>
                                    <input type="text" class="form-control" id="name" name="name" placeholder="Enter your full name" required oninput="validateText(this)">
                                </div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="gender" class="form-label">Gender</label>
                                    <select class="form-select" id="gender" name="gender" required>
                                        <option value="" disabled selected>Select your gender</option>
                                        <option value="Male">Male</option>
                                        <option value="Female">Female</option>
                                        <option value="Other">Other</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="dob" class="form-label">Date of Birth</label>
                                    <input type="date" class="form-control" id="dob" name="dob" required>
                                </div>
                            </div>
                        </div>

                        <!-- Row for Email and Mobile -->
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="email" class="form-label">Email Address</label>
                                <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email address" required>
                            </div>
                            <div class="col-md-6">
                                <label for="mobile" class="form-label">Mobile Number</label>
                                <input type="number" class="form-control" id="mobile" name="mobile" placeholder="Enter your mobile number" required>
                            </div>
                        </div>

                        <!-- Row for Aadhaar and Voter ID -->
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="adhar" class="form-label">Aadhaar Number</label>
                                <input type="number" class="form-control" id="adhar" name="adhar" placeholder="Enter your Aadhaar number" required>
                            </div>
                            <div class="col-md-6">
                                <label for="voter" class="form-label">Voter ID Number (EPIC)</label>
                                <input type="text" class="form-control" id="voter" name="voter" placeholder="Enter your voter ID number" required>
                            </div>
                        </div>

                        <!-- Address and Pincode -->
                        <div class="row mb-3">
                            <div class="col-md-12">
                                <label for="address" class="form-label">Address</label>
                                <input type="text" class="form-control" id="address" name="address" placeholder="Enter your address" required>
                            </div>
                        </div>
                        
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="ward" class="form-label">Ward No.</label>
                                <input type="text" class="form-control" id="ward" name="ward" placeholder="Enter your ward no." required>
                            </div>
                            <div class="col-md-6">
                                <label for="pincode" class="form-label">Pincode</label>
                                <input type="number" class="form-control" id="pincode" name="pincode" placeholder="Enter your pincode" required>
                            </div>
                        </div>

                        <!-- Row for State and District -->
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="state" class="form-label">State</label>
                                <select class="form-select" id="state" name="state" required onchange="updateDistricts()">
                                    <option value="">Select your state</option>
                                    <option value="Maharashtra">Maharashtra</option>
                                    <option value="Uttar Pradesh">Uttar Pradesh</option>
                                    <option value="Karnataka">Karnataka</option>
                                    <option value="Bihar">Bihar</option>
                                    <!-- Add other states as needed -->
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="district" class="form-label">District</label>
                                <select class="form-select" id="district" name="district" required>
                                    <option value="">Select your district</option>
                                    <!-- Districts will be populated based on state -->
                                </select>
                            </div>
                        </div>

                        <!-- Submit Button -->
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">Submit</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Predefined districts for each state
    const stateDistricts = {
        "Maharashtra": ["Mumbai", "Pune", "Nagpur", "Nashik"],
        "Uttar Pradesh": ["Lucknow", "Kanpur", "Varanasi", "Agra"],
        "Karnataka": ["Bangalore", "Mysore", "Hubli", "Mangalore"],
        "Bihar": [
            "Araria", "Arwal", "Aurangabad", "Banka", "Begusarai", "Bhagalpur", 
            "Bhojpur", "Buxar", "Darbhanga", "East Champaran (Motihari)", 
            "Gaya", "Gopalganj", "Jamui", "Jehanabad", "Kaimur (Bhabua)", 
            "Katihar", "Khagaria", "Kishanganj", "Lakhisarai", "Madhepura", 
            "Madhubani", "Munger", "Muzaffarpur", "Nalanda", "Nawada", 
            "Patna", "Purnia (Purnea)", "Rohtas", "Saharsa", "Samastipur", 
            "Saran", "Sheikhpura", "Sheohar", "Sitamarhi", "Siwan", 
            "Supaul", "Vaishali", "West Champaran"
        ],
        // Add more states and their districts here
    };

    function updateDistricts() {
        const state = document.getElementById('state').value;
        const districtSelect = document.getElementById('district');
        districtSelect.innerHTML = '<option value="">Select your district</option>'; // Reset options

        if (state && stateDistricts[state]) {
            stateDistricts[state].forEach(function(district) {
                const option = document.createElement('option');
                option.value = district;
                option.text = district;
                districtSelect.appendChild(option);
            });
        }
    }
    
    function validateText(input) {
        input.value = input.value.replace(/[^a-zA-Z\s]/g, ''); // Ensures only letters and spaces
    }
</script>




 <!-- Footer Start -->
    <footer class="bg-dark text-white py-4">
        <div class="container text-center">
            <p>&copy; 2024 E-Voter Service Portal. All Rights Reserved.</p>
        </div>
    </footer>
    <!-- Footer End -->

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- SweetAlert for registration status -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" href="https://unpkg.com/sweetalert/dist/sweetalert.css">

<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    var status = document.getElementById("status").value;

    if (status === "success") {
        swal("Congrats", "E-Voting request successfully submitted!", "success");
    }else if (status === "emailExists") {
        swal("Oops", "This email id is already registered!", "error");
    } else if (status === "adharExists") {
        swal("Oops", "This Aadhaar number is already registered!", "error");
    } else if (status === "voterExists") {
        swal("Oops", "This Voter ID number is already registered!", "error");
    } else if (status === "failed") {
        swal("Oops", "Registration Failed. Please try again!", "error");
    } else if (status === "underage") {
        swal("Oops", "You must be 18 years or older to register for e-voting!", "error");
    }
});
</script>

   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>
