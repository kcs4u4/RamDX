({
    doInit : function(component, event, helper) {
        console.log(component.get("v.story"));
        helper.getAlmNotes(component, event)
	},
	goBack : function(component, event, helper) {
        component.set("v.story",{});
	},
    addNote: function(component, event, helper) {
        component.set("v.isAddNote",true);
	}
})