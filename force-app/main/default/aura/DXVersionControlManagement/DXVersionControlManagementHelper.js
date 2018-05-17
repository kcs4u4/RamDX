({
    getVersionContrlList : function(comp) {
        comp.set("v.isVisible",true);
        var action = comp.get("c.Vcsplugins");
        action.setCallback(this,function(res){
            var state = res.getState();
            var response = JSON.parse(res.getReturnValue());
            console.log(response);
            if(state=="SUCCESS" && response.statusCode==200){
                var xml = response.Resbody;
                var xmlDoc = $.parseXML( xml );
                var $xml = $( xmlDoc );
                var $plugins  = $xml.find( "plugin" );
                var repositoryList = [];
                $plugins.each(function() {
                    if($(this).attr('type')=="SC")
                        repositoryList.push($(this).attr('uilabel'));
                });
                comp.set("v.repositoryList",repositoryList);
                comp.set("v.isVisible",false);
            }
        });
        $A.enqueueAction(action);
    },
    getDetails:function(comp,funName,attrName,xmlKey){
        comp.set("v.isVisible",true);
        var action = comp.get('c.'+funName);
        action.setCallback(this,function(res){
            var state = res.getState();
            var response = JSON.parse(res.getReturnValue());
            console.log(response);
            if(state=="SUCCESS" && response.statusCode==200){
                var xml = response.Resbody;
                var xmlDoc = $.parseXML( xml );
                var $xml = $( xmlDoc );
                var $keys = $xml.find( xmlKey );
                var list = [];
                $keys.each(function() {
                    var obj = {};
                    $.each(this.attributes, function() {
                        if(this.specified) {
                            obj[this.name] = this.value;
                        }
                    });
                    list.push(obj)
                });
                comp.set("v."+attrName,list);
                comp.set("v.isVisible",false);
            }
        })
        $A.enqueueAction(action);        
    }
})