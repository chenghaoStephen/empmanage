<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <title>佰圣人力</title>
    <%@include file="header.jsp"%>
    <!-- Vector CSS -->
    <link href="assets/plugins/vectormap/jquery-jvectormap-2.0.2.css" rel="stylesheet"/>
    <!-- animate CSS-->
    <link href="assets/css/animate.css" rel="stylesheet" type="text/css"/>
    <!-- simplebar CSS-->
    <link href="assets/plugins/simplebar/css/simplebar.css" rel="stylesheet"/>
    <!-- Icons CSS-->
    <link href="assets/css/icons.css" rel="stylesheet" type="text/css"/>
    <!-- Sidebar CSS-->
    <link href="assets/css/sidebar-menu.css" rel="stylesheet"/>
    <!--Data Tables -->
    <link href="assets/plugins/bootstrap-datatable/css/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css">
    <link href="assets/plugins/bootstrap-datatable/css/buttons.bootstrap4.min.css" rel="stylesheet" type="text/css">
    <!-- Custom Style-->
    <link href="assets/css/app-style.css" rel="stylesheet"/>

    <%@include file="UserInfoShowDlg.jsp"%>
    <%@include file="ModifyPassword.jsp"%>
    <%@include file="UserCreateDlg.jsp"%>
    <%@include file="UserEditDlg.jsp"%>
    <style>
        .js-edit,.js-detail {
            line-height : 1;
        }
    </style>
</head>

<body>

<!-- Start wrapper-->
<div id="wrapper">

    <%@include file="common.jsp"%>

    <div class="clearfix"></div>

    <div class="content-wrapper">
        <div class="container-fluid">

            <div class="row">
                <div class="col-2"><span class="btn btn-primary btn-xs ml-3" onclick="showAddUserDlg()">新增</span></div>
                <div class="col-3"></div>
                <div class="col-5">
                    <input type="text" class="form-control" id="SearchName"
                           style="border-color: #2a4888;" placeholder="请输入用户姓名"/>
                </div>
                <div class="col-2"><span class="btn btn-primary btn-xs ml-3" onclick="searchUserList()">搜索</span></div>
            </div>
            <table class="table table-striped table-bordered table-hover" id="userTables">
                <thead>
                <tr>
                    <th style="text-align: center;">姓名</th>
                    <th style="text-align: center;">性别</th>
                    <th style="text-align: center;">电话</th>
                    <th style="text-align: center;">公司</th>
                    <th style="text-align: center;">住址</th>
                    <th style="text-align: center;">身份</th>
                    <th style="text-align: center;">操作</th>
                </tr>
                </thead>
            </table>
        </div><!-- End container-fluid-->
    </div><!--End content-wrapper-->
</div><!--End wrapper-->

<%@include file="footer.jsp"%>
<script src="assets/js/common.js?version=20191119"></script>
<!-- sidebar-menu js -->
<script src="assets/js/sidebar-menu.js"></script>
<!-- Custom scripts -->
<script src="assets/js/app-script.js"></script>
<!-- fb-index2 js -->
<script src="assets/js/userlist.js?version=20191119"></script>

<!--Data Tables js-->
<script src="assets/plugins/bootstrap-datatable/js/jquery.dataTables.min.js"></script>
<script src="assets/plugins/bootstrap-datatable/js/dataTables.bootstrap4.min.js"></script>
<script src="assets/plugins/bootstrap-datatable/js/dataTables.buttons.min.js"></script>
<script src="assets/plugins/bootstrap-datatable/js/buttons.bootstrap4.min.js"></script>

</body>
</html>
