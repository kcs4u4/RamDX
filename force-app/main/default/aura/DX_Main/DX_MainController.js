({
    scriptsLoaded:function(component, event, helper) {
        var cometdUrl = window.location.protocol+'//'+window.location.hostname+'/cometd/40.0/';
        var action = component.get('c.getSessionId');
        helper.resetLoading(component);
        action.setStorable();
        action.setCallback(this,function(res){
            var cometd = new org.cometd.CometD();
            component.set('v.cometd', cometd);
            component.set('v.sessionId', res.getReturnValue());
            helper["connectCometd"](component,event);
        });
        $A.enqueueAction(action);
        
        if(!window.localStorage.getItem("activeListItems")){
            window.localStorage.setItem("activeListItems", "[]");
        }
        var url_string = window.location.href;
        var url = new URL(url_string);
        var c = url.searchParams.get("0.code");
        var state = url.searchParams.get("0.state");
        var objVal = JSON.parse(state); 
        if(c && objVal.nav=='DXHubManagement'){
            console.log('--------------------DXHubManagement------------------');
            var action = component.get('c.createDevhub');
            action.setStorable();
            action.setParams({
                "devUsername":objVal.name,
                "hubname":objVal.alias,
                "code":c
            })
            action.setCallback(this,function(res){
                console.log('res');
                console.log(res.getReturnValue());
                var state = res.getState();
                var resp = JSON.parse(res.getReturnValue());
                var xmlDoc = $.parseXML(resp.Resbody);
                var $xml = $( xmlDoc );
                var $hubs = $xml.find( "faultstring,return" );
                var statusMsg = $hubs.text();
                helper.showToast(statusMsg,resp.statusCode,component)
            })
            $A.enqueueAction(action);
        }
        else if(c && objVal.nav=='SFOrgReg'){
            console.log('--------------------SFOrgReg------------------');
            var dataObj = objVal.data;
            var action = component.get('c.SFOrgsWithOAuth');
            action.setStorable();
            dataObj.code = c;
            action.setParams(dataObj);
            action.setCallback(this,function(res){
                var state = res.getState();
                var resp = JSON.parse(res.getReturnValue());
                var xmlDoc = $.parseXML(resp.Resbody);
                var $xml = $( xmlDoc );
            })
            $A.enqueueAction(action);
        }
    },
    addTab : function(component, event, helper) {
        var obj = event.getParam("appLauncher");
        var tabTitle  = obj['tabTitle'];
        var compName  = obj['compName'];
        var isCached  =  obj['isCached'];
        var compAttrs = obj['compAttrs'];
        obj.isActive = true;
        var lst = JSON.parse(window.localStorage.getItem("activeListItems"));
        var indx = helper.getArrayObjectsIndex(lst,tabTitle,'tabTitle');
        if(indx<0 && compName){
            helper.openTab(component,event,tabTitle,compName,null,null,compAttrs);
            if(isCached=="true"){
                lst.push(obj);
                window.localStorage.setItem("activeListItems",JSON.stringify(lst));
                helper.refreshTabs(tabTitle);
            }
        }
        else if(indx>=0 && compName){
            var accpt = window.confirm("Opening a different page with in this module will overwrite your content, do you wish to proceed?");
            if(accpt){
                helper.closeItemHandler(component, event,$("#navList li:eq("+indx+")")); 
                var closedTabIndex = helper.getArrayObjectsIndex(lst,tabTitle,'tabTitle');
                lst.splice(closedTabIndex,1);
                helper.openTab(component,event,tabTitle,compName,null,null,compAttrs);
                if(isCached=="true"){
                    lst.push(obj);
                    window.localStorage.setItem("activeListItems",JSON.stringify(lst));
                    helper.refreshTabs(tabTitle);
                }
            }
        }
            else if(tabTitle=="Salesforce Home"){
                window.localStorage.clear();
                var url = window.location.origin+"/one/one.app#/setup/home";
                window.location.href = url; 
            }
        component.set("v.isAppLauncherVisible",false);
    },
    handleListItems:function(component, event, helper){
        var htmlnode = event.getParam("htmlnode");
        var $htmlnode = $(htmlnode);
        var listClass = $htmlnode.attr('class').split(" ")[0];
        $("."+listClass).removeClass("slds-is-active");
        $htmlnode.addClass("slds-is-active");
        var panelId = $htmlnode.attr("tabindex");
        $("#tabpanelswrapper").find("div[id^='context-tab-panel']").removeClass("slds-show").addClass("slds-hide");
        $("#tabpanelswrapper").find("div[id='context-tab-panel-"+panelId+"']").removeClass("slds-hide").addClass("slds-show");
        helper.refreshTabs($htmlnode.attr("title"));
    },
    closeItem:function(component, event, helper){
        var htmlnode = event.getParam("htmlnode");
        helper.closeItemHandler(component, event,htmlnode);
    },
    appLauncherTrigger:function(component, event, helper) {
        var isVisible = component.get("v.isAppLauncherVisible");
        component.set("v.isAppLauncherVisible",!isVisible);	
    },
    showAlert:function(component,event,helper){
        component.find('notifLib').showNotice({
            "variant": event.getParam("variant"),
            "header": event.getParam("header")||"",
            "message":event.getParam("message"),
            closeCallback: function() {
                return false;
            }
        });
    }
})