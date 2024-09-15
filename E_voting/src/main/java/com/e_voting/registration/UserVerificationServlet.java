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

@WebServlet("/UserVerificationServlet")
public class UserVerificationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String aadhaar = request.getParameter("aadhaar");
        String uniqueKey = request.getParameter("uniqueKey");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/E_voting?useSSL=false", "root", "Rajiv@2023");

            // Step 1: Check if the user has already cast their vote
            String checkVoteQuery = "SELECT * FROM votes WHERE aadhaar = ? AND unique_key = ?";
            ps = con.prepareStatement(checkVoteQuery);
            ps.setString(1, aadhaar);
            ps.setString(2, uniqueKey);
            rs = ps.executeQuery();

            if (rs.next()) {
                // User has already voted
                request.setAttribute("message", "You have already cast your vote. Don't try again.");
                request.getRequestDispatcher("userVerification.jsp").forward(request, response);
                return; // Exit early since the user has already voted
            }

            // Step 2: If not voted, proceed to check Aadhaar and Unique Key
            String query = "SELECT * FROM users WHERE aadhaar = ? AND unique_key = ? AND verified = TRUE AND rejected = FALSE";
            ps = con.prepareStatement(query);
            ps.setString(1, aadhaar);
            ps.setString(2, uniqueKey);
            rs = ps.executeQuery();

            if (rs.next()) {
                // Store Aadhaar and Unique Key in session and redirect to leader selection
                HttpSession session = request.getSession();
                session.setAttribute("aadhaar", aadhaar);
                session.setAttribute("unique_key", uniqueKey);
                response.sendRedirect("leaderSelection.jsp");
            } else {
                // Invalid Aadhaar or Unique Key or user not verified
                request.setAttribute("message", "Invalid Aadhaar or Unique Key, or user not verified.");
                request.getRequestDispatcher("userVerification.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "An error occurred during verification. Please try again.");
            request.getRequestDispatcher("userVerification.jsp").forward(request, response);
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception ignored) {}
            if (ps != null) try { ps.close(); } catch (Exception ignored) {}
            if (con != null) try { con.close(); } catch (Exception ignored) {}
        }
    }
}
