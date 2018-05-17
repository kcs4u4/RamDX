({
    doInit : function(component, event, helper) {
        $("[role='navigation']").hide();
        $('[data-aljs="icon-group"]').iconGroup();
        var vcsList         = component.get("v.repositoryList");
        var accesskeyList   = component.get("v.accesskeyList");
        var repoDetailsList = component.get("v.repositoryDetailsList");
        if(vcsList.length==0)    	     helper.getVersionContrlList(component);
        if(accesskeyList.length==0)      helper.getDetails(component,'AllCredentials','accesskeyList','accesskey');
        if(repoDetailsList.length==0)    helper.getDetails(component,'UserRepositories','repositoryDetailsList','repository');
    },
    showModal: function(component, event, helper) {
        component.set('v.isModalVisible',true);
    },
    showRepoList: function(component, event, helper) {
        component.set('v.isModalVisible',false);
        helper.getVersionContrlList(component);
    },
    handleComponentEvent: function(component, event, helper) {
        helper.getDetails(component,'AllCredentials','accesskeyList','accesskey');
    },
    getBranchList:function(component, event, helper) {
        component.set("v.isVisible",true);
        var action = component.get('c.SCMRepoDetails');
        action.setParams({
            "reponame":event.target.name
        });
        component.set("v.repoid",event.target.id);
        component.set("v.reponame",event.target.name);
        component.set("v.repourl",event.target.dataset.repourl);
        action.setCallback(this,function(res){
            var state = res.getState();
            if(state == 'SUCCESS'){
                var response = JSON.parse(res.getReturnValue())
                var xml = response.Resbody;
                var xmlDoc = $.parseXML( xml );
                var $xml = $( xmlDoc );
                var $keys = $xml.find('branch');
                var list = [];
                $keys.each(function() {
                    var obj = {};
                    $.each(this.attributes, function() {
                        if(this.specified) {
                            obj[this.name] = this.value;
                        }
                    });
                    list.push(obj)
                });
                console.log(list);
                component.set("v.branchList",list);
                component.set("v.isBranchDetailsVisible",true);
                component.set("v.isVisible",false);
            }
        });
        $A.enqueueAction(action);
    },
    backToRepoList:function(component, event, helper) {
        component.set("v.isBranchDetailsVisible",false);
    },
    createBranch:function(component, event, helper) {
        component.set("v.createBranch",true);
    },
    registerBranch:function(component, event, helper) {
        component.set("v.registerBranch",true);
    }
})