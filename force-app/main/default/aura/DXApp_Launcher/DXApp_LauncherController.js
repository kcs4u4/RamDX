({
    addTab : function(component, event, helper) {
        var obj = {}
        var tabTitle = $(event.srcElement).parents("li").attr("title");
        var compName = $(event.srcElement).parents("li").attr("data-component-name");
        obj['tabTitle'] = tabTitle;
        obj['compName'] = compName;
        obj['isCached'] = "true";
        var cmpEvent = component.getEvent("appLauncher");
        cmpEvent.setParams({
            "appLauncher":obj
        });
        cmpEvent.fire();
    },
    appLauncherTrigger:function(component, event, helper) {
        var isVisible = component.get("v.isAppLauncherVisible");
        component.set("v.isAppLauncherVisible",!isVisible);	
    }
})