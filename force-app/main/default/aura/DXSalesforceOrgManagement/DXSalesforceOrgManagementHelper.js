({
    showToast : function(resp) {
        var xml = resp.Resbody;
        var xmlDoc = $.parseXML( xml );
        var $xml = $( xmlDoc );
        var code = resp.statusCode;
        var msg = $xml.find( code==200?"return":"faultString" ).text();   
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": code!=200?"Error!":"Success!",
            "message": msg,
            "type": code!=200?"error":"success"
        });
        toastEvent.fire();
    },
    getSandboxesHistory:function(component,event){
        var action = component.get("c.SanboxesHistory");
        action.setCallback(this,function(res){
            var state = res.getState();
            var response = JSON.parse(res.getReturnValue());
            console.log(response.Resbody);
            if(state=="SUCCESS" && response.statusCode==200){
                var xml = response.Resbody;
                var xmlDoc = $.parseXML( xml );
                var $xml = $( xmlDoc );
                var $keys = $xml.find('sandbox');
                var list = [];
                $keys.each(function() {
                    var obj = {};
                    $.each(this.attributes, function() {
                            obj[this.name] = this.value;
                    });
                    obj['instanceurl'] = $(this).find('url').text();
                    obj['environment'] = $(this).find('environment').text();
                    list.push(obj)
                });
                component.set("v.SfOrgList",list);
                console.log('----------------sfOrgsList-----------------------');
                console.log(component.get("v.SfOrgList"));
            }
            else{
                helper.showToast(response);
            }
        });
        $A.enqueueAction(action);
    }
})