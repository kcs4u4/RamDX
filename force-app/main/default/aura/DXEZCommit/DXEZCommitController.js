({
    doInit : function(component, event, helper) {
        helper.goUp();
        helper.getScrOrgList(component);
        helper.getDetails(component,'UserRepositories','repositoryDetailsList','repository');
    },
    fetchChanges : function(component, event, helper) {
        $(".slds-error").remove();
        var c=0;
        if(component.get('v.fetchChangesMap.sforgname')==""){
            c++
            $("#srcOrg").parent().after("<span class='slds-error'>Please select 'Salesforce Org'.</span>");
        }
        if(component.get('v.fetchChangesMap.reponame')==""){
            c++
            $("#Repository").parent().after("<span class='slds-error'>Please select 'Repository'.</span>");
        }
        if(component.get('v.fetchChangesMap.branch')==""){
            c++
            $("#Branch").parent().after("<span class='slds-error'>Please select 'Branch'.</span>");
        }
        var user = $("#user").val();
        component.set('v.fetchChangesMap.usersList',user);
        var dataObj = helper.getDataObj(component.get('v.fetchChangesMap'));
        console.log(dataObj);
        if(c==0){
            component.set("v.isVisible",true);
            var action = component.get('c.fetchUserChangesFromSfOrg');
            action.setStorable();
            action.setParams(dataObj);
            action.setCallback(this,function(res){
                var response = JSON.parse(res.getReturnValue());
                console.log(response);
                if(response){
                    var xml = response.Resbody;
                    var xmlDoc = $.parseXML( xml );
                    var $xml = $( xmlDoc );
                    var errorMsg = $xml.find('return,faultString').text();   
                    var statusCode = response['statusCode'];
                    if(response['statusCode']==200 && res.getState()=='SUCCESS'){
                        var $keys = $xml.find('types');
                        var dataObj = {};
                        $keys.each(function(){
                            var list = [];
                            $(this).find('members').each(function(){
                                var obj = {};
                                $.each(this.attributes, function() {
                                    obj[this.name] = this.value;
                                });
                                list.push(obj)
                            })
                            dataObj[$(this).attr('name')] = list;
                        })
                        var newDataList = [];
                        for(var key in dataObj){
                            var obj={};
                            obj.name= key;
                            obj.members = dataObj[key];
                            obj.showMembers = false;
                            newDataList.push(obj);
                        }
                        console.log(newDataList);
                        component.set("v.fetchChangesList",newDataList);
                        component.set("v.isShowChanges",newDataList.length>0?true:false);
                        component.set("v.isFetchChanges",newDataList.length>0?false:true);
                    }
                }
                else{
                    console.log('-----------response null--------------');
                    helper.showToast('Please try again.',500);  
                }
                component.set("v.isVisible",false);
            });
            $A.enqueueAction(action);            
        }
        
    },
    selectDeloyment:function(component, event, helper) {
        var selectId = event.target.id;
        var index = $("#"+selectId).prop('selectedIndex');
        if(index>0){
            if(selectId=="srcOrg"){
                var sforgname = $("#"+selectId).find("option:eq("+index+")").text();
                var source = $("#"+selectId).val();
                component.set("v.source",source);
                if(sforgname){
                    component.set('v.fetchChangesMap.sforgname',sforgname);
                    component.set("v.isVisible",true);
                    var action = component.get("c.getuserInfo");
                    
                    action.setCallback(this,function(res){
                        var state = res.getState();
                        if(state=="SUCCESS"){
                            var list = [res.getReturnValue()];
                            component.set("v.UserList",list);   
                            component.set("v.isVisible",false);
                        }
                    })
                    $A.enqueueAction(action);  
                }
                
            }
            else if(selectId=="Repository"){
                var $selOpt = $("#"+selectId);
                var reponame = $selOpt.find("option:eq("+index+")").text();
                var repoUrl = $selOpt.find("option:eq("+index+")").attr("data-url");
                component.set("v.fetchChangesMap.repoUrl",repoUrl);
                var destination = $selOpt.val();
                component.set("v.destination",destination);
                if(reponame){
                    component.set("v.isVisible",true);
                    component.set('v.fetchChangesMap.reponame',reponame);
                    var action = component.get("c.Branches");
                    action.setParams({
                        "reponame":reponame
                    });
                    action.setCallback(this,function(res){
                        var state = res.getState();
                        var response = JSON.parse(res.getReturnValue());
                        if(state=="SUCCESS" && response.statusCode==200)
                        {
                            var xml = response.Resbody;
                            console.log(xml);
                            var xmlDoc = $.parseXML( xml );
                            var $xml = $( xmlDoc );
                            var $keys = $xml.find('branch');
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
                            component.set("v.BranchList",list);
                        }
                        component.set("v.isVisible",false);
                    })
                    $A.enqueueAction(action);                
                }
            }
                else if(selectId=="Branch"){
                    var branch = $("#"+selectId).val();
                    component.set('v.fetchChangesMap.branch',branch);  
                    component.set("v.branch",branch);
                }
        }
        
    },
    confirmCommit:function(component, event, helper) {
        component.set("v.isVisible",true);
        var metadataMap = helper.getDataObj(component.get("v.metadataMap"));
        var metadataMembers = [];
        for(var key in metadataMap){
            var obj = {};
            obj['name'] = key;
            obj['members'] = metadataMap[key].length>0?getMetadataNames(metadataMap[key]):'All';
            metadataMembers.push(obj);
        }
        component.set("v.metadataMembers",metadataMembers);
        component.set("v.confirm",true);
        component.set("v.isVisible",false);
        function getMetadataNames(arr){
            var strMeta = '';
            for(var i=0;i<arr.length;i++){
                strMeta+=(arr[i].fullname || arr[i].filename.split("/").slice(-1)[0])+',';
            }
            return strMeta.slice(0,-1);
        }
    },
    commitChanges:function(component, event, helper) {
        
        component.set("v.confirm",false);
        var dataObj={};
        
        /*var commitLabel = component.find("commitLabel").get('v.customLabel');
        console.log('commitChanges');
        var labelType = component.find("commitLabel").get('v.label');*/
        
        dataObj['usersList']=component.get("v.fetchChangesMap.usersList");
        dataObj['sforgname']=component.get("v.fetchChangesMap.sforgname");
        dataObj['metadata']=JSON.stringify(component.get("v.metadataMap"));
        dataObj['reponame']=component.get("v.fetchChangesMap.reponame");
        dataObj['branch']=component.get("v.fetchChangesMap.branch");
        dataObj['commitLabel'] = component.get("v.commitLabel");
        dataObj['labelType'] = component.get("v.labelType");
        dataObj['comment'] = component.get("v.fetchChangesMap.comment");
        if(component.get("v.fetchChangesMap.isSfdx"))
        dataObj['dxfoldername'] = component.get("v.fetchChangesMap.dxfoldername");
        
        var action = component.get('c.commitChangesToSCM');
        action.setParams(dataObj);
        action.setCallback(this,function(res){
            var state = res.getState();
            var response = JSON.parse(res.getReturnValue());
            var xml = response.Resbody;
            var xmlDoc = $.parseXML( xml );
            var $xml = $( xmlDoc );
            var errMsg = $xml.find("return,faultString").text();
            if(state=="SUCCESS" && response.statusCode==200)
            {
                var $commits = $xml.find('metadata');
                var commitList = [];
                $commits.find('members').each(function() {
                    commitList.push($(this).text());
                });
                var $uncommits = $xml.find('uncommittedmetadata');
                var uncommitList = [];
                $uncommits.find('members').each(function() {
                    uncommitList.push($(this).text());
                });
                var nocommit = commitList.length;
                var nouncommit = uncommitList.length;
                var total = nocommit+nouncommit;
                component.set("v.commitReport.success",commitList);
                component.set("v.commitReport.failure",uncommitList);
                component.set("v.commitReport.report.total",total);
                component.set("v.commitReport.report.success",nocommit);
                component.set("v.commitReport.report.errors",nouncommit);
                if(total>0){
                    component.set("v.isShowCommitReport",true);
                    component.set("v.isShowChanges",false);
                    component.set("v.isFetchChanges",false);
                    //helper.showToast(errMsg,response.statusCode);
                }
                else{
                    component.set("v.isShowChanges",false);
                    component.set("v.isShowCommitReport",false);
                    component.set("v.isFetchChanges",true);
                    //helper.showToast(errMsg,response.statusCode);
                }
            }
            else{
                //helper.showToast(errMsg,response.statusCode);
            }
            
        });
        $A.enqueueAction(action);
    },
    compareCommit:function(component, event, helper) {
        console.log(JSON.stringify(component.get("v.metadataMap")));
        component.set("v.isVisible",true);
        component.set("v.confirm",false);
        var dataObj={};
        dataObj['usersList']=component.get("v.fetchChangesMap.usersList");
        dataObj['sforgname']=component.get("v.fetchChangesMap.sforgname");
        dataObj['metadata']=JSON.stringify(component.get("v.metadataMap"));
        dataObj['reponame']=component.get("v.fetchChangesMap.reponame");
        dataObj['branch']=component.get("v.fetchChangesMap.branch");
        var action = component.get('c.FileDifferencesForCompare');
        action.setParams(dataObj);
        action.setCallback(this,function(res){
            var state = res.getState();
            var response = JSON.parse(res.getReturnValue());
            var xml = response.Resbody;
            var xmlDoc = $.parseXML( xml );
            var $xml = $( xmlDoc );
            var errMsg = $xml.find("return,faultString").text();            
            if(state=="SUCCESS" && response.statusCode==200)
            {
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
                component.set("v.compareMetadataMembers",newDataList);
                if(newDataList.length>0){
                    component.set("v.isShowChanges",false);
                    component.set("v.isShowCommitReport",false);
                    component.set("v.isCommitAndConfirm",true);
                }
                else{
                    component.set("v.isShowChanges",true);
                    component.set("v.isCommitAndConfirm",false);
                }
            }
            else{
                //helper.showToast(errMsg,response.statusCode);
            }
            component.set("v.isVisible",false);
        });
        $A.enqueueAction(action);
    },
    newCommit:function(component, event, helper){
        var obj = {}
        obj['tabTitle'] = "EZ Commit";
        obj['compName'] = "DXEZCommit";
        obj['isCached'] = "true"; 
        var cmpEvent = component.getEvent("appLauncher");
        cmpEvent.setParams({
            "appLauncher":obj
        });
        cmpEvent.fire();
    },
    addLabelToEzCommit:function(component, event, helper){
        component.set("v.addLabelModalVisible",true);
    },
    additionalMetadata:function(component, event, helper){
        component.set("v.addMDModalVisible",true);
    }
})