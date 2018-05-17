({
    doInit:function(component, event, helper) {
    },
    hideModal:function(component, event, helper) {
        helper.setEvent(component);
    },
    generatePassword:function(component, event, helper) {
        var r = confirm(" Do you want to Send credentials to register Email Id");
        if (r) {
            if($("#Emailidlist").val()){
                console.log($("#Emailidlist").val());
                var EmailIds = $("#Emailidlist").val();
                console.log(EmailIds)
            }
            else{
                var EmailId = "";
            }
            var action = component.get('c.sendOrgCredentials');
            console.log('***********');
            console.log(component.get('v.soid'))
            console.log(component.get('v.soname'))
            action.setParams({
               
                "sousername":component.get('v.soname'),
                "emails":EmailIds
            });
            console.log(EmailIds);
            action.setCallback(this,function(res){
                var state = res.getState();
                if(state=="SUCCESS"){
                    component.set('v.isNew',false);
                }
            })
            
            $A.enqueueAction(action);
        }
    }
})