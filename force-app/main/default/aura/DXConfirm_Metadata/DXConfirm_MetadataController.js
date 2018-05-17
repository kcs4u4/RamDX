({
    confirmData:function(component, event, helper) {
        var bol = !component.get("v.confirm");
        component.set("v.confirm",bol);
        var metadataMembers = component.get("v.metadataMembers");
        console.log('--------confirm----------------');
        console.log(metadataMembers);
    },
    exeDeploy:function(component, event, helper) {
        var cmpEvent = component.getEvent("cmpEvent");
        cmpEvent.setParams({
            "flag":component.get("v.confirm")
        })
        cmpEvent.fire();
        component.set("v.isCommitAndConfirm",false)
    }
})