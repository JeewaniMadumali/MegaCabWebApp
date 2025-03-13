<%@page import="java.util.List"%>
<%@page import="models.Car"%>
<%@page import="service.CarService"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<title>Vehicles</title>


 <%@ include file="navbar.jsp" %>

    <%
        CarService carService = new CarService();
        List<Car> carList = carService.getAllCars();
    %>




        <!-- Car categories Start -->
        <div class="container-fluid categories pb-5">
            <div class="container pb-5">
                <div class="text-center mx-auto pb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 800px;">
                    <h1 class="display-5 text-capitalize mb-3">Vehicle <span class="text-primary">Categories</span></h1>
                    <p class="mb-0">At Mega City Cab Service, we offer a diverse fleet of vehicles to suit your every need. Whether you're commuting solo, traveling with family, or heading out for a business trip, we’ve got you covered! Choose from our comfortable sedans, spacious SUVs, luxury cars, and efficient vans — each maintained to the highest standards for a safe and smooth ride.
                    </p>
                    <p class="mb-0">Discover the perfect ride that matches your style and requirements!,</p>
                </div>
                <div class="categories-carousel owl-carousel wow fadeInUp" data-wow-delay="0.1s">
           
                    <% for (Car car : carList) { %>
                        <div class="categories-item p-4">
                            <div class="categories-item-inner">
                                <div class="categories-img rounded-top">
                                    <img src="img/car-2.png" class="img-fluid w-100 rounded-top" alt="">
                                </div>
                                <div class="categories-content rounded-bottom p-4">
                                    <h4><%= car.getName() %></h4>
                                    <div class="categories-review mb-4">
                                        <div class="me-3">3.5 Review</div>
                                        <div class="d-flex justify-content-center text-secondary">
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star text-body"></i>
                                        </div>
                                    </div>
                                    <div class="mb-4">
                                        <h4 class="bg-white text-primary rounded-pill py-2 px-4 mb-0">$<%= car.getPrice() %>/Per Km</h4>
                                    </div>
                                    <div class="row gy-2 gx-0 text-center mb-4">
                                        <div class="col-4 border-end border-white">
                                            <i class="fa fa-users text-dark"></i> <span class="text-body ms-1">Seats</span>
                                        </div>
                                        <div class="col-4 border-end border-white">
                                            <i class="fa fa-car text-dark"></i> <span class="text-body ms-1">AT/MT</span>
                                        </div>
                                        <div class="col-4">
                                            <i class="fa fa-gas-pump text-dark"></i> <span class="text-body ms-1">Petrol</span>
                                        </div>
                                        <div class="col-4 border-end border-white">
                                            <i class="fa fa-car text-dark"></i> <span class="text-body ms-1">2015</span>
                                        </div>
                                        <div class="col-4 border-end border-white">
                                            <i class="fa fa-cogs text-dark"></i> <span class="text-body ms-1">AUTO/Manual</span>
                                        </div>
                                        <div class="col-4">
                                            <i class="fa fa-road text-dark"></i> <span class="text-body ms-1">100K</span>
                                        </div>
                                       
                                        <h5><%= car.isAvailable() ? "Available" : "Not Available" %></h5>
                                    </div>
                                        <a href="#" class="btn btn-primary rounded-pill d-flex justify-content-center py-3"
                                            onclick="checkBooking(<%= car.getId() %>)">Book Now</a>                                
                                </div>
                            </div>
                        </div>
                        
                    <% } %>
                        
                        

                </div>
            </div>
        </div>
        <!-- Car categories End -->
        
        
        
        
<%@ include file="footer.jsp" %>

    
                <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/wow/wow.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/counterup/counterup.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>
    

    <!-- Template Javascript -->
    <script src="js/main.js"></script>
    
    <script>
        function checkBooking(carId) {
            <% if (session.getAttribute("loggedUser") == null) { %>
                alert("You must be logged in to book a car!");
                window.location.href = "login.jsp"; // Redirect to login page
            <% } else { %>
                window.location.href = "booking.jsp?carId=" + carId; // Proceed to booking page
            <% } %>
        }
    </script>
