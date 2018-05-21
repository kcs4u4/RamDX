public class Email1 {
    
    Public Object__c obj{set ; get;} 
     public Email1(ApexPages.StandardController controller) { 
     obj  = new Object__c();
     } 
    
    
    
       public Object__c getobj() {
      return obj;
  }
   
    public PageReference getSendmail(){
        

        insert obj;
        
        Contact recipient = new contact (LastName='Test', email=obj.Email__c);
        insert recipient;
        sendEmail(recipient.ID,obj.id);
        delete recipient;
        
        obj.confirmation__c=true;
        
        update obj;

        
         PageReference pageRef = ApexPages.currentPage();
    pageRef.setRedirect(true);
    return pageRef;

}
    
     public void sendEmail(ID recipient, ID obj) {
                  

         Messaging.SingleEmailMessage mail =

            new Messaging.SingleEmailMessage();

// Who you are sending the email to

   mail.setTargetObjectId(recipient);

// mail.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});

   // The email template ID used for the email
System.debug(recipient);
   mail.setTemplateId('00X28000001hhuF');

           

   mail.setWhatId(obj);   

   mail.setBccSender(false);

   mail.setUseSignature(false);

   mail.setSaveAsActivity(false); 
Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

 

    } 
}