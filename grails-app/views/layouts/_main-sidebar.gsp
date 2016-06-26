<%@ page import="CarSale.SystemMenu" %>
<!-- Left side column. contains the logo and sidebar -->
<aside class="main-sidebar">

    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">

        <!-- Sidebar user panel (optional) -->
        <div class="user-panel">
            <div class="pull-left image">
                <img src="/img/user2-160x160.jpg" class="img-circle" alt="User Image">
            </div>

            <div class="pull-left info">
                <p>${session.staff.realName}</p>
                <!-- Status -->
                <a href="#"><i class="fa fa-circle text-success"></i> 工作顺利</a>
            </div>
        </div>

        <!-- Sidebar Menu -->
        <ul class="sidebar-menu">
            <li class="header">菜单</li>
            <!-- Optionally, you can add icons to the links -->
            <g:set var="systemStaffRoleService" bean="systemStaffRoleService"></g:set>
            <g:each in="${systemStaffRoleService.getStaffFirstMenus(session.staff)}">


            <li class="active treeview">
                <a href="#">
                    <i class="fa ${it.menuIcon}"></i> <span>${it.menuName}</span> <i class="fa fa-angle-left pull-right"></i>
                </a>
                <ul class="treeview-menu">
                    <g:each var="subMenu" in="${CarSale.SystemMenu.findAllByParentMenu(it.id).sort{it.rootPath}}">
                        <g:if test="${session.menuUrl == subMenu?.menuUrl}">
                            <li class="subMenu active"></g:if>
                        <g:else>
                            <li class="subMenu">
                        </g:else>
                    <a href="${subMenu?.menuUrl}"><i class="fa fa-circle-o"></i> ${subMenu?.menuName}</a></li>
                    </g:each>
                </ul>
            </li>
            </g:each>

        </ul><!-- /.sidebar-menu -->
    </section>
    <!-- /.sidebar -->
</aside>
<script>
    $("li.subMenu.active").parents(".treeview").addClass("active");
</script>
