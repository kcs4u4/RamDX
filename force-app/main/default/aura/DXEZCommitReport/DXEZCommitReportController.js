({
	changeTab:function(component, event, helper) {
        $('.slds-tabs_scoped__nav').find("li").removeClass('slds-is-active');
        $A.util.addClass(event.srcElement.parentNode, "slds-is-active");
        $(".slds-tabs_scoped__content").removeClass('slds-show');
        $(".slds-tabs_scoped__content").addClass('slds-hide');
        var id = $(event.srcElement).attr('id').split('__')[0];
        $("#"+id).addClass("slds-show");        
    }
})