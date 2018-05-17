({
    doInit:function(component, event, helper){
        helper.getSFOrgs(component);
        helper.getVersionContrlList(component);
        helper.getDetails(component,'UserRepositories','repositoryDetailsList','repository');
    },
    refresh:function(component, event, helper){
        component.set('v.isLoadingVisible',true);
        var obj = {}
        obj['tabTitle'] = "Load Metadata";
        obj['compName'] = "DXDeployment";
        obj['isCached'] = "true"; 
        var cmpEvent = component.getEvent("appLauncher");
            cmpEvent.setParams({
                "appLauncher":obj
            });
        cmpEvent.fire();
        component.set('v.isLoadingVisible',false);
    },
    selectDeloyment:function(component, event, helper) {
        var selectId = event.target.id
        var index = $("#"+selectId).prop('selectedIndex');
        if(selectId=="DeploymentFrom"){
            helper.getDeploymentFrom(component);
        }
        else if(selectId=="VersionControl"){
            var versionCtrl =$("#"+selectId).find("option:eq("+index+")").attr("data-vc");
            if(versionCtrl){
                component.set('v.metaDataMap.type',versionCtrl);
                component.set('v.versionCtrl',versionCtrl.toLowerCase()); 
            }
            
        }
            else if(selectId=="Repository"){
                var repoid = $("#"+selectId).find("option:eq("+index+")").text();
                if(repoid){
                    component.set('v.isLoadingVisible',true);
                    component.set('v.metaDataMap.reponame',repoid);
                    var action = component.get("c.Branches");
                    action.setParams({
                        "reponame":repoid
                    })
                    action.setCallback(this,function(res){
                        var state = res.getState();
                        var response = JSON.parse(res.getReturnValue());
                        console.log(response);
                        if(state=="SUCCESS" && response.statusCode==200)
                        {
                            var xml = response.Resbody;
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
                        component.set('v.isLoadingVisible',false);
                    })
                    $A.enqueueAction(action);                
                }
                
            }
                else if(selectId=="Branch"){
                    if(index>0){
                        component.set('v.metaDataMap.branch',$("#"+selectId).val());
                    }
                }
                    else if(selectId=="srcOrg"){
                        console.log('---------srcOrg-----------');
                        var destOrgname = $("#"+selectId).find("option:eq("+index+")").text();
                        var destination = $("#"+selectId).val();
                        if(destOrgname){
                            component.set('v.metaDataMap.destOrgname',destOrgname);
                            component.set('v.destination',destination);
                        }
                    }
                        else if(selectId=="sforg"){
                            console.log('---------sforg-----------');
                            var srcOrgname = $("#"+selectId).find("option:eq("+index+")").text();
                            var source = $("#"+selectId).val();
                            if(srcOrgname){
                                component.set('v.metaDataMap.srcOrgname',srcOrgname);
                                component.set('v.source',source);
                            }
                        }
    },
    retrieveMetaData:function(component, event, helper) {
        $(".slds-error").remove();
        var c=0;
        var labelName = component.find("labelName");
        var labelNameValue = labelName.get("v.value");
        helper.clearMessages([labelName]);
        if($A.util.isEmpty(labelNameValue)){
            c++;
            labelName.set("v.errors", [{message: "Please Enter 'Deployment Label' Name."}]);
        }
        if(component.get('v.metaDataMap.destOrgId')==""){
            c++
            $("#srcOrg").parent().after("<span class='slds-error'>Please select 'Destination Org'.</span>");
        }
        
        $(".main-body").animate({ scrollTop: 0 }, "fast");
        if(c==0){
            component.set('v.isLoadingVisible',true);
            var dataObj = helper.getDataObj(component.get('v.metaDataMap'));
            var action = component.get("c.Agents");
            action.setCallback(this,function(res){
                var state = res.getState();
                var response = JSON.parse(res.getReturnValue());
                console.log(res.getReturnValue());
                if(state=="SUCCESS" && response.statusCode==200 && response!=null)
                {
                    var xml = response.Resbody;
                    var xmlDoc = $.parseXML( xml );
                    var $xml = $( xmlDoc );
                    var $key = $xml.find('agent').attr("id");
                    if($key){
                        component.set('v.agent',$key);
                    } 
                }
            });
            $A.enqueueAction(action);
            console.log(dataObj);
            action = component.get("c.SourcePackageManifest");
            action.setParams(dataObj);
            action.setCallback(this,function(res){
                var state = res.getState();
                var response = JSON.parse(res.getReturnValue());
                console.log(response);
                if(response!=null){
                    var xml = response.Resbody;
                    var xmlDoc = $.parseXML( xml );
                    var $xml = $( xmlDoc );
                    var errMsg = $xml.find("return,faultString").text();
                    if(state=="SUCCESS" && response.statusCode==200)
                    {
                        var $keys = $xml.find( 'type' );
                        var list = [];
                        $keys.each(function() {
                            var obj = {};
                            obj['name'] = $(this).attr('name');
                            obj['members'] = [];
                            obj['isSel'] = false;
                            list.push(obj);
                        });
                        component.set('v.metadataList',list);
                        component.set('v.isVisible',false);
                        component.set('v.isMetadataMembersVisible',true);
                        if(list.length==0){
                            helper.showToast(errMsg,response.statusCode);
                        }
                       
                    }
                    else{
                        helper.showToast(errMsg,response.statusCode);
                    }
                     component.set('v.isLoadingVisible',false);
                }
            });
            $A.enqueueAction(action)            
        }
    },
    changeTab:function(component, event, helper) {
        console.log('-----------------changeTab start-----------');
        component.set("v.isLoadingVisible",true);
        $('.slds-tabs_scoped__nav').find("li").removeClass('slds-is-active');
        $A.util.addClass(event.srcElement.parentNode, "slds-is-active");
        $(".slds-tabs_scoped__content").removeClass('slds-show');
        $(".slds-tabs_scoped__content").addClass('slds-hide');
        var id = $(event.srcElement).attr('id').split('__')[0];
        $("#"+id).addClass("slds-show");
		component.set("v.isLoadingVisible",false);        
        console.log('-----------------changeTab end-----------');
    }
})