package controllers;

import models.Booking;
import service.BookingService;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;

@Path("/bookings")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class BookingController {

    private BookingService bookingService = new BookingService();

    // Get all bookings
    @GET
    @Path("/getAllBookings")
    public Response getAllBookings() {
        List<Booking> bookings = bookingService.getAllBookings();
        return Response.ok(bookings).build();
    }

    // Get a booking by ID
    @GET
    @Path("/{id}")
    public Response getBookingById(@PathParam("id") int id) {
        Booking booking = bookingService.getBookingById(id);
        if (booking != null) {
            return Response.ok(booking).build();
        } else {
            return Response.status(Response.Status.NOT_FOUND).entity("Booking not found").build();
        }
    }

    // Add a new booking
    @POST
    @Path("/addBooking")
    public Response addBooking(Booking booking) {
        boolean created = bookingService.addBooking(booking);
        if (created) {
            return Response.status(Response.Status.CREATED).entity("Booking added successfully").build();
        }
        return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Failed to add booking").build();
    }

    // Update an existing booking
    @PUT
    @Path("/{id}")
    public Response updateBooking(@PathParam("id") int id, Booking booking) {
        booking.setId(id); // Ensure the ID in the request matches the path parameter
        boolean updated = bookingService.updateBooking(booking);
        if (updated) {
            return Response.ok("Booking updated successfully").build();
        }
        return Response.status(Response.Status.NOT_FOUND).entity("Booking not found").build();
    }

    // Delete a booking
    @DELETE
    @Path("/{id}")
    public Response deleteBooking(@PathParam("id") int id) {
        boolean deleted = bookingService.deleteBooking(id);
        if (deleted) {
            return Response.ok("Booking deleted successfully").build();
        }
        return Response.status(Response.Status.NOT_FOUND).entity("Booking not found").build();
    }
}
