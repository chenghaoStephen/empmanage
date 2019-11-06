$(function() {
    $("#TopBarTitle").text("编辑用户关系");
    // 获取用户关系图数据
    $.ajax({
        type: "GET",
        url: "/userrln/findByParUserId",
        data: {},
        success: function (result) {
            if (result.status == '0') {
                var datasource = result.data;
                refreshRlnDiagram(datasource);
            } else {
                Notiflix.Notify.Failure(result.msg);
            }
        },
        error: function (e) {
            Notiflix.Notify.Failure("获取用户关系失败");
        }
    });

});

function refreshRlnDiagram(datasource) {

    var getId = function() {
        return (new Date().getTime()) * 1000 + Math.floor(Math.random() * 1001);
    };

    var oc = $('#chart-container').orgchart({
        'data' : datasource,
        'chartClass': 'edit-state',
        'nodeContent': 'title',
        'pan': true,
        'zoom': true,
        'parentNodeSymbol': 'fa-th-large',
        'createNode': function($node, data) {
            $node[0].id = getId();
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

// 添加节点
function addnode() {
    var oc = $('#chart-container').orgchart();
    var $chartContainer = $('#chart-container');
    var $node = $('#selected-node').data('node');
    if (!$node) {
        Notiflix.Notify.Warning("请选择一个节点");
        return;
    }
    // 弹出节点选择弹框


    // // 添加节点后，刷新界面
    // $.ajax({
    //     type: "GET",
    //     url: "/userrln/findByParUserId",
    //     data: {},
    //     success: function (result) {
    //         if (result.status == '0') {
    //             var datasource = result.data;
    //             refreshRlnDiagram(datasource);
    //         } else {
    //             Notiflix.Notify.Failure(result.msg);
    //         }
    //     },
    //     error: function (e) {
    //         Notiflix.Notify.Failure("添加失败，请稍后再试");
    //     }
    // });
}

// 删除节点
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
    oc.removeNodes($node);
    $('#selected-node').val('').data('node', null);
}