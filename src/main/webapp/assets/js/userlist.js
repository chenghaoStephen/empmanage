$(function() {
    // 设置标题
    $("#TopBarTitle").text("用户录入编辑");

    // 获取用户列表
    bindDataTable();
    clickEvent();

    // 注册用户
    $("#UserCreateOKButton").click(
        function (event) {
            event.preventDefault();
            // 校验
            var userName = $("#UserInfoUsernameCreate").val();
            var realName = $("#UserInfoRealnameCreate").val();
            if (userName == null || userName.length <= 0) {
                Notiflix.Notify.Warning("用户名不能为空");
                return;
            } else if (realName == null || realName.length <= 0) {
                Notiflix.Notify.Warning("真实姓名不能为空");
                return;
            }
            // 调用接口，注册用户
            $.ajax({
                type: "POST",
                url: "/user/register",
                data: $("#UserCreateForm").serialize(),
                success: function (result) {
                    if (result.status == '0') {
                        $("#UserCreateModal").modal("hide");
                        Notiflix.Notify.Success('操作成功');
                        bindDataTable();
                        clickEvent();
                    } else {
                        Notiflix.Notify.Failure(result.msg);
                    }
                },
                error: function (e) {
                    Notiflix.Notify.Failure("创建用户失败，请稍后再试");
                }
            });
        }
    );

    // 编辑用户
    $("#UserEditOKButton").click(
        function (event) {
            event.preventDefault();
            // 校验
            var realName = $("#UserInfoRealnameEdit").val();
            if (realName == null || realName.length <= 0) {
                Notiflix.Notify.Warning("真实姓名不能为空");
                return;
            }
            // 调用接口，更新用户信息
            $.ajax({
                type: "POST",
                url: "/user/updateInformation",
                data: $("#UserEditForm").serialize(),
                success: function (result) {
                    if (result.status == '0') {
                        $("#UserEditModal").modal("hide");
                        Notiflix.Notify.Success('操作成功');
                        bindDataTable();
                        clickEvent();
                    } else {
                        Notiflix.Notify.Failure(result.msg);
                    }
                },
                error: function (e) {
                    Notiflix.Notify.Failure("编辑用户失败，请稍后再试");
                }
            });
        }
    );
});

// 新增用户弹窗
function showAddUserDlg() {
    // 只有管理员能新建所有身份的用户，其他用户只能新建 代理/客户
    if (category && category == "1") {
        $('#UserInfoCategoryCreate').empty();
        var str = "<option value='1'>管理员</option>";
        str += "<option value='2'>员工</option>";
        str += "<option value='3'>代理</option>";
        str += "<option value='4'>客户</option>";
        $('#UserInfoCategoryCreate').html(str);
    } else {
        $('#UserInfoCategoryCreate').empty();
        str += "<option value='3'>代理</option>";
        str += "<option value='4'>客户</option>";
        $('#UserInfoCategoryCreate').html(str);
    }
    $("#UserCreateModal").modal("show");
}

// 搜索用户
function searchUserList() {
    bindDataTable();
    clickEvent();
}

// 获取用户列表
function bindDataTable() {
    $("#userTables").dataTable({
        lengthMenu: [10, 20, 30, 40],//定义在每页显示记录数的select中显示的选项。
        lengthChange: false,
        processing: true,//是否显示表格加载状态，在数据量大的时候需要
        destroy: true,//允许销毁替换，在表格重新查询时，可以自动销毁以前的data
        paging: true,//分页
        serverSide: true,//开启后端分页
        height: 500,
        pagingType: "full_numbers",//分页样式的类型
        ordering: false,//是否启用排序
        searching: false,//搜索
        ajax: function (data, callback, settings) {
            var param = getQueryCondition(data);
            $.ajax({
                type: "POST",
                url: "/user/findUserList",
                data: param,
                success: function (result) {
                    if (result.status == '0') {
                        var returnData = {};
                        returnData.draw = data.draw;
                        returnData.recordsTotal = result.total;
                        returnData.recordsFiltered = result.total;
                        returnData.data = result.pageData;
                        callback(returnData);
                    } else {
                        Notiflix.Notify.Failure("查询失败，请稍后再试");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    Notiflix.Notify.Failure("查询失败，请稍后再试");
                }
            });

        },
        language: {
            "lengthMenu": "10",//默认每页小时条数
            "sZeroRecords": "没有匹配结果",
            "sInfo": "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项",
            "sInfoEmpty": "显示第 0 至 0 项结果，共 0 项",
            "sInfoFiltered": "(由 _MAX_ 项结果过滤)",
            "sInfoPostFix": "",
            "sSearch": "搜索:",
            "sUrl": "",
            "sEmptyTable": "表中数据为空",
            "sInfoThousands": ",",
            "paginate": {
                "first": "首页",
                "previous": "上页",
                "next": "下页",
                "last": "末页",
                "processing": "正在处理中。。。"
            },
        },
        columns: [//定义行数据字段
            {data: 'realName'},
            {data: 'sexCn'},
            {data: 'phone'},
            {data: 'company'},
            {data: 'address'},
            {data: 'categoryCn'},
            {data: 'CZ'}
        ],
        columnDefs: [//自定义处理行数据，和行样式
            {"width": "10%", "targets": 0},
            {"width": "10%", "targets": 1},
            {"width": "15%", "targets": 2},
            {"width": "15%", "targets": 3},
            {"width": "20%", "targets": 4},
            {"width": "10%", "targets": 5},
            {
                //   指定第四列，从0开始，0表示第一列，1表示第二列……
                "width": "20%",
                "targets": 6,
                "render": function (data, type, row, meta) {
                    var rowIndex = meta.row;//获取到该行的rowIndex
                    var userId = row.userId;
                    return '<span class="btn btn-primary btn-xs ml-3 js-edit" data-id="'+userId+'">编辑</span> <span class="btn btn-info btn-xs ml-3 js-detail" data-id="'+userId+'">详情</span>';
                }
            }
        ]
    });
}

function clickEvent(){
    $('#userTables').off('click');
    $('#userTables').on('click','.js-detail',function(){
        var userId = $(this).attr('data-id');
        // 根据id获取用户信息
        $.ajax({
            type: "GET",
            url: "/user/getUserInfoById",
            data: {"userId" : userId},
            success: function (result) {
                if (result.status == '0') {
                    var userDetail = result.data;
                    // 展示用户信息
                    $("#UserInfoUsernameShow").val(userDetail.userName);
                    $("#UserInfoRealnameShow").val(userDetail.realName);
                    $("#UserInfoSexShow").val(userDetail.sexCn);
                    $("#UserInfoPhoneShow").val(userDetail.phone);
                    $("#UserInfoBankNameShow").val(userDetail.bankName);
                    $("#UserInfoBankAccountShow").val(userDetail.bankAccount);
                    $("#UserInfoCompanyShow").val(userDetail.company);
                    $("#UserInfoAddressShow").val(userDetail.address);
                    $("#UserInfoCategoryShow").val(userDetail.categoryCn);
                    $("#UserInfoRemarkShow").val(userDetail.remark);
                    $("#UserInfoShowModal").modal("show");
                } else {
                    Notiflix.Notify.Failure(result.msg);
                }
            },
            error: function (e) {
                Notiflix.Notify.Failure("获取用户信息失败");
            }
        });
    }).on('click','.js-edit',function(){
        var userId = $(this).attr('data-id');
        // 根据id获取用户信息
        $.ajax({
            type: "GET",
            url: "/user/getUserInfoById",
            data: {"userId" : userId},
            success: function (result) {
                if (result.status == '0') {
                    var userDetail = result.data;
                    // 展示用户信息
                    $("#UserInfoUserIdEdit").val(userDetail.userId);
                    $("#UserInfoUsernameEdit").val(userDetail.userName);
                    $("#UserInfoRealnameEdit").val(userDetail.realName);
                    if (userDetail.sex == '2') {
                        $("#UserEditForm input[type=radio][name=sex][value='2']").prop("checked", true);
                    } else {
                        $("#UserEditForm input[type=radio][name=sex][value='1']").prop("checked", true);
                    }
                    $("#UserInfoPhoneEdit").val(userDetail.phone);
                    $("#UserInfoBankNameEdit").val(userDetail.bankName);
                    $("#UserInfoBankAccountEdit").val(userDetail.bankAccount);
                    $("#UserInfoCompanyEdit").val(userDetail.company);
                    $("#UserInfoAddressEdit").val(userDetail.address);
                    // 只有管理员能新建所有身份的用户，其他用户只能新建 代理/客户
                    if (category && category == "1") {
                        $('#UserInfoCategoryEdit').empty();
                        var str = "<option value='1'>管理员</option>";
                        str += "<option value='2'>员工</option>";
                        str += "<option value='3'>代理</option>";
                        str += "<option value='4'>客户</option>";
                        $('#UserInfoCategoryEdit').html(str);
                        $("#UserInfoCategoryEdit").removeAttr("disabled");
                    } else {
                        // 不能改变员工类别，代理/客户可切换
                        if (userDetail.category && userDetail.category == "2") {
                            $("#UserInfoCategoryEdit").attr("disabled","disabled");
                        } else {
                            $('#UserInfoCategoryEdit').empty();
                            str += "<option value='3'>代理</option>";
                            str += "<option value='4'>客户</option>";
                            $('#UserInfoCategoryEdit').html(str);
                            $("#UserInfoCategoryEdit").removeAttr("disabled");
                        }
                    }
                    $("#UserInfoCategoryEdit").val(userDetail.category);
                    $("#UserInfoRemarkEdit").val(userDetail.remark);
                    $("#UserEditModal").modal("show");
                } else {
                    Notiflix.Notify.Failure(result.msg);
                }
            },
            error: function (e) {
                Notiflix.Notify.Failure("获取用户信息失败");
            }
        });
    })
}

<!--组装的查询参数部分-->
function getQueryCondition(data) {
    var param = {};
    //组装分页参数
    param.start = data.start;
    param.length = data.length;
    param.draw = data.draw;
    param.name = $("#SearchName").val();
    param.type = '1';//查询所有数据
    return param;
}
