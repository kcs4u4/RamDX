({
	doInit:function(component, event, helper){
        helper.getAlmType(component);
    },
    getAlmProjects:function(component, event, helper){
        helper.getProjects(component);
    },
    getAlmSprints:function(component, event, helper){
        helper.getSprints(component);
    },
    getUserStories:function(component, event, helper){
        var almType = component.get("v.UserManagement.Almtype")!='Select';
        var almProject = component.get("v.UserManagement.AlmProject")!='Select';
        var plannedFor = component.get("v.UserManagement.PlannedFor")!='Select';
        if(almType && almProject && plannedFor){
            helper.getStories(component);
        }
        else{
         	alert("Please select mandatory fields!");   
        }
    },
    goToUserStoryMgmt : function(component, event, helper) {
        var id = event.target.id.split('-')[1];
        var stories = component.get("v.AlmUserStories");
        var story = stories[event.target.dataset.story];
        story['almname']=component.get('v.UserManagement.Almtype');
        story['sprintid']=helper.getId(component.get("v.AlmSprints"),component.get('v.UserManagement.PlannedFor'));
        component.set("v.story",story);
    }
})