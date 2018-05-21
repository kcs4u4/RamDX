/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class RedemptionUtil {
    global RedemptionUtil() {

    }
    global static void addRedemptionItem(FieloEE__Redemption__c redemption, FieloEE__Reward__c reward, Integer cantidad) {

    }
    global static void addRedemptionItems(Id redemptionId, List<FieloEE.RedemptionUtil.RedItemWrapper> items) {

    }
    webService static String cancelRedemtionItem(String id) {
        return null;
    }
    global static void closeRedemption(FieloEE__Redemption__c redemption) {

    }
    @Deprecated
    global static List<FieloEE__RewardItem__c> createItemsIntangible(FieloEE__Reward__c reward, Integer cant) {
        return null;
    }
    webService static String deliverItems(Id id, List<Id> itemsIds) {
        return null;
    }
    global static Boolean evaluateCriteria(FieloEE__RedemptionRuleCriteria__c c, FieloEE__Member__c member) {
        return null;
    }
    global static FieloEE__Redemption__c getRedemption(FieloEE__Member__c member, String origin) {
        return null;
    }
    global static void instantRedemption(List<FieloEE.RedemptionUtil.MemberRewardWrapper> wrapperList, String origin) {

    }
    global static Set<Id> lookForMatchingRedemptionRulesCookie() {
        return null;
    }
    global static List<String> lookForMatchingRedemptionRules(FieloEE__Member__c member) {
        return null;
    }
    global static void refreshSegmentCookies() {

    }
    @Deprecated
    global static Boolean validate(FieloEE__Reward__c prize, FieloEE__Redemption__c orden, Integer cantidad) {
        return null;
    }
global class MemberRewardWrapper {
    global String status;
    global MemberRewardWrapper(Id idMember, Id idReward, Boolean stockControl) {

    }
    global MemberRewardWrapper(Id idMember, Id idReward, Id idTransaction, Boolean stockControl) {

    }
    global Id getRedemption() {
        return null;
    }
}
global class RedItemWrapper {
    global Integer quantity {
        get;
        set;
    }
    global Id rewardId {
        get;
        set;
    }
    global RedItemWrapper(Id rewardId, Integer quantity) {

    }
}
}
