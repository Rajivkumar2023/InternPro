package com.e_voting.registration;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/login")
public class Login extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uemail = request.getParameter("username");
        String upwd = request.getParameter("password");
        HttpSession session = request.getSession(); // Get the session (create if not exists)

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/E_voting?useSSL=false", "root", "Rajiv@2023");

            // Fetch the hashed password and username from the database based on the provided email
            PreparedStatement pst = con.prepareStatement("SELECT uname, upwd FROM registration WHERE uemail = ?");
            pst.setString(1, uemail);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                String storedHashedPwd = rs.getString("upwd");
                String uname = rs.getString("uname");

                // Compare the entered password with the stored hashed password
                if (BCrypt.checkpw(upwd, storedHashedPwd)) {
                    // Password match, login successful
                    session.setAttribute("name", uname);
                    
                    // Prevent caching
                    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
                    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
                    response.setDateHeader("Expires", 0); // Proxies

                    // Use redirect instead of forward to implement PRG pattern
                    response.sendRedirect("welcome.jsp");
                } else {
                    // Password does not match
                    request.setAttribute("status", "failed");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
                    dispatcher.forward(request, response);
                }
            } else {
                // Email not found
                request.setAttribute("status", "failed");
                RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
                dispatcher.forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
