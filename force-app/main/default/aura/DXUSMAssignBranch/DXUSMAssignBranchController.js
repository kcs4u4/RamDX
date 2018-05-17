({
    doInit : function(component, event, helper) {
        console.log(component.get('v.story'));
        component.set("v.newBranchName",component.get('v.story.id'))
        helper.getDataFromXML(component,event,'UserRepositories',null,'repoList','repository');
    },
    assignBranch : function(component, event, helper) {
        var arrComp = component.find("btn");
        console.log(arrComp.length);
        for(var i=0;i<arrComp.length;i++){
            $A.util.removeClass(arrComp[i], "slds-button--brand");
        }
        var comp = event.getSource();
        var branchType = comp.get('v.name')
        $A.util.addClass(comp, "slds-button--brand");
        component.set("v.branchType",comp.get('v.name'));
        component.find("repo").set("v.value","");
        component.set("v.errorCount",0);
        if(branchType=='new-branch'){
            component.find("parentBranch").set("v.value","");
            component.find("branchType").set("v.value","");
        }
        else if(branchType=='registered-branch'){
            component.find("rbranch").set("v.value","");
        }
            else if(branchType=='assign-branch'){
                component.find("abranch").set("v.value","");
                component.find("expdate").set("v.value","");    
            }  
        
    },
    getBranches : function(component, event, helper) {
        var comp = event.getSource();
        var branchType = component.get("v.branchType");
        var repoDetails = comp.get('v.value').split('-');
        var repo = repoDetails[0];
        if(repo.length>0){
            console.log(repo.length);
            //component.set("v.story.reponame",repo);
            if(branchType=='new-branch'){
                var paramObj = {"reponame":repo};
                helper.getDataFromTEXT(component,event,'RemoteBranches',paramObj,'branchList','return');
                helper.getDataFromTEXT(component,event,'BranchType',null,'branchTypes','return');
                //component.set("v.story.branch",component.get("v.story.id"));
            }
            else if(branchType=='registered-branch'){
                var paramObj = {"reponame":repo};
                helper.getDataFromXML(component,event,'Branches',paramObj,'ARBranchList','branch');
            }
                else if(branchType=='assign-branch'){
                    var paramObj = {"reponame":repo};
                    helper.getDataFromTEXT(component,event,'RemoteBranches',paramObj,'branchList','return');
                }
        }
        else{
            component.set("v.story.reponame","");
            component.set("v.story.branch","");
        }
    },
    cancel:function(component,event,helper){
        component.set("v.currComp","");
    },
    checkDate : function(component, event, helper) {
        var comp = event.getSource();
        helper.checkDate(component,comp);
    },
    createBranch : function(component, event, helper) {
        var branchType = component.get("v.branchType");
        var repo = component.find("repo");
        repo.showHelpMessageIfInvalid();
        helper.validateData(component,repo)
        console.log(repo.get("v.validity.valueMissing"));
        var errorCount = component.get("v.errorCount");
        if(branchType=='new-branch'){
            var isSfdx = component.get("v.isSfdx");
            var parentBranch = component.find("parentBranch");
            var branchType = component.find("branchType");
            var branchname = component.find("newbranchname");
            if(isSfdx){
                var sfdxFolderName = component.find("folderName");
                helper.validateData(component,sfdxFolderName);
            }
            helper.validateData(component,parentBranch);
            helper.validateData(component,branchType);
            helper.validateData(component,branchname);
            if(errorCount==0){
                var paramsObj = {};
                var repoDetails = repo.get("v.value").split('-');
                var repoName = repoDetails[0];
                var scmtype = repoDetails[1];
                var url = repoDetails[2];
                paramsObj["createdby"]="";
                paramsObj["reponame"]=repoName;
                paramsObj["type"]=branchType.get("v.value");
                paramsObj["parent"]=parentBranch.get("v.value");
                paramsObj["name"]=branchname.get("v.value");
                paramsObj["scmtype"]=scmtype;
                paramsObj["url"]=url;
                paramsObj["almworkitemid"]=component.get('v.story.id');
                paramsObj["sfdxfoldername"]= isSfdx?sfdxFolderName.get("v.value"):""; 
                console.log(paramsObj);
                helper.createBranch(component,event,"createBranchOnALMStory",paramsObj);
            }
        }
        else if(branchType=='registered-branch'){
            var rbranch = component.find("rbranch");
            helper.validateData(component,rbranch);
            if(errorCount==0){
                var paramsObj = {};
                var repoDetails = repo.get("v.value").split('-');
                var repoName = repoDetails[0];
                var scmtype = repoDetails[1];
                var url = repoDetails[2];
                paramsObj["reponame"]=repoName;
                paramsObj["name"]=rbranch.get("v.value");
                paramsObj["almworkitemid"]=component.get('v.story.id');
                paramsObj["url"]=url;
                paramsObj["scmtype"]=scmtype;
                console.log(paramsObj);
                helper.createBranch(component,event,"assignBranchOnALMStory",paramsObj);
            }
        }
            else if(branchType=='assign-branch'){
                var abranch = component.find("abranch");
                var expdate = component.find("expdate");
                helper.validateData(component,abranch);
                helper.checkDate(component,expdate);
                if(errorCount==0){
                    var paramsObj = {};
                    var repoDetails = repo.get("v.value").split('-');
                    var repoName = repoDetails[0];
                    var scmtype = repoDetails[1];
                    var url = repoDetails[2];
                    paramsObj["reponame"]=repoName;
                    paramsObj["almworkitemid"]=component.get('v.story.id');
                    paramsObj["url"]=url;
                    paramsObj["scmtype"]=scmtype;
                    paramsObj["name"]=abranch.get("v.value");
                    paramsObj["lcd"]=expdate.get("v.value");
                    console.log(paramsObj);
                    helper.createBranch(component,event,"registerBranchOnAlmStrory",paramsObj);
                }
            }  
    }
})