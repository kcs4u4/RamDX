/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class RedemptionItemVoucherController {
    global String voucherCustomVoucher {
        get;
        set;
    }
    global List<FieloEE.RedemptionItemVoucherController.voucherItem> vouchers {
        get;
        set;
    }
    global RedemptionItemVoucherController() {

    }
    @Deprecated
    global static String GetResourceURL(String resourceName) {
        return null;
    }
global class voucherItem {
    global Id imageId {
        get;
        set;
    }
    global String instructionsReward {
        get;
        set;
    }
    global String instructionsVoucher {
        get;
        set;
    }
    global FieloEE__RedemptionItem__c redemptionItem {
        get;
        set;
    }
    global FieloEE.RewardItemWrapper rewardItemWrapper {
        get;
        set;
    }
    global Integer voucherNum {
        get;
        set;
    }
    global voucherItem(FieloEE.RewardItemWrapper rewardItemWrapper, Integer i, String instructionsVoucher, String instructionsReward) {

    }
    global voucherItem(FieloEE__RedemptionItem__c redemptionItem, Id imageId, Integer i, String instructionsVoucher, String instructionsReward) {

    }
}
}
