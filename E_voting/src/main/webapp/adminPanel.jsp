<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    // Prevent caching of admin pages
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setDateHeader("Expires", 0); // Proxies.

    // Check if the session exists and the admin attribute is set
    if (session == null || session.getAttribute("admin") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    // Retrieve the username stored in the session
    String username = (String) session.getAttribute("name");
    
    // Retrieve the message if available
    String message = (String) session.getAttribute("message");
    if (message != null) {
        session.removeAttribute("message"); // Clear the message after displaying
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="styles.css">
</head>
<body>

<!-- header part start -->
<section>
    <nav class="navbar navbar-expand-lg navbar-light bg-primary">
        <div class="container-fluid">
            <a class="navbar-brand" href="index.html"><img src="logo.png" alt="logo"></a>
            <div class="portal">
                <p>E-मतदाता सेवा पोर्टल</p>
                <p>E-VOTER'S SERVICE PORTAL</p>
            </div>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                <div class="navbar-nav ms-auto text-center mx-5 fs-5">
                    <a class="nav-link mx-3 text-white" aria-current="page" href="index.html">Welcome to E-Voting</a>
                    <p style="color:white; margin-top:7px;"><%= username %></p>
                    <button class="btn btn-warning m-2" onclick="window.location.href='AdminLogoutServlet'">Logout</button>
                </div>
            </div>
        </div>
    </nav>
</section>
<!-- header part End -->

<div class="container-fluid mt-5">
    <h2 class="text-center">Users Data</h2>
    <% if (message != null) { %>
        <div class="alert alert-info" role="alert">
            <%= message %>
        </div>
    <% } %>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Title</th>
                <th>Name</th>
                <th>DOB</th>
                <th>Gender</th>
                <th>Email</th>
                <th>Mobile</th>
                <th>Aadhaar</th>
                <th>Voter ID</th>
                <th>Address</th>
                <th>Ward no.</th>
                <th>District</th>
                <th>State</th>
                <th>Pincode</th>
                <th>Verified</th>
                <th>Unique Key</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/E_voting?useSSL=false", "root", "Rajiv@2023");

                    String query = "SELECT * FROM users";
                    ps = con.prepareStatement(query);
                    rs = ps.executeQuery();
                    while (rs.next()) {
                        String email = rs.getString("email");
                        boolean isVerified = rs.getBoolean("verified");
                        boolean isRejected = rs.getBoolean("rejected");
            %>
            <tr>
                <td><%= rs.getString("title") %></td>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("dob") %></td>
                <td><%= rs.getString("gender") %></td>
                <td><%= email %></td>
                <td><%= rs.getString("mobile") %></td>
                <td><%= rs.getString("aadhaar") %></td>
                <td><%= rs.getString("voter_id") %></td>
                <td><%= rs.getString("address") %></td>
                <td><%= rs.getString("ward") %></td>
                <td><%= rs.getString("district") %></td>
                <td><%= rs.getString("state") %></td>
                <td><%= rs.getString("pincode") %></td>
                <td><%= isVerified ? "Yes" : "No" %></td>
                <td><%= rs.getString("unique_key") %></td>
                <td>
                    <form action="AdminActionServlet" method="post">
                        <input type="hidden" name="userEmail" value="<%= email %>">
                        <button type="submit" name="action" value="verify" class="btn btn-success" <% if (isVerified || isRejected) { %> disabled <% } %>>Verify</button>
                        <button type="submit" name="action" value="reject" class="btn btn-danger" <% if (isRejected || isVerified) { %> disabled <% } %>>Reject</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                    if (ps != null) try { ps.close(); } catch (SQLException ignored) {}
                    if (con != null) try { con.close(); } catch (SQLException ignored) {}
                }
            %>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
