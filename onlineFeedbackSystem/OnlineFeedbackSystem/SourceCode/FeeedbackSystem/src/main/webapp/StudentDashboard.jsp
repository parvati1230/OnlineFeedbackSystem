<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Student Dashboard - SSSIT</title>

  
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f5f7fb;
      margin: 0;
      padding: 0;
    }

    
    .header {
      background-color: #004aad;
      color: white;
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 15px 40px;
    }

    .header h2 {
      text-align: center;
      flex-grow: 1;
      margin: 0;
      font-weight: bold;
      letter-spacing: 1px;
    }

    .dropdown .btn {
      background-color: white;
      color: #004aad;
      font-weight: 600;
      border: none;
      border-radius: 25px;
      padding: 6px 18px;
    }

    .dropdown-menu {
      right: 0;
      left: auto;
      box-shadow: 0 3px 8px rgba(0, 0, 0, 0.2);
    }

    
    .dashboard {
      display: grid;
      grid-template-columns: 4fr 8fr;
      min-height: 85vh;
    }

    .sidebar {
      background-color: #eaf0ff;
      padding: 40px 20px;
      border-right: 3px solid #004aad;
      display: flex;
      flex-direction: column;
      gap: 20px;
    }

    .sidebar button {
      background-color: #004aad;
      color: white;
      border: none;
      border-radius: 8px;
      padding: 12px;
      font-weight: 600;
      transition: 0.3s;
    }

    .sidebar button:hover {
      background-color: #00337a;
    }

    .content {
      background: url("https://www.sssit.info/images/SSSIT_Logo3.png") center center no-repeat;
      background-size: 250px;
      background-color: #f8faff;
      padding: 30px;
      position: relative;
    }

    .content iframe {
      width: 100%;
      height: 100%;
      border: none;
      background: transparent;
    }

    footer {
      text-align: center;
      background-color: #004aad;
      color: white;
      padding: 10px;
      font-size: 0.9rem;
    }
  </style>
</head>

<body>

  
  <div class="header">
    <h2>Student</h2>

    <div class="dropdown">
      <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown">
        <i class="bi bi-person-circle"></i>
      </button>
      <ul class="dropdown-menu dropdown-menu-end">
        <li><a class="dropdown-item" href="#"onclick="loadPage('StudentProfile.jsp')" >View Profile</a></li>
        <li><a class="dropdown-item" href="StudentLogout.jsp">Logout</a></li>
      </ul>
    </div>
  </div>

 
  <div class="dashboard">
    <!-- LEFT: Sidebar -->
    <div class="sidebar">
      <button onclick="loadPage('Feedback.html')">Add Feedback</button>
    </div>

    
    <div class="content">
      <iframe id="contentFrame" src=""></iframe>
    </div>
  </div>

  
  <footer>
    © 2025 SSSIT | Student Dashboard | Designed by SSSIT Web Team
  </footer>

  <!-- ✅ JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    // Function to load JSP pages into iframe
    function loadPage(page) {
      document.getElementById("contentFrame").src = page;
    }
  </script>

</body>
</html>
