({
	getAlmNotes : function(component, event) {
		var action = component.get("c.AlmWINotes");
        action.setParams({
            "workitemid":component.get("v.story.id")
        });
        action.setCallback(this,function(res){
            var state = res.getState();
            var response = JSON.parse(res.getReturnValue());
            console.log(response.Resbody);
            if(state=="SUCCESS" && response.statusCode==200){
                var xml = response.Resbody;
                var xmlDoc = $.parseXML( xml );
                var $xml = $( xmlDoc );
                var $keys = $xml.find('workitemsnote');
                var list = [];
                $keys.each(function() {
                    var obj = {};
                    $.each(this.attributes, function() {
                            obj[this.name] = this.value;
                    });
                    list.push(obj)
                });
                console.log(list);
                component.set("v.notesList",list);
            }
        });
        $A.enqueueAction(action);
	}
})