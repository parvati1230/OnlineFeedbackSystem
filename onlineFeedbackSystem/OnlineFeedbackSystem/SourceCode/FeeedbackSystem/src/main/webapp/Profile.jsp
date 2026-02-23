<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String adminEmail = (String) session.getAttribute("adminEmail");
if (adminEmail == null) {
    response.sendRedirect("AdminLogin.jsp");
    return;
}

String fullname = "", email = "", mobilenumber = "";

// Default profile image
String profileIcon = "https://cdn-icons-png.flaticon.com/512/2922/2922510.png";

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/onlinefeedbacksystem", "root", "parvati@2003");

    // FIXED QUERY — only existing DB columns
    PreparedStatement ps = con.prepareStatement(
        "SELECT fullname, email, mobilenumber FROM admin WHERE email=?"
    );
    ps.setString(1, adminEmail);

    ResultSet rs = ps.executeQuery();

    if (rs.next()) {
        fullname = rs.getString("fullname");
        email = rs.getString("email");
        mobilenumber = rs.getString("mobilenumber");
    }

    rs.close();
    ps.close();
    con.close();

} catch (Exception e) {
    out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Profile</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body { background:#f8faff; font-family:'Poppins',sans-serif; }
.profile-container {
  max-width:600px; margin:40px auto; background:#fff; border-radius:15px;
  box-shadow:0 4px 10px rgba(0,0,0,0.1); padding:30px;
}
.profile-header { text-align:center; margin-bottom:25px; }
.profile-header img { width:100px; border-radius:50%; margin-bottom:10px; }
.btn-edit {
  background:#004aad; color:white; border:none; border-radius:8px;
  padding:10px 20px; font-weight:600; transition:0.3s;
}
.btn-edit:hover { background:#00337a; }
</style>
</head>

<body>

<div class="profile-container">
  <div class="profile-header">
    <img src="<%= profileIcon %>" alt="Profile">
    <h3><%= fullname %></h3>
  </div>

  <table class="table table-borderless">
    <tr><th>Email:</th><td><%= email %></td></tr>
    <tr><th>Mobile:</th><td><%= mobilenumber %></td></tr>
  </table>

  <div class="text-center">
    <a href="UpdateProfile.jsp" class="btn-edit">Edit Profile</a>
  </div>
</div>

</body>
</html>
