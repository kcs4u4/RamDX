({
	scriptsLoaded : function(component, event, helper) {
        $(document).ready(function() {
            $('[data-aljs="tabs"]').tabs();
        });
	}
})