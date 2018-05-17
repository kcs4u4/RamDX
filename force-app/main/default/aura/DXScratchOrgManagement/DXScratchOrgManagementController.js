({
    afterLoaded: function(component, event, helper) {
        console.log($("#Accspinner").length);
    },
    doInit: function(component, event, helper) {
        helper.getScrOrgList(component);
    },
    showModal: function(component, event, helper) {
        component.set('v.isModalVisible',true);
    },
    showModal1:function(component, event, helper){
        component.set('v.isNew',true);
        var $org = $(event.srcElement).parents("a");
        component.set("v.soid",$org.attr("data-soid"));
        component.set("v.soname",$org.attr("data-soname"));
    },
    goBack:function(component, event, helper){
        component.set("v.curDevHub",{});
    },
    delScratchOrg:function(component, event, helper) {
        var $org = $(event.srcElement).parents("a");
        var obj = {
            "soid":$org.attr("data-soid"),
            "soname":$org.attr("data-soname"),
            "sousername":$org.attr("data-sousername"),
            "hubuserid":$org.attr("data-hubid")
        };
        component.set("v.curScrOrg",obj);
        console.log(component.get("v.curScrOrg"));
        component.set('v.isDelete',true);
    },
    unRegister:function(component, event, helper) {
        component.set("v.isVisible",true);
        var action = component.get("c.ScratchOrgDelete");
        var $org = $(event.srcElement).parents("a");
        var obj = component.get("v.curScrOrg");
        obj.flag = event.getParam("flag").toString();
        console.log(obj);
        action.setParams(obj);
        action.setCallback(this,function(res){
            var state = res.getState();
            console.log(res);
            if(state=="SUCCESS"){
                window.setTimeout($A.getCallback(function() {
                    helper.getScrOrgList(component);
                    component.set("v.isVisible",false);
                }),5000);
            }
            else{
                component.set("v.isVisible",false);
            }
        })
        $A.enqueueAction(action);
    },
    scratchOrgURL:function(component, event, helper) {
        component.set("v.isVisible",true);
        var action = component.get("c.ScratchOrgURL");
        var $org = $(event.srcElement).parents("a");
        action.setParams({
            "soid":$org.attr("data-soid"),
            "soname":$org.attr("data-soname")
        });
        action.setCallback(this,function(res){
            var response = JSON.parse(res.getReturnValue());
            var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
                "url":  response.Resbody
            });
            urlEvent.fire();
            component.set("v.isVisible",false);
        });
        $A.enqueueAction(action);
    }
})