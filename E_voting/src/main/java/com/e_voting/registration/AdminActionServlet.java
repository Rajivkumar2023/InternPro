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
import java.security.SecureRandom;
import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;
@WebServlet("/AdminActionServlet")
public class AdminActionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userEmail = request.getParameter("userEmail");
        String action = request.getParameter("action");

        Connection con = null;
        PreparedStatement ps = null;
        String message = "";

        try {
            // Setup database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/E_voting?useSSL=false", "root", "Rajiv@2023");

            if ("verify".equals(action)) {
                // Get Aadhaar and voter ID for tracking purposes
                String aadhaar = getAadhaarByEmail(con, userEmail);
                String voterId = getVoterIdByEmail(con, userEmail);

                // Generate a 10-digit random unique key
                String uniqueKey = generateUniqueKey();

                // Update user status and unique key
                String updateQuery = "UPDATE users SET verified = ?, rejected = ?, unique_key = ? WHERE email = ? AND voter_id = ?";
                ps = con.prepareStatement(updateQuery);
                ps.setBoolean(1, true);
                ps.setBoolean(2, false); // Not rejected if verified
                ps.setString(3, uniqueKey); // Store the generated key
                ps.setString(4, userEmail);
                ps.setString(5, voterId);  // Use voter ID to support multiple requests
                
                // Check the number of rows updated
                int rowsAffected = ps.executeUpdate();
                if (rowsAffected > 0) {
                    System.out.println("Unique key successfully stored for user: " + userEmail);
                } else {
                    System.out.println("No rows were updated. Please check the userEmail and voterId.");
                }

                // Get the username for email content
                String username = getUsernameByEmail(con, userEmail);

                // Send verification email with the unique key
                sendNotification(userEmail, true, uniqueKey, username);
                message = "User verified successfully. Verification email sent.";

            } else if ("reject".equals(action)) {
                // Update user status to rejected
                String updateQuery = "UPDATE users SET verified = ?, rejected = ? WHERE email = ?";
                ps = con.prepareStatement(updateQuery);
                ps.setBoolean(1, false); // Not verified
                ps.setBoolean(2, true);  // Rejected
                ps.setString(3, userEmail);
                ps.executeUpdate();

                // Get the username for email content
                String username = getUsernameByEmail(con, userEmail);

                // Send rejection email
                sendNotification(userEmail, false, null, username);
                message = "User rejected successfully. Rejection email sent.";
            }

            // Set message in session and redirect to adminPanel.jsp
            HttpSession session = request.getSession();
            session.setAttribute("message", message);
            response.sendRedirect("adminPanel.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            // Set error message and redirect to adminPanel.jsp
            HttpSession session = request.getSession();
            session.setAttribute("message", "An error occurred while processing the action.");
            response.sendRedirect("adminPanel.jsp");

        } finally {
            if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }

    // Method to generate a 10-digit random unique key
    private String generateUniqueKey() {
        SecureRandom random = new SecureRandom();
        StringBuilder key = new StringBuilder();
        String characters = "0123456789"; // Numeric characters for a 10-digit key

        // Generate a 10-digit random unique key
        for (int i = 0; i < 10; i++) {
            int index = random.nextInt(characters.length());
            key.append(characters.charAt(index));
        }
        return key.toString();
    }

    // Method to retrieve Aadhaar by email
    private String getAadhaarByEmail(Connection con, String email) throws SQLException {
        String aadhaar = "";
        String query = "SELECT aadhaar FROM users WHERE email = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    aadhaar = rs.getString("aadhaar");
                }
            }
        }
        return aadhaar;
    }

    // Method to retrieve Voter ID by email
    private String getVoterIdByEmail(Connection con, String email) throws SQLException {
        String voterId = "";
        String query = "SELECT voter_id FROM users WHERE email = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    voterId = rs.getString("voter_id");
                }
            }
        }
        return voterId;
    }

    // Method to retrieve username by email
    private String getUsernameByEmail(Connection con, String email) throws SQLException {
        String username = "";
        String query = "SELECT name FROM users WHERE email = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    username = rs.getString("name");
                }
            }
        }
        return username;
    }

    // Method to send email notification
    private void sendNotification(String toEmail, boolean isVerified, String uniqueKey, String username) {
        final String fromEmail = "rajivdhanama00@gmail.com";
        final String emailPassword = "obel wjzl clud fuwd"; // Update with your app-specific password

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, emailPassword);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("E-Voting Verification Status");

            String emailContent = "Dear " + username + ",\n\n"
                    + "We are pleased to inform you that your verification status for the E-Voting platform has been updated.\n\n"
                    + (isVerified
                       ? "Congratulations! You are now verified and your E-voting number is: " + uniqueKey + ".\n"
                         + "You can now cast your vote using our secure E-voting website. Please ensure to review all options carefully before submitting your vote.\n\n"
                         + "For any assistance, feel free to contact our support team.\n\n"
                       : "Unfortunately, your request for verification was not successful. If you believe this is an error, please contact our support team for further assistance.\n\n")
                    + "Thank you for participating in the democratic process.\n\n"
                    + "Sincerely,\n"
                    + "The E-Voting Platform Team";


            message.setText(emailContent);
            Transport.send(message);

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}

