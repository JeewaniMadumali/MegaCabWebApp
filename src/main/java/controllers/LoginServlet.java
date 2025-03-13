package controllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "All fields are required.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        Connection con = null;
        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");
        	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab","root","1122");
            String sql = "SELECT id, name, email, password, role FROM users WHERE email = ?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, email);
            ResultSet  rs = pst.executeQuery();

            if (rs.next()) {
                String hashedPassword = rs.getString("password");
                String role = rs.getString("role");

                if (password.equals(hashedPassword)) {
//                    int userId = rs.getInt("id");
                    String userName = rs.getString("name");

                    // Store user details in session
                    HttpSession session = request.getSession();
                    session.setAttribute("loggedUser", 1);
                    session.setAttribute("userName", userName);
                    session.setAttribute("userRole", role);

                    // Redirect user based on role
                    if ("admin".equalsIgnoreCase(role)) {
                        response.sendRedirect(request.getContextPath() + "/admin/adminIndex.jsp");
                    } else {
                        response.sendRedirect("index.jsp");
                    }
                    return;
                } else {
                    request.setAttribute("errorMessage", "Invalid email or password.");
                }
            } else {
               
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred during login. Please try again.");
        } catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
