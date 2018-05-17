({
    doInit: function (cmp, event, helper) {
    var items = [{
            "label": "Western Sales Director",
            "name": "1",
            "expanded": true,
            "items": [{
                "label": "Western Sales Manager",
                "name": "2",
                "expanded": true,
                "items" :[{
                    "label": "CA Sales Rep",
                    "name": "3",
                    "expanded": true,
                    "items" : []
                },{
                    "label": "OR Sales Rep",
                    "name": "4",
                    "expanded": true,
                    "items" : []
                }]
            }]
        }, {
            "label": "Eastern Sales Director",
            "name": "5",
            "expanded": false,
            "items": [{
                "label": "Easter Sales Manager",
                "name": "6",
                "expanded": true,
                "items" :[{
                    "label": "NY Sales Rep",
                    "name": "7",
                    "expanded": true,
                    "items" : []
                }, {
                    "label": "MA Sales Rep",
                    "name": "8",
                    "expanded": true,
                    "items" : []
                }]
            }]
        }];
        cmp.set('v.items', items);
    },
    handleSelect: function (cmp, event, helper) {
        //return name of selected tree item
        var myName = event.getParam('name');
        alert("You selected: " + myName);
    }
})