<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View & Delete Feedbacks</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: lightblue;
            margin: 0;
            padding: 40px;
        }
        .container {
            max-width: 1000px;
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
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 25px;
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
    <h2>All Submitted Feedbacks</h2>

    <%
        String url = "jdbc:mysql://localhost:3306/onlinefeedbacksystem";
        String user = "root";
        String pass = "parvati@2003";

        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;

        
        String deleteId = request.getParameter("deleteId");
        if (deleteId != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, pass);
                PreparedStatement ps = conn.prepareStatement("DELETE FROM feedback WHERE feedback_id = ?");
                ps.setInt(1, Integer.parseInt(deleteId));
                ps.executeUpdate();
                ps.close();
                out.println("<p style='color:green;text-align:center;'>Feedback deleted successfully!</p>");
            } catch (Exception e) {
                out.println("<p style='color:red;text-align:center;'>Delete Error: " + e.getMessage() + "</p>");
            } finally {
                try { if (conn != null) conn.close(); } catch (Exception e) {}
            }
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, pass);
            st = conn.createStatement();

            String sql = "SELECT * FROM feedback";
            rs = st.executeQuery(sql);

            if (!rs.isBeforeFirst()) {
                out.println("<p style='text-align:center;color:red;'>No feedback records found!</p>");
            } else {
    %>

    <table>
        <tr>
            <th>ID</th>
            <th>Student Name</th>
            <th>Email</th>
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
            <td><%= rs.getString("email") %></td>
            <td><%= rs.getString("course") %></td>
            <td><%= rs.getString("faculty") %></td>
            <td><%= rs.getInt("rating") %></td>
            <td><%= rs.getString("comment") %></td>
            <td><%= rs.getTimestamp("submitted_at") != null ? rs.getTimestamp("submitted_at") : "—" %></td>
            <td>
                <a href="ViewFeedback.jsp?deleteId=<%= rs.getInt("feedback_id") %>" 
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
            try { if (st != null) st.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    %>

    <div style="text-align:center;">
        <a href="Feedback.html" class="btn">Go Back</a>
    </div>
</div>
</body>
</html>
