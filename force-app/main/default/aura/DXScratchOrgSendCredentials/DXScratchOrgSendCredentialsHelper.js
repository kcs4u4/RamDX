({
	setEvent : function(component) {
        component.set('v.isNew',false);
    },
     clearMessages : function(arrComps) {
        for(var i=0;i<arrComps.length;i++){
            arrComps[i].set("v.errors", [{message: ""}]);
        }
    },
})