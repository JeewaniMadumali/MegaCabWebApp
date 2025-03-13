<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String bookingNumber = request.getParameter("bookingNumber");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Successful</title>
    <style>
        body {
            margin: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: url('images/car-bg.jpg') no-repeat center center fixed;
            background-size: cover;
        }

        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.3);
            z-index: -1;
        }

        .form-section {
            flex: 1;
            max-width: 600px;
            margin: 2rem auto;
            padding: 2rem;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            z-index: 1;
            text-align: center;
        }

        h2 {
            color: #2c3e50;
            margin-bottom: 1.5rem;
            border-bottom: 2px solid #2ecc71;
            padding-bottom: 0.5rem;
        }

        .booking-number {
            font-size: 1.2rem;
            color: #34495e;
            margin: 1.5rem 0;
        }

        .badge {
            background: #2ecc71;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            font-weight: bold;
            display: inline-block;
            margin: 1rem 0;
        }

        a.button {
            display: inline-block;
            width: 200px;
            padding: 0.8rem;
            background: #3498db;
            color: white;
            text-align: center;
            border-radius: 5px;
            text-decoration: none;
            transition: background 0.3s ease;
        }

        a.button:hover {
            background: #2980b9;
        }

        @media (max-width: 768px) {
            .form-section {
                margin: 1rem;
                padding: 1.5rem;
            }
            
            a.button {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>

    <section class="form-section">
        <h2>Booking Confirmed!</h2>
        <p class="message success">Your car has been booked successfully.</p>
        
        <div class="booking-number">
            <div class="badge">Booking #: <%= bookingNumber %></div>
        </div>

        <a href="index.jsp" class="button">Go to Home</a>
    </section>

    <%@ include file="footer.jsp" %>

    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/wow/wow.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/counterup/counterup.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>