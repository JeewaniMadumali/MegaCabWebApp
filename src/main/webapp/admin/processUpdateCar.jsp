<%@page import="service.CarService" %>
<%@page import="models.Car" %>
<%@page import="java.io.IOException" %>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    String name = request.getParameter("name");
    String category = request.getParameter("category");
    double price = Double.parseDouble(request.getParameter("price"));
    boolean isAvailable = Boolean.parseBoolean(request.getParameter("isAvailable"));

    Car updatedCar = new Car();
    updatedCar.setId(id);
    updatedCar.setName(name);
    updatedCar.setCategory(category);
    updatedCar.setPrice(price);
    updatedCar.setAvailable(isAvailable);

    CarService carService = new CarService();
    boolean success = carService.updateCar(updatedCar);

    if (success) {
        response.sendRedirect("carList.jsp"); // Redirect to the car list
    } else {
        out.println("<script>alert('Failed to update car.'); window.location='updateCar.jsp?id=" + id + "';</script>");
    }
%>
