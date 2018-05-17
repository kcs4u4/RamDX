({
    showToast : function(res) {
        var xmlDoc = $.parseXML( res.Resbody );
        var $xml = $( xmlDoc );
        var errMsg = $xml.find( "return,faultString" ).text();
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": res.statusCode==200?"Success!":"Error!",
            "message": errMsg,
            "type": res.statusCode!=200?"error":"success",
            "duration":res.statusCode!=200?10000:5000
        });
        toastEvent.fire();
    },
    getScrOrgList:function(comp){
        comp.set("v.isVisible",true);
        var action = comp.get('c.ScratchOrgList');
        action.setParams({
            "hubname":comp.get("v.hubalias")
        });
        action.setCallback(this,function(res){
            var state = res.getState();
            if(state == 'SUCCESS'){
                console.log(res.getReturnValue());
                var xml = JSON.parse(res.getReturnValue());
                var xmlDoc = $.parseXML( xml.Resbody );
                var $xml = $( xmlDoc );
                var $sos = $xml.find( "sandbox" );
                var soList = [];
                $sos.each(function(){
                    var obj = {};
                    $.each(this.attributes, function() {
                        if(this.specified) {
                            obj[this.name] = this.value;
                        }
                    });
                    obj['username'] = $(this).find('username').text();
                    soList.push(obj);
                    
                });
                console.log('------------soList-----------------');
                console.log(soList);
                comp.set('v.ScrOrgList',soList);
                comp.set("v.isVisible",false);
            }
        });
        $A.enqueueAction(action);
    }
})