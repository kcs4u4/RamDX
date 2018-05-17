({
	doInit : function(component, event, helper) {
        var comp = component.find("body");
        var attrs = component.get("v.compAttrs");
        $A.createComponent(
            "c:"+component.get("v.compName"),attrs,
            function(newButton, status, errorMessage){
                //Add the new button to the body array
                if (status === "SUCCESS") {
                    console.log("SUCCESS");
                    var body = comp.get("v.body");
                    body.push(newButton);
                    comp.set("v.body", body);
                }
                else if (status === "INCOMPLETE") {
                    console.log("No response from server or client is offline.")
                    // Show offline error
                }
                else if (status === "ERROR") {
                    console.log("Error: " + errorMessage);
                    // Show error message
                }
            }
        );
	}
})