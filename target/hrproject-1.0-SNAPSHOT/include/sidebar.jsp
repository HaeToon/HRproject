<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bootstrap Sidebar</title>

    <style>
        .side-bar {
            width: 250px;
            height: 100vh;
            background-color: #f8f9fa;
            padding: 20px;
        }
        .side-bar__icon-box {
            margin-bottom: 20px;
        }
        .side-bar__icon-1 div {
            width: 30px;
            height: 5px;
            background-color: #333;
            margin: 6px 0;
        }
        .side-bar ul {
            list-style: none;
            padding-left: 0;
        }
        .side-bar ul ul {
            padding-left: 15px;
        }
    </style>
</head>
<body>
<aside class="side-bar">
    <section class="side-bar__icon-box">
        <section class="side-bar__icon-1">
            <div></div>
            <div></div>
            <div></div>
        </section>
    </section>
    <ul class="nav flex-column">
        <li class="nav-item">
            <a class="nav-link" href="#"><i class="fa-solid fa-cat"></i> menu1</a>
            <ul class="nav flex-column">
                <li class="nav-item"><a class="nav-link" href="#">text1</a></li>
                <li class="nav-item"><a class="nav-link" href="#">text2</a></li>
                <li class="nav-item"><a class="nav-link" href="#">text3</a></li>
                <li class="nav-item"><a class="nav-link" href="#">text4</a></li>
            </ul>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">menu2</a>
            <ul class="nav flex-column">
                <li class="nav-item"><a class="nav-link" href="#">text1</a></li>
                <li class="nav-item"><a class="nav-link" href="#">text2</a></li>
                <li class="nav-item"><a class="nav-link" href="#">text3</a></li>
                <li class="nav-item"><a class="nav-link" href="#">text4</a></li>
            </ul>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">menu3</a>
            <ul class="nav flex-column">
                <li class="nav-item"><a class="nav-link" href="#">text1</a></li>
                <li class="nav-item"><a class="nav-link" href="#">text2</a></li>
                <li class="nav-item"><a class="nav-link" href="#">text3</a></li>
                <li class="nav-item"><a class="nav-link" href="#">text4</a></li>
            </ul>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">menu4</a>
            <ul class="nav flex-column">
                <li class="nav-item"><a class="nav-link" href="#">text1</a></li>
                <li class="nav-item"><a class="nav-link" href="#">text2</a></li>
                <li class="nav-item"><a class="nav-link" href="#">text3</a></li>
                <li class="nav-item"><a class="nav-link" href="#">text4</a></li>
            </ul>
        </li>
    </ul>
</aside>
</body>
</html>
