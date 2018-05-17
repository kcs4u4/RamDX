({
    waiting: function(component, event, helper) {
        if(document.getElementById("Accspinner")){
            document.getElementById("Accspinner").style.display = "block";
        }
    },
    doneWaiting: function(component, event, helper) {
        if(document.getElementById("Accspinner")){
            //document.getElementById("Accspinner").style.display = "none";
        } 
    }
})