({
    doInit : function(component, event, helper) {
        var arr = component.get("v.branchList");
        var list = [];
        for(var i=0;i<arr.length;i++){
            list.push(arr[i].name);
        }
        component.set("v.branchNamesList",list);
        helper.getRemoteBranches(component);
    },
    cancelModal : function(component, event, helper) {
        component.set("v.registerBranch",false);
    },
    regBranch:function(component, event, helper) {
        var action = component.get("c.registerBranch");
        action.setParams({
            "reponame":component.get("v.reponame"),
            "scmtype":component.get("v.scmtype"),
            "url":component.get("v.repourl"),
            "branches":helper.convertStringArray(component.get("v.newRemoteBranches"))
        });
        action.setCallback(this,function(res){
            var state = res.getState();
            if(state=="SUCCESS"){
                helper.getRemoteBranches(component);
                var cmpEvent = component.getEvent("refreshBranches");
                cmpEvent.fire();
                component.set("v.registerBranch",false);                
            }
        })
        $A.enqueueAction(action);
    },
    checkDate : function(component, event, helper) {
        var today = new Date();
        var comp = event.getSource();
        var day = comp.get('v.value');
        // Returns false, since d is before day
        if($A.localizationService.isAfter(day, today)){
            comp.set("v.errors", [{message: "Please enter valid date."}]);
        }
        else{
            comp.set("v.errors", [{message: ""}]);
        }
    },
    checkBranchDetails : function(component, event, helper) {
        var comp = event.getSource();
        var chkInd = comp.get('v.class').split('-')[1];
        var dateComp = component.find('dateField')[chkInd];
        if(comp.get('v.checked')){
            dateComp.set("v.errors", [{message: "Please enter valid date."}]);
        }
        else{
            dateComp.set("v.errors", [{message: ""}]);
        }
    }
})