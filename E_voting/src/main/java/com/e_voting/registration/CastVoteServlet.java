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
import java.sql.SQLException;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

@WebServlet("/CastVoteServlet")
public class CastVoteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("aadhaar") == null) {
            response.sendRedirect("userVerification.jsp");
            return;
        }

        // Check if the user has already voted
        if (session.getAttribute("hasVoted") != null) {
            request.setAttribute("message", "You have already cast your vote. Don't try again.");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("userVerification.jsp").forward(request, response);
            return;
        }

        String aadhaar = (String) session.getAttribute("aadhaar");
        String uniqueKey = (String) session.getAttribute("unique_key");
        String leaderName = request.getParameter("leader_name");
        String partyName = request.getParameter("party_name");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            // Database connection setup
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/E_voting?useSSL=false", "root", "Rajiv@2023");

            // Insert vote details into the database
            String insertVoteQuery = "INSERT INTO votes (aadhaar, unique_key, leader_name, party_name, timestamp) VALUES (?, ?, ?, ?, NOW())";
            ps = con.prepareStatement(insertVoteQuery);
            ps.setString(1, aadhaar);
            ps.setString(2, uniqueKey);
            ps.setString(3, leaderName);
            ps.setString(4, partyName);

            int rowsInserted = ps.executeUpdate();
            if (rowsInserted > 0) {
                // Mark the user as having voted
                session.setAttribute("hasVoted", true);

                // Retrieve user email and name from the database
                User user = getUserDetailsByAadhaar(con, aadhaar);

                if (user != null) {
                    // Send a personalized thank you email with the user's name
                    sendThankYouEmail(user.getEmail(), user.getName(), leaderName, partyName);
                }

                // Redirect to the user verification page with a success message
                request.setAttribute("message", "Your vote has been successfully submitted.");
                request.setAttribute("messageType", "success");
                request.getRequestDispatcher("userVerification.jsp").forward(request, response);
            } else {
                request.setAttribute("message", "Failed to submit your vote. Please try again.");
                request.setAttribute("messageType", "error");
                request.getRequestDispatcher("leaderSelection.jsp").forward(request, response);
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "An error occurred while submitting your vote.");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("leaderSelection.jsp").forward(request, response);
        } finally {
            if (ps != null) try { ps.close(); } catch (Exception ignored) {}
            if (con != null) try { con.close(); } catch (Exception ignored) {}
        }
    }

    // Create a class to store user details
    class User {
        private String email;
        private String name;

        public User(String email, String name) {
            this.email = email;
            this.name = name;
        }

        public String getEmail() {
            return email;
        }

        public String getName() {
            return name;
        }
    }

    // Method to retrieve user email and name based on aadhaar
    private User getUserDetailsByAadhaar(Connection con, String aadhaar) throws SQLException {
        User user = null;
        String query = "SELECT email, name FROM users WHERE aadhaar = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, aadhaar);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String email = rs.getString("email");
                    String name = rs.getString("name");
                    user = new User(email, name);
                }
            }
        }
        return user;
    }

    // Method to send a personalized email
    private void sendThankYouEmail(String to, String userName, String leaderName, String partyName) {
        String from = "rajivdhanama00@gmail.com"; // Your email address
        String host = "smtp.gmail.com"; // Gmail SMTP server

        // Set up email server properties
        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        // Create a session with an authenticator
        Session session = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("rajivdhanama00@gmail.com", "obel wjzl clud fuwd"); // Your email and password
            }
        });

        try {
            // Create a MimeMessage object
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject("Thank You for Voting on E-Voting Platform!");

            // Compose the email body
            String emailBody = "Dear " + userName + ",<br><br>" +
                    "Thank you for using the E-Voting platform to cast your vote!<br>" +
                    "Your vote has been successfully recorded.<br><br>" +
                    "We appreciate your participation in strengthening democracy through secure and accessible voting.<br><br>" +
                    "Sincerely,<br>" +
                    "E-Voting Platform Team";

            message.setContent(emailBody, "text/html");

            // Send the email
            Transport.send(message);
            System.out.println("Email sent successfully.");
        } catch (MessagingException mex) {
            mex.printStackTrace();
        }
    }
}


