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
                //obj['filename'] = $("#"+id).attr('data-filename');
                obj['fullname'] = $("#"+id).attr('name');
                //obj['manageablestate'] = $("#"+id).attr('data-manageablestate');
                //obj['modifieddate'] = $("#"+id).attr('data-modifieddate');
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
        component.set("v.isVisible",true);
        var metadataMembers = [];
        var metadataMap = {};
        $(".metadata:checked").each(function(){
            metadataMap[$(this).attr('name')]=[];
        });
        $(".sub-metadata:checked").each(function(){
            var metadataName = $(this).attr('data-parent-name');
            var parid = $(this).attr("data-parentid");
            console.log($("#"+parid).is(":checked"));
            if (true) {//!$("#"+parid).is(":checked")
                if(!metadataMap.hasOwnProperty(metadataName)){
                    metadataMap[metadataName]=[];
                }
                metadataMap[metadataName].push($(this).attr('name'));
            }
        })
        for(var key in metadataMap){
            var obj = {};
            obj['name'] = key;
            obj['members'] = metadataMap[key].length>0?metadataMap[key].toString():metadataMap[key].toString();
            metadataMembers.push(obj);
        }
        console.log('-------------------metadataMembers1---------------------');
        console.log(metadataMembers);
        component.set("v.metadataMembers",metadataMembers);
        var cmpEvent = component.getEvent("commitConfirm");
        cmpEvent.setParams({
            "flag":component.get("v.isCommitAndConfirm")
        })
        cmpEvent.fire();
        component.set("v.isVisible",false);
    },
    getDiffDetails: function(component, event, helper) {
        component.set("v.isVisible",true);
        var action = component.get("c.metaDataFileDiff");
        var dataObj = {
            "srcOrgname":component.get("v.metaDataMap.srcOrgname"),
            "destOrgname":component.get("v.metaDataMap.destOrgname"),
            "labelName":component.get("v.metaDataMap.labelName"),
            "fullname":event.target.getAttribute("data-fullname"),
            "dpmsource":component.get("v.metaDataMap.dpmsource"),
            "type":event.target.getAttribute("data-type")
        };
        console.log(dataObj);
        action.setParams(dataObj);
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
            component.set("v.isVisible",false);
            component.set("v.isModalVisible",true);
        });
        $A.enqueueAction(action);
    },
    toggleExpandSelection:function(component, event, helper) {
        $(event.srcElement).parents(".slds-section").toggleClass("slds-is-open");
    }
})