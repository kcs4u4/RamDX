/** Client-Side Controller **/
({
    doInit: function (component, event, helper) {
        component.find("submit").onClick();
        console.log(component.find("submit").get("e.click").fire());
         // Prepare a new record from template
        /*component.find("forceRecordCmp").getNewRecord(
            "Contact", // sObject type (entityAPIName)
            null,      // recordTypeId
            false,     // skip cache?
            $A.getCallback(function() {
                var rec = component.get("v.obj");
                var error = "";
                if(error || (rec === null)) {
                    console.log("Error initializing record template: " + error);
                }
                else {
                    console.log('----------------------');
                }
            })
        );*/
    },
    initialize: function (component, event, helper) {
        /*$A.createComponent("c:DXtooltip",{"text":component.getReference("v.text")}, function(comp, status, errorMessage){
            var wrapper = component.find("main");
            wrapper.set("v.body",comp);
        });
        var options = [
            { value: "1", label: "Option 1" },
            { value: "2", label: "Option 2" },
            { value: "3", label: "Option 3" },
            { value: "4", label: "Option 4" },
            { value: "5", label: "Option 5" },
            { value: "6", label: "Option 6" },
            { value: "7", label: "Option 7" },
            { value: "8", label: "Option 8" },
        ];
        var values = ["7", "2", "3"];
        var required = ["2", "7"];
        component.set("v.listOptions", options);
        component.set("v.defaultOptions", values);
        component.set("v.requiredOptions", required);
        component.set("v.htmlstr","<b>Hello World!</b>");*/
    },
    handleChange: function (cmp, event) {
        // Get the list of the "value" attribute on all the selected options
        var selectedOptionsList = event.getParam("value");
        alert("Options selected: '" + selectedOptionsList + "'");
    },
    setData: function (cmp, event) {
        cmp.find("main").getElement().innerHTML="Welcome";
    },
    getDetails: function(component, event, helper) {
        var comp = event.srcElement;
        
        console.log('---------------------------getAlmProjects----------------------'+$A.getRoot().get("v.empname"));
    },
    showMessage: function(component, event, helper) {
        console.log('----------------showMessage-----------');
    },
    scriptsLoaded: function(component, event, helper) {
        var fixHelperModified = function(e, tr) {
            var $originals = tr.children();
            var $helper = tr.clone();
            $helper.children().each(function(index) {
                $(this).width($originals.eq(index).width())
            });
            return $helper;
        }
        var updateIndex = function(e, ui) {
                $('td.index', ui.item.parent()).each(function (i) {
                    $(this).html(i + 1);
                });
            var sortedIDs = $( ".slds-table tbody" ).sortable( "toArray" );
            console.log(sortedIDs);
            };
        
        $(".slds-table tbody").sortable({
            helper: fixHelperModified,
            stop: updateIndex
        }).disableSelection();
    },
    recordSaved:function(comp,event,helper){
        //console.log(comp.find('test').find('button').get('v.label'));
        //var eve = comp.find("edit").get('e.recordSave').fire();
        //console.log(eve);
        /*var cmps = comp.find("test");
        console.log(cmps.length);
        for(var i=0;i<cmps.length;i++){
          var cmp = cmps[i];
            cmp.find("con").submit();
        }*/
        comp.find("forceRecordCmp").saveRecord($A.getCallback(function(saveResult) {
            console.log(saveResult.state);
        }));
        console.log(comp.get("v.record.AccountId"));
    },
    handleClicked:function(comp,event,helper){
        console.log(event);
    }
})