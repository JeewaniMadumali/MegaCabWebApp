<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="models.Car" %>
<%@page import="service.CarService" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Car List</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
            padding: 10px;
            text-align: left;
        }
        img {
            width: 100px;
            height: auto;
        }
    </style>
</head>
<body>


 <%@ include file="/admin/layout/adminNav.jsp" %>
    <h2>Car List</h2>

    <%
        CarService carService = new CarService();
        List<Car> carList = carService.getAllCars();
    %>

    <table>
        <tr>
            <th>ID</th>
            <th>Image</th>
            <th>Name</th>
            <th>Category</th>
            <!--<th>Price</th>-->
            <th>Availability</th>
            <th>Action</th>
        </tr>

        <% for (Car car : carList) { %>
        <tr>
            <td><%= car.getId() %></td>
            <td>
                <% if (car.getImage() != null && !car.getImage().isEmpty()) { %>
                    <img src="uploads/<%= car.getImage() %>" alt="Car Image">
                <% } else { %>
                    <img src="uploads/default.jpg" alt="Default Image">
                <% } %>
            </td>
            <td><%= car.getName() %></td>
            <td><%= car.getCategory() %></td>
            <!--<td><%= car.getPrice() %></td>-->
            <td><%= car.isAvailable() ? "Available" : "Not Available" %></td>
            <td> 
               <a href="deleteCar.jsp?id=<%= car.getId() %>" class="btn btn-warning" onclick="return confirm('Are you sure you want to delete this car?');">Delete</a>
               <a href="updateCar.jsp?id=<%= car.getId() %>" class="btn btn-success">Update</a>
            </td>
        </tr>
        <% } %>
    </table>

    <br>
    <a href="addCar.jsp" class="btn btn-primary">Add New Car</a>
</body>
</html>
