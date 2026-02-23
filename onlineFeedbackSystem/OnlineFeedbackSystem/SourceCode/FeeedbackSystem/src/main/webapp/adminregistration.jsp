<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Registration</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    body {
        background: linear-gradient(to right, #6a11cb, #2575fc);
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        font-family: 'Poppins', sans-serif;
    }
    .register-box {
        background: #fff;
        padding: 30px 40px;
        border-radius: 15px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
        width: 420px;
        transition: transform 0.3s ease;
    }
    .register-box:hover {
        transform: translateY(-5px);
    }
    .register-box h2 {
        text-align: center;
        color: #333;
        margin-bottom: 25px;
        font-weight: 600;
    }
    .form-control {
        border-radius: 10px;
        padding: 10px;
    }
    .btn-register {
        width: 100%;
        border-radius: 10px;
        padding: 10px;
        background-color: #2575fc;
        color: white;
        font-weight: 600;
        border: none;
        transition: 0.3s;
    }
    .btn-register:hover {
        background-color: #1a5ed1;
    }
    .login-link {
        text-align: center;
        margin-top: 15px;
    }
    .login-link a {
        color: #2575fc;
        text-decoration: none;
        font-weight: 500;
    }
</style>
</head>

<body>

<%
    String message = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {

        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String mobilenumber = request.getParameter("mobilenumber");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/onlinefeedbacksystem", "root", "parvati@2003");

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO admin (fullname, email, mobilenumber, password) VALUES (?, ?, ?, ?)");

            ps.setString(1, fullname);
            ps.setString(2, email);
            ps.setString(3, mobilenumber);
            ps.setString(4, password);

            int result = ps.executeUpdate();

            if (result > 0) {
                response.sendRedirect("AdminLogin.jsp");
                return;
            } else {
                message = "❌ Registration Failed!";
            }

            con.close();

        } catch (SQLIntegrityConstraintViolationException e) {
            message = "⚠️ Email already exists!";
        } catch (Exception e) {
            message = "⚠️ Error: " + e.getMessage();
        }
    }
%>

<div class="register-box">
    <h2>Admin Registration</h2>

    <% if (!message.equals("")) { %>
        <div class="alert alert-info text-center"><%= message %></div>
    <% } %>

    <form method="post">
        <div class="mb-3">
            <label class="form-label">Full Name</label>
            <input type="text" name="fullname" class="form-control" placeholder="Enter full name" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" name="email" class="form-control" placeholder="Enter email" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Mobile Number</label>
            <input type="text" name="mobilenumber" class="form-control" placeholder="Enter mobile number" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control" placeholder="Enter password" required>
        </div>

        <button type="submit" class="btn-register">Register</button>

        <div class="login-link">
            Already have an account? <a href="AdminLogin.jsp">Login</a>
        </div>
    </form>
</div>

</body>
</html>
