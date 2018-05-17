({
    doInit:function(component, event, helper) {
        helper.getRemoteBranches(component);
    },
    handleSaveContact : function(component, event, helper) {
        /*var allValid = component.find('branch').reduce(function (validFields, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            return validFields && inputCmp.get('v.validity').valid;
        }, true);*/
        component.find('branchName').showHelpMessageIfInvalid();
        if(true){
            //component.set("v.isVisible",true);
            var isSfdx = component.get("v.isSfdx");
            var sfdxFolderName = isSfdx?component.get("v.sfdxFolderName"):'';
            console.log(isSfdx);
            console.log(component.get("v.branchType"));
            console.log(component.get("v.displayName"));
            console.log(component.get("v.parentBranch"));
            console.log(component.get("v.reponame"));
            console.log(component.get('v.scmtype'));
            var action = component.get("c.CreateBranch");
            action.setParams({
                "Parent":component.get("v.parentBranch"),
                "Type":component.get("v.branchType"),
                "DisplayName":component.get("v.displayName"),
                "scmtype":component.get('v.scmtype'),
                "reponame":component.get("v.reponame"),
                "sfdxfoldername":sfdxFolderName
            });
            action.setCallback(this,function(res){
                var cmpEvent = component.getEvent("refreshBranches");
                cmpEvent.fire();
                //component.set("v.isVisible",false);
            });
            $A.enqueueAction(action);
        }
    },
    cancelModal:function(component, event, helper) {
        component.set("v.isModalVisible",false);
    }
})