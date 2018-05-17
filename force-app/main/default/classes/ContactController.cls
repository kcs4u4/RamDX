public with sharing class ContactController{

    public List<Contact> getContacts() {
        List<Contact> contacts = 
                [SELECT Id, Phone, Email,ReportsToId,Level__c FROM Contact For update];
        List<DXAPI__c> DXAPIs = new List<DXAPI__c>();        
        //Add isAccessible() check
        return contacts;
    }
}