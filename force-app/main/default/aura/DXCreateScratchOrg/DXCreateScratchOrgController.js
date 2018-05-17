({
    hideModal:function(component, event, helper) {
        component.find("cso").cancel();
    },
    addScrOrg:function(component, event, helper) {
        component.find("cso").create();        
    }  
})