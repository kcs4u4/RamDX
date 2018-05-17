({
    gotoURL : function (component, event, helper) {
        var $LiNode = $(event.target).parents("li");
        var role = $LiNode.attr("role");
        var title = $LiNode.attr("title");
        var compName = $LiNode.attr("data-component-name");
        if(role=="modal"){
            component.set("v.currComp",title); 
        }
        else if(role=="tab"){
            var obj = {}
            obj['tabTitle'] = title;
            obj['compName'] = compName;
            obj['isCached'] = "false";
            var attrObj = {};
            var storyObj = component.get("v.story");
            console.log('--------------title--------------------'+title);
            if(title=="Load Metadata"){
                var storyObj = component.get("v.story");
                var soObj = {};
                soObj["id"] = storyObj.orgid;
                soObj["name"] = storyObj.scratchOrg;
                attrObj["ScrOrgList"] = [soObj];
                obj["compAttrs"] = attrObj;              
            }
            else if(title=="New Merge"){
                attrObj['story'] = component.get("v.story");
                obj["compAttrs"] = attrObj;
            }
            console.log(obj);
            var cmpEvent = component.getEvent("appLauncher");
            cmpEvent.setParams({
                "appLauncher":obj
            });
            cmpEvent.fire();
        }
    }
})