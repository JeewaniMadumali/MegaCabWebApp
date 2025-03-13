<%@ page import="java.sql.*, db.DBConnection" %>
<%@ page import="java.util.*" %>
<%
    Integer loggedUser = (Integer) session.getAttribute("loggedUser");
    if (loggedUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String carId = request.getParameter("carId");
    Connection conn = DBConnection.getConnection();
    PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM cars WHERE id = ?");
    pstmt.setString(1, carId);
    ResultSet rs = pstmt.executeQuery();

    if (!rs.next()) {
%>
        <div class="message error">Invalid car selection. Please try again.</div>
<%
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book a Car</title>
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
        }

        h2 {
            margin-bottom: 1.5rem;
            color: #2c3e50;
            text-align: center;
            border-bottom: 2px solid #3498db;
            padding-bottom: 0.5rem;
        }

        .car-details {
            margin-bottom: 2rem;
            padding: 1.5rem;
            background: rgba(255, 255, 255, 0.7);
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .car-details p {
            margin: 0.5rem 0;
            color: #34495e;
            font-size: 1.1rem;
        }

        label {
            display: block;
            margin: 1rem 0 0.5rem;
            color: #34495e;
            font-weight: bold;
        }

        input[type="date"],
        input[type="text"],
        input[type="tel"],
        select {
            width: 100%;
            padding: 0.75rem;
            margin-bottom: 1rem;
            border: 1px solid #bdc3c7;
            border-radius: 5px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }

        input:focus,
        select:focus {
            border-color: #3498db;
            outline: none;
        }

        button {
            width: 100%;
            padding: 0.8rem;
            background: #e74c3c;
            border: none;
            border-radius: 5px;
            color: white;
            font-size: 1rem;
            cursor: pointer;
            transition: background 0.3s ease;
            margin-top: 1rem;
        }

        button:hover {
            background: #c0392b;
        }

        button:active {
            transform: translateY(1px);
        }

        .message {
            margin: 1rem 0;
            padding: 0.75rem;
            border-radius: 5px;
            text-align: center;
        }

        .success {
            background-color: #d4edda;
            color: #155724;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
        }

        @media (max-width: 768px) {
            .form-section {
                margin: 1rem;
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>

    <section class="form-section">
        <h2>Book a Car</h2>
        
        <div class="car-details">
            <p><strong>Car Model :</strong> <%= rs.getString("name") %></p>
            <p><strong>Price Per KM :</strong> $<%= rs.getDouble("price") %></p>
            <p><strong>Car Type :</strong> <%= rs.getString("category") %></p>
        </div>

        <form action="confirmBooking.jsp" method="post">
            <input type="hidden" name="carId" value="<%= carId %>">

            <label for="pickupDate">Pick-Up Date:</label>
            <input type="date" id="pickupDate" name="pickupDate" required>

            <label for="returnDate">Return Date:</label>
            <input type="date" id="returnDate" name="returnDate" required>
            
            <label for="destination_from">Destination From:</label>
            <input type="text" id="destination_from" name="destination_from" required>

            <label for="destination_to">Destination To:</label>
            <input type="text" id="destination_to" name="destination_to" required>
            
            <label for="address">Address:</label>
            <input type="text" id="address" name="address" required>
            
            <label for="contact">Telephone:</label>
            <input type="tel" id="contact" name="contact" required>

            <label for="driver">Driver Required:</label>
            <select id="driver" name="driver" required>
                <option value="yes">Yes (+$10/day)</option>
                <option value="no">No</option>
            </select>

            <button type="submit">Confirm Booking</button>
        </form>
        
        <p class="message success">${successMessage}</p>
        <p class="message error">${errorMessage}</p>
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

<%
    rs.close();
    pstmt.close();
    conn.close();
%>