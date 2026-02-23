<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>View Students - Admin Dashboard</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    body {
      background-color: #f4f7fb;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .container {
      margin-top: 30px;
      background: white;
      padding: 25px;
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    }

    h2 {
      text-align: center;
      color: #004aad;
      font-weight: 700;
      margin-bottom: 25px;
    }

    table {
      border-radius: 10px;
      overflow: hidden;
    }

    thead {
      background-color: #004aad;
      color: white;
      text-align: center;
    }

    tbody tr:hover {
      background-color: #f0f5ff;
    }
  </style>
</head>

<body>
  <div class="container">
    <h2>All Registered Students</h2>

    <%
      Connection con = null;
      Statement st = null;
      ResultSet rs = null;

      try {
          Class.forName("com.mysql.cj.jdbc.Driver");
          con = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinefeedbacksystem", "root", "parvati@2003");
          st = con.createStatement();
          rs = st.executeQuery("SELECT * FROM student");

          if (!rs.isBeforeFirst()) {
    %>
            <div class="alert alert-warning text-center">No students found!</div>
    <%
          } else {
    %>
            <table class="table table-bordered table-striped table-hover">
              <thead>
                <tr>
                  <th>Student ID</th>
                  <th>Name</th>
                  <th>Email</th>
                  <th>Gender</th>
                  <th>Course</th>
                  <th>Contact</th>
                  <th>Registered Date</th>
                </tr>
              </thead>
              <tbody>
                <%
                  while (rs.next()) {
                %>
                  <tr>
                    <td><%= rs.getInt("student_id") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("email") %></td>
                    <td><%= rs.getString("gender") %></td>
                    <td><%= rs.getString("course") %></td>
                    <td><%= rs.getString("contact") %></td>
                    <td><%= rs.getTimestamp("created_at") %></td>
                  </tr>
                <%
                  }
                %>
              </tbody>
            </table>
    <%
          }
      } catch (Exception e) {
          out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
      } finally {
          if (rs != null) try { rs.close(); } catch (Exception ex) {}
          if (st != null) try { st.close(); } catch (Exception ex) {}
          if (con != null) try { con.close(); } catch (Exception ex) {}
      }
    %>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
