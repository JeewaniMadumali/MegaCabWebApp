<%-- 
    Document   : logout
    Created on : Feb 18, 2025, 9:02:18 PM
    Author     : SNC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Invalidate the session
    session.invalidate();

    // Redirect to the home page
    response.sendRedirect("index.jsp");
%>