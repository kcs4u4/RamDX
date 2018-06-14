trigger AccountUpdateTrigger on Account (before insert,before Update) {
    
    List<Account> accountrecords = [select id,name,(select id,Salutation,Description,FirstName,LastName,email from Contacts) from Account where id IN : Trigger.NewMap.KeySet()]; 	 
    List<Contact> newContact= new List<Contact>();
    for(Account a:accountrecords){
        for(Contact c:a.contacts){
            System.debug('[c.Id'+c.id+'][c.Description ');
            
            c.Description= c.FirstName+' '+c.LastName+' '+c.Salutation ;
            
            newContact.add(c);
        }
        
        update newContact;
    }
    
    
}