({
    clearMessages : function(arrComps) {
        for(var i=0;i<arrComps.length;i++){
            arrComps[i].set("v.errors", [{message: ""}]);
        }
    },
    hideModal:function(component) {
        component.set("v.flag",false);
        component.set("v.accflag",false);
    },
    resetFlags:function(component,arrFlags) {
        for(var i=0;i<arrFlags.length;i++){
            component.set("v."+arrFlags[i],false);
        }
    },
    setFlags:function(component,arrFlags) {
        for(var i=0;i<arrFlags.length;i++){
            component.set("v."+arrFlags[i],true);
        }
    },
    checkInput : function(comp,id,msg) {
        var curEle = comp.find(id);
        var curEleValue = curEle.get("v.value");
        if($A.util.isEmpty(curEleValue)){
            this.countErrors(comp);
            curEle.set("v.errors", [{message: msg}]);
        }
        else{
            curEle.set("v.errors", '');
        }
    },
    checkInputSelect : function(comp,id,msg,selectText) {
        var curEle = comp.find(id);
        $A.util.removeClass(curEle, "has-error");
        var curEleValue = curEle.get("v.value");
        var className = curEle.get("v.class").toString().split(' ')[1];
        if(selectText==curEleValue){
            this.countErrors(comp);
            curEle.set("v.errors", [{message: msg}]);
        }
        else{
            curEle.set("v.errors", '');
            $A.util.removeClass(curEle, "has-error");
        }
    },
    countErrors:function(comp){
        var val = comp.get("v.errorCount");
        val++;
        comp.set("v.errorCount",val);
    },
    checkCount:function(comp){
        var val = comp.get("v.errorCount");
        return val;
    },
    getDataObj:function(dataObj){
        var obj ={};
        for(var key in dataObj){
            obj[key] = dataObj[key];
        }
        return obj;
    },
    clearDataObj:function(comp,dataObj){
        var obj ={};
        for(var key in dataObj){
            obj[key] = '';
        }
        comp.set('v.dataObj',obj)
    },
    showToast : function(resp) {
        console.log("toast entered...!");
        var xml = resp.Resbody;
        console.log(xml);
        var xmlDoc = $.parseXML( xml );
        var $xml = $( xmlDoc );
        var code = resp.statusCode;
        var msg = $xml.find( code==200?"return":"faultString" ).text()||"Please try again!";   
        var toastEvent = $A.get("e.force:showToast");
        console.log(msg);
        toastEvent.setParams({
            "title": code!=200?"Error!":"Success!",
            "message": msg,
            "type": code!=200?"error":"success"
        });
        toastEvent.fire();
    },
    repositoryRegistration:function(component,methodName){
        component.set("v.errorCount",0);
        this.checkInputSelect(component,'repository','Please select repository.',"Select Repository");
        this.checkInput(component,'DisplayName','Please Enter Display Name.');
        this.checkInputSelect(component,'accesskey','Please select accesskey.',"Select Accesskey");
        if(component.get("v.isRepositoryURL")){
            this.checkInput(component,'url','Please Enter RepositoryURL.')
        }
        var val = this.checkCount(component);
        if(val==0){
            component.set('v.isSpinnerVisible',true);
            console.log(component.get('v.dataObj'));
            var dataObj = this.getDataObj(component.get('v.dataObj'));
            console.log(dataObj);
            var action = component.get('c.'+methodName);
            action.setParams(dataObj);
            action.setCallback(this,function(res){
                component.set('v.isSpinnerVisible',false);
                console.log('validateSCMCredentials');
                var state = res.getState();
                var response = JSON.parse(res.getReturnValue());
                console.log('state-----'+state);
                console.log(response);
                this.showToast(response);
                if(state=="SUCCESS" && response.statusCode==200){
                    if(methodName=="registerSCMRepository"){
                        console.log('------------------');
                        this.hideModal(component);
                        this.clearDataObj(component,dataObj);
                        $('#icon-2').iconGroup('select');
                        $('#icon-3').iconGroup('deselect');
                        var cmpEvent = component.getEvent("getList");
                        cmpEvent.setParams({
                            "flag":component.set("v.flag")
                        })
                        cmpEvent.fire();
                    }
                    else{
                        component.set("v.isSaveDisabled",false);
                    }
                    
                }
            });
            $A.enqueueAction(action);
        }
    }
})