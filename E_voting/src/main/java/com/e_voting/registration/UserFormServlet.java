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
import java.time.LocalDate;
import java.time.Period;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

@WebServlet("/UserFormServlet")
public class UserFormServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String name = request.getParameter("name");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String aadhaar = request.getParameter("adhar");
        String voter = request.getParameter("voter");
        String address = request.getParameter("address");
        String ward = request.getParameter("ward");
        String district = request.getParameter("district");
        String state = request.getParameter("state");
        String pincode = request.getParameter("pincode");

        // Calculate the user's age based on the provided date of birth
        LocalDate currentDate = LocalDate.now();
        LocalDate birthDate = LocalDate.parse(dob); // Ensure dob is in 'yyyy-MM-dd' format
        int userAge = Period.between(birthDate, currentDate).getYears();

        // Age validation: Only 18+ users can register
        if (userAge < 18) {
            response.sendRedirect("userRequest.jsp?status=underage");
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Load MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish the connection
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/E_voting?useSSL=false", "root", "Rajiv@2023");

            // Combined check query
            String combinedCheckQuery = "SELECT * FROM users WHERE email = ? OR aadhaar = ? OR voter_id = ?";
            ps = con.prepareStatement(combinedCheckQuery);
            ps.setString(1, email);
            ps.setString(2, aadhaar);
            ps.setString(3, voter);

            rs = ps.executeQuery();

            if (rs.next()) {
                if (rs.getString("aadhaar").equals(aadhaar)) {
                    // Aadhaar number already exists
                    response.sendRedirect("userRequest.jsp?status=adharExists");
                } else if (rs.getString("voter_id").equals(voter)) {
                    // Voter ID number already exists
                    response.sendRedirect("userRequest.jsp?status=voterExists");
                } else if (rs.getString("email").equals(email)) {
                    // Email ID number already exists
                    response.sendRedirect("userRequest.jsp?status=emailExists");
                }
                return;
            }

            // Prepare SQL query for insertion
            String insertQuery = "INSERT INTO users (title, name, dob, gender, email, mobile, aadhaar, voter_id, address, ward, district, state, pincode) "
                               + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(insertQuery);

            // Set the parameters
            ps.setString(1, title);
            ps.setString(2, name);
            ps.setString(3, dob);
            ps.setString(4, gender);
            ps.setString(5, email);
            ps.setString(6, mobile);
            ps.setString(7, aadhaar);
            ps.setString(8, voter);
            ps.setString(9, address);
            ps.setString(10, ward);
            ps.setString(11, district);
            ps.setString(12, state);
            ps.setString(13, pincode);

            // Execute the update
            int rowCount = ps.executeUpdate();

            if (rowCount > 0) {
                // Registration successful, send success status
                response.sendRedirect("userRequest.jsp?status=success");

                // Send confirmation email
                sendConfirmationEmail(email, name);
            } else {
                // Registration failed, send failure status
                response.sendRedirect("userRequest.jsp?status=failed");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("userRequest.jsp?status=failed");
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Method to send confirmation email
    private void sendConfirmationEmail(String toEmail, String userName) {
        String fromEmail = "rajivdhanama00@gmail.com";
        String emailPassword = "obel wjzl clud fuwd"; // Replace with actual password

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
            message.setSubject("E-Voting Registration Confirmation");
            //message.setText("Dear " + userName + ",\n\nThank you for registering for the E-Voting platform.\nYour request has been received successfully.");
            //Transport.send(message);
            
         // Compose the email body
            String emailBody = "Dear " + userName + ",<br><br>" +
                    "Thank you for registering for the E-Voting platform.<br>" +
                    "Your request has been received successfully.<br><br>" +
                    "We appreciate your participation in strengthening democracy through secure and accessible voting.<br><br>" +
                    "Sincerely,<br>" +
                    "E-Voting Platform Team";

            message.setContent(emailBody, "text/html");

            // Send the email
            Transport.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Get the current session (do not create)
        if (session != null) {
            session.invalidate(); // Invalidate the session to log out the user
        }
        response.sendRedirect("login.jsp?message=loggedout"); // Redirect to login page with logged-out message
    }
}

