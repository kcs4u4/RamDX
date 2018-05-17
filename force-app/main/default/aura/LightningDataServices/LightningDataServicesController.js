({
	doInit : function(component, event, helper) {
		var action = component.get("c.getContacts");
        action.setCallback(this,function(res){
            component.set("v.contactList",res.getReturnValue());
        });
        $A.enqueueAction(action);
	},
    getDetails : function(component, event, helper) {
        component.set("v.recordId",event.target.dataset.recid);
        component.find('recordData').reloadRecord(true) 
    }
})