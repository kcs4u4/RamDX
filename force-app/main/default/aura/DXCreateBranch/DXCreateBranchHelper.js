({
    getRemoteBranches:function(comp){
        var action = comp.get('c.RemoteBranches');
        action.setParams({
            "reponame":comp.get("v.reponame")
        });
        action.setCallback(this,function(res){
            var state = res.getState();
            if(state == 'SUCCESS'){
                console.log(res.getReturnValue());
                var xml = JSON.parse(res.getReturnValue());
                var xmlDoc = $.parseXML( xml.Resbody );
                var $xml = $( xmlDoc );
                var $sos = $xml.find( "return" ).text();
                var brList = $sos.split(', ');
                
                console.log('------------RemoteBranches-----------------');
                console.log(brList);
                comp.set('v.RemoteBranches',brList);
                this.getBranchTypes(comp);
            }
        });
        $A.enqueueAction(action);
    },
    getBranchTypes:function(comp){
        var action = comp.get('c.BranchType');
        
        action.setCallback(this,function(res){
            var state = res.getState();
            if(state == 'SUCCESS'){
                console.log(res.getReturnValue());
                var xml = JSON.parse(res.getReturnValue());
                var xmlDoc = $.parseXML( xml.Resbody );
                var $xml = $( xmlDoc );
                var $sos = $xml.find( "return" ).text();
                var brtypes = $sos.split(',');
                
                console.log('------------BranchTypes-----------------');
                console.log(brtypes);
                comp.set('v.BranchTypes',brtypes);
            }
        });
        $A.enqueueAction(action);
    },
    getBranchList:function(component) {
        /*var action = component.get('c.SCMRepoDetails');
        action.setParams({
            "reponame":component.get("v.reponame")
        });
        action.setCallback(this,function(res){
            var state = res.getState();
            if(state == 'SUCCESS'){
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
                component.set("v.isModalVisible",false);
            }
        });
        $A.enqueueAction(action);*/
    }
})