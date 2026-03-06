<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Select Restaurant | Eatzy</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Eatzy Theme Styles - Added without removing your existing classes */
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap');

        body {
            font-family: 'Inter', Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(145deg, #fefaf5 0%, #fff6ed 100%);
            min-height: 100vh;
        }

        /* Content with sidebar shift */
        .content {
            margin-left: 0;
            padding: 2rem 2rem 2rem 5rem;
            transition: margin-left 0.3s ease;
            min-height: 100vh;
        }

        .content.shift {
            margin-left: 280px;
        }

        /* Page Title */
        .content h2 {
            font-size: 2.2rem;
            font-weight: 800;
            color: #1e1e1e;
            margin-bottom: 2rem;
            position: relative;
            display: inline-block;
        }

        .content h2::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 80px;
            height: 4px;
            background: #f97316;
            border-radius: 4px;
        }

        /* Restaurant Cards Container */
        .content > div {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 1.5rem;
            margin-top: 2rem;
        }

        /* Restaurant Cards - Enhanced Eatzy Theme */
        .content > div > div {
            background: white;
            border: 2px solid #eaeef2;
            border-radius: 24px;
            padding: 1.5rem;
            transition: all 0.3s ease;
            box-shadow: 0 10px 20px -8px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
        }

        .content > div > div:hover {
            transform: translateY(-5px);
            border-color: #f97316;
            box-shadow: 0 20px 30px -12px rgba(249, 115, 22, 0.3);
        }

        .content > div > div::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: #f97316;
            transform: scaleX(0);
            transition: transform 0.3s ease;
            transform-origin: left;
        }

        .content > div > div:hover::before {
            transform: scaleX(1);
        }

        /* Restaurant Name */
        .content h3 {
            font-size: 1.4rem;
            font-weight: 700;
            color: #1e1e1e;
            margin-bottom: 1rem;
        }

        /* Restaurant Details */
        .content p {
            color: #6b6b6b;
            font-size: 1rem;
            margin-bottom: 0.8rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .content p:before {
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            color: #f97316;
            width: 20px;
        }

        .content p:first-of-type:before {
            content: '\f3c5'; /* map-marker-alt icon */
        }

        .content p:last-of-type:before {
            content: '\f3c5'; /* location-dot icon */
        }

        /* Manage Button */
        .content a button {
            background: #f97316;
            color: white;
            border: none;
            border-radius: 40px;
            padding: 0.8rem 1.5rem;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            width: 100%;
            margin-top: 1rem;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .content a button:hover {
            background: #e85d0e;
            transform: translateY(-2px);
            box-shadow: 0 10px 20px -8px rgba(249, 115, 22, 0.4);
        }

        .content a button:after {
            content: '\f061'; /* arrow-right icon */
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
        }

        /* Sidebar Styles (from your sidebar.jsp) */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 280px;
            height: 100vh;
            background: white;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
            transform: translateX(-100%);
            transition: transform 0.3s ease;
            z-index: 1000;
            padding: 2rem 1.5rem;
        }

        .sidebar.open {
            transform: translateX(0);
        }

        .sidebar .title {
            font-size: 2rem;
            font-weight: 800;
            color: #f97316;
            margin-bottom: 2rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #f97316;
        }

        .sidebar a {
            display: flex;
            align-items: center;
            gap: 0.8rem;
            padding: 0.9rem 1rem;
            margin: 0.4rem 0;
            color: #2e2e2e;
            text-decoration: none;
            border-radius: 40px;
            transition: all 0.2s;
            background: #f9f9fb;
            border: 1.5px solid transparent;
        }

        .sidebar a:hover {
            background: #fff6ed;
            border-color: #f97316;
            transform: translateX(6px);
        }

        .sidebar a i {
            color: #f97316;
        }

        /* Hamburger Button */
        .hamburger {
            position: fixed;
            top: 20px;
            left: 20px;
            font-size: 24px;
            cursor: pointer;
            z-index: 1100;
            background: #f97316;
            color: white;
            width: 52px;
            height: 52px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 8px 20px -6px rgba(249, 115, 22, 0.5);
            border: 2px solid white;
            transition: all 0.2s;
        }

        .hamburger:hover {
            background: #e85d0e;
            transform: scale(1.05);
        }

        /* Empty State */
        .content > div:empty {
            text-align: center;
            padding: 4rem;
            background: #f9f9fb;
            border-radius: 30px;
            border: 2px dashed #eaeef2;
            color: #6b6b6b;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .content {
                padding: 1rem;
            }

            .content.shift {
                margin-left: 0;
            }

            .content > div {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/jsp/sidebar.jsp" />


<div class="content" id="mainContent">
    <h2>🏪 Choose a Restaurant to Manage</h2>

    <div style="margin-top:20px;">
        <c:forEach var="r" items="${restaurants}">
            <div>
                <h3>${r.name}</h3>
                <p>Area: ${r.area}</p>
                <p>Location: ${r.location}</p>

                <a href="${pageContext.request.contextPath}/restaurant/${r.id}/dashboard">
                    <button>Manage Restaurant</button>
                </a>
            </div>
        </c:forEach>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const hamburger = document.getElementById("hamburgerBtn");
        const sidebar = document.getElementById("sidebar");
        const mainContent = document.getElementById("mainContent");

        if (hamburger && sidebar && mainContent) {
            hamburger.addEventListener("click", function (e) {
                e.stopPropagation();
                sidebar.classList.toggle("open");
                mainContent.classList.toggle("shift");
            });

            document.addEventListener('click', function(event) {
                if (!sidebar.contains(event.target) &&
                    !hamburger.contains(event.target) &&
                    sidebar.classList.contains('open')) {
                    sidebar.classList.remove('open');
                    mainContent.classList.remove('shift');
                }
            });
        }
    });
</script>

</body>
</html>