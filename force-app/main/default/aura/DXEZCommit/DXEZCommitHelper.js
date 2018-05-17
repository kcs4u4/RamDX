({
    getDataObj:function(dataObj){
        var obj ={};
        for(var key in dataObj){
            obj[key] = dataObj[key];
        }
        return obj;
    },
     clearMessages : function(arrComps) {
        for(var i=0;i<arrComps.length;i++){
            arrComps[i].set("v.errors", [{message: ""}]);
        }
    },
    getDetails:function(comp,funName,attrName,xmlKey){
        comp.set("v.isVisible",true);
        var action = comp.get('c.'+funName);
        //action.setStorable();
        action.setCallback(this,function(res){
            var state = res.getState();
            var response = JSON.parse(res.getReturnValue());
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
                console.log(list);
                comp.set("v."+attrName,list);
                comp.set("v.isVisible",false);
            }
        })
        $A.enqueueAction(action);        
    },
    getScrOrgList:function(comp){
        comp.set("v.isVisible",true);
        var action = comp.get('c.SanboxesHistory');
        /*action.setParams({
            "hubid":comp.get("v.hubid"),
            "hubname":comp.get("v.hubalias")
        });*/
        //action.setStorable();

        action.setCallback(this,function(res){
            var state = res.getState();
            if(state == 'SUCCESS'){
                var xml = JSON.parse(res.getReturnValue());
                var xmlDoc = $.parseXML( xml.Resbody );
                var $xml = $( xmlDoc );
                var $sos = $xml.find( "sandbox" );
                var soList = [];
                $sos.each(function(){
                    var obj = {};
                    obj.name = $(this).attr("name");
                    obj.username = $(this).attr("username");
                    obj.url = $(this).attr("url");
                    obj.date = $(this).attr("date");
                    obj.expirydate = $(this).attr("expirydate");
                    obj.hubuserid = $(this).attr("hubuserid");
                    obj.id =$(this).attr("id");
                    obj.orgurl = $(this).attr("orgurl");
                    soList.push(obj);
                    
                });
                comp.set('v.ScrOrgList',soList);
                comp.set("v.isVisible",false);
            }
        });
        $A.enqueueAction(action);
    },
    goUp:function(){
        $(document).on("click",".slds-btn-commit",function(){
            $(".main-body").animate({ scrollTop: 0 }, "fast");  
        })
        
    },
    showToast : function(msg,code) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": code!=200?"Error!":"Success!",
            "message": msg,
            "type": code!=200?"error":"success"
        });
        toastEvent.fire();
    }
})