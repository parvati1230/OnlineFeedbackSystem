<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
    // ✅ Invalidate the session and clear all stored data
    session.invalidate();

    // ✅ Redirect back to login page
    response.sendRedirect("MainDashboard.jsp");
%>
