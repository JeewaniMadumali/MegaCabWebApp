<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, db.DBConnection" %>
<%
    Integer userId = (Integer) session.getAttribute("loggedUser");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = DBConnection.getConnection();
    PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM users WHERE id = ?");
    pstmt.setInt(1, userId);
    ResultSet rs = pstmt.executeQuery();
    if (!rs.next()) {
        response.sendRedirect("login.jsp");
        return;
    }

    String name = rs.getString("name");
    String email = rs.getString("email");
%>

<%
    // Fetch user bookings with car name
    PreparedStatement pstmtBookings = conn.prepareStatement(
        "SELECT b.id, b.booking_number,b.pickup_date,b.return_date, c.name , c.category " +
        "FROM booking b " +
        "JOIN cars c ON b.car_id = c.id " +
        "WHERE b.user_id = ?"
    );
    pstmtBookings.setInt(1, userId);
    ResultSet rsBookings = pstmtBookings.executeQuery();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile</title>
    <style>
        body {
            margin: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: url('img/car-2.png') no-repeat center center fixed;
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

        .profile-container {
            flex: 1;
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 2rem;
        }

        .avatar-section {
            text-align: center;
        }

        .avatar {
            width: 150px;
            height: 150px;
            background: #3498db;
            border-radius: 50%;
            margin: 0 auto 1rem;
            position: relative;
        }

        .avatar::after {
            content: '👤';
            font-size: 6rem;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: white;
        }

        .details-section {
            padding: 1rem;
        }

        .detail-row {
            margin: 1rem 0;
            padding: 0.5rem;
            border-radius: 5px;
            background: #ecf0f1;
        }

        .detail-row:hover {
            background: rgba(0, 0, 0, 0.05);
        }

        .detail-row label {
            display: block;
            color: #7f8c8d;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }

        .detail-row span {
            display: block;
            color: #34495e;
            font-size: 1.1rem;
        }

        .edit-btn {
            background: #2ecc71;
            border: none;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s;
            margin-top: 1rem;
        }

        .edit-btn:hover {
            background: #27ae60;
        }

        .logout-form {
            margin-top: 2rem;
        }

        .logout-btn {
            background: #e74c3c;
            border: none;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s;
            width: 100%;
        }

        .logout-btn:hover {
            background: #c0392b;
        }

        .bookings-section {
            margin-top: 1rem;
            padding: 2rem;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }

        .bookings-section h2 {
            text-align: center;
            color: #34495e;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #3498db;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #eaf2f8;
        }

        td {
            color: #34495e;
        }

        @media (max-width: 768px) {
            .profile-container {
                grid-template-columns: 1fr;
                padding: 1rem;
            }

            .bookings-section {
                margin-top: 1rem;
            }
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>

    <div class="profile-container">
        <div class="avatar-section">
            <div class="avatar"></div>
            <button class="edit-btn">Change Avatar</button>
        </div>
        
        <div class="details-section">
            <div class="detail-row">
                <label>Name</label>
                <span><%= name %></span>
            </div>
            <div class="detail-row">
                <label>Email</label>
                <span><%= email %></span>
            </div>

            <form action="LogoutServlet" method="post" class="logout-form">
                <button type="submit" class="logout-btn">Logout</button>
            </form>
        </div>
    </div>

    <div class="bookings-section">
        <h2>My Bookings</h2>
        <table>
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>Booking Number</th>
                    <th>Car Model</th>
                    <th>Pick-up Date</th>
                    <th>Return Date</th>
                    <th>Category</th>
                </tr>
            </thead>
            <tbody>
                <%
                    boolean hasBookings = false;
                    while (rsBookings.next()) {
                        hasBookings = true;
                %>
                <tr>
                    <td><%= rsBookings.getInt("id") %></td>
                    <td><%= rsBookings.getString("booking_number") %></td>
                    <td><%= rsBookings.getString("name") %></td>
                    <td><%= rsBookings.getString("pickup_date") %></td>
                    <td><%= rsBookings.getString("return_date") %></td>
                    <td><%= rsBookings.getString("category") %></td>
                </tr>
                <%
                    }
                    if (!hasBookings) {
                %>
                <tr>
                    <td colspan="6" style="text-align: center; color: #7f8c8d;">No bookings found.</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <%@ include file="footer.jsp" %>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>

<%
    rs.close();
    pstmt.close();
    conn.close();
%>
