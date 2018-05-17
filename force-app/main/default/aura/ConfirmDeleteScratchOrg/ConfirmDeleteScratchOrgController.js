({
    cancel:function(component, event, helper) {
        component.set('v.isDelete',false);
    },
    deleteScracthOrg:function(component, event, helper) {
        var cmpEvent = component.getEvent("unRegister");
        cmpEvent.setParams({
            "flag" : component.find("confrm").get("v.checked")
        });
        cmpEvent.fire();
        component.set('v.isDelete',false);
    }
})