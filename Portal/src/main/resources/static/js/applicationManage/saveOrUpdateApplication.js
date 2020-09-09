$(function(){
    layui.use('form', function(){
        var form = layui.form;
        //监听提交
        form.on('submit(save)', function(data){
            if(data.field.id==null||data.field.id==''){
                Common.ajax('applicationManage/application',$("#form1").serialize(),true,'POST',applicationSaveSuccess);
            }else{
                Common.ajax('applicationManage/application',$("#form1").serialize(),true,'PUT',applicationSaveSuccess);
            }
            return false;
        });
    });
});
function applicationSaveSuccess(data){
    parent.applicationSaveOrUpdateSuccess();
}