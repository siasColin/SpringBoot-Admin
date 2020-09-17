var syncRecordtable;
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
        syncRecordtable = table.render({
            id: 'syncRecordtable'
            ,elem: '#syncRecordlist'
            ,height: "full-20"
            ,limit:15
            ,method:'GET'
            ,url: Common.ctxPath+'syncRecord/syncRecordListData' //数据接口
            ,parseData :parseDataFun
            ,title: '基础数据同步记录'
            ,page: true //开启分页
            ,limits: [5,10,15,20,30,50,70,80,90]
            ,toolbar: '#info_toolbar' //开启工具栏，此处显示默认图标，可以自定义模板，详见文档
            ,defaultToolbar: ['filter', 'print']
            ,totalRow: false //开启合计行
            ,cols: [[ //表头
                {field: 'syncStatus', title: '同步状态',templet: function(d){
                    if(d.syncStatus == 0){
                        return "<span style='color: greenyellow'>待同步</span>";
                    }else if(d.syncStatus == 1){
                        return "<span style='color: green'>已同步</span>";
                    }else if(d.syncStatus == 2){
                        return "<span style='color: red'>同步失败</span>";
                    }else if(d.syncStatus == 3){
                        return "<span style='color: red'>推送失败</span>";
                    }else if(d.syncStatus == -1){
                        return "<span style='color: #1E9FFF'>已忽略</span>";
                    }
                }}
                ,{field: 'createTime', title: '数据产生时间',templet:function(d){
                    return '<div>'+layui.util.toDateString(d.createTime, "yyyy-MM-dd HH:mm:ss")+'</div>';
                }}
                ,{field: 'syncTime', title: '数据同步时间',templet:function(d){
                        return '<div>'+layui.util.toDateString(d.syncTime, "yyyy-MM-dd HH:mm:ss")+'</div>';
                }}
                ,{fixed: 'right',title: '操作',  align:'center', toolbar: '#barSyncRecordlist',width:280}
            ]]
        });

        //监听头工具栏事件
        table.on('toolbar(syncRecordtable)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id)
                ,data = checkStatus.data; //获取选中的数据
            switch(obj.event){
                case 'allSync':
                    Common.ajax('syncRecord/syncDataAll',null,true,'POST',search);
                    break;
            };
        });

        //监听行工具事件
        table.on('tool(syncRecordtable)', function(obj){
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'details'){
                layer.open({
                    title:"数据信息",
                    type: 2,
                    area: ['70%','80%'],
                    content: Common.ctxPath+'syncRecord/syncData/'+data.dataId
                });
            } else if(layEvent === 'dosync'){
                Common.ajax('syncRecord/syncData/'+data.dataId,null,true,'POST',search);
            } else if(layEvent === 'ignore'){
                Common.ajax('syncRecord/syncDataItem/'+data.id,null,true,'PUT',search);
            }
        });
    });
});
function search(){
    syncRecordtable.reload({
        page: {
            curr: 1 //重新从第 1 页开始
        }
    });
}