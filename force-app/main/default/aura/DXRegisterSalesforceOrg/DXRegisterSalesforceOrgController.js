({
    checkEnvironment : function(component, event, helper) {
        var objEnv = {
            'Production or Development Edition':'https://login.salesforce.com',
            'SandBox':'https://test.salesforce.com',
            'Pre-Release':'https://prerellogin.pre.salesforce.com',
            'Custom URL':''
        }
        var env = component.get("v.sfRegMap.env");
        component.set("v.sfRegMap.sfurl",objEnv[env]);
    },
    checkValidation : function(component, event, helper) {
        var c=0;
        var auth = component.get("v.auth");
        var dataObj = helper.getDataObj(component.get("v.sfRegMap"));
        var hubInfo = helper.getDataObj(component.get("v.hubInfo"));
        var sforgname = component.find("sforgname");
        var sforgnameValue = sforgname.get("v.value");
        helper.clearMessages([sforgname]);
        if($A.util.isEmpty(sforgnameValue)){
            c++;
            sforgname.set("v.errors", [{message: "Please Enter Saleforce Org Name."}]);
        }
        
        if(auth=='Standard'){
            var username = component.find("User_Name");
            var usernameValue = username.get("v.value");
            var password = component.find("Password");
            var passwordValue = password.get("v.value");
            var SecurityToken = component.find("Security_Token");
            var SecurityTokenValue = SecurityToken.get("v.value");        
            helper.clearMessages([username,password,SecurityToken]);
            if($A.util.isEmpty(usernameValue)){
                c++;
                username.set("v.errors", [{message: "Please Enter User Name."}]);
            }
            if($A.util.isEmpty(passwordValue)){  
                c++;
                password.set("v.errors", [{message: "Please Enter password."}]);
            }
            if($A.util.isEmpty(SecurityTokenValue)){
                c++;
                SecurityToken.set("v.errors", [{message: "Please Enter Security Token."}]);
            }
            if(c==0){
                var action = component.get("c.registerSFOrgs");
                action.setParams(dataObj);
                action.setCallback(this,function(res){
                    var state = res.getState();
                    helper.showToast(JSON.parse(res.getReturnValue()));
                    var cmpEvent = component.getEvent("cmpEvent");
                    cmpEvent.setParams({
                        "flag":component.set("v.isNew")
                    })
                    cmpEvent.fire();
                    component.set("v.isNew",false);
                });
                $A.enqueueAction(action)
            }
        }
        else if(auth == "OAuth"){
            var clientId    = $A.get("$Label.c.DX_ClientId");
            var callbackUrl = $A.get("$Label.c.DX_CallbackURL");
            var sfurl = component.get("v.sfRegMap.sfurl");
            var stateObj = {"data":dataObj,"hubInfo":hubInfo,"nav":'HubManagement'};
            console.log(hubInfo);
            if(c==0){
                window.location.href=sfurl+'/services/oauth2/authorize?response_type=code&client_id=3MVG9d8..z.hDcPLKhdv4nBvYennLRz7oaJgYAQkeidSxL.Jycc2jPtZFPY9.KHcMS7CSJ8SGpdzdWgdZT__N&redirect_uri=https://ramdx-dev-ed.lightning.force.com/one/one.app&prompt=login&state={"data":{"sforgname":"'+dataObj.sforgname+'","orgtype":"'+dataObj.orgtype+'","env":"'+dataObj.env+'","sfurl":"'+sfurl+'"},"nav":"SFOrgReg"}';
            }
        }
        
    },
    cancel:function(component, event, helper){
        component.set('v.isNew',false);
    }
})