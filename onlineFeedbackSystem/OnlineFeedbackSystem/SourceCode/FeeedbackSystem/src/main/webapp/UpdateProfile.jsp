<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
String adminEmail = (String) session.getAttribute("adminEmail");
if (adminEmail == null) {
    response.sendRedirect("AdminLogin.jsp");
    return;
}

String fullname = "", email = "", mobilenumber = "", gender = "", course = "";
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/onlinefeedbacksystem", "root", "parvati@2003");
    PreparedStatement ps = con.prepareStatement("SELECT * FROM admin WHERE email=?");
    ps.setString(1, adminEmail);
    ResultSet rs = ps.executeQuery();
    if (rs.next()) {
        fullname = rs.getString("fullname");
        email = rs.getString("email");
        mobilenumber = rs.getString("mobilenumber");
        gender = rs.getString("gender");
        course = rs.getString("course");
    }
    con.close();
} catch (Exception e) {
    out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Profile</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body { background:#f8faff; font-family:'Poppins',sans-serif; }
.update-container {
  max-width:600px; margin:40px auto; background:#fff; border-radius:15px;
  box-shadow:0 4px 10px rgba(0,0,0,0.1); padding:30px;
}
.profile-header { text-align:center; margin-bottom:25px; }
.profile-header img { width:100px; border-radius:50%; margin-bottom:10px; }
.change-photo {
  font-size:0.9rem; color:#004aad; text-decoration:underline; cursor:pointer;
}
.btn-save {
  background:#004aad; color:white; border:none; border-radius:8px;
  padding:10px 20px; font-weight:600;
}
.btn-save:hover { background:#00337a; }
</style>
</head>
<body>

<div class="update-container">
  <div class="profile-header">
    <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" id="profilePic">
    <div>
      <label for="fileInput" class="change-photo">Click here to change photo</label>
      <input type="file" id="fileInput" style="display:none;" accept="image/*" onchange="previewImage(event)">
    </div>
  </div>

  <form method="post">
    <div class="mb-3">
      <label class="form-label">Full Name</label>
      <input type="text" class="form-control" name="fullname" value="<%= fullname %>" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Mobile Number</label>
      <input type="text" class="form-control" name="mobilenumber" value="<%= mobilenumber %>" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Course</label>
      <select class="form-select" name="course">
        <option <%= "Java".equalsIgnoreCase(course)?"selected":"" %>>Java</option>
        <option <%= "Python".equalsIgnoreCase(course)?"selected":"" %>>Python</option>
        <option <%= "Networking".equalsIgnoreCase(course)?"selected":"" %>>Networking</option>
        <option <%= "Web Development".equalsIgnoreCase(course)?"selected":"" %>>Web Development</option>
      </select>
    </div>
    <div class="mb-3">
      <label class="form-label">Gender</label>
      <select class="form-select" name="gender">
        <option <%= "Male".equalsIgnoreCase(gender)?"selected":"" %>>Male</option>
        <option <%= "Female".equalsIgnoreCase(gender)?"selected":"" %>>Female</option>
      </select>
    </div>
    <div class="text-center">
      <button type="submit" name="update" class="btn-save">Save Changes</button>
    </div>
  </form>
</div>

<script>
function previewImage(event){
  const reader=new FileReader();
  reader.onload=function(){
    document.getElementById('profilePic').src=reader.result;
  }
  reader.readAsDataURL(event.target.files[0]);
}
</script>

</body>
</html>

<%
if (request.getParameter("update") != null) {
    String newName = request.getParameter("fullname");
    String newMobile = request.getParameter("mobilenumber");
    String newGender = request.getParameter("gender");
    String newCourse = request.getParameter("course");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/onlinefeedbacksystem", "root", "parvati@2003");
        PreparedStatement ps = con.prepareStatement(
            "UPDATE admin SET fullname=?, mobilenumber=?, gender=?, course=? WHERE email=?");
        ps.setString(1, newName);
        ps.setString(2, newMobile);
        ps.setString(3, newGender);
        ps.setString(4, newCourse);
        ps.setString(5, adminEmail);

        int i = ps.executeUpdate();
        if (i > 0) {
            out.println("<script>alert('Profile updated successfully!'); window.location='Profile.jsp';</script>");
        }
        con.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
}
%>
