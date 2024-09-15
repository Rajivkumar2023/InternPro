<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession session1 = request.getSession(false);

    // Redirect to user verification page if the session is invalid or if the user has already voted
    if (session1 == null || session.getAttribute("aadhaar") == null || session.getAttribute("hasVoted") != null) {
        response.sendRedirect("userVerification.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vote for Leader</title>
    <link rel="stylesheet" href="styles.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        button {
            width: 150px;
        }
        /* Countdown Timer Styling */
        #timer {
            font-size: 24px;
            font-weight: bold;
            color: red;
        }
    </style>
    <script type="text/javascript">
        document.addEventListener("DOMContentLoaded", function() {
            // Countdown timer script
            var countdown = 10; // 20 seconds countdown
            var timerElement = document.getElementById("timer");

            function updateTimer() {
                timerElement.textContent = countdown + " seconds remaining";
                countdown--;
                if (countdown < 0) {
                    clearInterval(timerInterval);
                    window.location.href = "userVerification.jsp"; // Redirect to verification page
                }
            }

            var timerInterval = setInterval(updateTimer, 1000);
            updateTimer(); // Initialize the timer display immediately
        });
    </script>
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
                        <a class="nav-link mx-3 text-white" href="registration.jsp">Register</a>
                    </div>
                </div>
            </div>
        </nav>
    </section>

    <!-- Main Content -->
    <div class="container mt-5">
        <h2 class="text-center">Cast Your Vote</h2>
        <!-- Countdown Timer -->
        <div class="text-center mt-3">
            <p id="timer">20 seconds remaining</p>  
        </div>

            <table class="table table-striped table-bordered" style="font-size: 30px;">
                <thead>
                    <tr>
                        <th>Leader Sign</th>
                        <th>Leader Name</th>
                        <th>Party</th>
                        <th>Vote</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><img src="image/bjp.png" alt="BJP" width="80"></td>
                        <td>Amit Kumar</td>
                        <td>BJP</td>
                        <td>
                            <form action="CastVoteServlet" method="post">
                                <input type="hidden" name="leader_name" value="Amit Kumar">
                                <input type="hidden" name="party_name" value="BJP">
                                <button type="submit" class="btn btn-primary text-primary rounded-pill p-2 fs-2">VOTE</button>
                            </form>
                        </td>
                    </tr>
                    <!-- Other leaders... -->
                    <tr>
                        <td><img src="image/congress.png" alt="CONGRESS" width="80"></td>
                        <td>MD Gaffar</td>
                        <td>CONGRESS</td>
                        <td>
                            <form action="CastVoteServlet" method="post">
                                <input type="hidden" name="leader_name" value="MD Gaffar">
                                <input type="hidden" name="party_name" value="CONGRESS">
                                <button type="submit" class="btn btn-primary text-primary rounded-pill p-2 fs-2">VOTE</button>
                            </form>
                        </td>
                    </tr>
                    <!-- Other leaders... -->
                </tbody>
            </table>
    </div>
    
    <!-- for clear all session and cookies  -->
    <script>
document.addEventListener("DOMContentLoaded", function() {
    const messages = document.querySelectorAll(".success-message, .error-message");
    
    messages.forEach(message => {
        setTimeout(() => {
            message.remove();
        }, 11000); // 10s animation delay + 1s animation duration
    });

    // Set a timeout to reload the page after 11 seconds
    setTimeout(() => {
        // Clear all cookies
        document.cookie.split(";").forEach(function(c) {
            document.cookie = c.trim().split("=")[0] + "=;expires=Thu, 01 Jan 1970 00:00:00 UTC;path=/;";
        });

        // Clear session (JavaScript cannot directly clear server-side sessions)
        if (window.sessionStorage) {
            sessionStorage.clear();  // Clears session storage if used
        }

        // Reload the page
        window.location.reload(true); // Force reload to clear any cached data
    }, 11000); // 11 seconds delay (10s fade + 1s)
});
</script>
    
    
    

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
