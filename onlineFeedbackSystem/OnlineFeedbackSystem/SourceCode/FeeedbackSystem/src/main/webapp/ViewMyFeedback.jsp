<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Previous Feedbacks</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: lightblue;
            margin: 0;
            padding: 40px;
        }
        .container {
            max-width: 900px;
            margin: 30px auto;
            background: #fff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: blue;
            margin-bottom: 25px;
        }
        form {
            text-align: center;
            margin-bottom: 20px;
        }
        input[type="email"] {
            padding: 10px;
            width: 300px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }
        input[type="submit"] {
            background-color: blue;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 6px;
            margin-left: 10px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: darkblue;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 25px;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 10px 12px;
            text-align: center;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f8f9fa;
        }
        .btn {
            display: inline-block;
            background: blue;
            color: white;
            padding: 8px 14px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 14px;
        }
        .btn:hover {
            background: darkblue;
        }
        .btn-delete {
            background: red;
        }
        .btn-delete:hover {
            background: darkred;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>View My Previous Feedbacks</h2>

    <!-- Search Form -->
    <form method="get" action="ViewMyFeedback.jsp">
        <input type="email" name="email" placeholder="Enter your registered email" required />
        <input type="submit" value="View Feedbacks" />
    </form>

    <%
        String email = request.getParameter("email");
        String deleteId = request.getParameter("deleteId");

        String url = "jdbc:mysql://localhost:3306/onlinefeedbacksystem";
        String user = "root";
        String pass = "parvati@2003";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        
        if (deleteId != null && email != null && !email.trim().isEmpty()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, pass);
                PreparedStatement del = conn.prepareStatement("DELETE FROM feedback WHERE feedback_id=? AND email=?");
                del.setInt(1, Integer.parseInt(deleteId));
                del.setString(2, email);
                int rows = del.executeUpdate();
                if (rows > 0) {
                    out.println("<p style='color:green;text-align:center;'>Feedback deleted successfully!</p>");
                } else {
                    out.println("<p style='color:red;text-align:center;'>Unable to delete feedback.</p>");
                }
                del.close();
            } catch (Exception e) {
                out.println("<p style='color:red;text-align:center;'>Delete Error: " + e.getMessage() + "</p>");
            } finally {
                try { if (conn != null) conn.close(); } catch (Exception e) {}
            }
        }

        if (email != null && !email.trim().isEmpty()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, pass);

                // ✅ Query student's own feedbacks
                String sql = "SELECT * FROM feedback WHERE email = ? ORDER BY submitted_at DESC";
                ps = conn.prepareStatement(sql);
                ps.setString(1, email);
                rs = ps.executeQuery();

                if (!rs.isBeforeFirst()) {
                    out.println("<p style='text-align:center;color:red;'>No feedbacks found for <strong>" + email + "</strong></p>");
                } else {
    %>

    <table>
        <tr>
            <th>ID</th>
            <th>Student Name</th>
            <th>Course</th>
            <th>Faculty</th>
            <th>Rating</th>
            <th>Comment</th>
            <th>Date Submitted</th>
            <th>Action</th>
        </tr>

        <%
            while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("feedback_id") %></td>
            <td><%= rs.getString("student_name") %></td>
            <td><%= rs.getString("course") %></td>
            <td><%= rs.getString("faculty") %></td>
            <td><%= rs.getInt("rating") %></td>
            <td><%= rs.getString("comment") %></td>
            <td><%= rs.getTimestamp("submitted_at") != null ? rs.getTimestamp("submitted_at") : "—" %></td>
            <td>
                <a href="ViewMyFeedback.jsp?email=<%= email %>&deleteId=<%= rs.getInt("feedback_id") %>" 
                   class="btn btn-delete"
                   onclick="return confirm('Are you sure you want to delete this feedback?');">
                   Delete
                </a>
            </td>
        </tr>
        <%
            }
        %>
    </table>

    <%
                }
            } catch (Exception e) {
                out.println("<h3 style='color:red;text-align:center;'>Database Error: " + e.getMessage() + "</h3>");
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception e) {}
                try { if (ps != null) ps.close(); } catch (Exception e) {}
                try { if (conn != null) conn.close(); } catch (Exception e) {}
            }
        }
    %>

    <div style="text-align:center; margin-top:20px;">
        <a href="Feedback.html" class="btn">Go Back</a>
    </div>
</div>

</body>
</html>
