////package com.e_voting.registration;
////
////import java.io.IOException;
////import java.util.Properties;
////import java.util.Random;
////
////import jakarta.mail.Message;
////import jakarta.mail.MessagingException;
////import jakarta.mail.PasswordAuthentication;
////import jakarta.mail.Session;
////import jakarta.mail.Transport;
////import jakarta.mail.internet.InternetAddress;
////import jakarta.mail.internet.MimeMessage;
////import jakarta.servlet.RequestDispatcher;
////import jakarta.servlet.ServletException;
////import jakarta.servlet.annotation.WebServlet;
////import jakarta.servlet.http.HttpServlet;
////import jakarta.servlet.http.HttpServletRequest;
////import jakarta.servlet.http.HttpServletResponse;
////import jakarta.servlet.http.HttpSession;
////
////@WebServlet("/forgotPassword")
////public class ForgotPassword extends HttpServlet {
////    @Override
////    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
////            throws ServletException, IOException {
////        
////        String email = request.getParameter("email");
////        RequestDispatcher dispatcher = null;
////        HttpSession mySession = request.getSession();
////        
////        if (email != null && !email.isEmpty()) {
////            // Generating OTP
////            Random rand = new Random();
////            int otpvalue = rand.nextInt(999999); // Changed upper bound to 999999 for a 6-digit OTP
////
////            String to = email;
////            // Get the session object
////            Properties props = new Properties();
////            props.put("mail.smtp.host", "smtp.gmail.com");
////            props.put("mail.smtp.port", "587");
////            props.put("mail.smtp.auth", "true");
////            props.put("mail.smtp.starttls.enable", "true"); // Enable STARTTLS
////
////            Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
////                protected PasswordAuthentication getPasswordAuthentication() {
////                    return new PasswordAuthentication("rajivdhanama00@gmail.com", "obel wjzl clud fuwd"); // Use environment variables for sensitive data
////                }
////            });
////
////            try {
////                MimeMessage message = new MimeMessage(session);
////                message.setFrom(new InternetAddress("rajivdhanama00@gmail.com"));
////                message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
////                message.setSubject("Your OTP Code");
////                message.setText("Your OTP is: " + otpvalue);
////
////                Transport.send(message);
////                System.out.println("Message sent successfully");
////
////                // Forward to EnterOtp.jsp
////                dispatcher = request.getRequestDispatcher("EnterOtp.jsp");
////                request.setAttribute("message", "OTP is sent to your email ID");
////                mySession.setAttribute("otp", otpvalue);
////                mySession.setAttribute("email", email);
////                dispatcher.forward(request, response);
////
////            } catch (MessagingException e) {
////                e.printStackTrace();
////                request.setAttribute("errorMessage", "Failed to send OTP. Please try again.");
////                dispatcher = request.getRequestDispatcher("ForgotPassword.jsp"); // Redirect to the original page or an error page
////                dispatcher.forward(request, response);
////            }
////
////        } else {
////            request.setAttribute("errorMessage", "Email cannot be empty.");
////            dispatcher = request.getRequestDispatcher("ForgotPassword.jsp"); // Redirect to the original page or an error page
////            dispatcher.forward(request, response);
////        }
////    }
////}
//
//
//
//
//
//
//
//
//package com.e_voting.registration;
//
//import org.mindrot.jbcrypt.BCrypt; 
//
//import jakarta.mail.Message;
//import jakarta.mail.MessagingException;
//import jakarta.mail.PasswordAuthentication;
//import jakarta.mail.Session;
//import jakarta.mail.Transport;
//import jakarta.mail.internet.InternetAddress;
//import jakarta.mail.internet.MimeMessage;
//import jakarta.servlet.RequestDispatcher;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//
//import java.io.IOException;
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;
//import java.sql.SQLException;
//import java.util.Properties;
//import java.util.Random;
//
//@WebServlet("/forgotPassword")
//public class ForgotPassword extends HttpServlet {
//    private static final long serialVersionUID = 1L;
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
//            throws ServletException, IOException {
//        
//        String email = request.getParameter("email");
//        RequestDispatcher dispatcher = null;
//        HttpSession mySession = request.getSession();
//        
//        if (email != null && !email.isEmpty()) {
//            // Generating OTP
//            Random rand = new Random();
//            int otpvalue = rand.nextInt(999999); // Generate a 6-digit OTP
//
//            String to = email;
//            // Get the session object
//            Properties props = new Properties();
//            props.put("mail.smtp.host", "smtp.gmail.com");
//            props.put("mail.smtp.port", "587");
//            props.put("mail.smtp.auth", "true");
//            props.put("mail.smtp.starttls.enable", "true"); // Enable STARTTLS
//
//            Session mailSession = Session.getInstance(props, new jakarta.mail.Authenticator() {
//                protected PasswordAuthentication getPasswordAuthentication() {
//                    return new PasswordAuthentication("rajivdhanama00@gmail.com", "obel wjzl clud fuwd"); // Use environment variables for sensitive data
//                }
//            });
//
//            try {
//                MimeMessage message = new MimeMessage(mailSession);
//                message.setFrom(new InternetAddress("rajivdhanama00@gmail.com"));
//                message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
//                message.setSubject("Your OTP Code");
//                message.setText("Your OTP is: " + otpvalue);
//
//                Transport.send(message);
//                System.out.println("Message sent successfully");
//
//                // Forward to EnterOtp.jsp
//                dispatcher = request.getRequestDispatcher("EnterOtp.jsp");
//                request.setAttribute("message", "OTP has been sent to your email.");
//                mySession.setAttribute("otp", otpvalue);
//                mySession.setAttribute("email", email);
//                dispatcher.forward(request, response);
//
//            } catch (MessagingException e) {
//                e.printStackTrace();
//                request.setAttribute("errorMessage", "Failed to send OTP. Please try again.");
//                dispatcher = request.getRequestDispatcher("ForgotPassword.jsp"); // Redirect to the original page or an error page
//                dispatcher.forward(request, response);
//            }
//
//        } else {
//            request.setAttribute("errorMessage", "Email cannot be empty.");
//            dispatcher = request.getRequestDispatcher("ForgotPassword.jsp"); // Redirect to the original page or an error page
//            dispatcher.forward(request, response);
//        }
//    }
//}
//
//
//
//







package com.e_voting.registration;

import org.mindrot.jbcrypt.BCrypt; 

import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.RequestDispatcher;
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
import java.util.Properties;
import java.util.Random;

@WebServlet("/forgotPassword")
public class ForgotPassword extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        RequestDispatcher dispatcher = null;
        HttpSession mySession = request.getSession();
        
        if (email != null && !email.isEmpty()) {
            // Check if the email exists in the database
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/e_voting?useSSL=false", "root", "Rajiv@2023");
                
                String checkEmailQuery = "SELECT * FROM registration WHERE uemail = ?";
                PreparedStatement pst = con.prepareStatement(checkEmailQuery);
                pst.setString(1, email);
                ResultSet rs = pst.executeQuery();

                if (rs.next()) {
                    // Email exists, proceed with OTP generation
                    Random rand = new Random();
                    int otpvalue = rand.nextInt(999999); // Generate a 6-digit OTP

                    String to = email;
                    // Email session properties
                    Properties props = new Properties();
                    props.put("mail.smtp.host", "smtp.gmail.com");
                    props.put("mail.smtp.port", "587");
                    props.put("mail.smtp.auth", "true");
                    props.put("mail.smtp.starttls.enable", "true"); // Enable STARTTLS

                    Session mailSession = Session.getInstance(props, new jakarta.mail.Authenticator() {
                        protected PasswordAuthentication getPasswordAuthentication() {
                            return new PasswordAuthentication("rajivdhanama00@gmail.com", "obel wjzl clud fuwd");
                        }
                    });

                    // Sending OTP
                    try {
                        MimeMessage message = new MimeMessage(mailSession);
                        message.setFrom(new InternetAddress("rajivdhanama00@gmail.com"));
                        message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                        message.setSubject("Your forgot password OTP Code");
                        message.setText("Your forgot password OTP is: " + otpvalue);

                        Transport.send(message);
                        System.out.println("Message sent successfully");

                        // Forward to EnterOtp.jsp
                        dispatcher = request.getRequestDispatcher("EnterOtp.jsp");
                        request.setAttribute("message", "OTP has been sent to your email.");
                        mySession.setAttribute("otp", otpvalue);
                        mySession.setAttribute("email", email);
                        dispatcher.forward(request, response);

                    } catch (MessagingException e) {
                        e.printStackTrace();
                        request.setAttribute("errorMessage", "Failed to send OTP. Please try again.");
                        dispatcher = request.getRequestDispatcher("forgotPassword.jsp");
                        dispatcher.forward(request, response);
                    }
                } else {
                    // Email not registered
                    request.setAttribute("errorMessage", "This email is not registered. Please <a href='registration.jsp'>register</a>.");
                    dispatcher = request.getRequestDispatcher("forgotPassword.jsp");
                    dispatcher.forward(request, response);
                }


            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "An error occurred. Please try again.");
                dispatcher = request.getRequestDispatcher("forgotPassword.jsp");
                dispatcher.forward(request, response);
            }

        } else {
            request.setAttribute("errorMessage", "Email cannot be empty.");
            dispatcher = request.getRequestDispatcher("forgotPassword.jsp");
            dispatcher.forward(request, response);
        }
    }
}


