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

    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/jquery.orgchart.css">
    <link rel="stylesheet" href="css/style.css">
    <%@include file="UserInfoShowDlg.jsp"%>
    <%@include file="ModifyPassword.jsp"%>
    <%@include file="UserCreateDlg.jsp"%>
    <%@include file="UserEditDlg.jsp"%>
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
                <div id="ShowSearchInput" class="offset-2 col-6">
                    <input type="text" class="form-control" id="key-word"
                           style="border-color: #2a4888;" placeholder="请输入关键字"/>
                </div>
                <span id="ShowSearchBtn" class="btn btn-primary btn-xs ml-1" onclick="filterNodes($('#key-word').val());">搜索</span>
                &nbsp;&nbsp;
                <span id="ShowResetBtn" class="btn btn-light btn-xs ml-1" onclick="clearFilterResult();">重置</span>
            </div>

            <div id="chart-container"></div>

        </div><!-- End container-fluid-->
    </div><!--End content-wrapper-->
</div><!--End wrapper-->

<%@include file="footer.jsp"%>
<script src="assets/js/common.js?version=20191112"></script>
<script type="text/javascript" src="js/jquery.orgchart.js"></script>
<!-- sidebar-menu js -->
<script src="assets/js/sidebar-menu.js"></script>
<!-- Custom scripts -->
<script src="assets/js/app-script.js"></script>

<script src="assets/js/userrlnshow.js?version=20191112"></script>

</body>
</html>
