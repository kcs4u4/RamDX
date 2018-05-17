({
    doInit : function(component, event, helper) {
       
    },
	unRegister : function(component, event, helper) {
        component.set("v.isVisible",true);
        var action = component.get("c.deleteRepoBranch");
        console.log(event.target.dataset.reponame);
        action.setParams({
            "reponame":event.target.dataset.reponame,
            "branchname":event.target.dataset.branchname,
            "scmtype":event.target.dataset.scmtype
        });
        action.setCallback(this,function(res){
            console.log(res.getState());
            var state = res.getState();
            component.set("v.isVisible",false);
            if(state=='SUCCESS'){
                helper.getBranchList(component);
            }
        });
        $A.enqueueAction(action);
	},
    showModal: function(component, event, helper) {
        component.set('v.isModalVisible',true);
    },
    Convert : function(component, event, helper) {
        component.set("v.isVisible",true);
        var action = component.get("c."+event.target.dataset.method);
        console.log(event.target.dataset.reponame);
        action.setParams({
            "reponame":event.target.dataset.reponame,
            "branchname":event.target.dataset.branchname,
            "scmtype":event.target.dataset.scmtype,
             "repoid":event.target.dataset.repoid,
            "foldername":'force-app'
        });
        action.setCallback(this,function(res){
            console.log(res.getState());
            var state = res.getState();
            component.set("v.isVisible",false);
            if(state=='SUCCESS'){
                helper.getBranchList(component);
            }
        });
       
        $A.enqueueAction(action);
	},
    refreshBranches: function(component, event, helper) {
        helper.getBranchList(component);
        component.set("v.createBranch",false);
    }
    
})