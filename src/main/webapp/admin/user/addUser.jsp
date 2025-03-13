<%-- 
    Document   : addUser
    Created on : Mar 4, 2025, 9:02:55 PM
    Author     : SNC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add User</title>

    <!-- Bootstrap CSS (via CDN) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Styles -->
    <style>
        body {
            background-color: #f8f9fa;
        }
        .form-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 30px;
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            margin-bottom: 30px;
            color: #343a40;
        }
        label {
            font-weight: bold;
        }
        button[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #cc0a11;
            border: none;
            border-radius: 5px;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }
        button[type="submit"]:hover {
            background-color:  #04162e;
        }
    </style>
</head>
<body>
    <!-- Include Admin Navigation Bar -->
    <%@ include file="/admin/layout/adminNav.jsp" %>

    <!-- Form Container -->
    <div class="form-container">
        <h1>Add User</h1>

        <!-- Add User Form -->
        <form action="${pageContext.request.contextPath}/AddUserServlet" method="post" novalidate>
            <div class="mb-3">
                <label for="name" class="form-label">Name:</label>
                <input type="text" id="name" name="name" class="form-control" required>
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">Email:</label>
                <input type="email" id="email" name="email" class="form-control" required>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">Password:</label>
                <input type="password" id="password" name="password" class="form-control" required>
            </div>

            <div class="mb-3">
                <label for="role" class="form-label">Role:</label>
                <select id="role" name="role" class="form-select" required>
                    <option value="driver">Driver</option>
                    <option value="admin">Admin</option>
                    <option value="admin">User</option>
                </select>
            </div>

            <button type="submit" class="btn btn-primary">Add User</button>
        </form>
    </div>

    <!-- Bootstrap JS (Optional, if needed for other components) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>