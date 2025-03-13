package controllers;

import db.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/FinalizeBookingServlet")
public class FinalizeBookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
    throws ServletException, IOException {

    try {
        // Parse bookingId, kilometers, car_price, and driver
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        double kilometers = Double.parseDouble(request.getParameter("kilometers"));
        double pricePerKm = Double.parseDouble(request.getParameter("car_price"));
        String driver = request.getParameter("driver");

        // Parse discount and tax
        double discount = Double.parseDouble(request.getParameter("discount"));
        double tax = Double.parseDouble(request.getParameter("tax"));

        // Calculate subtotal
        double subtotal = kilometers * pricePerKm;

        // Add driver cost if applicable
        if ("yes".equalsIgnoreCase(driver)) {
            subtotal += 2000; // Add LKR 2000 for the driver
        }

        // Apply discount
        double discountAmount = (subtotal * discount) / 100;
        double discountedTotal = subtotal - discountAmount;

        // Apply tax
        double taxAmount = (discountedTotal * tax) / 100;
        double totalBill = discountedTotal + taxAmount;

        // Update database
        try (Connection con = DBConnection.getConnection()) {
            String query = "UPDATE booking SET kilometers = ?, total_bill = ?, discount = ?, tax = ?, status = 'confirmed' WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setDouble(1, kilometers);
            ps.setDouble(2, totalBill);
            ps.setDouble(3, discount);
            ps.setDouble(4, tax);
            ps.setInt(5, bookingId);

            int rowsUpdated = ps.executeUpdate();
            
            if (rowsUpdated > 0) {
                response.sendRedirect(request.getContextPath() + "/admin/bookings/viewBooking.jsp?message=Booking finalized successfully"); 
            } else {
                response.sendRedirect("error.jsp?error=Booking not found");
            }
        }

    } catch (NumberFormatException e) {
        e.printStackTrace();
        response.sendRedirect("error.jsp?error=Invalid input format: " + e.getMessage());
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("error.jsp?error=An error occurred while finalizing the booking.");
    }
}
}