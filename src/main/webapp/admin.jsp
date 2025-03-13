<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String userName = (String) session.getAttribute("userName");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Panel</title>
        <!-- Bootstrap CSS for styling -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
            }
            .navbar {
                background-color: #007bff;
                padding: 10px 20px;
            }
            .navbar a {
                color: white;
                margin-right: 15px;
                text-decoration: none;
            }
            .navbar a:hover {
                color: #f8f9fa;
            }
            .container {
                margin-top: 20px;
            }
            .btn {
                padding: 10px 20px;
                border-radius: 5px;
                text-decoration: none;
            }
            .btn-primary {
                background-color: #007bff;
                color: white;
                border: none;
            }
            .btn-primary:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <!-- Navigation Bar -->
        <div class="navbar">
            <a href="#">Home</a>
            <a href="#">Dashboard</a>
            <a href="#">Settings</a>
            <div style="float: right;">
                <% if (userName != null) { %>
                    <span style="color: white; margin-right: 15px;">Welcome, <%= userName %>!</span>
                    <a href="logout.jsp" class="btn btn-primary">Logout</a>
                <% } else { %>
                    <a href="<%= request.getContextPath() %>/LogoutServlet" class="btn btn-primary">Login</a>
                    <a href="register.jsp" class="btn btn-primary">Register</a>
                <% } %>
            </div>
        </div>

        <!-- Main Content -->
        <div class="container">
            <h1>Admin Dashboard</h1>
            <p>Welcome to the admin panel. Here you can manage your application.</p>

            <!-- Example Cards -->
            <div class="row">
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Users</h5>
                            <p class="card-text">Manage users and their permissions.</p>
                            <a href="#" class="btn btn-primary">Go to Users</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Products</h5>
                            <p class="card-text">Manage products and inventory.</p>
                            <a href="#" class="btn btn-primary">Go to Products</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Settings</h5>
                            <p class="card-text">Configure system settings.</p>
                            <a href="#" class="btn btn-primary">Go to Settings</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS (optional) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>