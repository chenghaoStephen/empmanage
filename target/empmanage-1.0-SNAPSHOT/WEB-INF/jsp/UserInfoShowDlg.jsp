<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<div class="modal fade" id="UserInfoShowModal" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <!-- header -->
            <div class="modal-header">
                <h4 class="modal-title"><b>个人信息</b></h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <!-- body -->
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="container">
                        <div class="row">
                            <div class="col-2"><label>用户名</label></div>
                            <div class="col-8">
                                <input type="text" class="form-control" id="UserInfoUsernameShow"
                                       name="userName" readonly="readonly"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-2"><label>真实姓名</label></div>
                            <div class="col-8">
                                <input type="text" class="form-control" id="UserInfoRealnameShow"
                                       name="realName" readonly="readonly"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-2"><label>性别</label></div>
                            <%--<div class="col-1">--%>
                                <%--<input class="inputradio" type="radio" name="sex" value="1" readonly="readonly" disabled="disabled"/>男--%>
                            <%--</div>--%>
                            <%--<div class="col-1">--%>
                                <%--<input class="inputradio" type="radio" name="sex" value="2" disabled="disabled"/>女--%>
                            <%--</div>--%>
                            <%--<div class="col-1"></div>--%>
                            <div class="col-8">
                                <input type="text" class="form-control" id="UserInfoSexShow"
                                       name="sex" readonly="readonly"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-2"><label>电话</label></div>
                            <div class="col-8">
                                <input type="text" class="form-control" id="UserInfoPhoneShow"
                                       name="phone" readonly="readonly"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-2"><label>公司</label></div>
                            <div class="col-8">
                                <input type="text" class="form-control" id="UserInfoCompanyShow"
                                       name="company" readonly="readonly"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-2"><label>住址</label></div>
                            <div class="col-8">
                                <textarea rows="3" class="form-control" id="UserInfoAddressShow"
                                          name="address" fixed="true" readonly="readonly"></textarea>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-2"><label>身份</label></div>
                            <div class="col-8">
                                <input type="text" class="form-control" id="UserInfoCategoryShow"
                                       name="category" readonly="readonly"/>
                            </div>
                        </div>
                    </div>
                </form>
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
