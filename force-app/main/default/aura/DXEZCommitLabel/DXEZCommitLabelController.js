({
    doInit : function(component, event, helper) {
        var label = component.get("v.label");
        console.log(component.get("v.fetchChangesMap.reponame"));
        var customLabelsParams = {
            "reponame":component.get("v.fetchChangesMap.reponame"),
            "branch":component.get("v.fetchChangesMap.branch")
        };
        if(label=='Custom Label'){
            helper.getData(component,'CommitLabels',customLabelsParams,'customLabels','label');
        }
        else if(label=='Release Label'){
            helper.getData(component,'getReleaseLabels',customLabelsParams,'releaseNames');
        }   
    },
    addCustomLabel : function(component, event, helper) {
        component.set('v.isModal',true);
    },
    showModal: function(component, event, helper) {
        component.set('v.isLabel',true);
    },
    getAlmProjects: function(component, event, helper) {
        var almType  = component.get("v.almType");
        if(almType!='Select ALM Type' && almType!=null){
            var paramsObj = {
                "almType":almType
            };
            helper.getData(component,'pullAlmProjects',paramsObj,'almProjects','project');
        }
        else{
            component.set('v.almProjects',[]);
            component.set('v.sprintsList',[]);
            component.set('v.workItems',[]);
        }
    },
    projectChange : function(component, event, helper) {
        var projKey  = component.get('v.projKey');
        var almType = component.get("v.almType");
        if(projKey!='Select Project' && almType!=null){
            var paramsObj = {
                "almType":almType,
                "projKey":projKey
            };
            helper.getData(component,'getSprints',paramsObj,'sprintsList','PlannedFor');
        }
        else{
            component.set('v.sprintsList',[]);
            component.set('v.workItems',[]);
        }
    }, 
    getWorkItems:function(component, event, helper) {
        var projKey  = component.get('v.projKey');
        var almType = component.get("v.almType");
        var sprint = component.get("v.sprint");
        var sprintDetails = sprint.split('$');
        var sprintName = sprintDetails[0];
        var sprintId = sprintDetails[1];
        if(sprint!='Select'){
            var paramsObj = {
                "almType":almType,
                "projKey":projKey,
                "sprintName":sprintName,
                "sprintId":sprintId
            };
            helper.getData(component,'pullAllWorkItems',paramsObj,'workItems','workitem');
        }
        else{
            component.set('v.workItems',[]);
            component.set("v.statusList",[]);
        }
    },
    getSatusList:function(component, event, helper) {
        var workItem = component.get("v.workItem");
        if(workItem!='Select' && workItem!=null){
            var statusList = ['Done','In Progress','To Do'];
            component.set("v.statusList",statusList);
        }
        else{
            component.set("v.statusList",[]);
        }
    },
    addLabel:function(component, event, helper){
        component.set('v.addLabelModalVisible',false);
    },
    cancel:function(component, event, helper){
        component.set('v.addLabelModalVisible',false);
    }
})