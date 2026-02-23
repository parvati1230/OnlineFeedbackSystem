<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>SSSIT - Feedback System</title>

  
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f4f7fb;
      margin: 0;
      padding: 0;
    }

    
    .top-bar {
      background-color: #ffffff;
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 10px 40px;
      border-bottom: 2px solid #ddd;
      box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
    }

    .top-left {
      display: flex;
      align-items: center;
      gap: 15px;
    }

    .top-left img {
      height: 65px;
    }

    .contact-info {
      text-align: center;
      font-size: 0.95rem;
      color: #333;
      line-height: 1.4;
    }

    .contact-info b {
      color: #004aad;
    }

    .top-right {
      display: flex;
      align-items: center;
      gap: 15px;
    }

   
.social-icons i {
  font-size: 1.4rem;
  margin-right: 10px;
  cursor: pointer;
  transition: transform 0.2s ease;
}

.social-icons .bi-linkedin { color: #0A66C2; }     /* LinkedIn Blue */
.social-icons .bi-facebook { color: #1877F2; }     /* Facebook Blue */
.social-icons .bi-twitter { color: #1DA1F2; }      /* Twitter Blue */
.social-icons .bi-instagram { color: #E4405F; }    /* Instagram Pink/Red */
.social-icons .bi-youtube { color: #FF0000; }      /* YouTube Red */

.social-icons i:hover {
  transform: scale(1.2);     /* Slight zoom effect on hover */
}

    .social-icons i:hover {
      color: #d62976;
    }

    .dropdown .btn {
      background-color: #004aad;
      color: white;
      border-radius: 25px;
      font-weight: 600;
      border: none;
      padding: 6px 18px;
    }

    .dropdown-menu {
      right: 0;
      left: auto;
      box-shadow: 0 3px 8px rgba(0, 0, 0, 0.2);
    }

    
    marquee {
      background-color: #eaf0ff;
      color: #004aad;
      font-weight: 500;
      padding: 8px;
      border-bottom: 2px solid #004aad;
    }

    
    .carousel-item {
      text-align: center;
    }

    .carousel-item img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

 
    .about {
      margin: 50px auto;
      width: 80%;
      padding: 30px;
      text-align: center;
      background-color: transparent;
      box-shadow: none;
    }

    .about h2 {
      color: #004aad;
      font-weight: bold;
      margin-bottom: 15px;
    }

    footer {
      background-color: #004aad;
      color: white;
      text-align: center;
      padding: 10px;
      font-size: 0.9rem;
    }

    .insta-icon {
      color: #d62976;
      font-size: 1.2rem;
      margin-left: 8px;
    }
  </style>
</head>

<body>

  
  <div class="top-bar">
    <!-- LEFT SIDE: LOGO + CONTACT INFO -->
    <div class="top-center">
      <img src="https://www.sssit.info/images/SSSIT_Logo3.png" alt="SSSIT Logo">
    </div>

    
    <div class="contact-info">
      <div><b>Email:</b> admin@sssit.info</div>
      <div><b>Mobile:</b> 9866144861 / 7032703254 / 7032703253</div>
    </div>


    <div class="top-right">
      <div class="social-icons">
        <i class="bi bi-linkedin"></i>
        <i class="bi bi-facebook"></i>
        <i class="bi bi-twitter"></i>
        <i class="bi bi-instagram"></i>
        <i class="bi bi-youtube"></i>
      </div>

      <div class="dropdown">
        <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown">
          Login
        </button>
        <ul class="dropdown-menu dropdown-menu-end">
          <li><a class="dropdown-item" href="AdminLogin.jsp">Admin Login</a></li>
          <li><a class="dropdown-item" href="StudentLogin.jsp">Student Login</a></li>
        </ul>
      </div>
    </div>
  </div>

  
  <marquee behavior="scroll" direction="left">
    📢 Welcome to SSSIT — Computer Education | Empowering Students through Quality Education |
    Learn | Innovate | Lead | Building Bright Futures with Excellence in Engineering and Technology.
  </marquee>

  
  <div id="coursesCarousel" class="carousel slide container my-5" data-bs-ride="carousel" data-bs-interval="2500">
    <div class="carousel-inner">
      <div class="carousel-item active">
        <img src="https://www.vcubesoftsolutions.com/wp-content/uploads/2024/11/java-fullstack.jpg" alt="Java Full Stack">
      </div>
      <div class="carousel-item">
        <img src="https://www.vcubesoftsolutions.com/wp-content/uploads/2025/04/WhatsApp-Image-2025-04-09-at-12.59.51_cc1a2cb0.jpg" alt="Python Full Stack">
      </div>
      <div class="carousel-item">
        <img src="https://www.vcubesoftsolutions.com/wp-content/uploads/2024/11/WhatsApp-Image-2024-11-21-at-16.49.07_19054748.jpg" alt="AWS and Azure">
      </div>
      <div class="carousel-item">
        <img src="https://www.vcubesoftsolutions.com/wp-content/uploads/2024/11/data-anallaytics.jpg" alt=".net full stack">
      </div>
    </div>

    
    <button class="carousel-control-prev" type="button" data-bs-target="#coursesCarousel" data-bs-slide="prev">
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#coursesCarousel" data-bs-slide="next">
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
    </button>
  </div>

  
  <marquee behavior="scroll" direction="left">
    📧 Email: admin@sssit.info | 📱 Mobile: 9866144861 / 7032703254 / 7032703253 | 
    📷 Instagram: @sssit_official <i class="bi bi-instagram insta-icon"></i>
  </marquee>

  
  <div class="about">
    <h2>About Us</h2>
    <p>
      SSSIT-Computer Education is a leading institution dedicated to providing 
      top-quality training in Information Technology. Our mission is to empower students with practical 
      knowledge, innovative skills, and confidence to succeed in the IT industry.
    </p>
    <p>
      We specialize in Full Stack Development, Cloud Technologies, Artificial Intelligence, and Data Science, 
      offering both academic and corporate training programs designed for real-world success.
    </p>
  </div>

  <footer>
    © 2025 SSSIT | All Rights Reserved | Designed by SSSIT Web Team
  </footer>

 
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
