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
    <!-- Custom Style-->
    <link href="assets/css/app-style.css" rel="stylesheet"/>
    <!--Data Tables -->
    <link href="assets/plugins/bootstrap-datatable/css/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css">
    <link href="assets/plugins/bootstrap-datatable/css/buttons.bootstrap4.min.css" rel="stylesheet" type="text/css">

    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/jquery.orgchart.css">
    <link rel="stylesheet" href="css/style.css">
    <%@include file="UserInfoShowDlg.jsp"%>
    <%@include file="ModifyPassword.jsp"%>
    <%@include file="UserCreateDlg.jsp"%>
    <%@include file="UserEditDlg.jsp"%>
    <%@include file="UserSelectDlg.jsp"%>
    <style type="text/css">
        .orgchart { background: #f6f9fc; }
        .orgchart td.left, .orgchart td.right, .orgchart td.top { border-color: #aaa; }
        .orgchart td>.down { background-color: #aaa; }
        .orgchart .middle-level .title { background-color: #006699; }
        .orgchart .middle-level .content { border-color: #006699; }
        .orgchart .product-dept .title { background-color: #bbcd00; }
        .orgchart .product-dept .content { border-color: #bbcd00; }
        .orgchart .rd-dept .title { background-color: #00d1c6; }
        .orgchart .rd-dept .content { border-color: #00d1c6; }
        .orgchart .pipeline1 .title { background-color: #65bb48; }
        .orgchart .pipeline1 .content { border-color: #65bb48; }
        .orgchart .frontend1 .title { background-color: #f8bb00; }
        .orgchart .frontend1 .content { border-color: #f8bb00; }
        .orgchart .node.matched { background-color: rgba(238, 217, 54, 0.5); }
        #edit-panel {
            text-align: center;
            position: relative;
            left: 10px;
            width: calc(100% - 40px);
            border-radius: 4px;
            float: left;
            margin-top: 10px;
            padding: 10px;
            color: #fff;
            background-color: #449d44;
        }
        #edit-panel * { font-size: 20px; }
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
                <h5 class="side-user-name" style="margin-top: 10px;margin-left: 30px;">请选择一个节点</h5>
                <div class="col-5">
                    <input type="text" class="form-control" id="selected-node"
                           style="border-color: #2a4888;" readonly="readonly"/>
                </div>
                <span class="btn btn-primary btn-xs ml-1" onclick="addnewnode();">添加新用户</span>
                &nbsp;&nbsp;
                <span class="btn btn-primary btn-xs ml-1" onclick="addnode();">添加已有用户</span>
                &nbsp;&nbsp;
                <span class="btn btn-primary btn-xs ml-1" onclick="editnode();">编辑用户</span>
                &nbsp;&nbsp;
                <span class="btn btn-danger btn-xs ml-1" onclick="deletenode();">移除用户</span>
            </div>

            <div id="chart-container"></div>

        </div><!-- End container-fluid-->
    </div><!--End content-wrapper-->
</div><!--End wrapper-->

<script type="text/javascript" src="js/jquery.min.js"></script>
<script src="assets/js/bootstrap.min.js"></script>
<script src="assets/js/notiflix-1.3.0.min.js" type="text/javascript"></script>
<script src="assets/js/common.js"></script>
<script>
    $(document).ready(function () {
        Notiflix.Notify.Init();
        Notiflix.Report.Init();
    });
</script>
<script type="text/javascript" src="js/jquery.orgchart.js"></script>
<!-- sidebar-menu js -->
<script src="assets/js/sidebar-menu.js"></script>
<!-- Custom scripts -->
<script src="assets/js/app-script.js"></script>

<script src="assets/js/userrlnedit.js"></script>
<!--Data Tables js-->
<script src="assets/plugins/bootstrap-datatable/js/jquery.dataTables.min.js"></script>
<script src="assets/plugins/bootstrap-datatable/js/dataTables.bootstrap4.min.js"></script>
<script src="assets/plugins/bootstrap-datatable/js/dataTables.buttons.min.js"></script>
<script src="assets/plugins/bootstrap-datatable/js/buttons.bootstrap4.min.js"></script>

</body>
</html>
