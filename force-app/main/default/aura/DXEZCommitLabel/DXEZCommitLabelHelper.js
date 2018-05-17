({
    getData : function(component,actionName,params,varName,tagName) {
        var action = component.get("c."+actionName);
        if(!$A.util.isEmpty(params) && typeof params != 'undefined' ){
            action.setParams(params)
        };
        action.setCallback(this,function(res){
            console.log(res.getReturnValue());
            this.setData(component,varName,res,tagName);
        });  
        $A.enqueueAction(action); 
    },
    setData:function(component,varName,res,tagName) {
        var response = JSON.parse(res.getReturnValue());
        var state = res.getState();
        if(state=="SUCCESS" && response['statusCode']==200){
            var xml = response.Resbody;
            var xmlDoc = $.parseXML( xml );
            var $xml = $( xmlDoc );
            var labels = [];
            var $keys = $xml.find(tagName);
            $keys.each(function(){
                var obj = {};
                $.each(this.attributes, function() {
                    obj[this.name] = this.value;
                });
                labels.push(obj)
            })
            console.log(labels)
            component.set("v."+varName,labels);    
        }
    }
})