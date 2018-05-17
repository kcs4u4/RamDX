({
    doInit : function(component, event, helper) {
        component.set("v.tempFetchChangesList",component.get("v.fetchChangesList"));
        component.set("v.isVisible",true);
        helper.getMetaData(component, event);
    },
    cancelModal : function(component, event, helper) {
        component.set("v.addMDModalVisible",false);
    },
    saveList : function(component, event, helper) {
        component.set("v.fetchChangesList",component.get("v.tempFetchChangesList"));
        component.set("v.addMDModalVisible",false);
    },
    getMDMembers : function(component, event, helper) {
        var $this = event.srcElement;
        var myCmp = component.find("spinner")[$($this).attr('data-index')];
		$A.util.addClass(myCmp, "slds-loading");
        var metadataType = $($this).find('.slds-truncate').text();
        var sforgname = component.get("v.sfOrgName");
        var action = component.get("c.getMetadataTypeMembers");
        var metadataList = component.get("v.metadataList");
        if(metadataType){
            action.setParams({
                "metadataType":metadataType,
                "sforgname":sforgname
            })
            action.setCallback(this,function(res){
                var state = res.getState();
                if(state=="SUCCESS"){
                    var response = JSON.parse(res.getReturnValue());
                    var xml = response.Resbody;
                    var xmlDoc = $.parseXML( xml );
                    var $xml = $( xmlDoc );
                    var $members = $xml.find("members");  
                    var list = [];
                    $members.each(function(){
                        var obj = {};
                        $.each(this.attributes, function() {
                            obj[this.name] = this.value;
                        });
                        obj['isChecked'] = false;
                        list.push(obj)
                    });
                    console.log(list);
                    if(list.length>0){
                       helper.getMdMembers(component,metadataList,metadataType,list); 
                    }
                    else{
                        alert('No metadata exists.')
                    }
                    $($this).parents('section').toggleClass("slds-is-open");
                    $A.util.removeClass(myCmp, "slds-loading");
                }
            });
            if(!$($this).parents('section').hasClass("slds-is-open")){
            	$A.enqueueAction(action);    
            }
            else{
               $($this).parents('section').toggleClass("slds-is-open");
               $A.util.removeClass(myCmp, "slds-loading");
            }
        }
    },
    captureMetadata : function(component, event, helper) {
        var comp = event.getSource();
        var metadataType = comp.get("v.name");
        //var metadata = comp.get("v.label"); 
        var isAdd = comp.get("v.checked");
        var metadatIndexes = comp.get("v.tabindex").split('-');
        var metadata = component.get("v.metadataList")[metadatIndexes[0]].members[metadatIndexes[1]];
        helper.captureMD(component,metadataType,metadata,isAdd);
    }
})