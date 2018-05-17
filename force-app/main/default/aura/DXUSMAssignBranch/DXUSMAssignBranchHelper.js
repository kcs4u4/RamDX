({
    getDataFromXML : function(component,event,actName,paramObj,attrName,findTag) {
        var action = component.get("c."+actName);
        if(!$A.util.isUndefinedOrNull(paramObj)){
            action.setParams(paramObj);
        }
        action.setCallback(this,function(res){
            var state = res.getState();
            var response = JSON.parse(res.getReturnValue());
            console.log(response);
            if(state=='SUCCESS'){
                var xmlDoc = $.parseXML( response.Resbody );
                var $xml = $( xmlDoc );
                var $sos = $xml.find(findTag);
                var list = [];
                $sos.each(function(){
                    var obj = {};
                    $.each(this.attributes, function() {
                        obj[this.name] = this.value;
                    });
                    list.push(obj)
                });
                console.log(list);
                component.set("v."+attrName,list);
            }
        });
        $A.enqueueAction(action);
    },
    getDataFromTEXT : function(component,event,actName,paramObj,attrName,findTag) {
        var action = component.get("c."+actName);
        if(!$A.util.isUndefinedOrNull(paramObj)){
            action.setParams(paramObj);
        }
        action.setCallback(this,function(res){
            var state = res.getState();
            var response = JSON.parse(res.getReturnValue());
            console.log(response);
            if(state=='SUCCESS'){
                var xmlDoc = $.parseXML( response.Resbody );
                var $xml = $( xmlDoc );
                var list = $xml.find(findTag).text().split(',');
                console.log(list);
                component.set("v."+attrName,list);
            }
        });
        $A.enqueueAction(action);
    },
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
    checkDate:function(component,comp){
        var today = new Date();
        var day = comp.get('v.value');
        var errorCount = component.get("v.errorCount");
        if($A.localizationService.isAfter(day, today)|| $A.util.isEmpty(day)){
            comp.set("v.errors", [{message: "Please enter valid date."}]);
            errorCount++;
            component.set("v.errorCount",errorCount);
        }
        else{
            comp.set("v.errors", [{message: ""}]);
            if(errorCount>0){
                errorCount--;
           	    component.set("v.errorCount",errorCount);
            }
        }
    },
    createBranch:function(component,event,actionName,paramObj){
       var action = component.get("c."+actionName);
       action.setParams(paramObj);
        action.setCallback(this,function(res){
         	var state = res.getState();
            if(state=="SUCCESS"){
                var story = component.get('v.story');
                story['reponame'] = paramObj['reponame'];
                story['branch'] = paramObj["name"];
                story['repourl'] = paramObj["url"];
                story['scmtype'] = paramObj['scmtype']
                component.set('v.story',story);
                component.set("v.currComp","");
            }
        })
       $A.enqueueAction(action); 
    }
})