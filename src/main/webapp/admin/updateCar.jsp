<%@page import="service.CarService" %>
<%@page import="models.Car" %>
<%@page import="java.io.IOException" %>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    CarService carService = new CarService();
    Car car = carService.getCarById(id);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Car</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;      
        }
        h2 {
            color: #333;
            text-align: center;
        }
        form {
            max-width: 500px;
            margin: 20px auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555;
        }
        input[type="text"],
        input[type="number"],
        select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #218838;
        }
        .form-group {
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <%@ include file="/admin/layout/adminNav.jsp" %>

    <h2>Update Car</h2>

    <form action="processUpdateCar.jsp" method="post">
        <input type="hidden" name="id" value="<%= car.getId() %>">

        <div class="form-group">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" value="<%= car.getName() %>" required>
        </div>

        <div class="form-group">
            <label for="category">Category:</label>
            <input type="text" id="category" name="category" value="<%= car.getCategory() %>" required>
        </div>

        <div class="form-group">
            <label for="price">Price:</label>
             <label for="price"><%= car.getPrice() %>:</label>
            <input type="number" step="0.01" id="price" name="price" value="<%= car.getPrice() %>" required>
        </div>

        <div class="form-group">
            <label for="isAvailable">Availability:</label>
            <select id="isAvailable" name="isAvailable">
                <option value="true" <%= car.isAvailable() ? "selected" : "" %> >Available</option>
                <option value="false" <%= !car.isAvailable() ? "selected" : "" %> >Not Available</option>
            </select>
        </div>

        <div class="form-group">
            <input type="submit" value="Update">
        </div>
    </form>
</body>
</html>