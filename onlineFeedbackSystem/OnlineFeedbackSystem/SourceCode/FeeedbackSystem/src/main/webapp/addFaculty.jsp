<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Add Faculty - Admin Dashboard</title>

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    body {
      background-color: #f4f7fb;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .container {
      background: #fff;
      width: 60%;
      margin: 40px auto;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }

    h2 {
      text-align: center;
      color: #004aad;
      margin-bottom: 25px;
      font-weight: 700;
    }

    .form-label {
      color: #004aad;
      font-weight: 600;
    }

    .btn-primary {
      background-color: #004aad;
      border: none;
      border-radius: 30px;
      padding: 10px 25px;
      font-weight: 600;
    }

    .btn-primary:hover {
      background-color: #00337a;
    }

    .message {
      text-align: center;
      font-weight: 600;
      margin-top: 15px;
    }
  </style>
</head>

<body>

  <div class="container">
    <h2>Add New Faculty</h2>

    <%
      String message = "";
      if ("POST".equalsIgnoreCase(request.getMethod())) {
          String facultyName = request.getParameter("faculty_name");
          String course = request.getParameter("course");
          String email = request.getParameter("email");
          String contact = request.getParameter("contact");

          Connection con = null;
          PreparedStatement ps = null;

          try {
              // ✅ Connect to Database
              Class.forName("com.mysql.cj.jdbc.Driver");
              con = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinefeedbacksystem", "root", "parvati@2003");

              // ✅ Insert Faculty Data
              String sql = "INSERT INTO faculty (faculty_name, course, email, contact, created_at) VALUES (?, ?, ?, ?, NOW())";
              ps = con.prepareStatement(sql);
              ps.setString(1, facultyName);
              ps.setString(2, course);
              ps.setString(3, email);
              ps.setString(4, contact);

              int result = ps.executeUpdate();
              if (result > 0) {
                  message = "<span style='color:green;'>✅ Faculty added successfully!</span>";
              } else {
                  message = "<span style='color:red;'>❌ Failed to add faculty. Try again.</span>";
              }

          } catch (Exception e) {
              message = "<span style='color:red;'>⚠️ Error: " + e.getMessage() + "</span>";
          } finally {
              if (ps != null) try { ps.close(); } catch (Exception ex) {}
              if (con != null) try { con.close(); } catch (Exception ex) {}
          }
      }
    %>

    <!-- Faculty Form -->
    <form method="post" action="">
      <div class="mb-3">
        <label class="form-label">Faculty Name</label>
        <input type="text" name="faculty_name" class="form-control" required>
      </div>

      <div class="mb-3">
        <label class="form-label">Course</label>
        <input type="text" name="course" class="form-control" placeholder="e.g. Java, Python, AWS" required>
      </div>

      <div class="mb-3">
        <label class="form-label">Email</label>
        <input type="email" name="email" class="form-control" required>
      </div>

      <div class="mb-3">
        <label class="form-label">Contact</label>
        <input type="text" name="contact" class="form-control" required pattern="[0-9]{10}" title="Enter a 10-digit mobile number">
      </div>

      <div class="text-center">
        <button type="submit" class="btn btn-primary">Add Faculty</button>
      </div>

      <% if (!message.isEmpty()) { %>
        <div class="message mt-3"><%= message %></div>
      <% } %>
    </form>
  </div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>