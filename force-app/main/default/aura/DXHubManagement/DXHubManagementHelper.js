({
    getHubList :  function(comp) {
        console.log('----getHubList----');
        comp.set('v.isVisible',true);
        var action = comp.get('c.getDevHubList');
        action.setCallback(this,function(res){
            var state = res.getState();
            if(state == "SUCCESS"){
                var xml = JSON.parse(res.getReturnValue());
                var xmlDoc = $.parseXML( xml.Resbody );
                var $xml = $( xmlDoc );
                var $hubs = $xml.find( "sfdxhub" );
                var hubList = [];
                $hubs.each(function(){
                    var obj = {};
                    obj.hubid = $(this).attr('uid');
                    obj.alias = $(this).attr('hubname');
                    obj.username = $(this).attr('username');
                    obj.instanceurl = $(this).attr('instanceurl');
                    obj.orgname = $(this).attr('orgname');
                    hubList.push(obj);
                });
                console.log(hubList);
                comp.set('v.DevHubList',hubList);
            }
            comp.set('v.isVisible',false);
        })
        $A.enqueueAction(action);
    },
    showToast : function(msg,code) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": code!=200?"Error!":"Success!",
            "message": msg,
            "type": code!=200?"error":"success",
            "duration":code!=200?10000:5000
        });
        toastEvent.fire();
    },
    getResponseDetails:function(res){
        var resObj = {};
        var xmlDoc = $.parseXML( res.Resbody );
        console.log(res.Resbody);
        var $xml = $( xmlDoc );
        resObj.msg = $xml.find('return,faultstring').text();
        resObj.code = res.statusCode;
        return resObj;
    },
    leftPage:function(comp){
        var action = comp.get('c.leavePage');
        $A.enqueueAction(action);
    }
})