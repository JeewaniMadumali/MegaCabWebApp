<%@ page import="java.sql.*" %>
<%@ page import="db.DBConnection" %>

<%
    int bookingId = Integer.parseInt(request.getParameter("bookingId"));
    Connection con = DBConnection.getConnection();
    
    String query = "SELECT b.booking_number, b.pickup_date, b.return_date, b.destination_from, b.destination_to, "
                 + "b.address, b.contact, b.driver, c.name AS car_name,c.price AS car_price, u.name AS customer_name, u.email AS customer_email "
                 + "FROM booking b "
                 + "JOIN cars c ON b.car_id = c.id "
                 + "JOIN users u ON b.user_id = u.id "
                 + "WHERE b.id = ?";
                 
    PreparedStatement ps = con.prepareStatement(query);
    ps.setInt(1, bookingId);
    ResultSet rs = ps.executeQuery();
    rs.next();
    
    String driver = rs.getString("driver");
%>

<html>
<head>
    <title>Finalize Booking</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
          
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        .container {
            display: flex;
            justify-content: space-between;
            gap: 20px;
            max-width: 1000px;
            margin: 0 auto;
        }

        .car-details, .customer-details {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            width: 48%;
        }

        h3 {
            font-size: 20px;
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }

        .detail-item {
            margin-bottom: 5px;
        }

        .detail-item label {
            display: inline-block;
            width: 150px;
            font-weight: bold;
            color: #555;
        }

        .detail-item .value {
            color: #333;
            font-weight: normal;
        }

        .input-field {
            width: 50%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
        }

        .input-field:focus {
            border-color: #007bff;
            outline: none;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
        }

        .button-container {
            text-align: center;
            margin-top: 40px;
        }

        button {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }
        
        
        
    </style>
</head>
<body>
    <%@ include file="/admin/layout/adminNav.jsp" %>
    
    
    <h2>Finalize Booking</h2>
    
   
   <form action="<%= request.getContextPath() %>/FinalizeBookingServlet" method="post">
      
        <input type="hidden" name="bookingId" value="<%= bookingId %>">
        
        <div class="container">
           
            <div class="car-details">
                <h3>Car Details</h3>
                <div class="detail-item">
                    <label>Booking Number:</label> <span class="value"><%= rs.getString("booking_number") %></span>
                </div>
                <div class="detail-item">
                    <label>Car Name:</label> <span class="value"><%= rs.getString("car_name") %></span>
                </div>
                <div class="detail-item">
                    <label>Price per Kilometer:</label> <span class="value">LKR <%= rs.getString("car_price") %></span>
                    <input type="hidden" name="car_price" value="<%= rs.getString("car_price") != null ? rs.getString("car_price") : "0" %>">
                </div>
                <div class="detail-item">
                    <label>Enter Kilometers:</label> 
                    <input type="number" id="kilometers" name="kilometers" class="input-field" required>
                </div>
                <% if ("yes".equalsIgnoreCase(driver)) { %>
                <div class="detail-item">
                    <label>Driver Cost:</label> <span class="value">LKR 10</span>
                </div>
                <% } %>
                
                
                <div class="detail-item">
                    <label>Discount (%):</label> 
                    <input type="number" id="discount" name="discount" class="input-field" value="0">
                </div>

                <div class="detail-item">
                    <label>Tax (%):</label> 
                    <input type="number" id="tax" name="tax" class="input-field" value="0">
                </div>

               
                <div class="detail-item">
                    <label>Total Cost:</label> 
                    <span class="value" id="totalCost">LKR 0</span>
                </div>
                <input type="hidden" name="car_price" value="<%= rs.getString("car_price") %>">
                <input type="hidden" name="driver" value="<%= rs.getString("driver") %>">
                <!-- Add hidden fields for discount and tax -->
                <input type="hidden" id="hiddenDiscount" name="discount" value="0">
                <input type="hidden" id="hiddenTax" name="tax" value="0">


    
             <!-- Centered Button -->
            <div class="button-container">
                <button type="submit">Confirm</button>
            </div>
        </div>
            
            
            <div class="customer-details">
                <h3>Customer Details</h3>
                <div class="detail-item">
                    <label>Customer Name:</label> <span class="value"><%= rs.getString("customer_name") %></span>
                </div>
                <div class="detail-item">
                    <label>Email:</label> <span class="value"><%= rs.getString("customer_email") %></span>
                </div>
                <div class="detail-item">
                    <label>Pickup Date:</label> <span class="value"><%= rs.getDate("pickup_date") %></span>
                </div>
                <div class="detail-item">
                    <label>Return Date:</label> <span class="value"><%= rs.getDate("return_date") %></span>
                </div>
                <div class="detail-item">
                    <label>From:</label> <span class="value"><%= rs.getString("destination_from") %></span>
                </div>
                <div class="detail-item">
                    <label>To:</label> <span class="value"><%= rs.getString("destination_to") %></span>
                </div>
                <div class="detail-item">
                    <label>Address:</label> <span class="value"><%= rs.getString("address") %></span>
                </div>
                <div class="detail-item">
                    <label>Contact:</label> <span class="value"><%= rs.getString("contact") %></span>
                </div>
                
            </div>
        </div>

        
    </form>
                
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        $("#kilometers").on("input", function() {
            var kilometers = $(this).val();
            var pricePerKm = parseFloat($("input[name='car_price']").val());
            var driverCost = $("input[name='driver']").val() === "yes" ? 10 : 0;

            if (kilometers && kilometers > 0) {
                var total = (kilometers * pricePerKm) + driverCost;
                $("#totalCost").text("LKR " + total.toFixed(2));
            } else {
                $("#totalCost").text("LKR 0");
            }
        });
    });
</script>

<script>
    $(document).ready(function() {
        function calculateTotal() {
            var kilometers = parseFloat($("#kilometers").val()) || 0;
            var pricePerKm = parseFloat($("input[name='car_price']").val()) || 0;
            var driverCost = $("input[name='driver']").val() === "yes" ? 10 : 0;
            var discount = parseFloat($("#discount").val()) || 0;
            var tax = parseFloat($("#tax").val()) || 0;

            if (kilometers > 0) {
                var subtotal = (kilometers * pricePerKm) + driverCost;
                var discountAmount = (subtotal * discount) / 100;
                var taxAmount = ((subtotal - discountAmount) * tax) / 100;
                var total = subtotal - discountAmount + taxAmount;

                $("#totalCost").text("LKR " + total.toFixed(2));

                $("#hiddenDiscount").val(discount);
                $("#hiddenTax").val(tax);
            } else {
                $("#totalCost").text("LKR 0");
            }
        }

        $("#kilometers, #discount, #tax").on("input", function() {
            calculateTotal();
        });
    });
</script>
</body>
</html>