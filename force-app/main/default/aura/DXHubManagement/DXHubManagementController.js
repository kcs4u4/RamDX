({
    scriptLoad:function(component, event, helper) {
        helper.getHubList(component);
    },
    doInit:function(component, event, helper) {
        window.addEventListener('unload', function(event) {
            helper.leftPage(component);
        });
        var url_string = window.location.href;
        var url = new URL(url_string);
        var c = url.searchParams.get("0.code");
        if(c){
            component.set('v.isVisible',true);
            window.setTimeout($A.getCallback(function(){
                window.location.href = url_string.split('?')[0];
            }),10000);
        }
    },
    goToScratchOrgList : function(component, event, helper) {
        var id = event.target.id.split('-')[1];
        var obj =   {
                "hubid":event.target.getAttribute("data-recId"),
                "hubusername":event.target.getAttribute("data-username"),
                "hubalias":event.target.getAttribute("data-alias")
            }
        component.set('v.curDevHub',obj);
    },
    showModal: function(component, event, helper) {
        component.set('v.isModalVisible',true);
    },
    unRegister: function(component, event, helper) {
        component.set('v.isVisible',true);
        var hubname = event.target.id.split('-')[1];;
        var r = confirm(" Do you want to un-registerd Dev Hub");
        if (r == true) {
            var action = component.get('c.unregisterDevHub');
            action.setParams({
                "hubname":hubname
            });
            action.setCallback(this,function(res){
                var state = res.getState();
                var resp = JSON.parse(res.getReturnValue());
                var resObj = helper.getResponseDetails(resp);
                if(state=="SUCCESS"){
                    //helper.showToast(resObj.msg,resObj.code);
                    component.set('v.isVisible',false);
                    helper.getHubList(component);
                }
                else{
                    //helper.showToast(resObj.msg,resObj.code);
                }
                component.set('v.isVisible',false);
            })
            $A.enqueueAction(action);        
        }
    }
})