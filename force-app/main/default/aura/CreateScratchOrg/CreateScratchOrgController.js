({
    doInit:function(component, event, helper) {
        helper.getData(component,'getDxFeatures','dxFeatures');
        helper.getData(component,'getDxOrgPreference','dxOrgPreferences');
        helper.getData(component,'getCountryDetails','dxCountries');     
        helper.getData(component,'getLanguageDetails','dxLanguages');  
    },
    hideModal:function(component, event, helper) {
        helper.setEvent(component);
    },
    addScrOrg:function(component, event, helper) {
        var c=0;
        var username = component.find("username");
        var usernameValue = username.get("v.value");
        var alias = component.find("alias");
        var aliasValue = alias.get("v.value"); 
        var sfedition=component.find("dxEdition"); 
        var sfeditionValue=sfedition.get("v.value");
        var days = component.find("days");
        var daysVal = days.get("v.value");
        var preferences = $("#OrgPreferences").val()?$("#OrgPreferences").val().join(';'):"";
        var features = $("#dxFeatures").val()?$("#dxFeatures").val().join(';'):"";
        var country = $("#country :selected").index()>0?$("#country :selected").val():"";
        var lang = $("#dxLanguages :selected").index()>0?$("#dxLanguages :selected").val():"";
        
        
        helper.clearMessages([username,alias,sfedition]);
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
            alias.set("v.errors", [{message: "Please enter alias."}]);
        }
        
        if($A.util.isEmpty(daysVal)){
            c++;
            days.set("v.errors", [{message: "Please enter duration."}]);
        }
        if(c==0){
            
            component.set('v.isVisible',true);
            //$('.demo-only,.slds-backdrop,.slds-modal__container').css('visibility','hidden');
           
            var action = component.get('c.newCreateScracthOrg');
            action.setParams({"dataMap":{
                "hubid":component.get('v.hubid'),
                "hubname":component.get('v.hubalias'),
                "hubuserid":component.get('v.hubusername'),
                "hubkey":component.get('v.hubalias').toLowerCase(),
                "name":aliasValue,
                "orgusername":usernameValue,
                "edition":sfeditionValue,
                "features":features,
                "Preferences":preferences,
                "almuserstoryid":component.get("v.almuserstoryid"),
                "durationdays":daysVal,
                "hassampledata":component.find("sampledata").get("v.value").toString(),
                "organization":component.find("organization").get("v.value"),
                "adminemail":component.find("email").get("v.value"),
                "country":country,
                "language":lang,
                "description":component.find("description").get("v.value")
            }});
            action.setCallback(this,function(res){
                var state = res.getState();
                var resData = JSON.parse(res.getReturnValue());
                var statusCode = resData.statusCode;
                var msg=resData.Response;
                var xml = resData.Resbody
                var xmlDoc = $.parseXML( xml );
                var $xml = $( xmlDoc );
                var $sos = statusCode == 200?$xml.find( "return" ):$xml.find( "faultstring" );
                msg = $sos.text();
                //helper.showToast(msg,statusCode);                
                if(state=="SUCCESS"){
                    component.set('v.isVisible',false);
                    var almid = component.get("v.almuserstoryid");
                    if($A.util.isEmpty(almid)){
                        var cmpEvent = component.getEvent("refreshSoList");
                    	cmpEvent.fire(); 
                        helper.setEvent(component);
                    }
                    else{
                        var cmpEvent = component.getEvent("refreshStories");
                        cmpEvent.fire();
                        component.set("v.currComp","");
                    }
                }
            });
            console.log('scr entered');
            $A.enqueueAction(action);
            
        }        
    }  
})