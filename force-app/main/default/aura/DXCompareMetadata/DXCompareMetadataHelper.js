({
	getDataObj:function(dataObj){
        var obj ={};
        for(var key in dataObj){
            obj[key] = dataObj[key];
        }
        return obj;
    }
})