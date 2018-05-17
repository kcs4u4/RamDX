({
    CheckVersionControlSystem : function(component, event, helper) {
        console.log(component.find('repository').get('v.value'));
        var repo = component.find('repository').get('v.value');
        helper.resetFlags(component,['isRepositoryURL','isbranch','isCheckBox']);
        if(repo=="SVN" || repo=="TFS"){
            helper.setFlags(component,['isRepositoryURL']);
        }
        else if(repo=="GIT"){
            helper.setFlags(component,['isRepositoryURL','isbranch','isCheckBox']);
        } 
    },
    checkValidation : function(component, event, helper) {
		helper.repositoryRegistration(component,'validateSCMCredentials');
    },
    save:function(component, event, helper) {
        helper.repositoryRegistration(component,'registerSCMRepository');
        component.set('v.accflag',false);
    },
    cancel:function(component, event, helper) {
        helper.hideModal(component);
    },
    showAccReg:function(component, event, helper) {
        component.set('v.accflag',true);
    }
    
})