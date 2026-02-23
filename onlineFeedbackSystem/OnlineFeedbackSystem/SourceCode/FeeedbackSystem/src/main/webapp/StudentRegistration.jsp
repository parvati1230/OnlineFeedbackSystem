<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Student Registration</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    body {
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        font-family: 'Poppins', sans-serif;
    }
    .register-box {
        background:#fff;
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
    .form-control, .form-select {
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
    .login-link a:hover {
        text-decoration: underline;
    }
</style>
</head>

<body>

<%
    String message = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String gender = request.getParameter("gender");
        String course = request.getParameter("course");
        String contact = request.getParameter("contact");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/onlinefeedbacksystem", "root", "parvati@2003");

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO student (name, email, password, gender, course, contact) VALUES (?, ?, ?, ?, ?, ?)");
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, gender);
            ps.setString(5, course);
            ps.setString(6, contact);

            int result = ps.executeUpdate();
            if (result > 0) {
                message = "✅ Registration Successful! Redirecting to login...";
                out.println("<script>alert('Registration Successful! Please Login.'); window.location='StudentLogin.jsp';</script>");
            } else {
                message = "❌ Registration Failed!";
            }

            con.close();
        } catch (SQLIntegrityConstraintViolationException e) {
            message = "⚠️ Email already registered!";
        } catch (Exception e) {
            message = "⚠️ Error: " + e.getMessage();
        }
    }
%>

<div class="register-box">
    <h2>Student Registration</h2>

    <% if (!message.equals("")) { %>
        <div class="alert alert-info text-center"><%= message %></div>
    <% } %>

    <form method="post">
        <div class="mb-3">
            <label class="form-label">Name</label>
            <input type="text" name="name" class="form-control" placeholder="Enter name" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Email ID</label>
            <input type="email" name="email" class="form-control" placeholder="Enter email address" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control" placeholder="Enter password" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Gender</label>
            <select name="gender" class="form-select" required>
                <option value="">-- Select Gender --</option>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
                <option value="Other">Other</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Course</label>
            <select name="course" class="form-select" required>
                <option value="">-- Select Course --</option>
                <option value="Java FullStack">Java FullStack</option>
                <option value="Python FullStack">Python FullStack</option>
                <option value="UI FullStack">UI FullStack</option>
                <option value=".Net FullStack">.Net FullStack</option>
                <option value="Data Science">Data Science</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Contact</label>
            <input type="tel" name="contact" class="form-control" placeholder="Enter contact" pattern="[0-9]{10}" required>
        </div>

        <button type="submit" class="btn-register">Register</button>

        <div class="login-link">
            Already have an account? <a href="StudentLogin.jsp">Login</a>
        </div>
    </form>
</div>

</body>
</html>