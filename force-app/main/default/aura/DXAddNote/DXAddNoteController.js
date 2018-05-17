({
	addNote : function(component, event, helper) {
		var action = component.get('c.addAlmNote');
        action.setParams({
            "workitemid":component.get("v.story.id"),
            "note":component.get("v.note")
        });
        action.setCallback(this,function(res){
            console.log(res.getState());
            console.log(res.getReturnValue());
            var state = res.getState();
            if(state=='SUCCESS'){
                component.getEvent('refreshNotes').fire();
                component.set("v.isAddNote",false);
            }
        });
        $A.enqueueAction(action);
	},
    cancelNote : function(component, event, helper) {
        component.set("v.isAddNote",false);
    }
})