//package com.e_voting.registration;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import java.io.IOException;
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//
//@WebServlet("/AdminLoginServlet")
//public class AdminLoginServlet extends HttpServlet {
//    private static final long serialVersionUID = 1L;
//
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String username = request.getParameter("username");
//        String password = request.getParameter("password");
//
//        Connection con = null;
//        PreparedStatement ps = null;
//        ResultSet rs = null;
//
//        System.out.println("Received login request for username: " + username); // Debugging
//
//        try {
//            Class.forName("com.mysql.cj.jdbc.Driver");
//            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/E_voting?useSSL=false", "root", "Rajiv@2023");
//
//            String query = "SELECT * FROM admins WHERE username = ? AND password = ?";
//            ps = con.prepareStatement(query);
//            ps.setString(1, username);
//            ps.setString(2, password);
//
//            rs = ps.executeQuery();
//
//            if (rs.next()) {
//                HttpSession session = request.getSession();
//                session.setAttribute("admin", "true");
//                response.sendRedirect("adminPanel.jsp");
//                System.out.println("Login successful for username: " + username); // Debugging
//            } else {
//                response.sendRedirect("adminLogin.jsp?error=invalid");
//                System.out.println("Invalid credentials for username: " + username); // Debugging
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.sendRedirect("adminLogin.jsp?error=error");
//            System.out.println("Error during login for username: " + username + ", error: " + e.getMessage()); // Debugging
//        } finally {
//            try {
//                if (rs != null) rs.close();
//                if (ps != null) ps.close();
//                if (con != null) con.close();
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//        }
//    }
//
//}









package com.e_voting.registration;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the username and password from the login form
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Load MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection to the database
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/E_voting?useSSL=false", "root", "Rajiv@2023");

            // Prepare SQL query to check if the admin credentials exist in the database
            String query = "SELECT * FROM admins WHERE username = ? AND password = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);

            rs = ps.executeQuery();

            if (rs.next()) {
                // Credentials are correct, create a session and redirect to admin dashboard
                HttpSession session = request.getSession();
                session.setAttribute("admin", "true");  // Set admin attribute for session
                session.setAttribute("name", username);  // Optionally, store the admin's name
                response.sendRedirect("adminPanel.jsp");
            } else {
                // Invalid credentials, redirect to login page with an error message
                response.sendRedirect("adminLogin.jsp?error=invalid");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminLogin.jsp?error=error");
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

