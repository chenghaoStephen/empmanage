var userIdSet = [];
$(function() {
    $("#TopBarTitle").text("编辑用户关系");
    // 获取用户关系图数据
    $.ajax({
        type: "GET",
        url: "/userrln/findByParUserId",
        data: {},
        success: function (result) {
            if (result.status == '0') {
                var data = result.data;
                refreshRlnDiagram(data);
            } else {
                Notiflix.Notify.Failure(result.msg);
            }
        },
        error: function (e) {
            Notiflix.Notify.Failure("获取用户关系失败");
        }
    });
    // 关闭弹框时，清空搜索框
    $("#UserSelectModal").on('hide.bs.modal', function () {
        $("#SearchName").val("");
    });

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
            // 调用接口，注册用户并且绑定关系
            var $node = $('#selected-node').data('node');
            var parUserId = $node.attr('id');
            $.ajax({
                type: "POST",
                url: "/userrln/insertUserAndUserRln",
                data: $("#UserCreateForm").serialize() + "&parUserId=" + parUserId,
                success: function (result) {
                    if (result.status == '0') {
                        var userInfo = result.data;
                        addNewNodeToChart(userInfo);
                        $("#UserCreateModal").modal("hide");
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
            var userName = $("#UserInfoUsernameEdit").val();
            if (userName == null || userName.length <= 0) {
                Notiflix.Notify.Warning("用户名不能为空");
                return;
            }
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
                        // 更新界面信息
                        var $node = $('#selected-node').data('node');
                        $node.find('.content').text($("#UserInfoRealnameEdit").val());
                        $node.removeClass("middle-level").removeClass("product-dept").removeClass("pipeline1").removeClass("frontend1");
                        var className = "frontend1";
                        var categoryCn = "客户";
                        switch($("#UserInfoCategoryEdit").val()) {
                            case "1":
                                className = "middle-level";
                                categoryCn = "管理员";
                                break;
                            case "2":
                                className = "product-dept";
                                categoryCn = "员工";
                                break;
                            case "3":
                                className = "pipeline1";
                                categoryCn = "代理";
                                break;
                            case "4":
                                className = "frontend1";
                                categoryCn = "客户";
                                break;
                            default:
                        }
                        $node.addClass(className);
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

function refreshRlnDiagram(data) {
    userIdSet = data.userIdSet;
    var oc = $('#chart-container').orgchart({
        'data' : data.datasource,
        'chartClass': 'edit-state',
        'nodeContent': 'title',
        'pan': true,
        'zoom': true,
        'parentNodeSymbol': 'fa-th-large',
        'createNode': function($node, data) {
        }
    });

    // 设置为编辑模式
    $('.orgchart').toggleClass('edit-state', true);
    $('.orgchart').find('tr').removeClass('hidden')
        .find('td').removeClass('hidden')
        .find('.node .edge').addClass('hidden');

    // 选中节点
    oc.$chartContainer.on('click', '.node', function() {
        var $this = $(this);
        $('#selected-node').val($this.find('.content').text()).data('node', $this);
    });

    // 取消选择（点击空白处）
    oc.$chartContainer.on('click', '.orgchart', function(event) {
        if (!$(event.target).closest('.node').length) {
            $('#selected-node').val('').data('node', null);
        }
    });
}

// 添加新用户
function addnewnode() {
    var $node = $('#selected-node').data('node');
    if (!$node) {
        Notiflix.Notify.Warning("请选择一个节点");
        return;
    }
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
    // 弹出新建用户弹窗
    $("#UserCreateModal").modal("show");
}

// 添加已有用户
function addnode() {
    var $node = $('#selected-node').data('node');
    if (!$node) {
        Notiflix.Notify.Warning("请选择一个节点");
        return;
    }
    // 弹出节点选择弹框
    $("#UserSelectModal").modal("show");
    searchUserList();
}

// 新建/选择用户后，添加到视图
function addNewNodeToChart(userInfo) {
    var oc = $('#chart-container').orgchart({
        'nodeContent': 'title'
    });
    var $node = $('#selected-node').data('node');

    var className = "frontend1";
    switch(userInfo.category) {
        case "1":
            className = "middle-level";
            break;
        case "2":
            className = "product-dept";
            break;
        case "3":
            className = "pipeline1";
            break;
        case "4":
            className = "frontend1";
            break;
        default:
    }
    var nodeVals = [{
        "id": userInfo.userId,
        "name": userInfo.categoryCn,
        "title": userInfo.realName,
        "className": className
    }];
    var hasChild = $node.parent().attr('colspan') > 0 ? true : false;
    if (!hasChild) {
        var rel = nodeVals.length > 1 ? '110' : '100';
        oc.addChildren($node, nodeVals.map(function (item) {
            return { 'name': item.name, 'relationship': rel, "title": item.title, "className": item.className , "id": item.id};
        }));
    } else {
        oc.addSiblings($node.closest('tr').siblings('.nodes').find('.node:first'), nodeVals.map(function (item) {
            return { 'name': item.name, 'relationship': '110', "title": item.title, "className": item.className, "id": item.id};
        }));
    }
    $('.orgchart').find('.node .edge').addClass('hidden');
    userIdSet.push(userInfo.userId);
    Notiflix.Notify.Success('操作成功');
    $("#UserSelectModal").modal("hide");
}

// 编辑用户
function editnode() {
    var oc = $('#chart-container').orgchart();
    var $node = $('#selected-node').data('node');
    if (!$node) {
        Notiflix.Notify.Warning("请选择一个节点");
        return;
    }
    var userId = $node.attr('id');
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
}

// 移除用户
function deletenode() {
    var oc = $('#chart-container').orgchart();
    var $node = $('#selected-node').data('node');
    if (!$node) {
        Notiflix.Notify.Warning("请选择一个节点");
        return;
    } else if ($node[0] === $('.orgchart').find('.node:first')[0]) {
        Notiflix.Notify.Failure("不能删除根节点");
        return;
    }
    if (!window.confirm('确定删除该节点吗?')) {
        return;
    }
    var userId = $node.attr('id');
    // 调用接口删除关系
    $.ajax({
        type: "POST",
        url: "/userrln/deleteByUserId",
        data: {
            "userId": userId
        },
        success: function (result) {
            if (result.status == '0') {
                oc.removeNodes($node);
                $('#selected-node').val('').data('node', null);
                // Set中删除
                var index = userIdSet.indexOf(userId);
                if (index >= 0) {
                    userIdSet.splice(index, 1);
                }
                Notiflix.Notify.Success('操作成功');
            } else {
                Notiflix.Notify.Failure(result.msg);
            }
        },
        error: function (e) {
            Notiflix.Notify.Failure("操作失败");
        }
    });
}

// 搜索用户
function searchUserList() {
    bindDataTable();
    clickEvent();
}

// 获取用户列表
function bindDataTable() {
    $("#userTables").dataTable({
        lengthMenu: [5, 10, 50, 100],//定义在每页显示记录数的select中显示的选项。
        lengthChange: false,
        processing: true,//是否显示表格加载状态，在数据量大的时候需要
        destroy: true,//允许销毁替换，在表格重新查询时，可以自动销毁以前的data
        paging: true,//分页
        serverSide: true,//开启后端分页
        height: 300,
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
            "lengthMenu": "5",//默认每页小时条数
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
            {data: 'userName'},
            {data: 'realName'},
            {data: 'sexCn'},
            {data: 'company'},
            {data: 'categoryCn'},
            {data: 'CZ'}
        ],
        columnDefs: [//自定义处理行数据，和行样式
            {"width": "15%", "targets": 0},
            {"width": "15%", "targets": 1},
            {"width": "15%", "targets": 2},
            {"width": "20%", "targets": 3},
            {"width": "15%", "targets": 4},
            {
                //   指定第四列，从0开始，0表示第一列，1表示第二列……
                "width": "20%",
                "targets": 5,
                "render": function (data, type, row, meta) {
                    var rowIndex = meta.row;//获取到该行的rowIndex
                    var userId = row.userId;
                    return '<span class="btn btn-primary btn-xs ml-3 js-select" data-id="'+userId+'">选择</span>';
                }
            }
        ]
    });
}

function clickEvent(){
    $('#userTables').off('click');
    $('#userTables').on('click','.js-select',function() {
        var userId = $(this).attr('data-id');
        var $node = $('#selected-node').data('node');
        var parUserId = $node.attr('id');
        // 判断用户是否已经存在于树中，如果存在，则提示删除
        if (userIdSet.indexOf(userId) >= 0) {
            Notiflix.Notify.Warning("用户已经存在关系，请先删除后再添加");
            return;
        }
        // 添加用户关系
        $.ajax({
            type: "POST",
            //contentType: "application/json",
            url: "/userrln/insertUserRln",
            data: {
                "userId": userId,
                "parUserId": parUserId
            },
            success: function (result) {
                if (result.status == '0') {
                    var userInfo = result.data;
                    addNewNodeToChart(userInfo);
                } else {
                    Notiflix.Notify.Failure(result.msg);
                }
            },
            error: function (e) {
                Notiflix.Notify.Failure("操作失败");
            }
        });
    });
}

<!--组装的查询参数部分-->
function getQueryCondition(data) {
    var param = {};
    //组装分页参数
    param.start = data.start;
    param.length = data.length;
    param.draw = data.draw;
    param.name = $("#SearchName").val();
    param.type = '2';//只查询没有关系的数据
    return param;
}