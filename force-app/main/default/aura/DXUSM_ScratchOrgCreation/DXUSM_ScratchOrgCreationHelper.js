({
    setEvent : function(component) {
        component.set('v.currComp','');
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
    getDevHubList:function(comp){
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
                    obj.hubid = $(this).find('uid').text();
                    obj.alias = $(this).find('hubname').text();
                    obj.username = $(this).find('username').text();
                    obj.instanceurl = $(this).find('instanceurl').text();
                    obj.orgname = $(this).find('orgname').text();
                    $.each(this.attributes, function() {
                        obj[this.name] = this.value;
                    });
                    hubList.push(obj);
                });
                console.log('Devhublist');
                console.log(hubList); 
                comp.set('v.DevHubList',hubList);
            }
        })
        $A.enqueueAction(action);
    },
    getScrOrgList:function(comp){
        var action = comp.get('c.ScratchOrgList');
        action.setParams({
            "hubname":comp.get("v.DevHub.hubname")
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
                console.log(soList);
                comp.set('v.ScrOrgList',soList);
            }
        });
        $A.enqueueAction(action);
    },
    assignScratchOrg:function(comp){
        var soVal = comp.find("soSelect").get("v.value");
        if(soVal.length>0){
            var tempArr = soVal.split('$');
            var index = tempArr[1];
            var soName = tempArr[0];
            comp.set("v.isVisible",true);
            var action = comp.get('c.assignScratchOrgUSM');
            var dataObj = comp.get("v.story");
            var scrOrgList = comp.get('v.ScrOrgList');
            var currentSODetails = scrOrgList[index];
            var datMap = {
                "almuserstoryid":dataObj.id,
                "id":currentSODetails.id,
                "name":currentSODetails.name,
                "orgusername":currentSODetails.username,
                "createddate":currentSODetails.createddate,
                "expirydate":currentSODetails.expirydate,
                "almuserstorykey":dataObj.key,
                "almname":dataObj.almname,
                "projectkey":dataObj.projectkey,
                "almprojectname":dataObj.name,
                "sprintid":dataObj.sprintid,
                "sprintname":dataObj.sprint
            };
            console.log(datMap);
            action.setParams({
                "dataMap":datMap
            });
            action.setCallback(this,function(res){
                comp.set("v.isVisible",false);
                var state = res.getState();
                if(state == 'SUCCESS'){
                    var cmpEvent = comp.getEvent("refreshStories");
                    cmpEvent.fire();
                    comp.set("v.currComp","");
                }
            });
            $A.enqueueAction(action);            
        }
    }
})