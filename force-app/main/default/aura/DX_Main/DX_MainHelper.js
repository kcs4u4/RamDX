({
    createComponent : function(compName,attrObj,parentName,parentBody,component,tabTitle) {
        $A.createComponent(
            compName,attrObj,
            function(tab, status, errorMessage){
                //Add the new button to the body array
                if (status === "SUCCESS") {
                    parentBody.push(tab);
                    parentName.set("v.body", parentBody);
                }
                else if (status === "INCOMPLETE") {
                    console.log("No response from server or client is offline.")
                    // Show offline error
                }
                    else if (status === "ERROR") {
                        console.log("Error: " + errorMessage);
                        // Show error message
                    }
            });
    },
    showToast : function(msg,code,component) {
        /*var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": code!=200?"Error!":"Success!",
            "message": msg,
            "type": code!=200?"error":"success"
        });
        toastEvent.fire();*/
        component.find('notifLib').showToast({
            "variant": code!=200?"error":"success",
            "title": code!=200?"Error!":"Success!",
            "message": msg
        });
    },
    openTab:function(component,event,tabTitle,subCompName,isActive,ind,compAttrs){
        var navList = component.find("navList");
        var body = navList.get("v.body");
        var len = $("#navList").find("li").length;
        $("#navList").find("li").removeClass("slds-is-active");
        console.log('-----------isActive------------'+isActive);
        var attrObj = {
            "tabTile": tabTitle,
            "tabIndex":ind||parseInt(len+1),
            "isActive":isActive||"true"
        }
        this.createComponent("c:DXTab",attrObj,navList,body,tabTitle);
        var tabsList = component.find("tabpanelswrapper");
        body = tabsList.get("v.body");
        len = $("#tabpanelswrapper>div").length;
        attrObj = {
            "aura:id":"tabcontent"+parseInt(len+1),
            "compName":subCompName,
            "index":ind||parseInt(len+1),
            "isActive":isActive||"true",
            "compAttrs":compAttrs||{}
        }
        $("#tabpanelswrapper>div").removeClass("slds-show").addClass("slds-hide");
        this.createComponent("c:DXTabContent",attrObj,tabsList,body,component,tabTitle);
    },
    getAppLauncherOptions:function(component, event){
        var action = component.get('c.appLauncherOptions');
        action.setStorable();
        action.setCallback(this,function(res){
            var state = res.getState();
            if(state=="SUCCESS"){
                var arr = res.getReturnValue();
                arr.sort(function(a,b) {return (a.order__c > b.order__c) ? 1 : ((b.order__c > a.order__c) ? -1 : 0);} );
                component.set('v.appLauncherItems',arr);
            }
        });
        $A.enqueueAction(action);
    },
    userLogin:function(component, event){
        var action = component.get('c.userLogin');
        action.setCallback(this,function(res){
            var state = res.getState();
            if(state=="SUCCESS"){
                this.openOldTabs(component,event)
                this.getAppLauncherOptions(component, event);
            }
        });
        $A.enqueueAction(action);
    },
    getArrayObjectsIndex:function(arr,val,propName){
        var c;
        for(var i=0;i<arr.length;i++){
            if(arr[i][propName]==val){
                c=i;
                break;
            }
        }
        return (typeof c!="undefined") ?c:-1;
    },
    openOldTabs:function(component,event){
        var lst = JSON.parse(window.localStorage.getItem("activeListItems"));
        var indx = this.getArrayObjectsIndex(lst,true,'isActive');
        if(indx<0 && lst.length>0){
            lst[lst.length-1]['isActive'] = true;
        }
        var navList = component.find("navList");
        navList.set("v.body","");
        var tabsList = component.find("tabpanelswrapper");
        tabsList.set("v.body","");
        for(var i=0;i<lst.length;i++){
            var obj = lst[i];
            if(obj["tabTitle"]){
                this.openTab(component,event,obj["tabTitle"],obj["compName"],obj["isActive"].toString(),i+1,null);
            }
        }
        this.resetLoading(component);
    },
    refreshTabs:function(tabTitle){
        var lst = JSON.parse(window.localStorage.getItem("activeListItems"));
        for(var i=0;i<lst.length;i++){
            var obj = lst[i];
            if(obj["tabTitle"]!=tabTitle){
                obj.isActive = false;
            }
            else{
                obj.isActive = true;
            }
        }
        window.localStorage.setItem("activeListItems",JSON.stringify(lst));
    },
    connectCometd : function(component) {
        var helper = this;
        // Configure CometD
        var cometdUrl = window.location.protocol+'//'+window.location.hostname+'/cometd/39.0/';
        var cometd = component.get('v.cometd');
        cometd.configure({
            url: cometdUrl,
            requestHeaders: { Authorization: 'OAuth '+ component.get('v.sessionId')},
            appendMessageTypeToURL : false
        });
        cometd.websocketEnabled = false;
        cometd.handshake(function(handshakeReply) {
            console.log('------------handshakeReply.successful-------------'+handshakeReply.successful);
            if (handshakeReply.successful) {
                console.log('Connected to CometD.');
                // Establish CometD connection
                console.log('Connecting to CometD: '+ cometdUrl);
                console.log('Connecting to CometD: '+ component.get('v.sessionId'));
                helper.userLogin(component, event);
                cometd.subscribe('/event/Notification__e',
                                 function(platformEvent) {
                                     console.log('Platform event received: '+ JSON.stringify(platformEvent));
                                     var msg = platformEvent.data.payload.Message__c;
                                     if(msg.length>3)
                                     helper.showToast(msg,platformEvent.data.payload.statuscode__c,component);
                                 }
                                );
            }
            else{
                helper.userLogin(component, event);
            }
        })
    },
    closeItemHandler:function(component, event,htmlnode){
        var helper=this;
        var tabTitle = $(htmlnode).attr("title");
        var lst = JSON.parse(window.localStorage.getItem("activeListItems"));
        var closedTabIndex = helper.getArrayObjectsIndex(lst,tabTitle,'tabTitle');
        lst.splice(closedTabIndex,1);
        var panelId = $(htmlnode).attr("tabindex");
        if($(htmlnode).hasClass("slds-is-active") && $(htmlnode).next("li").length){
            $(htmlnode).next().addClass("slds-is-active");
            $("#tabpanelswrapper").find("div[id='context-tab-panel-"+$(htmlnode).next().attr('tabindex')+"']").removeClass("slds-hide").addClass("slds-show");
            if(lst[closedTabIndex+1]){
                lst[closedTabIndex+1]['isActive'] = true;
            }
        }
        else if($(htmlnode).hasClass("slds-is-active") && $(htmlnode).prev("li").length){
            $(htmlnode).prev().addClass("slds-is-active");
            $("#tabpanelswrapper").find("div[id='context-tab-panel-"+$(htmlnode).prev().attr('tabindex')+"']").removeClass("slds-hide").addClass("slds-show");
            if(lst[closedTabIndex-1]){
                lst[closedTabIndex-1]['isActive'] = true;
            }
        }
        $(htmlnode).remove();
        $("#tabpanelswrapper").find("div[id='context-tab-panel-"+panelId+"']").remove();
        window.localStorage.setItem("activeListItems",JSON.stringify(lst));
        return true;
    },
    resetLoading:function(comp){
        var bol = comp.get("v.isVisible");
        comp.set("v.isVisible",!bol)
    }
})