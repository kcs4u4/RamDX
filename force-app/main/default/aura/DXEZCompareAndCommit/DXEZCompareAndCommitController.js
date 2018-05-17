({
    doInit: function(component, event, helper) {
        console.log('list');
       
    },
    storeDetails : function(component, event, helper) {
        var metadataMap = helper.getDataObj(component.get("v.compareMetadataMap"));
        console.log('-------start--metadataMap--------------')
        console.log(metadataMap);
        var cls = event.target.className;
        var id = event.target.id;
        var metaParName = id.split('-')[0];
        var isChecked = event.target.checked;
        if(!metadataMap.hasOwnProperty(metaParName)){
            metadataMap[metaParName] =[];
        }
        if(cls=='sub-metadata'){
            var contentName = event.target.name;
            if(isChecked){
                var obj={};
                obj['filename'] = $("#"+id).attr('data-filename');
                obj['fullname'] = $("#"+id).attr('name');
                obj['manageablestate'] = $("#"+id).attr('data-manageablestate');
                obj['modifieddate'] = $("#"+id).attr('data-modifieddate');
                metadataMap[metaParName].push(obj);              
            }
            else{
                var arr = $.grep(metadataMap[metaParName], function(value) {
                    return value.fullname != contentName;
                });
                metadataMap[metaParName] = arr;
                if(arr.length==0){
                    delete metadataMap[metaParName];
                }
            }
        }
        console.log(metadataMap);
        component.set("v.compareMetadataMap",metadataMap);
    },
  
    confirmCommit : function(component, event, helper) {
        var metadataMap = component.get("v.compareMetadataMap");
        component.set("v.metadataMap",metadataMap);
        var cmpEvent = component.getEvent("commitConfirm");
        cmpEvent.setParams({
            "flag":component.get("v.isCommitAndConfirm")
        })
        cmpEvent.fire();
    },
    getDiffDetails: function(component, event, helper) {
        var action = component.get("c.ContentOfFilesDiff");
        console.log(event.target.getAttribute("data-fullname") || event.target.getAttribute("data-filename").split("/").slice(-1)[0]);
        action.setParams({
            "sforgname":component.get("v.fetchChangesMap.sforgname"),
            "type":event.target.getAttribute("data-type"),
            "fullName":event.target.getAttribute("data-fullname") || event.target.getAttribute("data-filename").split("/").slice(-1)[0]
        });
        action.setCallback(this,function(res){
            var response = JSON.parse(res.getReturnValue());
            console.log(response.Resbody);
            var xml = response.Resbody;
            var xmlDoc = $.parseXML( xml );
            var $xml = $( xmlDoc );
            var $keys = $xml.find('line');
            var list = [];
            $keys.each(function() {
                var ind = $(this).attr('lnum') || $(this).attr('rnum');
                var obj = list[ind] || {};
                obj[$(this).attr('side')+'Content'] = $(this).html().slice(9,-3);
                obj[$(this).attr('side')+'Type'] = $(this).attr('type');
                list[ind] = obj;
            });
            console.log(list);
            component.set("v.diffChanges",list.slice(1));
            component.set("v.isModalVisible",true);
        });
        $A.enqueueAction(action);
    },
    toggleExpandSelection:function(component, event, helper) {
        $(event.srcElement).parents(".slds-section").toggleClass("slds-is-open");
    }
})