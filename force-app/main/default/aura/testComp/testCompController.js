({
	doInit : function(component, event, helper) {
        var obj={};
        obj['expenses'] = '';
        obj['goods'] = '';
        component.set("v.expObj",obj)
	},
    clicked : function(component, event, helper) {
        var action = component.get('c.setData');
        console.log(component.get("v.expObj"));
        //action.setParams(JSON.parse(component.get("v.expObj")));
        //$A.enqueueAction(action);
    },
    scriptsLoaded: function(component, event, helper) {
        var fixHelperModified = function(e, tr) {
            var $originals = tr.children();
            var $helper = tr.clone();
            $helper.children().each(function(index) {
                $(this).width($originals.eq(index).width())
            });
            return $helper;
        }
        var updateIndex = function(e, ui) {
                $('td.index', ui.item.parent()).each(function (i) {
                    $(this).html(i + 1);
                });
            var sortedIDs = $( ".slds-table tbody" ).sortable( "toArray" );
            console.log(sortedIDs);
            };
        
        $(".slds-table tbody").sortable({
            helper: fixHelperModified,
            stop: updateIndex
        }).disableSelection();
    }
})