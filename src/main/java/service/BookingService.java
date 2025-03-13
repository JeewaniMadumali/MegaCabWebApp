package service;

import db.DBConnection;
import models.Booking;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class BookingService {

    // Get all bookings
    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT * FROM booking";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setId(rs.getInt("id"));
                booking.setBookingNumber(rs.getString("booking_number"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setCarId(rs.getInt("car_id"));
                booking.setPickupDate(rs.getDate("pickup_date"));
                booking.setReturnDate(rs.getDate("return_date"));
                booking.setDriver(rs.getString("driver"));
                booking.setDestinationFrom(rs.getString("destination_from")); 
                booking.setDestinationTo(rs.getString("destination_to"));  
                bookings.add(booking);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bookings;
    }

    // Get a booking by ID
    public Booking getBookingById(int id) {
        String query = "SELECT * FROM booking WHERE id = ?";
        Booking booking = null;
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    booking = new Booking();
                    booking.setId(rs.getInt("id"));
                    booking.setBookingNumber(rs.getString("booking_number"));
                    booking.setUserId(rs.getInt("user_id"));
                    booking.setCarId(rs.getInt("car_id"));
                    booking.setPickupDate(rs.getDate("pickup_date"));
                    booking.setReturnDate(rs.getDate("return_date"));
                    booking.setDriver(rs.getString("driver"));
                    booking.setDestinationFrom(rs.getString("destination_from"));
                    booking.setDestinationTo(rs.getString("destination_to"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return booking;
    }

    // Add a new booking
    public boolean addBooking(Booking booking) {
        String query = "INSERT INTO booking (booking_number, user_id, car_id, pickup_date, return_date, driver, destination_from, destination_to) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

            LocalDate pickupDate = LocalDate.parse(booking.getPickupDate().toString(), formatter);
            LocalDate returnDate = LocalDate.parse(booking.getReturnDate().toString(), formatter);

            ps.setString(1, booking.getBookingNumber());
            ps.setInt(2, booking.getUserId());
            ps.setInt(3, booking.getCarId());
            ps.setDate(4, java.sql.Date.valueOf(pickupDate));
            ps.setDate(5, java.sql.Date.valueOf(returnDate));
            ps.setString(6, booking.getDriver());
            ps.setString(7, booking.getDestinationFrom());
            ps.setString(8, booking.getDestinationTo());
            
            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update an existing booking
    public boolean updateBooking(Booking booking) {
        String query = "UPDATE booking SET booking_number = ?, user_id = ?, car_id = ?, pickup_date = ?, return_date = ?, driver = ?, destination_from = ?, destination_to = ? WHERE id = ?";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setString(1, booking.getBookingNumber());
            ps.setInt(2, booking.getUserId());
            ps.setInt(3, booking.getCarId());
            ps.setDate(4, new java.sql.Date(booking.getPickupDate().getTime()));
            ps.setDate(5, new java.sql.Date(booking.getReturnDate().getTime()));
            ps.setString(6, booking.getDriver());
            ps.setString(7, booking.getDestinationFrom());
            ps.setString(8, booking.getDestinationTo());
            ps.setInt(9, booking.getId());
            
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete a booking
    public boolean deleteBooking(int id) {
        String query = "DELETE FROM booking WHERE id = ?";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setInt(1, id);
            
            int rowsDeleted = ps.executeUpdate();
            return rowsDeleted > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
