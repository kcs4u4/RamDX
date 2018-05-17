({
    validateData:function(component,comp){
        comp.showHelpMessageIfInvalid();
        var isValid = comp.get("v.validity.valueMissing");
        var errorCount = component.get("v.errorCount");
        if(isValid){
            errorCount++;
            component.set("v.errorCount",errorCount);
        }
        else{
            if(errorCount>0){
                errorCount--;
                component.set("v.errorCount",errorCount);
            }
        }
    },
    getToBranchList:function(component,event){
        var reponame = component.get("v.story.reponame");
        if(!$A.util.isUndefinedOrNull(reponame)){
            var action = component.get("c.getReposMapped");
            action.setCallback(this,function(res){
                var state = res.getState();
                if(state=="SUCCESS"){
                    var xml = JSON.parse(res.getReturnValue());
                    var xmlDoc = $.parseXML( xml.Resbody );
                    var $xml = $( xmlDoc );
                    var $branches = $xml.find( "branches" );
                    var repoList = [];
                    $branches.each(function(){
                        $(this).find("branch").each(function(){
                            var repo = $(this).attr("reponame");
                            if(reponame==repo){
                                var obj = {};
                                $.each(this.attributes, function() {
                                    obj[this.name] = this.value;
                                });
                                repoList.push(obj);
                            }
                        });
                        console.log(repoList);
                        if(repoList.length>0){
                            component.set("v.toBranchList",repoList)
                            return false;
                        }
                    })
                }
            });
            $A.enqueueAction(action);   
        }
    },
    checkLabelExist:function(component,event){
        var comp = event.getSource();
        var labelName = comp.get("v.value");
        if($A.util.isEmpty(labelName)){
            comp.set("v.errors", [{message: "Please Enter label."}]);
        }
        else{
            comp.set("v.errors", []);
            var spinnerComp = component.find("spinner");
            $A.util.removeClass(spinnerComp, "slds-hide");
            var action = component.get("c.isMergeLabelExist");
            action.setParams({
                "label":labelName
            })
            action.setCallback(this,function(res){
                var state = res.getState();
                if(state=="SUCCESS"){
                    var xml = JSON.parse(res.getReturnValue());
                    var xmlDoc = $.parseXML( xml.Resbody );
                    var $xml = $( xmlDoc );
                    var $return = $xml.find( "return" ).text();
                    if($return=='true'){
                        comp.set("v.errors", [{message: "Label is already existed!"}]);
                    }
                    $A.util.addClass(spinnerComp, "slds-hide");
                }
            });
            $A.enqueueAction(action);             
        }
    },
    getSCMRevisions:function(component,event){
        var spinnerComp = component.find("mTypeSpinner");
        $A.util.removeClass(spinnerComp, "slds-hide");
        var action = component.get("c.getSCMRevisions");
       	action.setParams({
            "reponame":component.get("v.story.reponame"),
            "branchname":component.get("v.story.branch"),
            "scmtype":component.get("v.story.scmtype")
        })
        action.setCallback(this,function(res){
            var state = res.getState();
            if(state=="SUCCESS"){
                var xml = JSON.parse(res.getReturnValue());
                var xmlDoc = $.parseXML( xml.Resbody );
                var $xml = $( xmlDoc );
                var $revisions = $xml.find( "return" ).text().split(',');
                component.set("v.mergeTypeList",$revisions);
            }
            $A.util.addClass(spinnerComp, "slds-hide");
        });
        $A.enqueueAction(action);
    },
    submitMergeRequest:function(component,event){
        var comp = event.getSource()
        var action = component.get("c.submitMergeRequest");
        action.setParams({
            "isdryrun":comp.get("v.label")=='Dry Run'?true:false,
            "frombranch":component.get("v.story.branch"),
            "mergelabelname":component.find("mergeLabelName").get("v.value"),
            "message":component.find("comment").get("v.value"),
            "reponame":component.get("v.story.reponame"),
            "scmtype":component.get("v.story.scmtype").toUpperCase(),
            "tobranch":component.find("toBranch").get("v.value"),
            "emailtolist":component.find("emailList").get("v.value")
        });
        action.setCallback(this,function(res){
            console.log(res.getState());
            console.log(res.getReturnValue());
        });
        $A.enqueueAction(action);
    }
})