({
    checkInput : function(comp,id,msg,type) {
        var curEle = comp.find(id);
        var curEleValue = curEle.get("v.value");
        if($A.util.isEmpty(curEleValue)){
            this.countErrors(comp);
            curEle.set("v.errors", [{message: msg}]);
        }
        else if(type=='email'){
            var regExpEmailformat = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            if(!curEleValue.match(regExpEmailformat)){
                this.countErrors(comp);
                curEle.set("v.errors", [{message: "Please Enter a Valid Email Address."}]);
            }
        }
        else{
            curEle.set("v.errors", '');
        }
    },
    checkInputSelect : function(comp,id,msg) {
        var curEle = comp.find(id);
        var curEleValue = curEle.get("v.value");
        if(curEleValue=="Select"){
            this.countErrors(comp);
            curEle.set("v.errors", [{message: msg}]);
        }
        else{
            curEle.set("v.errors", '');
        }
    },
    countErrors:function(comp){
        var val = comp.get("v.errorCount");
        val++;
        comp.set("v.errorCount",val);
    },
    checkCount:function(comp){
        var val = comp.get("v.errorCount");
        return val;
    },
    getDataObj:function(dataObj){
        var obj ={};
        for(var key in dataObj){
            obj[key] = dataObj[key];
        }
        return obj;
    },
    clearDataObj:function(comp,dataObj){
        var obj ={};
        for(var key in dataObj){
            obj[key] = '';
        }
        comp.set('v.dataObj',obj)
    },
    getAllCredentials:function(comp){
        var action = comp.get('c.AllCredentials');
        action.setCallback(this,function(res){
            var state = res.getState();
            var response = JSON.parse(res.getReturnValue());
            console.log(response);
            if(state=="SUCCESS" && response.statusCode==200){
                var xml = response.Resbody;
                var xmlDoc = $.parseXML( xml );
                var $xml = $( xmlDoc );
                var $accesskeys = $xml.find( "accesskey" );
                var accesskeyList = [];
                $accesskeys.each(function() {
                    var obj = {};
                    $.each(this.attributes, function() {
                        if(this.specified) {
                            obj[this.name] = this.value;
                        }
                    });
                    accesskeyList.push(obj)
                });
                comp.set("v.accesskeyList",accesskeyList);
            }
            else{
                this.showToast(response);
            }
        })
        $A.enqueueAction(action);
    },
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
    }
})