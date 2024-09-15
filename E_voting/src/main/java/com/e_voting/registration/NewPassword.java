package com.e_voting.registration;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Properties;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;
import jakarta.mail.*;
import jakarta.mail.internet.*;

@WebServlet("/newPassword")
public class NewPassword extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String newPassword = request.getParameter("password");
        String confPassword = request.getParameter("confPassword");
        String email = (String) session.getAttribute("email");
        RequestDispatcher dispatcher = null;

        if (newPassword != null && confPassword != null && newPassword.equals(confPassword)) {
            try {
                // Hash the new password using BCrypt
                String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());

                // Load the MySQL driver
                Class.forName("com.mysql.cj.jdbc.Driver");
                
                // Connect to the database
                Connection con = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/e_voting?useSSL=false", "root", "Rajiv@2023");
                
                // Prepare the SQL statement
                String sql = "UPDATE registration SET upwd = ? WHERE uemail = ?";
                PreparedStatement pst = con.prepareStatement(sql);
                pst.setString(1, hashedPassword);  // Store the hashed password
                pst.setString(2, email);

                // Execute the update
                int rowCount = pst.executeUpdate();

                if (rowCount > 0) {
                    // Notify the user with a message
                    request.setAttribute("status", "resetSuccess");
                    //request.setAttribute("message", "Password reset successfully. You can now log in with your new password.");
//                    request.setAttribute("message", "Password reset successfully. Your new password is: " + newPassword);
                    
                    // Send an email with the new password
                    sendEmail(email, newPassword);

                    dispatcher = request.getRequestDispatcher("login.jsp");
                    System.out.println("Password reset successfully.");
                } else {
                    request.setAttribute("status", "resetFailed");
                   // request.setAttribute("message", "Password reset failed. Try again.");
                    dispatcher = request.getRequestDispatcher("newPassword.jsp");
                    System.out.println("Password reset failed.");
                }
                dispatcher.forward(request, response);
                
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("status", "resetFailed");
                request.setAttribute("message", "An error occurred. Please try again.");
                dispatcher = request.getRequestDispatcher("newPassword.jsp");
                dispatcher.forward(request, response);
            }
        } else {
            // If passwords don't match, return an error
            request.setAttribute("status", "resetFailed");
            request.setAttribute("message", "Passwords do not match. Please try again.");
            dispatcher = request.getRequestDispatcher("newPassword.jsp");
            dispatcher.forward(request, response);
            System.out.println("Password reset failed due to mismatch.");
        }
    }

    private void sendEmail(String recipient, String newPassword) {
        String host = "smtp.gmail.com"; // Update with your SMTP server
        final String user = "rajivdhanama00@gmail.com"; // Update with your email
        final String password = "obel wjzl clud fuwd"; // Update with your email password

        // Set properties
        Properties properties = System.getProperties();
        properties.setProperty("mail.smtp.host", host);
        properties.setProperty("mail.smtp.port", "587");  // Gmail SMTP port for TLS
        properties.setProperty("mail.smtp.auth", "true");
        properties.setProperty("mail.smtp.starttls.enable", "true"); // Enable TLS


        // Get the default session object
        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });

        try {
            // Create a default MimeMessage object
            MimeMessage message = new MimeMessage(session);

            // Set From: header field
            message.setFrom(new InternetAddress(user));

            // Set To: header field
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient));

            // Set Subject: header field
            message.setSubject("Password Reset Successfully");

            // Set the actual message
            message.setText("Your password has been reset successfully. Your new password is: " + newPassword);

            // Send message
            Transport.send(message);
            System.out.println("Email sent successfully.");
        } catch (MessagingException mex) {
            mex.printStackTrace();
        }
    }
}
