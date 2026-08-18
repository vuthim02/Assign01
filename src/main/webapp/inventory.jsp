<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ page import="java.util.Date" %>
<%-- SECURITY GUARD: If session token is missing, bounce user to login screen --%>
<c:if test="${empty sessionScope.authenticatedUser}">
 <c:redirect url="login.jsp" />
</c:if>
<%-- Mock Data Initialization using Modern Expression Language (EL 3.0+) --%>
<c:set var="product1" value="${{'name': 'ultra gaming laptop', 'price': 1299.99, 'stock': 3}}" />
<c:set var="product2" value="${{'name': 'ergonomic mechanical keyboard', 'price': 89.50, 'stock': 12}}" />
<c:set var="product3" value="${{'name': '4K ultra-wide monitor', 'price': 449.00, 'stock': 2}}" />
<c:set var="inventory" value="${{product1, product2, product3}}" />
<jsp:useBean id="reportDate" class="java.util.Date" />
<!DOCTYPE html>
<html lang="en">
<head>
 <meta charset="UTF-8">
 <title>E-Commerce Inventory Dashboard</title>
 <style>
 body { font-family: Arial, sans-serif; margin: 40px; background-color: #f9f9f9; }
 .header-container { display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #ddd; padding-bottom: 10px; }
 h1 { color: #333; margin: 0; }
 .user-badge { background-color: #e3fcef; color: #006644; padding: 6px 12px; border-radius: 20px; font-weight: bold; font-size: 14px; }
 table { width: 100%; border-collapse: collapse; margin-top: 20px; background: white; }
 th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
 th { background-color: #0076d6; color: white; }
 tr:nth-child(even) { background-color: #f2f2f2; }
 .badge { padding: 5px 10px; border-radius: 4px; font-weight: bold; font-size: 12px; }
 .low-stock { background-color: #ffebe6; color: #de350b; }
 .in-stock { background-color: #e3fcef; color: #006644; }
 .summary { margin-top: 20px; font-size: 14px; color: #666; font-style: italic; }
 </style>
</head>
<body>

 <div class="header-container">
 <h1>📦 Enterprise Inventory Dashboard</h1>
 <div>
 <%-- Display the session username --%>
 <span class="user-badge">👤 User: ${sessionScope.authenticatedUser}</span>

 <%-- Logout Action Button --%>
 <a href="logout.jsp" style="
 margin-left: 15px;
 padding: 6px 12px;
 background-color: #de350b;
 color: white;
 text-decoration: none;
 border-radius: 4px;
 font-weight: bold;
 font-size: 14px;">
 Log Out
 </a>
 </div>
 </div>

 <p><strong>Total Unique Catalog Items:</strong> ${fn:length(inventory)}</p>
 <table>
 <thead>
 <tr>
 <th>Product Name (Sanitized)</th>
 <th>Unit Price</th>
 <th>Stock Level</th>
 <th>Status Alert</th>
 </tr>
 </thead>
 <tbody>
 <c:forEach var="item" items="${inventory}">
 <tr>
 <td>${fn:toUpperCase(item.name)}</td>
 <td><fmt:formatNumber value="${item.price}" type="currency" currencySymbol="$" /></td>
 <td>${item.stock} units</td>
 <td>
 <c:choose>
 <c:when test="${item.stock < 5}">
 <span class="badge low-stock">⚠ LOW STOCK</span>
 </c:when>
 <c:otherwise>
 <span class="badge in-stock">✅ IN STOCK</span>
 </c:otherwise>
 </c:choose>
 </td>
 </tr>
 </c:forEach>
 </tbody>
 </table>
 <div class="summary">
 Report compiled on: <fmt:formatDate value="${reportDate}" type="both" dateStyle="long" timeStyle="medium" />
 </div>
</body>
</html>