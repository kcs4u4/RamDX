({
	closeItem : function(component, event, helper) {
        helper.getHtmlNode(component,event.target,"closeItemEvent","LI");
	},
    selectItem : function(component, event, helper) {
        helper.getHtmlNode(component,event.target,"selectItemEvent","LI");
    }
})