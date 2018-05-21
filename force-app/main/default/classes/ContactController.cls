public with sharing class ContactController {
    
    @AuraEnabled
    Public Static List<Contact> findAll(){
        return [select id ,name , phone from Contact Limit 50];
    }
    @AuraEnabled
    Public Static List<Contact> findByName(String searchKey){
        String name='%'+searchKey+'%';
        return [select id ,name ,phone from Contact where name LIKE:name Limit 50];
    }
    @AuraEnabled
    
    Public Static List<Contact> FindById(String ContactId){
        return [select id ,name ,phone from Contact where id=:ContactId];
    }

}