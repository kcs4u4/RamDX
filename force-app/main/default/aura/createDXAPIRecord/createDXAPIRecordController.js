({
    handleClick : function(component, event, helper) {
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "/a04/e?action=goback"
        });
        urlEvent.fire();
    }
})