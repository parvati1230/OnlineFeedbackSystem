<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String studentEmail = (String) session.getAttribute("studentEmail");
    if (studentEmail == null) {
        response.sendRedirect("StudentLogin.jsp");
        return;
    }

    String name = "", gender = "", course = "", contact = "", password = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/onlinefeedbacksystem", "root", "parvati@2003");

        PreparedStatement ps = con.prepareStatement("SELECT * FROM student WHERE email=?");
        ps.setString(1, studentEmail);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            name = rs.getString("name");
            gender = rs.getString("gender");
            course = rs.getString("course");
            contact = rs.getString("contact");
        }

        con.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
    if (request.getParameter("update") != null) {
        String newName = request.getParameter("name");
        String newCourse = request.getParameter("course");
        String newContact = request.getParameter("contact");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/onlinefeedbacksystem", "root", "parvati@2003");

            PreparedStatement ps = con.prepareStatement(
                "UPDATE student SET name=?, course=?, contact=? WHERE email=?");

            ps.setString(1, newName);
            ps.setString(2, newCourse);
            ps.setString(3, newContact);
            ps.setString(4, studentEmail);

            int updated = ps.executeUpdate();

            if (updated > 0) {
                out.println("<script>alert('Profile Updated Successfully!'); window.location='StudentProfile.jsp';</script>");
            } else {
                out.println("<script>alert('Update Failed!');</script>");
            }

            con.close();
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error updating profile: " + e.getMessage() + "</p>");
        }
    }

    
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Update Profile</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body {
  background-color: #eef3fa;
  font-family: 'Poppins', sans-serif;
}

.navbar {
  background-color: #004aad;
}

.navbar-brand, .nav-link {
  color: white !important;
  font-weight: 600;
}

.update-container {
  max-width: 600px;
  margin: 60px auto;
  background: white;
  padding: 40px;
  border-radius: 15px;
  box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

h3 {
  text-align: center;
  color: #004aad;
  margin-bottom: 30px;
  font-weight: 700;
}

.btn-update {
  background-color: #004aad;
  color: white;
  border: none;
  border-radius: 8px;
  padding: 10px 20px;
  font-weight: 600;
  transition: 0.3s;
}

.btn-update:hover {
  background-color: #002e73;
}

.form-label {
  font-weight: 600;
  color: #333;
}
</style>
</head>

<body>

<nav class="navbar navbar-expand-lg">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Student Portal</a>
    <div class="collapse navbar-collapse justify-content-end">
      <ul class="navbar-nav">
        <li class="nav-item"><a class="nav-link" href="StudentDashboard.jsp">Dashboard</a></li>
        <li class="nav-item"><a class="nav-link" href="StudentProfile.jsp">Profile</a></li>
        <li class="nav-item"><a class="nav-link" href="StudentLogout.jsp">Logout</a></li>
      </ul>
    </div>
  </div>
</nav>

<div class="update-container">
  <h3>Update Your Profile</h3>
  <form method="post" action="StudentProfileUpdate.jsp">
    <div class="mb-3">
      <label class="form-label">Full Name</label>
      <input type="text" name="name" class="form-control" value="<%= name %>" required>
    </div>

    <div class="mb-3">
      <label class="form-label">Course</label>
      <input type="text" name="course" class="form-control" value="<%= course %>" required>
    </div>

    <div class="mb-3">
      <label class="form-label">Contact Number</label>
      <input type="text" name="contact" class="form-control" value="<%= contact %>" required>
    </div>

  

    <div class="text-center">
      <button type="submit" name="update" class="btn-update">Update Profile</button>
    </div>
  </form>
</div>

</body>
</html>
