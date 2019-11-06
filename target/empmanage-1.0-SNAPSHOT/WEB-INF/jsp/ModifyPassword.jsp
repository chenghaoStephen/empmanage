<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<div class="modal fade" id="ModifyPasswordModal" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <!-- header -->
            <div class="modal-header">
                <h4 class="modal-title"><b>修改密码</b></h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <!-- body -->
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="container">
                        <div class="row">
                            <div class="col-2"><label>原密码</label></div>
                            <div class="col-8">
                                <input type="password" class="form-control" id="ModifyPasswordPasswordOldShow"
                                       name="passwordOld"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-2"><label>新密码</label></div>
                            <div class="col-8">
                                <input type="password" class="form-control" id="ModifyPasswordPasswordNewShow"
                                       name="passwordNew"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-2"><label>确认密码</label></div>
                            <div class="col-8">
                                <input type="password" class="form-control" id="ModifyPasswordPasswordConfirmShow"
                                       name="passwordConfirm"/>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <!-- footer -->
            <div class="modal-footer">
                <div class="btn-toolbar">
                    <button id="ModifyPasswordOKButton" class="btn btn-primary btn-theme" type="button">确定</button>
                    <button type="button" class="btn" data-dismiss="modal">取消</button>
                </div>
            </div>
        </div>
        <!-- modal-content -->
    </div>
    <!-- modal-dialog -->
</div>
<!-- modal -->
