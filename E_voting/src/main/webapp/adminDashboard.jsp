<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Admin Dashboard</h2>
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Mobile</th>
            <th>Aadhaar</th>
            <th>Voter ID</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/e_voting_db", "root", "password");
                 Statement stmt = connection.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT * FROM users")) {

                while (rs.next()) {
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    String mobile = rs.getString("mobile");
                    String aadhaar = rs.getString("aadhaar");
                    String voterId = rs.getString("voter_id");
                    boolean isVerified = rs.getBoolean("is_verified");
        %>
        <tr>
            <td><%= name %></td>
            <td><%= email %></td>
            <td><%= mobile %></td>
            <td><%= aadhaar %></td>
            <td><%= voterId %></td>
            <td><%= isVerified ? "Verified" : "Pending" %></td>
            <td>
                <a href="VerifyUserServlet?email=<%= email %>" class="btn btn-success btn-sm">Verify</a>
            </td>
        </tr>
        <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>
