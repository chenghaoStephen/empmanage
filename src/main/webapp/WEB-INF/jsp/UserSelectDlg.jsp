<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<div class="modal fade" id="UserSelectModal" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <!-- header -->
            <div class="modal-header">
                <h4 class="modal-title"><b>请选择添加的用户</b></h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <!-- body -->
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="offset-2 col-6">
                            <input type="text" class="form-control" id="SearchName"
                                   style="border-color: #2a4888;" placeholder="请输入用户姓名"/>
                        </div>
                        <div class="col-2"><span class="btn btn-primary btn-xs ml-3" onclick="searchUserList()">搜索</span></div>
                    </div>
                    <table class="table table-striped table-bordered table-hover" style="width:100%" id="userTables">
                        <thead>
                        <tr>
                            <th style="text-align: center;">用户名</th>
                            <th style="text-align: center;">姓名</th>
                            <th style="text-align: center;">性别</th>
                            <th style="text-align: center;">公司</th>
                            <th style="text-align: center;">身份</th>
                            <th style="text-align: center;">操作</th>
                        </tr>
                        </thead>
                    </table>
                </div><!-- End container-fluid-->
            </div>
            <!-- footer -->
            <div class="modal-footer">
                <div class="btn-toolbar">
                    <button type="button" class="btn" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
        <!-- modal-content -->
    </div>
    <!-- modal-dialog -->
</div>
<!-- modal -->
