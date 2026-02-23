<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Login</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body {
  height: 100vh; display: flex; justify-content: center; align-items: center;
  font-family: 'Poppins', sans-serif;
}
.login-box { background:#fff; padding:35px 40px; border-radius:15px; width:380px; box-shadow:0 4px 20px rgba(0,0,0,0.2);}
.btn-login { width:100%; background-color:#2575fc; color:white; border:none; border-radius:10px; padding:10px; font-weight:600;}
.btn-login:hover { background-color:#1a5ed1; }
</style>
</head>

<body>
<%
String message = "";
if ("POST".equalsIgnoreCase(request.getMethod())) {
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinefeedbacksystem", "root", "parvati@2003");

        PreparedStatement ps = con.prepareStatement("SELECT * FROM admin WHERE email=? AND password=?");
        ps.setString(1, email);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            // ✅ Store admin details in session (optional but recommended)
            session.setAttribute("adminName", rs.getString("fullname"));
            session.setAttribute("adminEmail", rs.getString("email"));

            // ✅ Redirect to Admin Dashboard
            response.sendRedirect("AdminDashboard.jsp");
            return;
        } else {
            message = " Invalid Email or Password!";
        }

        con.close();
    } catch (Exception e) {
        message = "⚠️ Database Error: " + e.getMessage();
    }
}
%>

<div class="login-box">
  <h2 class="text-center mb-3">Admin Login</h2>
  <% if (!message.equals("")) { %>
    <div class="alert alert-info text-center"><%= message %></div>
  <% } %>

  <form method="post">
    <div class="mb-3">
      <label class="form-label">Email ID</label>
      <input type="email" name="email" class="form-control" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Password</label>
      <input type="password" name="password" class="form-control" required>
    </div>
    <button type="submit" class="btn-login">Login</button>
    <div class="text-center mt-3">
      Don’t have an account? <a href="adminregistration.jsp">Register</a>
    </div>
  </form>
</div>
</body>
</html>
