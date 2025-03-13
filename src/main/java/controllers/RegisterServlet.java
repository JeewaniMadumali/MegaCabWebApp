package controllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import db.DBConnection;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Extract form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validate form data (basic validation)
        if (name == null || name.trim().isEmpty() || email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "All fields are required.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
//         String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        Connection con = null;
        
        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab","root","1122");
			String sql = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";
			PreparedStatement pst  = con.prepareStatement(sql);
			pst.setString(1, name);
			pst.setString(2, email);
			pst.setString(3, password);

            int rowsAffected = pst.executeUpdate();

            if (rowsAffected > 0) {
//                request.setAttribute("successMessage", "Registration successful!");
                request.getSession().setAttribute("userName", name);
                response.sendRedirect("login.jsp");
                return;
            } else {
                request.setAttribute("errorMessage", "Registration failed. Please try again.");
            }
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        

        // Forward the request to the register page to display the message
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }
}