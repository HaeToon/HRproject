<%--
  Created by IntelliJ IDEA.
  User: jhta
  Date: 2024-06-10
  Time: 오후 3:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Salary List</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <script src="../js/bootstrap.bundle.min.js"></script>
</head>
<body>

<div class="container">
    <h2 class="mt-5 mb-5">LIST</h2>
    <form action="../board/delete-all" method="post">
        <table class="table table-striped">
            <colgroup>
                <col style="width:80px">
                <col>
                <col style="width:150px">
                <col style="width:80px">
                <col style="width:250px">
            </colgroup>
            <thead>
            <tr>
                <th>테스트</th>
                <th>테스트</th>
                <th>테스트</th>
                <th>테스트</th>
                <th>테스트</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${salaryList}" var="salaryDto" varStatus="loop">
                <tr>
                    <td>${salaryDto.salaryNo}</td>
                    <td>${salaryDto.salary}</td>
                    <td>${salaryDto.salaryDay}</td>
                    <td>${salaryDto.salaryCategory}</td>
                    <td>${salaryDto.salaryInfo}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </form>
</div>

</body>
</html>
