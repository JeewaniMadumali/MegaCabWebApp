<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, db.DBConnection, java.text.DecimalFormat, java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking Receipt</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
            }
            .container {
                max-width: 800px;
                margin: 0 auto;
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            h1 {
                text-align: center;
                color: #333;
                margin-bottom: 20px;
            }
            .logo {
                text-align: center;
                margin-bottom: 20px;
            }
            .logo img {
                max-width: 150px;
            }
            .detail-item {
                margin-bottom: 15px;
                font-size: 1.1em;
            }
            .detail-item label {
                font-weight: bold;
                display: inline-block;
                width: 160px;
                color: #555;
            }
            .detail-item .value {
                color: #333;
            }
            .bill-breakdown {
                margin-top: 20px;
                padding: 15px;
                background-color: #f9f9f9;
                border-radius: 5px;
                border: 1px solid #ddd;
            }
            .bill-breakdown h3 {
                margin-top: 0;
                color: #333;
            }
            .back-btn, .print-btn {
                text-align: center;
                margin-top: 20px;
            }
            .back-btn a, .print-btn button {
                text-decoration: none;
                color: #fff;
                background-color: #007bff;
                padding: 10px 20px;
                border-radius: 5px;
                border: none;
                cursor: pointer;
            }
            .back-btn a:hover, .print-btn button:hover {
                background-color: #0056b3;
            }
            .footer {
                text-align: center;
                margin-top: 30px;
                font-size: 0.9em;
                color: #777;
            }
        </style>
    </head>
    <body>
       
        <div class="container">
            
            <h1>Booking Details</h1>
            <%
                String bookingIdStr = request.getParameter("bookingId");
                if (bookingIdStr == null || bookingIdStr.isEmpty()) {
                    out.println("<p>Error: Booking ID is missing.</p>");
                } else {
                    int bookingId = Integer.parseInt(bookingIdStr);

                    Connection con = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;

                    try {
                        con = DBConnection.getConnection();
                        String query = "SELECT b.booking_number, b.pickup_date, b.return_date, "
                                    + "b.destination_from, b.destination_to, b.address, b.contact, "
                                    + "b.driver, b.kilometers, b.total_bill, b.discount, b.tax, "
                                    + "c.name AS car_name, c.price AS car_price, "
                                    + "u.name AS user_name, u.email AS user_email "
                                    + "FROM booking b "
                                    + "JOIN cars c ON b.car_id = c.id "
                                    + "JOIN users u ON b.user_id = u.id "
                                    + "WHERE b.id = ?";
                        ps = con.prepareStatement(query);
                        ps.setInt(1, bookingId);
                        rs = ps.executeQuery();

                        if (rs.next()) {
                            DecimalFormat df = new DecimalFormat("#,##0.00");
                            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
                            double baseFare = rs.getDouble("car_price") * rs.getDouble("kilometers");
                            double discountAmount = baseFare * (rs.getDouble("discount") / 100);
                            double taxAmount = (baseFare - discountAmount) * (rs.getDouble("tax") / 100);
                            double totalBill = rs.getDouble("total_bill");
            %>
                            <div class="detail-item">
                                <label>Booking Number:</label>
                                <span class="value"><%= rs.getString("booking_number") %></span>
                            </div>
                            <div class="detail-item">
                                <label>User Name:</label>
                                <span class="value"><%= rs.getString("user_name") %></span>
                            </div>
                            <div class="detail-item">
                                <label>Email:</label>
                                <span class="value"><%= rs.getString("user_email") %></span>
                            </div>
                            <div class="detail-item">
                                <label>Car Name:</label>
                                <span class="value"><%= rs.getString("car_name") %></span>
                            </div>
                            <div class="detail-item">
                                <label>Car Price (per km):</label>
                                <span class="value">LKR <%= df.format(rs.getDouble("car_price")) %></span>
                            </div>
                            <div class="detail-item">
                                <label>Pickup Date:</label>
                                <span class="value"><%= sdf.format(rs.getTimestamp("pickup_date")) %></span>
                            </div>
                            <div class="detail-item">
                                <label>Return Date:</label>
                                <span class="value"><%= sdf.format(rs.getTimestamp("return_date")) %></span>
                            </div>
                            <div class="detail-item">
                                <label>From:</label>
                                <span class="value"><%= rs.getString("destination_from") %></span>
                            </div>
                            <div class="detail-item">
                                <label>To:</label>
                                <span class="value"><%= rs.getString("destination_to") %></span>
                            </div>
                            <div class="detail-item">
                                <label>Address:</label>
                                <span class="value"><%= rs.getString("address") %></span>
                            </div>
                            <div class="detail-item">
                                <label>Contact:</label>
                                <span class="value"><%= rs.getString("contact") %></span>
                            </div>
                            <div class="detail-item">
                                <label>Driver:</label>
                                <span class="value"><%= rs.getString("driver") %></span>
                            </div>
                            <div class="detail-item">
                                <label>Kilometers:</label>
                                <span class="value"><%= df.format(rs.getDouble("kilometers")) %></span>
                            </div>
                            <div class="bill-breakdown">
                                <h3>Bill Breakdown</h3>
                                <div class="detail-item">
                                    <label>Base Fare:</label>
                                    <span class="value">LKR <%= df.format(baseFare) %></span>
                                </div>
                                <div class="detail-item">
                                    <label>Discount (<%= rs.getDouble("discount") %>%):</label>
                                    <span class="value">- LKR <%= df.format(discountAmount) %></span>
                                </div>
                                <div class="detail-item">
                                    <label>Tax (<%= rs.getDouble("tax") %>%):</label>
                                    <span class="value">+ LKR <%= df.format(taxAmount) %></span>
                                </div>
                                <div class="detail-item">
                                    <label>Total Bill:</label>
                                    <span class="value">LKR <%= df.format(totalBill) %></span>
                                </div>
                            </div>
            <%
                        } else {
                            out.println("<p>Error: Booking not found.</p>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<p>Error: An error occurred while fetching booking details.</p>");
                    } finally {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (con != null) con.close();
                    }
                }
            %>

            <div class="footer">
                <p>Thank you for choosing us! For any queries, contact us at support@example.com.</p>
            </div>
        </div>
    </body>
</html>
