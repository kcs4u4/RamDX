({
    getSubMebers : function(component,label,xml,index) {
        var metadataList = component.get("v.metadataList");
            var xmlDoc = $.parseXML( xml );
            var $xml = $( xmlDoc );
            var $keys = $xml.find( 'members' );
            var list = [];
            $keys.each(function(){
                if($(this).text().length>0){
                    var obj = {};
                    obj['name'] = $(this).text();
                    obj['isSel'] = false;
                    list.push(obj);
                }
            })
            console.log(list);
            metadataList[index]['members'] = list;
            console.log(metadataList[index]);
            if(list.length==0){
                var appEvent = $A.get("e.c:notificationHandler");
                appEvent.setParams({
                    "variant":"info",
                    "message":"No components for '<<"+label+">>' metadata type!",
                    "header":"Info"
                });
                appEvent.fire();
            }
        component.set("v.metadataList",metadataList); 
        component.set("v.isVisible",false);
    },
    eventattacher:function(){
        $(document).on('click',':checkbox',function(){
            var id = $(this).attr('id');
            var arr = id.split('-');
            if(arr.length==3){
                var parId = arr.slice(0,-1).join('-');
                console.log(parId);
                var noOfChecked = $("input[id^='"+parId+"-']:checked").length;
                var noOfchkBoxes = $("input[id^='"+parId+"-']").length;
                if(!$(this).prop("checked")){
                    $("#"+parId).prop("checked",false);
                }
                else if(noOfChecked==noOfchkBoxes){
                    $("#"+parId).prop("checked",true);
                }
            }
            else{
                $("input[id*='"+id+"-']").prop("checked",$(this).prop('checked'));
            }
            
        });
    },
    getDeployReport:function(comp,response){
        if(response.statusCode==200){
            var accesskeyList = this.getDataObj(response,'iteration');
            console.log("=-----------------------accesskeyList-----------------");
            console.log(accesskeyList);
            var asyncid = accesskeyList[0]['asyncid'];
            console.log("=-----------------------asynicid-----------------"+asyncid);
            var action = comp.get("c.DeploymentStatus");
            action.setParams({
                "destOrgname":comp.get("v.metaDataMap.destOrgname"),
                "asyncid":asyncid
            })
            action.setCallback(this,function(res){
                var response = JSON.parse(res.getReturnValue());
                console.log(response.Resbody);
                if(response.statusCode==200){
                    comp.set("v.isMetadataMembersVisible",false);
                    comp.set('v.deploymentReport.report',this.getDataObj(response,'return')[0]);
                    comp.set('v.deploymentReport.success',this.getDataObj(response,'componentsuccess'));
                    comp.set('v.deploymentReport.failure',this.getDataObj(response,'componentfailure'));
                    console.log('----------------deploymentReport---------------');
                    console.log(comp.get('v.deploymentReport'));
                    comp.set('v.isMetadataReportVisible',true);
                    comp.set("v.isVisible",false);
                }
                
            })
            $A.enqueueAction(action);
            comp.set("v.deploymentOrgInfo",accesskeyList[0]);
        }
    },
    getDataObj:function(response,title){
        var xml = response.Resbody;
        var xmlDoc = $.parseXML( xml );
        var $xml = $( xmlDoc );
        var $accesskeys = $xml.find( title );
        var accesskeyList = [];
        $accesskeys.each(function() {
            var obj = {};
            $.each(this.attributes, function() {
                obj[this.name] = this.value;
            });
            accesskeyList.push(obj)
        });
        return accesskeyList;
    },
    getMetadata:function(component){
        //component.set("v.isVisible",true);
        var metadataMembers = [];
        var metadataMap = {};
        $(".metadata:checked").each(function(){
            metadataMap[$(this).attr('name')]=[];
        });
        $(".sub-metadata:checked").each(function(){
            var metadataName = $(this).attr('data-parent-name');
            var parid = $(this).attr("data-parentid");
            console.log($("#"+parid).is(":checked"));
            if (!$("#"+parid).is(":checked")) {
                if(!metadataMap.hasOwnProperty(metadataName)){
                    metadataMap[metadataName]=[];
                }
                metadataMap[metadataName].push($(this).attr('name'));
            }
        })
        console.log('-------------------metadataMap---------------------');
        console.log(metadataMap);
        for(var key in metadataMap){
            var obj = {};
            obj['name'] = key;
            obj['members'] = metadataMap[key].length>0?metadataMap[key].toString():'All';
            metadataMembers.push(obj);
        }
        console.log('-------------------metadataMembers---------------------');
        console.log(metadataMembers);
        component.set("v.metadataMembers",metadataMembers);
        component.set('v.deployMetaDataMap',metadataMap);
        //component.set("v.isVisible",false);
    },
    showToast : function(msg,code) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": code!=200?"Error!":"Success!",
            "message": msg,
            "type": code!=200?"error":"success"
        });
        toastEvent.fire();
    },
    compareDeploy:function(component){
        this.getMetadata(component);
        component.set("v.isVisible",true);
        var dataObj={};
        var action = component.get('c.OrgDifference');
        dataObj["destorgname"] = component.get("v.metaDataMap.destOrgname");
        dataObj["srcOrgname"] = component.get("v.metaDataMap.srcOrgname");
        dataObj["labelName"] = component.get("v.metaDataMap.labelName");
        dataObj["dpmsource"] = component.get("v.metaDataMap.dpmsource");
        dataObj["metadata"] = JSON.stringify(component.get("v.deployMetaDataMap"));
        dataObj["reponame"] = component.get("v.metaDataMap.reponame");
        dataObj["type"] = component.get("v.metaDataMap.type");
        dataObj["branch"] = component.get("v.metaDataMap.branch");
        action.setParams(dataObj);
        //console.log(dataObj);
        action.setCallback(this,function(res){
            if(res.getState()=='SUCCESS'){
                var response = JSON.parse(res.getReturnValue());
                //console.log(response.Resbody);
                var xml = response.Resbody;
                var xmlDoc = $.parseXML( xml );
                var $xml = $( xmlDoc );
                var dataObj = {};
                $xml.find('type').each(function(){
                    var list = [];
                    $(this).find('member').each(function(){
                        var obj = {};
                        $.each(this.attributes, function() {
                            obj[this.name] = this.value;
                        });
                        list.push(obj)
                    })
                    dataObj[$(this).attr('name')] = list;
                });
                var newDataList = [];
                for(var key in dataObj){
                    var obj={};
                    obj.name= key;
                    obj.members = dataObj[key];
                    newDataList.push(obj);
                }
                console.log(newDataList);
                component.set("v.compareMetadataMembers",newDataList);
                component.set("v.metadataMembers",[]);
                component.set("v.isVisible",false);                
            }
        });
        $A.enqueueAction(action);
    },
    checkMetadataInList:function(list,metadataName){
        
    }
})