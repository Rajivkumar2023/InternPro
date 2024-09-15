package com.e_voting.registration;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/AdminLogoutServlet")
public class AdminLogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve the current session, if any
        HttpSession session = request.getSession(false);

        // If a session exists, invalidate it
        if (session != null) {
            session.invalidate();
        }

        // Redirect to the admin login page
       // response.sendRedirect("adminLogin.jsp");
        response.sendRedirect("adminLogin.jsp?message=loggedout");
    }
}
