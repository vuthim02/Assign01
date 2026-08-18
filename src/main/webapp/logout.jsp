<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%-- Force a client-side redirect back to the login screen --%>
<c:remove var="userDatabase" scope="session" />
<c:remove var="authenticatedUser" scope="session" />
<c:redirect url="login.jsp" />