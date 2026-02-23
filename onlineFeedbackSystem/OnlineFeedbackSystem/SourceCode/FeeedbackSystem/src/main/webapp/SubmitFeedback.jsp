<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");

    String studentName = request.getParameter("student_name");
    String email = request.getParameter("email");
    String course = request.getParameter("course");
    String faculty = request.getParameter("faculty");
    String rating = request.getParameter("rating");
    String comment = request.getParameter("comment");

    String url = "jdbc:mysql://localhost:3306/onlinefeedbacksystem";
    String user = "root";
    String pass = "parvati@2003";

    Connection conn = null;
    PreparedStatement ps = null;
    boolean success = false;

   
    int count5 = 0, count4 = 0, count3 = 0, count2 = 0, count1 = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, pass);

        
        String sql = "INSERT INTO feedback (student_name, email, course, faculty, rating, comment) VALUES (?, ?, ?, ?, ?, ?)";
        ps = conn.prepareStatement(sql);
        ps.setString(1, studentName);
        ps.setString(2, email);
        ps.setString(3, course);
        ps.setString(4, faculty);
        ps.setString(5, rating);
        ps.setString(6, comment);
        int rows = ps.executeUpdate();
        if (rows > 0) {
            success = true;
        }
        ps.close();

      
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("SELECT rating, COUNT(*) AS total FROM feedback GROUP BY rating");
        while (rs.next()) {
            int r = rs.getInt("rating");
            int total = rs.getInt("total");
            switch (r) {
                case 5: count5 = total; break;
                case 4: count4 = total; break;
                case 3: count3 = total; break;
                case 2: count2 = total; break;
                case 1: count1 = total; break;
            }
        }
        rs.close();
        st.close();

    } catch (Exception e) {
        out.println("<h3 style='color:red;text-align:center;'>Database Error: " + e.getMessage() + "</h3>");
    } finally {
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Feedback Submitted</title>
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: lightblue;
      margin: 0;
      padding: 40px;
    }
    .container {
      max-width: 800px;
      margin: 30px auto;
      background: white;
      padding: 25px;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }
    h2 {
      color: blue;
      text-align: center;
    }
    .btn {
      display: inline-block;
      background: blue;
      color: white;
      padding: 10px 16px;
      border-radius: 6px;
      text-decoration: none;
      margin-top: 20px;
    }
    .btn:hover {
      background: blue;
    }
    #piechart {
      width: 100%;
      height: 400px;
      margin-top: 30px;
    }
  </style>

  <script type="text/javascript">
    google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
      var data = google.visualization.arrayToDataTable([
        ['Rating', 'Count'],
        ['5 - Excellent', <%= count5 %>],
        ['4 - Very Good', <%= count4 %>],
        ['3 - Good', <%= count3 %>],
        ['2 - Fair', <%= count2 %>],
        ['1 - Poor', <%= count1 %>]
      ]);

      var options = {
        title: 'Overall Rating Distribution',
        is3D: true,
        colors: ['#28a745','#7fd858','#f9d71c','#f39c12','#e74c3c']
      };

      var chart = new google.visualization.PieChart(document.getElementById('piechart'));
      chart.draw(data, options);
    }
  </script>
</head>

<body>
  <div class="container">
    <% if (success) { %>
      <h2>Feedback Submitted Successfully!</h2>
      <p><strong>Student Name:</strong> <%= studentName %></p>
      <p><strong>Email:</strong> <%= email %></p>
      <p><strong>Course:</strong> <%= course %></p>
      <p><strong>Faculty:</strong> <%= faculty %></p>
      <p><strong>Rating:</strong> <%= rating %></p>
      <p><strong>Comment:</strong> <%= comment %></p>

      <div id="piechart"></div>

      <a href="Feedback.html" class="btn">Submit Another Feedback</a>
    <% } else { %>
      <h2 style="color:red;">Feedback Submission Failed!</h2>
      <p>Please try again later.</p>
      <a href="Feedback.html" class="btn">Back to Form</a>
    <% } %>
  </div>
</body>
</html>
