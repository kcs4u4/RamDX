({
    doInit : function(cmp) {
        var opts = [
            { class: "optionClass", label: "Option1", value: "opt1", selected: "true" },
            { class: "optionClass", label: "Option2", value: "opt2" },
            { class: "optionClass", label: "Option3", value: "opt3" }
            
        ];
        cmp.find("select").set("v.options", opts);
        /*var c=0;
        $A.createComponent(
            "lightning:button",
            {
                "aura:id": "findableAuraId"+c,
                "label": "Press Me",
                "onclick": cmp.getReference("c.handlePress")
            },
            function(newButton, status, errorMessage){
                //Add the new button to the body array
                if (status === "SUCCESS") {
                    var body = cmp.get("v.body");
                    body.push(newButton);
                    cmp.set("v.body", body);
                    console.log("button: " + cmp.find("findableAuraId0").get("v.label"));
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
        );*/
         $A.createComponents(
        [
            [
                "lightning:select", { label: "Select List", name: "list1"}
            ],
            [
                "option", { value: "Option 1", label: "Option 1" }
            ],
            [
                "option", { value: "Option 2", label: "Option 2" }
            ]
        ],
            function(components) {
                components[0].set("v.body", [components[1], components[2]]);
                cmp.set("v.body", components[0]);
            }

        );
    },
    
    handlePress : function(cmp) {
        // Find the button by the aura:id value
        console.log("button: " + cmp.find("findableAuraId0").get("v.label"));
        console.log("button pressed");
    }
})