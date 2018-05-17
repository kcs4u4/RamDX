({
	clearMessages : function(arrComps) {
        for(var i=0;i<arrComps.length;i++){
            arrComps[i].set("v.errors", [{message: ""}]);
        }
	},
    getDataObj:function(dataObj){
        var obj ={};
        for(var key in dataObj){
            obj[key] = dataObj[key];
        }
        return obj;
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