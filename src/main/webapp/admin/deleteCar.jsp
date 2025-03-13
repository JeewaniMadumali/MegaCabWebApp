<%@page import="service.CarService" %>
<%@page import="java.io.IOException" %>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    CarService carService = new CarService();
    
    boolean deleted = carService.deleteCar(id);
    
    if (deleted) {
        response.sendRedirect("carList.jsp");
    } else {
        out.println("<script>alert('Failed to delete car.'); window.location='carList.jsp';</script>");
    }
%>
