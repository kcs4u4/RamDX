({
    getAlmType:function(comp,event, helper){
        comp.set("v.isVisible",true);
        var action = comp.get('c.Plugins');
        action.setCallback(this,function(res){
            var state = res.getState();
            if(state == 'SUCCESS'){
                var xml = JSON.parse(res.getReturnValue());
                var xmlDoc = $.parseXML( xml.Resbody );
                var $xml = $( xmlDoc );
                var $sos = $xml.find( "plugin" );
                var AlmList = [];
                console.log($sos);
                $sos.each(function(){
                    var obj = {};
                    $.each(this.attributes, function() {
                        obj[this.name] = this.value;
                    });
                    if(obj.enabled && obj.type=="RM")
                        AlmList.push(obj);
                });
                comp.set('v.AlmType',AlmList);
                comp.set('v.UserManagement.Almtype',AlmList[0].uilabel);
                this.getProjects(comp);
            }
        });
        $A.enqueueAction(action);
    },
    getProjects:function(comp){
        comp.set("v.isVisible",true);
        var action = comp.get("c.ProjectsFromConnectors");
        var almType = comp.get('v.UserManagement.Almtype');
        if(almType!="Select"){
            action.setParams({
                "connectortype":almType.toLowerCase()
            })
            action.setCallback(this,function(res){
                var state = res.getState();
                var response = JSON.parse(res.getReturnValue());
                if(state=="SUCCESS" && response.statusCode==200){
                    var xml = response.Resbody;
                    this.setList(comp,xml,'project','AlmProjects');
                }
                comp.set("v.isVisible",false);
            })
            $A.enqueueAction(action);
        }
    },
    getSprints:function(comp){
        comp.set("v.isVisible",true);
        var action = comp.get("c.PlannedForListFromALM");
        var almType = comp.get('v.UserManagement.Almtype');
        var almProject = comp.get('v.UserManagement.AlmProject');
        var almProjId = this.getId(comp.get("v.AlmProjects"),almProject);
        
        if(almProject!="Select"){
            comp.set('v.UserManagement.almProjId',almProjId);
            action.setParams({
                "connectortype":almType.toLowerCase(),
                "projectkey":almProjId
            })
            action.setCallback(this,function(res){
                var state = res.getState();
                var response = JSON.parse(res.getReturnValue());
                if(state=="SUCCESS" && response.statusCode==200){
                    var xml = response.Resbody;
                    this.setList(comp,xml,'PlannedFor','AlmSprints');
                }
            })
            $A.enqueueAction(action);
        }
    }, 
    getStories:function(comp){
        comp.set("v.isVisible",true);
        var action = comp.get('c.AlmStories');
        action.setParams({
            'projectkey':comp.get('v.UserManagement.almProjId'),
            'connectortype':comp.get('v.UserManagement.Almtype'),
            'key':comp.get('v.UserManagement.PlannedFor'),
            'id':this.getId(comp.get("v.AlmSprints"),comp.get('v.UserManagement.PlannedFor'))
        })
        action.setCallback(this,function(res){
            var state = res.getState();
            var response = JSON.parse(res.getReturnValue());
            if(state=="SUCCESS" && response.statusCode==200){
                var xml = response.Resbody;
                this.setList(comp,xml,'workitem','AlmUserStories');
            }
        })
        $A.enqueueAction(action);
    },
    getId:function(arr,name){
        return $.grep( arr, function( obj, i ) {
            return obj.name==name;
        })[0].id; 
    },
    setList:function(comp,xml,findFor,varList){
        var xmlDoc = $.parseXML( xml );
        var $xml = $( xmlDoc );
        var $keys = $xml.find(findFor);
        var list = [];
        $keys.each(function() {
            var obj = {};
            $.each(this.attributes, function() {
                obj[this.name] = this.value;
                
            });
            var storyObj = comp.get("v.story");
            if(findFor=='workitem'){
                obj['description'] = $(this).find('description').text().replace("<![CDATA[", "").replace("]]>", "").replace("<![CDATA[", "").replace("]]>", "");
                obj['description'] = obj['description']!='null'?obj['description']:obj['name'];
            }
            if(storyObj){
                if(storyObj.id==obj.id){
                    comp.set("v.story",obj);
                } 
            }
            
            list.push(obj)
        });
        console.log(list);
        comp.set('v.'+varList,list);
        comp.set("v.isVisible",false);
    }
})