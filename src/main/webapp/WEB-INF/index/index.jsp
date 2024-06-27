<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="../include/header.jsp" %>
<c:choose>
    <c:when test="${loginDto eq null}">
        <jsp:include page="../hrm/login.jsp" flush="true"/>
    </c:when>
    <c:otherwise>
        <%@include file="../include/content.jsp" %>
    </c:otherwise>
</c:choose>
