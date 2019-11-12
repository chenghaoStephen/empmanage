<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<div class="modal fade" id="UserEditModal" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <!-- header -->
            <div class="modal-header">
                <h4 class="modal-title"><b>编辑用户</b></h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <!-- body -->
            <div class="modal-body">
                <form id="UserEditForm" class="form-horizontal">
                    <div class="container">
                        <div class="row">
                            <div class="col-2"><label>用户名</label></div>
                            <div class="col-8">
                                <input type="text" class="form-control" id="UserInfoUsernameEdit"
                                       name="userName" readonly="readonly"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-2"><label>真实姓名</label></div>
                            <div class="col-8">
                                <input type="text" class="form-control" id="UserInfoRealnameEdit"
                                       name="realName" maxlength="20"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-2"><label>性别</label></div>
                            <div class="col-1">
                                <input class="inputradio" type="radio" name="sex" value="1" checked="checked"/>男
                            </div>
                            <div class="col-1">
                                <input class="inputradio" type="radio" name="sex" value="2"/>女
                            </div>
                            <div class="col-1"></div>
                        </div>
                        <div class="row">
                            <div class="col-2"><label>电话</label></div>
                            <div class="col-8">
                                <input type="text" class="form-control" id="UserInfoPhoneEdit"
                                       name="phone" maxlength="20"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-2"><label>开户行</label></div>
                            <div class="col-8">
                                <input type="text" class="form-control" id="UserInfoBankNameEdit"
                                       name="bankName" maxlength="20"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-2"><label>银行卡号</label></div>
                            <div class="col-8">
                                <input type="text" class="form-control" id="UserInfoBankAccountEdit"
                                       name="bankAccount" maxlength="30"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-2"><label>公司</label></div>
                            <div class="col-8">
                                <input type="text" class="form-control" id="UserInfoCompanyEdit"
                                       name="company" maxlength="20"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-2"><label>住址</label></div>
                            <div class="col-8">
                                <textarea rows="2" class="form-control" id="UserInfoAddressEdit"
                                          name="address" fixed="true" maxlength="35"></textarea>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-2"><label>身份</label></div>
                            <div class="col-8">
                                <select class="form-control" id="UserInfoCategoryEdit" name="category" required>
                                    <option value="1">管理员</option>
                                    <option value="2">员工</option>
                                    <option value="3">代理</option>
                                    <option value="4">客户</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-2"><label>备注</label></div>
                            <div class="col-8">
                                <input type="text" class="form-control" id="UserInfoRemarkEdit"
                                       name="remark" maxlength="20"/>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <!-- footer -->
            <div class="modal-footer">
                <div class="btn-toolbar">
                    <button id="UserEditOKButton" class="btn btn-primary btn-theme" type="button">确定</button>
                    <button type="button" class="btn" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
        <!-- modal-content -->
    </div>
    <!-- modal-dialog -->
</div>
<!-- modal -->
