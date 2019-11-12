$(function() {
    $("#TopBarTitle").text("查看用户关系");
    // 手机端处理
    if (!IsPC()) {
        $("#ShowSearchInput").removeClass("offset-2").removeClass("col-6").addClass("offset-1").addClass("col-5");
        $("#ShowSearchBtn").removeClass("btn-xs").removeClass("ml-1").addClass("col-2");
        $("#ShowResetBtn").removeClass("btn-xs").removeClass("ml-1").addClass("col-2");
        $("#ShowSearchBtn").css("padding","9px 5px");
        $("#ShowResetBtn").css("padding","9px 5px");
    }
    // 获取用户关系图数据
    $.ajax({
        type: "GET",
        url: "/userrln/findByParUserId",
        data: {},
        success: function (result) {
            if (result.status == '0') {
                var datasource = result.data.datasource;
                refreshRlnDiagram(datasource);
            } else {
                Notiflix.Notify.Failure(result.msg);
            }
        },
        error: function (e) {
            Notiflix.Notify.Failure("获取用户关系失败");
        }
    });

    $('#key-word').on('keyup', function(event) {
        if (event.which === 13) {
            filterNodes(this.value);
        } else if (event.which === 8 && this.value.length === 0) {
            clearFilterResult();
        }
    });

});

function filterNodes(keyWord) {
    if(!keyWord.length) {
        Notiflix.Notify.Warning("请输入搜索内容");
        return;
    } else {
        var $chart = $('.orgchart');
        // disalbe the expand/collapse feture
        $chart.addClass('noncollapsable');
        // distinguish the matched nodes and the unmatched nodes according to the given key word
        $chart.find('.node').filter(function(index, node) {
            keyWord = keyWord.toLowerCase();
            return $(node).text().toLowerCase().indexOf(keyWord) > -1;
        }).addClass('matched')
            .closest('table').parents('table').find('tr:first').find('.node').addClass('retained');
        // hide the unmatched nodes
        $chart.find('.matched,.retained').each(function(index, node) {
            $(node).removeClass('slide-up')
                .closest('.nodes').removeClass('hidden')
                .siblings('.lines').removeClass('hidden');
            var $unmatched = $(node).closest('table').parent().siblings().find('.node:first:not(.matched,.retained)')
                .closest('table').parent().addClass('hidden');
            $unmatched.parent().prev().children().slice(1, $unmatched.length * 2 + 1).addClass('hidden');
        });
        // hide the redundant descendant nodes of the matched nodes
        $chart.find('.matched').each(function(index, node) {
            if (!$(node).closest('tr').siblings(':last').find('.matched').length) {
                $(node).closest('tr').siblings().addClass('hidden');
            }
        });
    }
}

function clearFilterResult() {
    $('.orgchart').removeClass('noncollapsable')
        .find('.node').removeClass('matched retained')
        .end().find('.hidden').removeClass('hidden')
        .end().find('.slide-up, .slide-left, .slide-right').removeClass('slide-up slide-right slide-left');
    $('#key-word').val("");
}

function refreshRlnDiagram(datasource) {
    var oc = $('#chart-container').orgchart({
        'data' : datasource,
        'nodeContent': 'title',
        'pan': true,
        'zoom': true
    });

    $('.orgchart').find('tr').removeClass('hidden')
        .find('td').removeClass('hidden')
        .find('.node .edge').addClass('hidden');
    // oc.$chartContainer.on('touchmove', function(event) {
    //     event.preventDefault();
    // });

    oc.$chartContainer.on('click', '.node', function() {
        var $this = $(this);
        // 点击时，展示用户详情
        var userId = $this.attr('id');
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
    });
}