({
    doInit:function(component, event, helper) {
        console.log('-------------------------------story--------------------');
        console.log(component.get('v.story'));
      
        component.set("v.isVisible",true);
        var action = component.get('c.getDxFeatures');
        action.setCallback(this,function(res){
            var features = res.getReturnValue();
            component.set("v.dxFeatures",features);
        });
        $A.enqueueAction(action);
        action = component.get('c.getDxOrgPreference');
        action.setCallback(this,function(res){
            var preferences = res.getReturnValue();
            component.set("v.dxOrgPreferences",preferences);
            component.set("v.isVisible",false);
        });
        $A.enqueueAction(action);   
        helper.getDevHubList(component);
    },
    hideModal:function(component, event, helper) {
        helper.setEvent(component);
    },
    addScrOrg:function(component, event, helper) {
        var type = component.get("v.type");
        if(type=='new'){
        	component.find("cso").create();       
        }
        else{
            helper.assignScratchOrg(component);
        }
    },
    getDevHubDetails:function(component, event, helper) {
        var comp = event.getSource();
        var val = comp.get("v.value");
        var type = component.get("v.type");
        console.log(val);
        if(val.length>0){
            var tempArr = val.split('-');
            var hubName = tempArr[0];
            var index = tempArr[1];
            var devHubList = component.get('v.DevHubList');
        	console.log(devHubList[index]);
        	component.set("v.DevHub",index>=0?devHubList[index]:{});
            if(type=='assign'){
                helper.getScrOrgList(component);
            }
        }
    },
    createOrAssignScratchOrg:function(component, event, helper) {
        var arrComp = component.find("btn");
        console.log(arrComp.length);
        for(var i=0;i<arrComp.length;i++){
            $A.util.removeClass(arrComp[i], "slds-button--brand");
        }
        var comp = event.getSource();
        var branchType = comp.get('v.name')
        $A.util.addClass(comp, "slds-button--brand");
        console.log(branchType);
        component.set("v.type",branchType);
        component.find("dxDevHub").set("v.value","");
    }
})