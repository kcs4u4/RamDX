({
	init: function (cmp, event, helper) {
        /*cmp.set('v.mycolumns', [
            {label: 'Contact Name', fieldName: 'Name', type: 'text','sortable':true},
                {label: 'Phone', fieldName: 'Phone', type: 'phone','sortable':true},
                {label: 'Email', fieldName: 'Email', type: 'email','sortable':true}
            ]);
        helper.getData(cmp);
        var columns =  cmp.get('v.columns');*/
    },
    columnSorting: function (cmp, event, helper) {
   		console.log('---------------------------------');
        var fieldName = event.getParam('fieldName');
        var sortDirection = event.getParam('sortDirection');
        // assign the latest attribute with the sorted column fieldName and sorted direction
        cmp.set("v.sortedBy", fieldName);
        cmp.set("v.sortedDirection", sortDirection);
        helper.sortData(cmp, fieldName, sortDirection);
    },
    onrowselection: function (component, event) {
        var selectedRows = event.getParam('selectedRows');
        for (var i = 0; i < selectedRows.length; i++){
           console.log(selectedRows[i].Id);
        }
    }
})