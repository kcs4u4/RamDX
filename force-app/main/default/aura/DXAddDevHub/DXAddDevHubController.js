({
    hideModal:function(component, event, helper) {
        helper.setEvent(component);
    },
    addDevHub:function(component, event, helper) {
        var c=0;
        var username = component.find("username");
        var usernameValue = username.get("v.value");
        var alias = component.find("alias");
        var aliasValue = alias.get("v.value");   
        var sfurl = component.find("sfurl");
        var sfurlValue = sfurl.get("v.value"); 
        helper.clearMessages([username,alias]);
        if($A.util.isEmpty(usernameValue)){
            c++;
            username.set("v.errors", [{message: "Please Enter username."}]);
        }
        else{
            var regExpEmailformat = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            if(!usernameValue.match(regExpEmailformat)){
                c++;
                username.set("v.errors", [{message: "Please Enter a Valid Email Address."}]);
            }
        }
        if($A.util.isEmpty(aliasValue)){
            c++;
            alias.set("v.errors", [{message: "Please Enter alias."}]);
        }
        if($A.util.isEmpty(sfurlValue)){
            c++;
            sfurl.set("v.errors", [{message: "Please enter valid Salesforce Org Url."}]);
        }
        if(c==0){ 
            helper.setEvent(component);
            var DX_ClientId = $A.get("$Label.c.DX_ClientId");
            
            window.location.href=sfurlValue+'/services/oauth2/authorize?response_type=code&client_id='+DX_ClientId+'&redirect_uri=https://ramdx-dev-ed.lightning.force.com/one/one.app&prompt=login&login_hint='+usernameValue+'&state={"name":"'+usernameValue+'","alias":"'+aliasValue+'","nav":"DXHubManagement"}';
        }
    },
    checkEnvironment : function(component, event, helper) {
        var objEnv = {
            'Production or Development Edition':'https://login.salesforce.com',
            'SandBox':'https://test.salesforce.com',
            'Pre-Release':'https://prerellogin.pre.salesforce.com',
            'Custom URL':''
        }
        var env = component.get("v.sfOrgMap.env");
        component.set("v.sfOrgMap.sfurl",objEnv[env]);
    }
})