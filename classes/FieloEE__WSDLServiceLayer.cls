/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class WSDLServiceLayer {
    global WSDLServiceLayer() {

    }
    webService static String confirmRedemption() {
        return null;
    }
    webService static String createRedemption(List<FieloEE.WSDLServiceLayer.RedemptionItemWrapper> items) {
        return null;
    }
    webService static String createTransaction(FieloEE__Transaction__c tran) {
        return null;
    }
    webService static List<FieloEE__Banner__c> getBanners() {
        return null;
    }
    webService static List<FieloEE__Category__c> getCategories() {
        return null;
    }
    webService static FieloEE__Member__c getMember() {
        return null;
    }
    webService static List<FieloEE__News__c> getNews(Id newsId, String newsType) {
        return null;
    }
    webService static List<FieloEE__RedemptionItem__c> getRedemptions(Id redemptionId) {
        return null;
    }
    webService static List<FieloEE__Reward__c> getRewards(Id rewardId) {
        return null;
    }
    webService static List<FieloEE__Transaction__c> getTransactions(Id transactionId) {
        return null;
    }
    webService static String updateMember(FieloEE__Member__c member) {
        return null;
    }
global class RedemptionItemWrapper {
    webService Integer quantity {
        get;
        set;
    }
    webService String rewardId {
        get;
        set;
    }
    global RedemptionItemWrapper() {

    }
}
}
