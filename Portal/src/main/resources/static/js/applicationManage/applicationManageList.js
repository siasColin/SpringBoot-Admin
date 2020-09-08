var applicationtable;
//定义处理数据结构转化的适配器
var parseDataFun = function (res){
    return {
        "code": res.returnCode
        , "message": res.returnMessage
        , "data": res.data
        , "count": res.total
    };
};


/**
 * 保存或者更新成功后回调
 */
function applicationSaveOrUpdateSuccess(){
    layui.use('layer', function() {
        var layer = layui.layer;
        layer.closeAll('iframe'); //关闭弹框
    });
    search();
}
$(function(){
    layui.use([ 'layer', 'table','form'], function(){
        var layer = layui.layer //弹层
            ,table = layui.table //表格
            ,form = layui.form //表格

        //执行一个 table 实例
        applicationtable = table.render({
            id: 'applicationtable'
            ,elem: '#applicationlist'
            ,height: "full-135"
            ,limit:10
            ,method:'GET'
            ,url: Common.ctxPath+'applicationManage/applicationList' //数据接口
            ,parseData :parseDataFun
            ,title: '应用列表'
            ,page: true //开启分页
            ,toolbar: '#info_toolbar' //开启工具栏，此处显示默认图标，可以自定义模板，详见文档
            ,defaultToolbar: ['filter', 'print']
            ,totalRow: false //开启合计行
            ,cols: [[ //表头
                {field: 'applicationNameZh', title: '应用名称'}
                ,{field: 'applicationName', title: '应用编码'}
                ,{field: 'createUser', title: '创建人'}
                ,{field: 'createTime', title: '创建时间',templet:function(d){
                    return '<div>'+layui.util.toDateString(d.createTime, "yyyy-MM-dd HH:mm:ss")+'</div>';
                }}
                ,{fixed: 'right',  align:'center', toolbar: '#barApplicationlist',width:130}
            ]]
        });


        //监听头工具栏事件
        table.on('toolbar(applicationtable)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id)
                ,data = checkStatus.data; //获取选中的数据
            switch(obj.event){
                case 'add':
                    layer.open({
                        title:"应用信息",
                        type: 2,
                        area: ['30%','35%'],
                        btn: ['保存', '取消'],
                        content: Common.ctxPath+'applicationManage/application',
                        yes: function(index,layero){
                            // 获取iframe层的body
                            var body = layer.getChildFrame('body', index);
                            // 找到隐藏的提交按钮模拟点击提交
                            body.find('#permissionSubmit').click();
                        }
                    });
                    break;
                case 'delete':
                    if(data.length === 0){
                        Common.info("请至少选择一行");
                    } else {
                        var ids = "";
                        for(var i=0;i<data.length;i++){
                            if(i == data.length - 1){
                                ids+=data[i].id
                            }else{
                                ids+=data[i].id+',';
                            }
                        }
                        var params = {};
                        params.ids = ids;
                        Common.openConfirm("确定删除吗?",function () {
                            Common.ajax('userManage/user',params,true,'DELETE',search);
                        });
                    }
                    break;
            };
        });

        //监听行工具事件
        table.on('tool(applicationtable)', function(obj){
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'detail'){
            } else if(layEvent === 'del'){
                var params = {};
                params.ids = data.id;
                Common.openConfirm("确定删除吗?",function () {
                    Common.ajax('userManage/user',params,true,'DELETE',search);
                })
            } else if(layEvent === 'edit'){
                layer.open({
                    title:"应用信息",
                    type: 2,
                    area: ['30%','35%'],
                    btn: ['修改', '取消'],
                    content: Common.ctxPath+'applicationManage/application/'+data.id,
                    yes: function(index,layero){
                        // 获取iframe层的body
                        var body = layer.getChildFrame('body', index);
                        // 找到隐藏的提交按钮模拟点击提交
                        body.find('#permissionSubmit').click();

                    }
                });
            }
        });
        $("#chongzhi").click(function () {
            layui.use(['form'], function(){
                var form = layui.form;
                $("#applicationNameZh").val("");
                $("#applicationName").val("");
                form.render();
            });
        });
    });
});
function search(){
    var applicationNameZh = $('#applicationNameZh');
    var applicationName = $('#applicationName');
    applicationtable.reload({
        page: {
            curr: 1 //重新从第 1 页开始
        }
        ,where: {
            applicationNameZh: applicationNameZh.val(),
            applicationName: applicationName.val()

        }
    });
}