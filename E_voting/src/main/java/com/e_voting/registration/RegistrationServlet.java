package com.e_voting.registration;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uname = request.getParameter("name").toUpperCase();
        String uemail = request.getParameter("email");
        String upwd = request.getParameter("pass");
        String re_upwd = request.getParameter("re_pass");
        String umobile = request.getParameter("contact");
        RequestDispatcher dispatcher = null;
        Connection con = null;

        if (!upwd.equals(re_upwd)) {
            request.setAttribute("status", "passwordMismatch");
            dispatcher = request.getRequestDispatcher("registration.jsp");
            dispatcher.forward(request, response);
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/E_voting?useSSL=false", "root", "Rajiv@2023");

            // Check if the username or email is already registered
            PreparedStatement checkUserStmt = con.prepareStatement("SELECT * FROM registration WHERE uname = ? OR uemail = ?");
            checkUserStmt.setString(1, uname);
            checkUserStmt.setString(2, uemail);
            ResultSet rs = checkUserStmt.executeQuery();

            if (rs.next()) {
                if (rs.getString("uemail").equals(uemail)) {
                    request.setAttribute("status", "emailExists");
                } 
                dispatcher = request.getRequestDispatcher("registration.jsp");
            } else {
                // Hash the password before storing it
                String hashedPwd = BCrypt.hashpw(upwd, BCrypt.gensalt());

                // Insert user data into the database
                PreparedStatement pst = con.prepareStatement("INSERT INTO registration(uname,upwd,uemail,umobile) VALUES(?,?,?,?)");
                pst.setString(1, uname);
                pst.setString(2, hashedPwd);
                pst.setString(3, uemail);
                pst.setString(4, umobile);

                int rowCount = pst.executeUpdate();
                dispatcher = request.getRequestDispatcher("registration.jsp");
                if (rowCount > 0) {
                    request.setAttribute("status", "success");
                    // Send email after successful registration
                    sendEmail(uemail, uname, upwd);
                } else {
                    request.setAttribute("status", "failed");
                }
            }

            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    // Method to send email with login details
    private void sendEmail(String recipientEmail, String username, String password) {
        final String senderEmail = "rajivdhanama00@gmail.com"; // Change this to your email
        final String senderPassword = "obel wjzl clud fuwd";     // Change this to your password

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject("Thank You for Registering on E-Voting Platform");
            message.setText("Dear " + username + ",\n\nThank you for registering on E-Voting Platform.\n" +
                    "Your login details are as follows:\n" +
                    "Email: " + recipientEmail + "\n" +
                    "Password: " + password + "\n\n" +
                    "Best regards,\nE-Voting Team");

            Transport.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
