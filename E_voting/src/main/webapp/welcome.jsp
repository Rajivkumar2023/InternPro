<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession session1 = request.getSession(false);
    if (session1 == null || session.getAttribute("name") == null) {
        // If session is invalid or user is not logged in, redirect to login page
        response.sendRedirect("login.jsp");
        return;
    }

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
    <title>E-voting</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="styles.css">
</head>
<body>
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
					    HttpSession session2 = request.getSession(false);
					
					    // Check if the session is not null and the username attribute is set
					    if (session2 != null && session1.getAttribute("name") != null) {
					        // Get the username from the session
					        String username = (String) session1.getAttribute("name");
					%>
					 <p style="color:white; margin-top:7px;"><%= username %></p>
					 <button class="btn btn-warning m-2" onclick="window.location.href='logout.jsp'">Logout</button>
					
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

<div class="container-fluid my-4">
    <h3 class="text-primary bg-light-general mb-4 p-1">General Elections 2024</h3>
    <div class="row">
        <!-- Forms Section -->
        <div class="col-lg-7">
            <h4 class="bg-light-formservice text-white p-2">FORMS</h4>
            <div class="row p-2">
                <div class="col-md-6 mb-3">
                    <div class="card bg-light-green">
                        <div class="card-body">
                            <div class="d-flex mb-4">
                                <img src="https://voters.eci.gov.in/static/media/form6NewImage.0deb980d9fa70394813cd83fc8f96bc7.svg" class="icon" alt="images1">
                                <div class="ms-5">
                                    <h5 class="card-title text-danger">New registration for E-voter electors</h5>
                                    <p class="card-text">Fill Form 6 if you are 18 years or above or you will turn 18 in few months</p>
                                   <!-- here button open -->
                                    <!-- here button closed -->
                                </div>
                                
                            </div>
                            <a href="userRequest.jsp" class="btn btn-success">Fill Form</a>
                            <a href="#" class="btn btn-link">Download</a>
                            <a href="#" class="btn btn-link">Guidelines</a>
                        </div>
                    </div>
                </div>
                <!-- Add more forms as needed -->
                <div class="col-md-6 mb-3">
                    <div class="card bg-light-blue">
                        <div class="card-body">
                            <div class="d-flex mb-4">
                                <img src="	https://voters.eci.gov.in/static/media/form6ANewImage.43b6bcbe52e49d197d8914469896e361.svg" class="icon" alt="images2">
                                <div class="ms-5">
                                    <h5 class="card-title">New registration for overseas (NRI) electors</h5>
                                    <p class="card-text">Fill Form 6A if you are a citizen of India and have of any other country.</p>
                                
                                </div>
                            </div>
                            <a href="#" class="btn btn-primary">Fill Form 6A</a>
                            <a href="#" class="btn btn-link">Download</a>
                            <a href="#" class="btn btn-link">Guidelines</a>
                        </div>
                    </div>
                </div>
                <!--2nd row 1st Add more forms as start -->
                <div class="col-md-6 mb-3">
                    <div class="card second-row-1st">
                        <div class="card-body">
                            <div class="d-flex mb-5">
                                <img src="https://voters.eci.gov.in/static/media/form7NewImage.c9214d53efaf287038b7edbb1ae58473.svg" class="icon" alt="images2">
                                <div class="ms-5">
                                    <h5 class="card-title w-50">Objection for proposed</h5>
                                    <h5 class="card-title w-60">inclusion/deletion of name in existing</h5>
                                    <h5 class="card-title w-60">roll</h5>
                                    <p class="card-text">Fill Form 7 to get name deleted from the existing electoral roll.</p>
                                
                                </div>
                            </div>
                            <a href="#" class="btn btn-primary">Fill Form 6A</a>
                            <a href="#" class="btn btn-link">Download</a>
                            <a href="#" class="btn btn-link">Guidelines</a>
                        </div>
                    </div>
                </div>
                 <!--2nd row 1st Add more forms as end -->

                <!--2nd row 2nd Add more forms as start -->
                <div class="col-md-6 mb-3">
                    <div class="card second-row-2nd">
                        <div class="card-body">
                            <div class="d-flex mb-5">
                                <img src="https://voters.eci.gov.in/static/media/form8NewImage.13bd63999e3b9fc676cc638e74dd2831.svg" class="icon" alt="images2">
                                <div class="ms-5">
                                    <h5 class="card-title w-60 lh-base">Shifting of residence/correction of entries in existing electoral roll/replacement of EPIC/marking of</h5>
                                    <h5 class="card-title w-60 lh-base">PwD</h5>
                                    <p class="card-text">Fill Form 8 to get EPIC with updated or replacement or marking of PwD.</p>
                                
                                </div>
                            </div>
                            <a href="#" class="btn btn-primary">Fill Form 6A</a>
                            <a href="#" class="btn btn-link">Download</a>
                            <a href="#" class="btn btn-link">Guidelines</a>
                        </div>
                    </div>
                </div>
                 <!--2nd row 2nd Add more forms as end -->

                 <!--3rd row Add more forms as start -->
                 <div class="col-lg-12 mb-3">
                    <div class="card third-row">
                        <div class="card-body">
                            <div class="d-flex mb-3">
                                <img src="https://voters.eci.gov.in/static/media/form6BNewImage.6bf01d7a7e1c04c6e1ac3aa5654aaa3d.svg" class="icon" alt="images2">
                                <div class="ms-5">
                                    <h5 class="card-title">Aadhaar collection</h5>
                                    <p class="card-text">Fill Form 6B to get Aadhaar and EPIC.</p>
                                
                                </div>
                            </div>
                            <a href="#" class="btn btn-primary">Fill Form 6A</a>
                            <a href="#" class="btn btn-link">Download</a>
                            <!-- <a href="#" class="btn btn-link">Guidelines</a> -->
                        </div>
                    </div>
                </div>
                   <!--3rd row Add more forms as end -->


                <!--4th row 1st Add more forms as start -->
                 <div class="col-md-6 mb-3">
                    <div class="card fourth-row-1st">
                        <div class="card-body">
                            <div class="d-flex mb-4">
                                <img src="https://voters.eci.gov.in/static/media/formM.719264123811b65091c5a7e31983e9ed.svg" class="icon" alt="images2">
                                <div class="ms-5">
                                    <h5 class="card-title">Form M</h5>
                                    <p class="card-text">This form is for the Migrant Electors of Kashmir who want to cast vote from any one special polling station of Delhi, Jammu and Udhampur.</p>
                                
                                </div>
                            </div>
                            <!-- <a href="#" class="btn btn-primary">Fill Form 6A</a> -->
                            <a href="#" class="btn btn-link">Download</a>
                        </div>
                    </div>
                </div>
                   <!--4th row 1st Add more forms as end -->

                    <!--4th row 2nd Add more forms as start -->
                 <div class="col-md-6 mb-3">
                    <div class="card fourth-row-2nd">
                        <div class="card-body">
                            <div class="d-flex mb-4">
                                <img src="	https://voters.eci.gov.in/static/media/form12C.0972208df62c5019110de761420c8057.svg
                                " class="icon" alt="images2">
                                <div class="ms-5">
                                    <h5 class="card-title">Form 12C</h5>
                                    <p class="card-text">This form is for Migrant Electors of Kashmir who want to cast vote through postal ballot.</p>
                                
                                </div>
                            </div>
                            <!-- <a href="#" class="btn btn-primary">Fill Form 6A</a> -->
                            <a href="#" class="btn btn-link mb-4">Download</a>
                        </div>
                    </div>
                </div>
                   <!--4th row 2nd Add more forms as end -->
                 

            </div>
        </div>

        <!-- Services Section -->
        <div class="col-lg-5">
            <h4 class="bg-light-formservice text-white p-2">SERVICES</h4>
            <div class="row p-2">

                                <!--SERVICES 1st row 1st card Add start -->
                                <div class="col-md-6 mb-3">
                                    <div class="card ser-1st-row-1st">
                                        <div class="card-body">
                                            <div class="d-flex">
                                                <img src="https://voters.eci.gov.in/static/media/GreviencePortalIcon.826c4b5b5c8459fee99942b74406aa60.svg" class="icon" alt="images2">
                                                <div class="ms-5">
                                                    <h5 class="card-title fs-6 text-white">Register Complaint/ Share Suggestion</h5>        
                                                </div>
                                            </div>
                                            <a href="#" class="btn btn-link text-white mt-2">Chatbot</a>
                                            <!-- <a href="#" class="btn btn-primary">Fill Form 6A</a> -->
                                            <!-- <a href="#" class="btn btn-link">Guidelines</a> -->
                                        </div>
                                    </div>
                                </div>
                                 <!--SERVICES 1st row 1st card Add End -->

                <!--SERVICES 1st row 2nd card Add more start -->
                <div class="col-md-6 mb-3">
                    <div class="card ser-1st-row-2nd">
                        <div class="card-body">
                            <div class="d-flex mb-5">
                                <img src="	https://voters.eci.gov.in/static/media/TrackApplicationIcon.137536280aaf648088bf44980f9104bd.svg" class="icon" alt="images2">
                                <div class="ms-5 text-white">
                                    <h5 class="card-title fs-6">Track Application Status</h5>
                                    <h6 class="card-text fs-6 w-100">Track all your form status here.</h6>
                                
                                </div>
                            </div>
                            <!-- <a href="#" class="btn btn-primary">Fill Form 6A</a> -->

                        </div>
                    </div>
                </div>
                 <!--SERVICES 1st row 2nd card Add start -->



                                                 <!--SERVICES 2nd row 1st card Add start -->
                                                 <div class="col-md-6 mb-3">
                                                    <div class="card ser-2nd-row-1st">
                                                        <div class="card-body">
                                                            <div class="d-flex mb-3">
                                                                <img src="https://voters.eci.gov.in/static/media/SearchInElRoleIcon.acb5d8787a2b81c7c1343e67453575fc.svg" class="icon" alt="images2">
                                                                <div class="ms-5">
                                                                    <h5 class="card-title fs-6 text-white">Register Complaint/ Share Suggestion</h5>        
                                                                </div>
                                                            </div>
                                                            <!-- <a href="#" class="btn btn-link text-white mt-2">Chatbot</a> -->
                                                            <!-- <a href="#" class="btn btn-primary">Fill Form 6A</a> -->
                                                            <!-- <a href="#" class="btn btn-link">Guidelines</a> -->
                                                        </div>
                                                    </div>
                                                </div>
                                                 <!--SERVICES 2nd row 1st card Add End -->
                
                                <!--SERVICES 2nd row 2nd card Add start -->
                                <div class="col-md-6 mb-3">
                                    <div class="card ser-2nd-row-2nd">
                                        <div class="card-body">
                                            <div class="d-flex mb-3">
                                                <img src="	https://voters.eci.gov.in/static/media/DownloadEEpicIconNew.d2b45d94b6489faacccb4c5ff5388415.svg" class="icon" alt="images2">
                                                <div class="ms-5 text-white">
                                                    <h5 class="card-title fs-6">Track Application Status</h5>
                                                    <h6 class="card-text fs-6 w-100">Track all your form status here.</h6>
                                                
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                                 <!--SERVICES 1st row 2nd card Add start -->


                            <!--SERVICES 3rd row card Add start -->
                                <div class="col-lg-12 mb-3">
                                    <div class="card ser-3rd-row">
                                        <div class="card-body">
                                            <div class="d-flex mb-3">
                                                <img src="https://voters.eci.gov.in/static/media/KnowBoothIcon.ce9c0c6254fa535b837b9f953ce6a537.svg" class="icon" alt="images2">
                                                <div class="ms-5 text-white">
                                                    <h5 class="card-title fs-6">Track Application Status</h5>
                                                    <h6 class="card-text fs-6 w-100">Track all your form status here.</h6>
                                                
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                                 <!--SERVICES 3rd row card Add End -->

                                 
<hr>

                            <!--SERVICES 4th row card Add start -->
                            <div class="col-lg-12 mb-3">
                                <div class="card ser-4th-row">
                                    <div class="card-body">
                                        <div class="d-flex mb-3">
                                            <img src="https://voters.eci.gov.in/static/media/faqIconQuestionMark.2c1c2634ce5a1110be2035bdc09cb96c.svg" class="icon2" alt="images2">
                                            <div class="ms-5">
                                                <h4 class="card-title fs-6 mt-4">Freequently Asked Questions</h4>
                                            
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                             <!--SERVICES 4th row card Add End -->


                             <!--SERVICES 5th row card Add start -->
                            <div class="col-lg-12 mb-3">
                                <div class="card ser-4th-row">
                                    <div class="card-body">
                                        <div class="d-flex mb-3">
                                            <img src="	https://voters.eci.gov.in/static/media/EciIconVspHomepage.f1917254012137eecf05da0435cb3e49.svg" class="icon2" alt="images2">
                                            <div class="ms-5">
                                                <h4 class="card-title fs-6 mt-4">Visit ECI Website : <a href="https://voters.eci.gov.in/">https://eci.gov.in</a></h4>
                                            
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                             <!--SERVICES 5th row card Add End -->
                
                     <!--SERVICES 6th row card Add start -->
                            <div class="col-lg-12 mb-3">
                                <div class="card ser-4th-row">
                                    <div class="card-body">
                                        <div class="d-flex mb-3">
                                            <img src="icon/ele-logo.png" class="icon2" alt="images2">
                                            <div class="ms-5">
                                                <h4 class="card-title fs-6 mt-4">General Elections 2024 : <a href="https://elections24.eci.gov.in/">https://elections24.eci.gov.in</a></h4>
                                            
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                             <!--SERVICES 6th row card Add End -->
            </div>
        </div>
    </div>

    <hr>

    <div>
        <h5 class="text-center">@2024 Election Commission of India. All Rights Reserved..</h5>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>

