<!-- Main Header -->
<header class="main-header">
    <!-- Logo -->
    <a href="index2.html" class="logo">
        <!-- mini logo for sidebar mini 50x50 pixels -->
        <span class="logo-mini"><g:meta name="info.app.displayName"/></span>
        <!-- logo for regular state and mobile devices -->
        <span class="logo-lg"><g:meta name="info.app.displayName"/></span>
    </a>

    <!-- Header Navbar -->
    <nav class="navbar navbar-static-top" role="navigation">
        <!-- Sidebar toggle button-->
        <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
            <span class="sr-only">Toggle navigation</span>
        </a>
        <!-- Navbar Right Menu -->
        <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">
                <li>
                <a href="/staffInfo/welcome" class="dropdown-toggle">
                <!-- The user image in the navbar-->
                <span class="hidden-xs">首页</span>
                </a>
            </li>
                <!-- User Account Menu -->
                <li class="dropdown user user-menu">
                    <!-- Menu Toggle Button -->
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <!-- The user image in the navbar-->
                        <img src="/img/avatar.jpg" class="user-image" alt="User Image">
                        <!-- hidden-xs hides the username on small devices so only the image appears. -->
                        <span class="hidden-xs">用户中心</span>
                    </a>
                    <ul class="dropdown-menu">
                        <!-- The user image in the menu -->
                        <li class="user-header">
                            <img src="/img/avatar.jpg" class="img-circle" alt="User Image">
                            <p>
                                ${session.staff?.realName} - Web Developer
                                <small>个人简介信息</small>
                            </p>
                        </li>
                        <!-- Menu Body -->
                        <li class="user-body">
                            <div class="col-xs-4 text-center">
                                <a href="#">等级</a>
                            </div>
                            <div class="col-xs-4 text-center">
                                <a href="#">积分</a>
                            </div>
                            <div class="col-xs-4 text-center">
                                <a href="#">推广</a>
                            </div>
                        </li>
                        <!-- Menu Footer-->
                        <li class="user-footer">
                            <div class="pull-left">
                                <a href="#" class="btn btn-default btn-flat">设置</a>
                            </div>
                            <div class="pull-right">
                                <button type="button" class="btn btn-default btn-flat" onclick="logout()">退出</button>
                            </div>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>
</header>

<script>
    function logout() {
        $.post("/login/logout", null, function (bdata) {
            if (bdata.status != "success") {
                bootbox.alert("退出失败！")
            } else {
                window.location = "/login/index";
            }
        }, "json");
    }

</script>