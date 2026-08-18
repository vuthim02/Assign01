<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%-- STEP 1: Define the Authorized Users List using EL Map Syntax --%>
<c:set var="userDatabase" value="${{
 'admin': '111',
 'user': '222',
 'guest': '333'
}}" scope="session" />
<%-- STEP 2: Handle Authentication Logic if Form is Submitted --%>
<c:if test="${pageContext.request.method eq 'POST'}">
 <c:set var="inputUser" value="${param.username}" />
 <c:set var="inputPass" value="${param.password}" />

 <%-- Lookup the password associated with the username in our map --%>
 <c:set var="correctPassword" value="${userDatabase[inputUser]}" />

 <c:choose>
 <%-- Check if user exists and password matches --%>
 <c:when test="${not empty correctPassword && correctPassword eq inputPass}">
 <%-- Initialize a session variable to track successful authentication --%>
 <c:set var="authenticatedUser" value="${inputUser}" scope="session" />

 <%-- Route user safely to the dashboard --%>
 <c:redirect url="inventory.jsp" />
 </c:when>
 <c:otherwise>
 <%-- Set temporary error message if validation checks fail --%>
 <c:set var="loginErrorMessage" value="Invalid username or password. Please try again." />
 </c:otherwise>
 </c:choose>
</c:if>
<!DOCTYPE html>
<html lang="en">
<head>
 <meta charset="UTF-8">
 <title>Enterprise Login</title>
 <style>
 body { font-family: Arial, sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; background-color: #f4f6f9; margin: 0; }
 .login-card { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); width: 320px; }
 h2 { margin-top: 0; color: #333; text-align: center; }
 .form-group { margin-bottom: 15px; }
 label { display: block; margin-bottom: 5px; font-weight: bold; color: #555; font-size: 14px; }
 input[type="text"], input[type="password"] { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
 button { width: 100%; padding: 10px; background-color: #0076d6; color: white; border: none; border-radius: 4px; font-weight: bold; cursor: pointer; margin-top: 10px; }
 button:hover { background-color: #00569e; }
 .error-msg { color: #de350b; background-color: #ffebe6; padding: 10px; border-radius: 4px; font-size: 13px; margin-bottom: 15px; text-align: center; border: 1px solid #ffbdad; }
 </style>
</head>
<body>
<div class="login-card">
 <h2>System Login</h2>

 <%-- Render errors dynamically without raw expression scriptlets --%>
 <c:if test="${not empty loginErrorMessage}">
 <div class="error-msg">${loginErrorMessage}</div>
 </c:if>
 <form action="login.jsp" method="POST">
 <div class="form-group">
 <label for="username">Username</label>
 <input type="text" id="username" name="username" required autocomplete="off">
 </div>
 <div class="form-group">
 <label for="password">Password</label>
 <input type="password" id="password" name="password" required>
 </div>
 <button type="submit">Sign In</button>
 </form>
</div>
</body>
</html>