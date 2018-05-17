({
    init: function (cmp) {
        cmp.set('v.past', Date.now());
        cmp.set('v.future', Date.now());
    },
     openTab : function(component, event, helper) {
        var workspaceAPI = component.find("workspace");
        workspaceAPI.openTab({
            url: '#/sObject/0037F00000UVWSl/view',
            focus: true
        });
    },
    
    recordSaved:function(comp,event,helper){
        //console.log(comp.find('test').find('button').get('v.label'));
        //var eve = comp.find("edit").get('e.recordSave').fire();
        //console.log(eve);
        var cmps = comp.find("test");
        console.log(cmps.length);
        for(var i=0;i<cmps.length;i++){
          var cmp = cmps[i];
            cmp.find("con").submit();
        }
    }
})