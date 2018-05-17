({
    doInit : function(component, event, helper){
        var accKeyList = component.get("v.accesskeyList");
        if(accKeyList.length==0){
            helper.getAllCredentials(component);
        }
    },
    cancel : function(component, event, helper){
        component.set("v.flag",false);
    },
    save : function(component, event, helper) {
        component.set("v.errorCount",0);
        helper.checkInput(component,'username',"Please enter username.",'email');
        helper.checkInput(component,'password',"Please enter password.");
        helper.checkInput(component,'accesskey',"Please enter Credential Name.");
        helper.checkInputSelect(component,'scope',"Please select scope.");
        helper.checkInputSelect(component,'type',"Please select type.");
        var val = helper.checkCount(component);
        if(val==0){
            component.set('v.isSpinnerVisible',true);
            console.log(component.get('v.dataObj'));
            var dataObj = helper.getDataObj(component.get('v.dataObj'));
            console.log(dataObj);
            var action = component.get('c.AccessType');
            action.setParams(dataObj);
            action.setCallback(this,function(res){
                component.set('v.isSpinnerVisible',false);
                console.log('AccessType');
                var state = res.getState();
                var response = JSON.parse(res.getReturnValue());
                console.log('state-----'+state);
                console.log(response);
                helper.showToast(response);
                if(state=="SUCCESS" && response.statusCode==200){
                    helper.clearDataObj(component,dataObj);
                    helper.getAllCredentials(component);
                    var cmpEvent = component.getEvent("cmpEvent");
                    cmpEvent.setParams({
                        "flag":component.set("v.flag")
                    })
                    cmpEvent.fire();
                    component.set("v.flag",false);
                     
                }
            });
            $A.enqueueAction(action);
        }
    }
})