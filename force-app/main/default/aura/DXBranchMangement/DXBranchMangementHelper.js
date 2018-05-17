({
	getBranchList:function(component) {
        component.set("v.isVisible",true);
        var action = component.get('c.SCMRepoDetails');
        action.setParams({
            "reponame":component.get("v.reponame")
        });
        action.setCallback(this,function(res){
            var state = res.getState();
            if(state == 'SUCCESS' && res.getReturnValue()!=null){
                var response = JSON.parse(res.getReturnValue())
                var xml = response.Resbody;
                var xmlDoc = $.parseXML( xml );
                var $xml = $( xmlDoc );
                var $keys = $xml.find('branch');
                var list = [];
                $keys.each(function() {
                    var obj = {};
                    $.each(this.attributes, function() {
                        if(this.specified) {
                            obj[this.name] = this.value;
                        }
                    });
                    list.push(obj)
                });
                console.log(list);
                component.set("v.branchList",list);
                component.set("v.isVisible",false);
            }
        });
        $A.enqueueAction(action);
    }
})