<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--Start sidebar-wrapper-->
<div id="sidebar-wrapper" data-simplebar="" data-simplebar-auto-hide="true">
    <div class="brand-logo">
        <a href="/">
            <img src="assets/images/logo-icon.png" class="logo-icon" alt="logo icon">
            <h5 class="logo-text">佰圣人力</h5>
        </a>
    </div>
    <div class="user-details">
        <div class="media align-items-center user-pointer" data-toggle="collapse" data-target="#user-dropdown">
            <div class="avatar"><img class="mr-3 side-user-img" src="assets/images/male.png" alt="user avatar"></div>
            <div class="media-body">
                <h6 id="user_realname_show" class="side-user-name">${sessionScope.currentUser.realName}</h6>
            </div>
        </div>
        <div id="user-dropdown" class="collapse show">
            <ul class="user-setting-menu">
                <li><a href="javaScript:showUserInfo();"><i class="icon-user"></i>  个人信息</a></li>
                <li><a href="javaScript:modifyPassword();"><i class="icon-settings"></i> 修改密码</a></li>
                <li><a href="/user/logout"><i class="icon-power"></i> 退出登录</a></li>
            </ul>
        </div>
    </div>
    <ul class="sidebar-menu do-nicescrol">
        <li class="sidebar-header">管理员功能</li>
        <li>
            <a href="/userRlnShow" class="waves-effect">
                <i class="zmdi zmdi-group-work"></i> <span>查看用户关系</span>
            </a>
        </li>
        <li>
            <a href="/userRlnEdit" class="waves-effect">
                <i class="zmdi zmdi-edit"></i> <span>编辑用户关系</span>
            </a>
        </li>
        <li>
            <a href="/userList" class="waves-effect">
                <i class="zmdi zmdi-info"></i> <span>用户录入编辑</span>
            </a>
        </li>
    </ul>

</div>
<!--End sidebar-wrapper-->

<!--Start topbar header-->
<header class="topbar-nav">
    <nav class="navbar navbar-expand fixed-top">
        <ul class="navbar-nav mr-auto align-items-center">
            <li class="nav-item">
                <a class="nav-link toggle-menu" href="javascript:empty();">
                    <i class="icon-menu menu-icon"></i>
                </a>
            </li>
            <li class="nav-item" style="margin-left: 15px;">
                <h5 id="TopBarTitle" class="mb-0 text-white"></h5>
            </li>
        </ul>

        <ul class="navbar-nav align-items-center right-nav-link">
            <li class="nav-item" style="margin-right: 15px;">
                <h6 class="mb-0 text-white">${sessionScope.currentUser.realName}</h6>
            </li>
            <li class="nav-item">
                <a class="nav-link dropdown-toggle dropdown-toggle-nocaret" data-toggle="dropdown" href="#">
                    <span class="user-profile"><img src="assets/images/male-bg.png" class="img-circle" alt="user avatar"></span>
                </a>
                <ul class="dropdown-menu dropdown-menu-right">
                    <li class="dropdown-item"><a href="javaScript:showUserInfo();"><i class="icon-user mr-2"></i> 个人信息</a></li>
                    <li class="dropdown-divider"></li>
                    <li class="dropdown-item"><a href="javaScript:modifyPassword();"><i class="icon-settings mr-2"></i> 修改密码</a></li>
                    <li class="dropdown-divider"></li>
                    <li class="dropdown-item"><a href="/user/logout"><i class="icon-power mr-2"></i> 退出登录</a></li>
                </ul>
            </li>
        </ul>
    </nav>
</header>
<!--End topbar header-->
