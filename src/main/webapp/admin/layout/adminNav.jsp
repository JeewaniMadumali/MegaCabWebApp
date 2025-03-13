<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

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
                background-color:#18838c;
                padding: 10px 20px;
            }
            .navbar a {
                color:  #f8f9fa;
                margin-right: 15px;
                text-decoration: none;
            }
            .navbar a:hover {
                color: #fafbfc;
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
                background-color: #cc0a11;
                color: white;
                border: none;
            }
            .btn-primary:hover {
                background-color: #04162e;
            }
        </style>
    </head>
    <body>
        <!-- Navigation Bar -->
        <div class="navbar">
            <a href="${pageContext.request.contextPath}/admin/adminIndex.jsp">Home</a>
            
            <div style="float: right;">
                <% if (userName != null) { %>
                    <span style="color: white; margin-right: 15px;">Welcome, <%= userName %>!</span>
                    <a href="<%= request.getContextPath() %>/LogoutServlet" class="btn btn-primary">Logout</a>
                <% } else { %>
                    <a href="login.jsp" class="btn btn-primary">Login</a>
                    <a href="register.jsp" class="btn btn-primary">Register</a>
                <% } %>
            </div>
        </div>

        <!-- Bootstrap JS (optional) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>