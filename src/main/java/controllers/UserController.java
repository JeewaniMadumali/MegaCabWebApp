package controllers;

import models.User;
import service.UserService;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;

@Path("/users")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class UserController {

    private UserService userService = new UserService();

    // Get all users
    @GET
    @Path("/getAllUsers")
    public Response getAllUsers() {
        List<User> users = userService.getAllUsers();
        return Response.ok(users).build();
    }

    // Get a user by ID
    @GET
    @Path("/{id}")
    public Response getUserById(@PathParam("id") int id) {
        User user = userService.getUserById(id);
        if (user != null) {
            return Response.ok(user).build();
        } else {
            return Response.status(Response.Status.NOT_FOUND).entity("User not found").build();
        }
    }

    // Add a new user
    @POST
    @Path("/addUser")
    public Response addUser(User user) {
        boolean created = userService.addUser(user);
        if (created) {
            return Response.status(Response.Status.CREATED).entity("User added successfully").build();
        }
        return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Failed to add user").build();
    }

    // Update an existing user
    @PUT
    @Path("/{id}")
    public Response updateUser(@PathParam("id") int id, User user) {
        user.setId(id); // Ensure the ID in the request matches the path parameter
        boolean updated = userService.updateUser(user);
        if (updated) {
            return Response.ok("User updated successfully").build();
        }
        return Response.status(Response.Status.NOT_FOUND).entity("User not found").build();
    }

    // Delete a user
    @DELETE
    @Path("/{id}")
    public Response deleteUser(@PathParam("id") int id) {
        boolean deleted = userService.deleteUser(id);
        if (deleted) {
            return Response.ok("User deleted successfully").build();
        }
        return Response.status(Response.Status.NOT_FOUND).entity("User not found").build();
    }
}