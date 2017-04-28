<%@ page language="java" pageEncoding="utf-8" %>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<html>
<head>


    <title>title</title>
    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">


</head>

<body style="padding-top: 0px;background-color: #323544">


<!-- Carousel
================================================== -->
<div id="myCarousel" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <div class="container">


        <form class="form-signin" action="index" method="post" id="login">


            <label for="inputEmail" class="sr-only">Username</label>
            <label class="colorwhite "></label>
            <input type="text"
                   name="username"
                   id="inputEmail"
                   class="form-control"
                   placeholder="请输入用户名"
                   required
                   autofocus>
            <label for="inputPassword" class="sr-only">Password</label>
            <input type="password" name="password" id="inputPassword" class="form-control" placeholder="请输入密码" required>

            <button class="btn btn-lg btn-danger btn-block" type="submit">登录</button>
        </form>

    </div>
</div><!-- /.carousel -->


<script src="http://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/md5.js"></script>
</body>
</html>

