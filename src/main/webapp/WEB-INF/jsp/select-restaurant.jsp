<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Select Restaurant</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        .card {
            border: 1px solid #ddd;
            padding: 16px;
            margin-bottom: 10px;
            border-radius: 8px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .btn {
            padding: 8px 14px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            background: #3498db;
            color: white;
        }
    </style>
</head>
<body>

<h2>🏪 Choose a Restaurant to Manage</h2>

<div style="margin-top:20px;">
    <c:forEach var="r" items="${restaurants}">
        <div style="border:1px solid #ddd; padding:12px; margin-bottom:10px; border-radius:6px;">
            <h3>${r.name}</h3>
            <p>Area: ${r.area}</p>
            <p>Location: ${r.location}</p>

            <a href="${pageContext.request.contextPath}/restaurant/${r.id}/dashboard">
                <button>Manage</button>
            </a>
        </div>
    </c:forEach>
</div>

</body>
</html>