package controllers;

import db.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ApproveBookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("UPDATE booking SET status = 'approved' WHERE id = ?")) {
            
            ps.setInt(1, bookingId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirect admin to the kilometer entry page
        response.sendRedirect(request.getContextPath() + "/admin/bookings/approve_booking.jsp?bookingId=" + bookingId);

    }
}
