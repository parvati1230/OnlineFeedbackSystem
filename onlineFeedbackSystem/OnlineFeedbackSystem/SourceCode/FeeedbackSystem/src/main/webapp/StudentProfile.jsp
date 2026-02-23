<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>


<%
    String studentEmail = (String) session.getAttribute("studentEmail");
    if (studentEmail == null) {
        response.sendRedirect("StudentLogin.jsp");
        return;
    }

    String name = "", email = "", password = "", gender = "", course = "", contact = "", profileIcon = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/onlinefeedbacksystem", "root", "parvati@2003");

        PreparedStatement ps = con.prepareStatement("SELECT * FROM student WHERE email=?");
        ps.setString(1, studentEmail);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            name = rs.getString("name");
            email = rs.getString("email");
            password = rs.getString("password");
            gender = rs.getString("gender");
            course = rs.getString("course");
            contact = rs.getString("contact");
        }

        con.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>Database Error: " + e.getMessage() + "</p>");
    }

    if ("Female".equalsIgnoreCase(gender)) {
        profileIcon = "https://cdn-icons-png.flaticon.com/512/2922/2922561.png"; // 👩 female
    } else {
        profileIcon = "https://cdn-icons-png.flaticon.com/512/2922/2922510.png"; // 👨 male
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Student Profile</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body {
  background-color: #f0f4fa;
  font-family: 'Poppins', sans-serif;
}

.profile-container {
  max-width: 650px;
  margin: 50px auto;
  background: #fff;
  border-radius: 15px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  padding: 30px;
}

.profile-header {
  text-align: center;
  margin-bottom: 25px;
}

.profile-header img {
  width: 110px;
  height: 110px;
  border-radius: 50%;
  margin-bottom: 10px;
  transition: 0.3s;
}

.profile-header img:hover {
  transform: scale(1.05);
}

.profile-header h3 {
  color: #004aad;
  font-weight: 700;
}

.profile-header p {
  color: #666;
  margin-top: 5px;
}

.table th {
  width: 40%;
  color: #004aad;
  font-weight: 600;
  background-color: #f9fbff;
}

.table td {
  font-weight: 500;
  color: #333;
}

.btn-edit {
  background-color: #004aad;
  color: white;
  border: none;
  border-radius: 8px;
  padding: 10px 25px;
  font-weight: 600;
  transition: 0.3s;
}

.btn-edit:hover {
  background-color: #002f6c;
}
</style>
</head>

<body>

<div class="profile-container">
  <div class="profile-header">
    <img src="<%= profileIcon %>" alt="Profile Icon">
    <h3><%= name %></h3>
    <p><%= course %> | <%= gender %></p>
  </div>

  <div class="profile-details">
    <table class="table table-borderless align-middle">
      <tr>
        <th>Email:</th>
        <td><%= email %></td>
      </tr>
      <tr>
        <th>Mobile Number:</th>
        <td><%= contact %></td>
      </tr>
      <tr>
        <th>Course:</th>
        <td><%= course %></td>
      </tr>
      <tr>
        <th>Gender:</th>
        <td><%= gender %></td>
      </tr>
    </table>
  </div>

  <div class="text-center mt-3">
<a href="#" class="btn-edit" onclick="parent.loadPage('StudentProfileUpdate.jsp')">Edit Profile</a>
  </div>
</div>

</body>
</html>
