<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Navigation Bar Example</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .navbar {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
            padding-left: 0;
            background-color: #f8f9fa; /* 배경색을 파란색으로 변경 */
        }

        .navbar-nav .nav-link {
            color: #6c757d; /* 글자색을 회색으로 변경 */
        }

        .nav-link:hover {
            color: #343a40; /* 호버시 글자색을 어두운 회색으로 변경 */
        }

        .navbar-brand {
            margin-right: auto;
            margin-left: 15px;
        }

        .navbar-nav {
            margin: 0 auto;
            display: table;
            table-layout: fixed;
            float: none;
        }

        .navbar-nav > li {
            float: none;
            display: inline-block;
        }

        .sidebar {
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            padding-top: 70px; /* Height of the navbar plus some extra padding */
            background-color: #f8f9fa;
        }
        .content {
            margin-left: 250px;
            padding: 20px;
            padding-top: 70px; /* Height of the navbar plus some extra padding */
        }
    </style>
</head>
<body>

<!-- 상단 네비게이션 바 -->
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Navbar</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavDropdown">
            <ul class="navbar-nav mx-auto"> <!-- mx-auto를 사용하여 중앙 정렬 -->
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="#">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Features</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Pricing</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Dropdown link
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                        <a class="dropdown-item" href="#">Action</a>
                        <a class="dropdown-item" href="#">Another action</a>
                        <a class="dropdown-item" href="#">Something else here</a>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- 사이드 네비게이션 바 -->
<div class="sidebar">
    <ul class="nav flex-column">
        <li class="nav-item">
            <a class="nav-link active" href="#">Dashboard</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">Orders</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">Products</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">Customers</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">Reports</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">Integrations</a>
        </li>
    </ul>
</div>

<!-- 컨텐츠 영역 -->
<div class="content">
    <h1>Main Content Area</h1>
    <p>This is the main content area. Your content goes here.</p>
</div>

<!-- 부트스트랩 필수 JS 파일 -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
