({
    checkToggle : function(component, event, helper) {
        helper.eventattacher();
    },
    getDataMemebrs : function(component, event, helper) {
        
        var action = component.get("c.MembersForMetadataType");
        var metadataList = component.get("v.metadataList");
        var Metadatatype = event.target.getAttribute("data-label");
        var index = event.target.getAttribute("data-index");
        console.log('------------index------------'+index);
        console.log('------------Metadatatype------------'+Metadatatype);
        var spinner = component.find("spinner")[index];
        $A.util.removeClass(spinner, "slds-hide");
        var obj = metadataList[index];
        console.log(typeof obj);
        console.log(obj);
        if(metadataList[index]['members'].length==0){
            action.setParams({
                "Metadatatype":Metadatatype,
                "labelName":component.get("v.metaDataMap.labelName"),
                "dpmsource":component.get("v.metaDataMap.dpmsource"),
                "srcOrgname":component.get("v.metaDataMap.srcOrgname")
            })
            console.log('----------Metadatatype---------'+Metadatatype);
            console.log('----------labelName---------'+component.get("v.metaDataMap.labelName"));
            console.log('----------dpmsource---------'+component.get("v.metaDataMap.dpmsource"));
            //  console.log('----------srcOrgId---------'+component.get("v.metaDataMap.srcOrgId"));
            action.setCallback(this,function(res){
                var state = res.getState();
                var response = JSON.parse(res.getReturnValue());
                console.log(response);
                if(state=="SUCCESS" && response.statusCode==200)
                {
                    var xml = response.Resbody;
                    helper.getSubMebers(component,Metadatatype,xml,index);
                }
                $A.util.addClass(spinner, "slds-hide");
            });
            $A.enqueueAction(action);  
        }
        else{
            metadataList[index]['members'] = [];
            component.set("v.metadataList",metadataList); 
            $A.util.addClass(spinner, "slds-hide");
        }
    },
    confirmData:function(component, event, helper) {
        component.set("v.isVisible",true);
        component.set("v.confirm",!component.get("v.confirm"));
        var metadataMembers = component.get("v.metadataMembers");
        console.log('--------metadataMembers2----------------');
        console.log(metadataMembers);
        if(metadataMembers.length==0){
            helper.getMetadata(component);
        }
        component.set("v.isVisible",false);
    },
    compareAndDeploy:function(component, event, helper) {
        helper.compareDeploy(component);
    },
    exeDeploy:function(component, event, helper) {
        component.set("v.isVisible",true);
        var confrm = component.get("v.confirm");
        if(confrm){
            component.set("v.confirm",false);
            $(".main-body").animate({ scrollTop: 0 }, "fast");
            helper.getMetadata(component);
            var dataObj={};
            var action = component.get('c.deployMetadata');
            dataObj["destOrgname"] = component.get("v.metaDataMap.destOrgname");
            dataObj["srcOrgname"] = component.get("v.metaDataMap.srcOrgname");
            dataObj["srcusername"] = component.get("v.metaDataMap.srcusername");
            dataObj["agentid"] = component.get("v.agent");
            dataObj["labelname"] = component.get("v.metaDataMap.labelName");
            dataObj["dpmsource"] = component.get("v.metaDataMap.dpmsource");
            dataObj["metadata"] = JSON.stringify(component.get("v.deployMetaDataMap"));
            dataObj["reponame"] = component.get("v.metaDataMap.reponame");
            dataObj["type"] = component.get("v.metaDataMap.type");
            dataObj["branch"] = component.get("v.metaDataMap.branch");
            console.log(dataObj);
            action.setParams(dataObj);
            action.setCallback(this,function(res){
                var response = JSON.parse(res.getReturnValue());
                var state = res.getState();
                console.log(response);
                var xmlDoc = $.parseXML( response.Resbody );
                var $xml = $( xmlDoc );
                var msg = $xml.find( 'faultString,return' ).text();
                var code = response.statusCode;
                helper.showToast(msg,code)
                if(state=="SUCCESS"){
                    helper.getDeployReport(component,response);
                }
            })
            $A.enqueueAction(action);
        }
    }
    
})