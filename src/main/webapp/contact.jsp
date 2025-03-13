
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<title>Services</title>

 <%@ include file="navbar.jsp" %>


<!-- Services Start -->
       <!-- Contact Us Start -->
<div class="container-fluid contact py-5">
    <div class="container py-5">
        <div class="text-center mx-auto pb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 800px;">
            <h1 class="display-5 text-capitalize mb-3">Contact <span class="text-primary">Us</span></h1>
            <p class="mb-0">Got questions or need assistance with your booking? We’re here to help! Reach out to Mega City Cab Service and experience customer support that’s as reliable as our rides. Whether it’s feedback, inquiries, or reservations, our team is just a call or message away.</p>
            <p class="mb-0">Your journey starts with us — get in touch today! 🚕💬</p>
        </div>
        <div class="row g-4">
            <div class="col-md-6 col-lg-4 wow fadeInUp" data-wow-delay="0.1s">
                <div class="contact-item p-4">
                    <div class="contact-icon mb-4">
                        <i class="fa fa-phone-alt fa-2x"></i>
                    </div>
                    <h5 class="mb-3">Call Us</h5>
                    <p class="mb-0">+94 770509860</p>
                    <p class="mb-0">+94 765116517</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-4 wow fadeInUp" data-wow-delay="0.3s">
                <div class="contact-item p-4">
                    <div class="contact-icon mb-4">
                        <i class="fa fa-envelope fa-2x"></i>
                    </div>
                    <h5 class="mb-3">Email Us</h5>
                    
                    <p class="mb-0">info@example.com</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-4 wow fadeInUp" data-wow-delay="0.5s">
                <div class="contact-item p-4">
                    <div class="contact-icon mb-4">
                        <i class="fa fa-map-marker-alt fa-2x"></i>
                    </div>
                    <h5 class="mb-3">Visit Us</h5>
                    <p class="mb-0">Colombo,</p>
                    <p class="mb-0">Sri Lanka</p>
                </div>
            </div>
        </div>
        <!-- Contact Form -->
        <div class="row mt-5 wow fadeInUp" data-wow-delay="0.1s">
            <div class="col-lg-8 mx-auto">
                <h3 class="text-center mb-4">Send Us a Message</h3>
                <form>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <input type="text" class="form-control" placeholder="Your Name" required>
                        </div>
                        <div class="col-md-6">
                            <input type="email" class="form-control" placeholder="Your Email" required>
                        </div>
                        <div class="col-12">
                            <input type="text" class="form-control" placeholder="Subject" required>
                        </div>
                        <div class="col-12">
                            <textarea class="form-control" rows="5" placeholder="Your Message" required></textarea>
                        </div>
                        <div class="col-12 text-center">
                            <button type="submit" class="btn btn-primary btn-lg">Send Message</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- Contact Us End -->
        <!-- Services End -->
        
        
        
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
