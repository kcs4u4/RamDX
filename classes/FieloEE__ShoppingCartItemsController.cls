/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class ShoppingCartItemsController {
    global Decimal itemsQuantity {
        get;
        set;
    }
    global List<FieloEE.ShoppingCartItemsController.OrderItemsWrapper> listOrderItems {
        get;
        set;
    }
    global FieloEE__Member__c member {
        get;
        set;
    }
    global FieloEE__Redemption__c orden {
        get;
        set;
    }
    global FieloEE__Member__c participant {
        get;
        set;
    }
    global FieloEE__Redemption__c redemption {
        get;
        set;
    }
    global Decimal totalPoints {
        get;
        set;
    }
    global ShoppingCartItemsController() {

    }
    @Deprecated
    global System.PageReference addPrize() {
        return null;
    }
    global System.PageReference deleteValues() {
        return null;
    }
    @Deprecated
    global System.PageReference doReturn() {
        return null;
    }
    global System.PageReference doVoucher() {
        return null;
    }
    global List<FieloEE.ShoppingCartItemsController.OrderItemsWrapper> getOrderItems() {
        return null;
    }
    global System.PageReference init() {
        return null;
    }
    global System.PageReference refreshValues() {
        return null;
    }
    @Deprecated
    global void updateMemberPoints() {

    }
global class OrderItemsWrapper {
    global Id imageId {
        get;
        set;
    }
    global Integer newQuantity {
        get;
        set;
    }
    global String newQuantityAux {
        get;
        set;
    }
    global String prizeId {
        get;
        set;
    }
    global String prizeName {
        get;
        set;
    }
    global Decimal prizePoints {
        get;
        set;
    }
    global String rewardId {
        get;
        set;
    }
    global Integer total {
        get;
        set;
    }
    global OrderItemsWrapper(AggregateResult orderAggregateResult) {

    }
}
}
