$(function () {

    // 关闭个人信息界面时，重置
    $("#UserInfoShowModal").on('hide.bs.modal', function () {
        resetUserInfo();
    });

    // 修改密码
    $("#ModifyPasswordOKButton").click(
        function (event) {
            event.preventDefault();
            // 校验密码
            var passwordOld = $("#ModifyPasswordPasswordOldShow").val();
            var passwordNew = $("#ModifyPasswordPasswordNewShow").val();
            var passwordConfirm = $("#ModifyPasswordPasswordConfirmShow").val();
            if (passwordOld == null || passwordOld.length <= 0) {
                Notiflix.Notify.Warning("原密码不能为空");
                return;
            } else if (passwordNew == null || passwordNew.length <= 0) {
                Notiflix.Notify.Warning("新密码不能为空");
                return;
            } else if (passwordConfirm == null || passwordConfirm.length <= 0) {
                Notiflix.Notify.Warning("确认密码不能为空");
                return;
            } else if (passwordNew != passwordConfirm) {
                Notiflix.Notify.Warning("新密码和确认密码不一致");
                return;
            }
            // 调用接口，修改密码
            $.ajax({
                type: "POST",
                url: "/user/resetPassword",
                data: {
                    'password' : passwordOld,
                    'passwordNew' : passwordNew
                },
                success: function (result) {
                    if (result.status == '0') {
                        $("#ModifyPasswordModal").modal("hide");
                        Notiflix.Notify.Success('操作成功');
                    } else {
                        Notiflix.Notify.Failure(result.msg);
                    }
                },
                error: function (e) {
                    Notiflix.Notify.Failure("修改密码失败，请稍后再试");
                }
            });
        }
    );
});

// 弹窗展示当前用户信息，用户信息保存在userInfo中
function showUserInfo() {
    $.ajax({
        type: "GET",
        url: "/user/getUserInfo",
        data: {},
        success: function (result) {
            if (result.status == '0') {
                var userInfo = result.data;
                // 展示用户信息
                $("#UserInfoUsernameShow").val(userInfo.userName);
                $("#UserInfoRealnameShow").val(userInfo.realName);
                $("#UserInfoSexShow").val(userInfo.sexCn);
                $("#UserInfoPhoneShow").val(userInfo.phone);
                $("#UserInfoCompanyShow").val(userInfo.company);
                $("#UserInfoAddressShow").val(userInfo.address);
                $("#UserInfoCategoryShow").val(userInfo.categoryCn);
                $("#UserInfoShowModal").modal("show");
            } else {
                Notiflix.Notify.Failure(result.msg);
            }
        },
        error: function (e) {
            Notiflix.Notify.Failure("获取用户信息失败，请稍后再试");
        }
    });
}

// 重置用户信息
function resetUserInfo() {
    $("#UserInfoUsernameShow").val('');
    $("#UserInfoRealnameShow").val('');
    $("#UserInfoSexShow").val('');
    $("#UserInfoPhoneShow").val('');
    $("#UserInfoCompanyShow").val('');
    $("#UserInfoAddressShow").val('');
    $("#UserInfoCategoryShow").val('');
}

// 弹出修改密码界面
function modifyPassword() {
    // 清空密码信息
    $("#ModifyPasswordPasswordOldShow").val();
    $("#ModifyPasswordPasswordNewShow").val();
    $("#ModifyPasswordPasswordConfirmShow").val();
    $("#ModifyPasswordModal").modal("show");
}