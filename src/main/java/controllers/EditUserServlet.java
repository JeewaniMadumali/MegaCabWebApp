package controllers;

import models.User;
import service.UserService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/EditUserServlet")
public class EditUserServlet extends HttpServlet {
    private UserService userService = new UserService();

    // Handle GET request to fetch user details for editing
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);

                // Fetch the user from the database
                User user = userService.getUserById(id);

                if (user != null) {
                    // Set the user as a request attribute and forward to the edit page
                    request.setAttribute("user", user);
                    request.getRequestDispatcher("/admin/user/editUser.jsp").forward(request, response);
                } else {
                    // Redirect if user not found
                    response.sendRedirect(request.getContextPath() + "/admin/user/viewUser.jsp?error=User+not+found");
                }
            } catch (NumberFormatException e) {
                // Handle invalid ID format
                response.sendRedirect(request.getContextPath() + "/admin/user/viewUser.jsp?error=Invalid+user+ID");
            }
        } else {
            // Redirect if ID is missing
            response.sendRedirect(request.getContextPath() + "/admin/user/viewUser.jsp?error=User+ID+is+required");
        }
    }

    // Handle POST request to update user details
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);

                // Validate input fields
                if (name == null || name.trim().isEmpty() ||
                    email == null || email.trim().isEmpty() ||
                    password == null || password.trim().isEmpty() ||
                    role == null || role.trim().isEmpty()) {

                    response.sendRedirect(request.getContextPath() + "/admin/user/editUser.jsp?id=" + id + "&error=All+fields+are+required");
                    return;
                }

                // Create a User object and update it in the database
                User user = new User(id, name, email, password, role);
                boolean isUpdated = userService.updateUser(user);

                if (isUpdated) {
                    // Redirect to the view users page with a success message
                    response.sendRedirect(request.getContextPath() + "/admin/user/viewUser.jsp?message=User+updated+successfully");
                } else {
                    // Redirect with an error message if update fails
                    response.sendRedirect(request.getContextPath() + "/admin/user/editUser.jsp?id=" + id + "&error=Failed+to+update+user");
                }
            } catch (NumberFormatException e) {
                // Handle invalid ID format
                response.sendRedirect(request.getContextPath() + "/admin/user/viewUser.jsp?error=Invalid+user+ID");
            }
        } else {
            // Redirect if ID is missing
            response.sendRedirect(request.getContextPath() + "/admin/user/viewUser.jsp?error=User+ID+is+required");
        }
    }
}