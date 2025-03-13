<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, db.DBConnection" %>

<%
    Connection conn = DBConnection.getConnection();
    PreparedStatement pstmt = conn.prepareStatement(
        "SELECT b.id, b.booking_number, b.pickup_date, b.return_date, b.destination_from, b.destination_to, " +
        "b.address, b.contact, b.status, c.name AS car_name, c.category, u.name AS user_name, u.email " +
        "FROM booking b " +
        "JOIN cars c ON b.car_id = c.id " +
        "JOIN users u ON b.user_id = u.id"
    );

    ResultSet rs = pstmt.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - View Bookings</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 100%;
            max-width: 1500px;
            margin: 2rem auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
            background: white;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background: #3498db;
            color: black;
        }

        tr:hover {
            background: #f1f1f1;
        }

        .action-btn {
            padding: 6px 12px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            color: white;
            transition: 0.3s;
        }
       
        .approve-btn {
            background: #2ecc71;
        }

        .approve-btn:hover {
            background: #27ae60;
        }

        .delete-btn {
            background: #e74c3c;
        }

        .delete-btn:hover {
            background: #c0392b;
        }

        .view-btn {
            background: #4b9c8f;
        }
        
        .print-btn {
            background: black;
        }

        .view-btn:hover {
            background: #2980b9;
        }

    </style>
</head>
<body>

    <%@ include file="/admin/layout/adminNav.jsp" %>

<div class="p-2">
    <h2>All Bookings</h2>
    <table class="table table-bordered table-striped">
        <thead class="thead-black">
            <tr>
                <th>Booking ID</th>
                <th>Booking Number</th>
                <th>User</th>
                <th>Email</th>
                <th>Car Model</th>
                <th>Category</th>
                <th>Pick-up Date</th>
                <th>Return Date</th>
                <th>From</th>
                <th>To</th>
                <th>Address</th>
                <th>Contact</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
           <%
                boolean hasBookings = false;
                while (rs.next()) {
                    hasBookings = true;
                    String status = rs.getString("status"); 
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("booking_number") %></td>
                <td><%= rs.getString("user_name") %></td>
                <td><%= rs.getString("email") %></td>
                <td><%= rs.getString("car_name") %></td>
                <td><%= rs.getString("category") %></td>
                <td><%= rs.getString("pickup_date") %></td>
                <td><%= rs.getString("return_date") %></td>
                <td><%= rs.getString("destination_from") %></td>
                <td><%= rs.getString("destination_to") %></td>
                <td><%= rs.getString("address") %></td>
                <td><%= rs.getString("contact") %></td>
                <td>
                    <% if ("pending".equalsIgnoreCase(status)) { %>
                        <a href="approve_booking.jsp?bookingId=<%= rs.getInt("id") %>">
                            <button class="action-btn approve-btn">Approve</button>
                        </a>
                        <form action="DeleteBookingServlet" method="post" style="display:inline;">
                            <input type="hidden" name="bookingId" value="<%= rs.getInt("id") %>">
                            <button type="submit" class="action-btn delete-btn">Delete</button>
                        </form>
                    <% } else if ("confirmed".equalsIgnoreCase(status)) { %>
                        <a href="confirmed_bookings.jsp?bookingId=<%= rs.getInt("id") %>">
                            <button class="action-btn view-btn">View</button>
                        </a>
<!--                        <a href="print.jsp?bookingId=<%= rs.getInt("id") %>">
                            <button class="action-btn print-btn">Print</button>
                        </a>-->
                        
                        <a href="javascript:void(0);" onclick="printBooking('<%= rs.getInt("id") %>')">
                            <button class="action-btn print-btn">Print</button>
                        </a>
                    <% } %>
                </td>
            </tr>
            <%
                }
                if (!hasBookings) {
            %>
            <tr>
                <td colspan="13" class="text-center text-muted">No bookings available.</td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>

</body>
<script>
    function printBooking(bookingId) {
        // Open print.jsp in a new window
        const printWindow = window.open('print.jsp?bookingId=' + bookingId, '_blank');

        // Wait for the new window to load
        printWindow.onload = function () {
            // Trigger the print dialog
            printWindow.print();
        };
    }
</script>
</html>

<%
    rs.close();
    pstmt.close();
    conn.close();
%>
