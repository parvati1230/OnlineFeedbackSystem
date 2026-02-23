<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>View Faculty - Admin Dashboard</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    body {
      background-color: #f4f7fb;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .container {
      background: #fff;
      width: 90%;
      margin: 40px auto;
      padding: 25px;
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }

    h2 {
      text-align: center;
      color: #004aad;
      margin-bottom: 25px;
      font-weight: 700;
    }

    table {
      background: white;
      border-radius: 10px;
      overflow: hidden;
      box-shadow: 0 3px 8px rgba(0,0,0,0.1);
    }

    th {
      background-color: #004aad;
      color: white;
    }

    tr:hover {
      background-color: #f1f5ff;
    }
  </style>
</head>

<body>

  <div class="container">
    <h2>Faculty List</h2>

    <%
      Connection con = null;
      Statement stmt = null;
      ResultSet rs = null;

      try {
          Class.forName("com.mysql.cj.jdbc.Driver");
          con = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinefeedbacksystem", "root", "parvati@2003");

          stmt = con.createStatement();
          rs = stmt.executeQuery("SELECT * FROM faculty ORDER BY faculty_name ASC");

          if (!rs.isBeforeFirst()) {
    %>
            <div class="alert alert-warning text-center mt-4">⚠️ No faculty records found!</div>
    <%
          } else {
    %>
            <table class="table table-striped table-bordered text-center">
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Faculty Name</th>
                  <th>Course</th>
                  <th>Email</th>
                  <th>Contact</th>
                  <th>Created At</th>
                </tr>
              </thead>
              <tbody>
              <%
                while (rs.next()) {
              %>
                <tr>
                <td><%= rs.getInt("faculty_id") %></td>
<td><%= rs.getString("faculty_name") %></td>
<td><%= rs.getString("course") %></td>
<td><%= rs.getString("email") %></td>
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
    %>
          <div class="alert alert-danger text-center mt-3">⚠️ Error: <%= e.getMessage() %></div>
    <%
      } finally {
          try { if (rs != null) rs.close(); } catch (Exception ex) {}
          try { if (stmt != null) stmt.close(); } catch (Exception ex) {}
          try { if (con != null) con.close(); } catch (Exception ex) {}
      }
    %>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>