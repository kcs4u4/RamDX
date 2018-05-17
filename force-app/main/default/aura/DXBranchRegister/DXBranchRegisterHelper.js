({
    convertStringArray : function(arr) {
        var list = [];
        for(var i=0;i<arr.length;i++){
            if(arr[i]['isSel'])
                list.push(JSON.stringify(arr[i]));
        }
        return list;
    },
    getRemoteBranches:function(comp){
        comp.set("v.isVisible",true);
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
                var nameList = comp.get("v.branchNamesList");
                var newList = $(brList).not(nameList).get();
                var newRemoteBranches = [];
                for(var i=0;i<newList.length;i++){
                    var obj = {};
                    obj['name']=newList[i];
                    obj['date']='';
                    obj['isSel']=false;
                    newRemoteBranches.push(obj);
                } 
                console.log(newRemoteBranches);
                comp.set('v.newRemoteBranches',newRemoteBranches);
            }
            comp.set("v.isVisible",false);
        });
        $A.enqueueAction(action);
    }
})