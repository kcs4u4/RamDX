trigger updateContactsCountInAccountObj on Contact (after insert,after update,before delete) {
    list<id> accIds = new list<Id>();
    list<account> accList = new list<account>();
    if(Trigger.isDelete){
        for(contact con:Trigger.old){
            accIds.add(con.AccountId);
        }
        for(Account acc:[select id,(select id from contacts where id in:Trigger.old),No_of_Contacts__c from account where id in:accIds]){
            system.debug('--------'+Trigger.old);
            acc.No_of_Contacts__c = acc.No_of_Contacts__c-acc.contacts.size();
            accList.add(acc);
        }
    }
    else{
        for(contact con:Trigger.new){
            accIds.add(con.AccountId);
        }
        for(Account acc:[select id,(select id from contacts),No_of_Contacts__c from account where id in:accIds]){
            acc.No_of_Contacts__c = acc.contacts.size();
            accList.add(acc);
        }
    }
    update accList;
}