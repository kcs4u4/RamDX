({
    cancel : function(component, event, helper) {
        component.set('v.isModal',false);
    },
    addLabel : function(component, event, helper) {
        var LabelName = component.find("LabelName");
        var LabelNameValue = LabelName.get("v.value");
        if($A.util.isEmpty(LabelNameValue)){
            LabelName.set("v.errors", [{message: "Please Enter label name."}]);
        }
        else{
            var action = component.get("c.CommitLabelExist");
            action.setParams({
                "repoid":component.get("v.fetchChangesMap.repoid"),
                "branch":component.get("v.fetchChangesMap.branch"),
                "labelname":component.get('v.customLabel.label')
            });
            action.setCallback(this,function(res){
                console.log(res.getReturnValue());
                var response = JSON.parse(res.getReturnValue());
                var state = res.getState();
                if(state=="SUCCESS" && response['statusCode']==200){
                    var xml = response.Resbody;
                    var xmlDoc = $.parseXML( xml );
                    var $xml = $( xmlDoc );
                    var isExist = $xml.find('return').text();
                    if(isExist=='false'){
                        var customLabels = component.get('v.customLabels');
                        var label = component.get('v.customLabel.label');
                        if(label){
                            var obj = {};
                            obj.name = label;
                            customLabels.push(obj);
                            component.set('v.customLabels',customLabels);
                        }
                        component.set('v.isModal',false);
                    }
                    else{
                        LabelName.set("v.errors", [{message: "Label name is already existed."}]);
                    }
                }
                
            });   
            $A.enqueueAction(action); 
        }
    }
})