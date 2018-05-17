({
    doInit : function(component, event, helper) {
		helper.getToBranchList(component, event);
    },
    checkLabelExist : function(component, event, helper) {
		helper.checkLabelExist(component, event);
    },
    copyValue : function(component, event, helper) {
        var comp = event.getSource();
        var labelName = comp.get("v.value");
        component.set("v.comment",labelName);
    },
    mergingBranch : function(component, event, helper) {
      component.set("v.errorCount",0);  
      var comp = component.find("mergeLabelName");
      var labelName = comp.get("v.value");
      var errorCount =  comp.get("v.errors").length; 
      component.set("v.errorCount",errorCount);
      if($A.util.isEmpty(labelName)){
            comp.set("v.errors", [{message: "Please Enter label."}]);
            errorCount++;
            component.set("v.errorCount",errorCount);
      }
        helper.validateData(component,component.find("toBranch"));
        helper.validateData(component,component.find("mergeType"));
        var singleRevision = component.find("singleRevision");   
        if(!$A.util.isUndefined(singleRevision)){
            helper.validateData(component,singleRevision);  
        }
        helper.submitMergeRequest(component, event);
    },
    getMergeTypeDetails : function(component, event, helper) {
        var comp = event.getSource();
        var type = comp.get("v.value");
        component.set("v.mergeTypeList",[]);
        if(type=='2'){
            helper.getSCMRevisions(component, event);
        }
    }
})