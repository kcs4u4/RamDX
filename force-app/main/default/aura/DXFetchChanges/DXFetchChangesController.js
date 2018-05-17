({
    doInit : function(component, event, helper) {
   
    },
    storeDetails : function(component, event, helper) {
        var metadataMap = helper.getDataObj(component.get("v.metadataMap"));
        console.log('-------start--metadataMap--------------')
        
        var cls = event.target.className;
        var id = event.target.id;
        var metaParName = id.split('-')[0];
        var isChecked = event.target.checked;
        if(!metadataMap.hasOwnProperty(metaParName)){
            metadataMap[metaParName] =[];
        }
        if(cls=='metadata'){
            $("input[id^='"+id+"-']").prop("checked",isChecked);
            console.log(metadataMap);
            if(isChecked){
                var arr = [];
                $("input[id^='"+id+"-']").each(function(){
                    var obj={};
                    obj['filename'] = $(this).attr('data-filename');
                    obj['fullname'] = $(this).attr('name');
                    obj['manageablestate'] = $(this).attr('data-manageablestate');
                    obj['modifieddate'] = $(this).attr('data-modifieddate');
                    arr.push(obj);
                })
                metadataMap[metaParName] = arr;
            }
            else{
                if(metadataMap.hasOwnProperty(metaParName)){
                    delete metadataMap[metaParName];
                }
            }
            
        }
        else if(cls=='member'){
            var parId = id.split('-').slice(0,-1).join('-');
            var contentName = event.target.name;
            if(isChecked){
                var obj={};
                obj['filename'] = $("#"+id).attr('data-filename');
                obj['fullname'] = $("#"+id).attr('name');
                obj['manageablestate'] = $("#"+id).attr('data-manageablestate');
                obj['modifieddate'] = $("#"+id).attr('data-modifieddate');
                metadataMap[metaParName].push(obj);
                if($("input[id^='"+parId+"-']").length==$("input[id^='"+parId+"-']:checked").length){
                    $("#"+parId).prop("checked",true);   
                }                
            }
            else{
                var arr = $.grep(metadataMap[metaParName], function(value) {
                    return value.fullname != contentName;
                });
                console.log('------------arr------------------');
                console.log(arr);
                metadataMap[metaParName] = arr;
                if(arr.length==0){
                    delete metadataMap[metaParName];
                }
                $("#"+parId).prop("checked",false);
            }
        }
        console.log(metadataMap);
        component.set("v.metadataMap",metadataMap);
    },
    showMetadata : function(component, event, helper) {
        /*var nodeName = event.target.nodeName;
        if(nodeName!="INPUT"){
            $(event.srcElement).parents(".slds-section").toggleClass('slds-is-open');
        }*/
        console.log(event);
        var changesList = component.get("v.fetchChangesList");
        var index = event.target.dataset.index;
        if(index>=0){
            changesList[index].showMembers = !changesList[index].showMembers;
            component.set("v.fetchChangesList",changesList);
            console.log(changesList[index].showMembers);
        }
        $(event.srcElement).parents(".slds-section").toggleClass("slds-is-open");
    }
})