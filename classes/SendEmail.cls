public class SendEmail {
    Public SendEmail(Apexpages.StandardController controller){}
    
    public String getSendMail(){
        String id1=ApexPages.currentPage().getParameters().get('Id');
        System.debug('id1'+id1);
        A__C a=[select id ,Price__c,Email__c from A__c where id=:id1];
        
        Contact recipient=new Contact(LastName='test',Email=a.Email__c);
        insert recipient;
        System.debug('Email'+a.Email__c);
        send(recipient.Id,a.id);
        
        return null;
    }
    
    public  void send(id recipient ,id a) {
// Define the email
    
    PageReference pdf = Page.A_XLS;
        
   pdf.getParameters().put('id',a);
    pdf.setRedirect(true);
 
    Blob b = pdf.getContent();
// Create the email attachment
    Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
    efa.setFileName('attachment.XLS');
    efa.setBody(b);
  /*  String addresses;
    email.setSubject( 'subject' );
    string[] test = new String[] {'aa@aa.com'};
    email.setToAddresses( test  );
    email.setPlainTextBody(' body' );
    email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
// Send it
    Messaging.SendEmailResult [] r =
    Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email}); */
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setTargetObjectId(recipient);
        email.setPlainTextBody(' body' );
        email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
         Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email}); 
 
}
}