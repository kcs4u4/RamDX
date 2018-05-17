({
    setEvent : function(component) {
        component.set('v.flag',false);
    },
    clearMessages : function(arrComps) {
        for(var i=0;i<arrComps.length;i++){
            arrComps[i].set("v.errors", [{message: ""}]);
        }
    },
    showToast : function(msg,code) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": code!=200?"Internal Server Error!":"Success!",
            "message": msg+".",
            "type": code!=200?"error":"success"
        });
        toastEvent.fire();
    },
    getData:function(component,funName,attr){
        var action = component.get('c.'+funName);
        action.setCallback(this,function(res){
            var data = res.getReturnValue();
            console.log(data);
            component.set("v."+attr,data);
        });
        $A.enqueueAction(action);
    }
})