({
    doInit:function(component, event, helper){
        var url_string = window.location.href;
        var url = new URL(url_string);
        var c = url.searchParams.get("code");
        if(c){
            var url1 = window.location.href.split('?')[0];
            var compCode = window.location.href.split('?')[1].split('#')[1];
            window.location.href = url1+"#"+compCode; 
        }
       helper.getSandboxesHistory(component, event);
    },
    showModal:function(component, event, helper){
        component.set('v.isNew',true);
    },
    deleteScrOrg:function(component, event, helper){
        var action = component.get("c.deleteSFOrg");
        var $org = $(event.srcElement).parents("a");
        action.setParams({
            "orgId":$org.attr("data-sforgid"),
            "orgLabel":$org.attr("data-sforgname")
        });
        console.log($org.attr("data-sforgid"));
        action.setCallback(this,function(res){
             helper.getSandboxesHistory(component, event);
        });
        $A.enqueueAction(action);
    }
})