({
    doInit : function(component, event, helper) {
        var action = component.get("c.setData");
        var obj = {'name':'Ram'};
        action.setParams({
            "strlist":new Date()
        });
        action.setCallback(this,function(res){
            console.log(res.getState());
        });
        $A.enqueueAction(action);
        action= component.get("c.getData");
        action.setCallback(this,function(res){
            var obj = res.getReturnValue();
            console.log(res.getReturnValue());
            console.log(obj.name);
        });
        $A.enqueueAction(action);
    },
    goTo: function(component, event, helper) {
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "/apex/test",
            "isredirect":true
        });
        urlEvent.fire();
    }
})