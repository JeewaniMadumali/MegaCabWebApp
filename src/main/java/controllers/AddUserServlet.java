package controllers;

import models.User;
import service.UserService;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddUserServlet")
public class AddUserServlet extends HttpServlet {
    private UserService userService = new UserService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // Validate input fields
        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            role == null || role.trim().isEmpty()) {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('All fields are required.'); window.location.href='addUser.jsp';</script>");
            return;
        }

        // Hash the password with BCrypt
//        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(12)); // Secure hashing

        // Create a new User object with the hashed password
        User user = new User(0, name, email, password, role);
        boolean isAdded = userService.addUser(user);

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        if (isAdded) {
            response.sendRedirect(request.getContextPath() + "/admin/adminIndex.jsp"); // Redirect to admin dashboard
            out.println("<script>alert('User added successfully!');</script>");
        } else {
            out.println("<script>alert('Failed to add user. Try again.'); window.location.href='addUser.jsp';</script>");
        }
    }
}
