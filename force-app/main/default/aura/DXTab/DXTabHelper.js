({
	getHtmlNode : function(component,htmlObj,eventName,elementName) {
        if(htmlObj.nodeName==elementName){
            var cmpEvent = component.getEvent(eventName);
            cmpEvent.setParams({
                "htmlnode":htmlObj
            });
            cmpEvent.fire();
        }
        else{
            this.getHtmlNode(component,htmlObj.parentNode,eventName,elementName);
        }
	}
})