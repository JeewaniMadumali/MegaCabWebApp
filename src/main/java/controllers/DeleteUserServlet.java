package controllers;

import service.UserService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    private UserService userService = new UserService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve the user ID from the request parameter
        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);

                // Delete the user from the database
                boolean isDeleted = userService.deleteUser(id);

                if (isDeleted) {
                    // Redirect to the view users page with a success message
                    response.sendRedirect(request.getContextPath() + "/admin/user/viewUser.jsp?message=User+deleted+successfully");
                } else {
                    // Redirect with an error message if deletion fails
                    response.sendRedirect(request.getContextPath() + "/admin/user/viewUser.jsp?error=Failed+to+delete+user");
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