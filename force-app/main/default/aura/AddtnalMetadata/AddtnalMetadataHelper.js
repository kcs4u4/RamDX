({
    getMetaData:function(component, event){
      var action = component.get('c.getMetadata');
        action.setStorable();
        action.setParams({
            "sfOrgName":component.get("v.sfOrgName")
        })
        action.setCallback(this,function(res){
            var state = res.getState();
            console.log(state);
            console.log(res.getReturnValue());
            if(state=="SUCCESS"){
                var response = JSON.parse(res.getReturnValue());
                var xml = response.Resbody;
                var xmlDoc = $.parseXML( xml );
                var $xml = $( xmlDoc );
                var $types = $xml.find("type");  
                var list = [];
                $types.each(function(){
                    var obj = {};
                    $.each(this.attributes, function() {
                        obj[this.name] = this.value;
                    });
                    obj['members'] = [];
                    list.push(obj)
                });
                console.log(list);
                component.set("v.metadataList",list);
            }
            component.set("v.isVisible",false);
        })
        $A.enqueueAction(action);  
    },
    getMdMembers : function(component,metadataList,metadataType,mdMembers) {
        for(var i=0;i<metadataList.length;i++){
            var mdObj = metadataList[i];
            if(mdObj.name==metadataType){
                mdObj.members = mdMembers;
                component.set("v.metadataList",metadataList);
                break;
            }
        }
    },
    captureMD : function(component,metadataType,metadata,isAdd) {
        var metadataList = component.get("v.tempFetchChangesList");
        var isExist = false;
        for(var i=0;i<metadataList.length;i++){
            var obj = metadataList[i];
            if(obj.name==metadataType){
                var members = obj.members;
                isExist = true;
                var isMemberExist = this.getArrayIndex(members,metadata.fullname,'fullname');
                console.log('----------------isMemberExist--------------');
                console.log(isMemberExist);
                if(isMemberExist<0 && isAdd){
                    members.push(metadata);
                    obj.members = members;
                }
                else if(isMemberExist>=0 && !isAdd){
                    var isNew = members[isMemberExist].modifieddate;
                    if(!isNew){
                        members.splice(isMemberExist,1);
                        obj.members = members;
                    }
                }
                break;
            }
        }
        if(!isExist){
            var tempObj = {}
            tempObj["name"] = metadataType;
            tempObj["members"] = [metadata];
            tempObj["showMembers"] = false;
            metadataList.push(tempObj);
        }
        component.set("v.tempFetchChangesList",metadataList);
    },
    getArrayIndex:function(arr,val,keyName){
        var index = -1;
        for(var i=0;i<arr.length;i++){
            if(arr[i][keyName]==val){
                index = i;
                break;
            }
        }
        return index;
    }
})