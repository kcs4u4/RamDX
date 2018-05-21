// In a separate class so that it can be used elsewhere
Global class emailHelper {

public static void sendEmail(ID recipient, ID candidate) {
  PageReference pdf = Page.myVFPage;
        pdf.getParameters().put('id',candidate);

  //New instance of a single email message
 Messaging.SingleEmailMessage mail = 
            new Messaging.SingleEmailMessage();
 
// Who you are sending the email to
   mail.setTargetObjectId(recipient);

   // The email template ID used for the email
   mail.setTemplateId('00X30000001GLJj');
          
   mail.setWhatId(candidate);    
   mail.setBccSender(false);
   mail.setUseSignature(false);
   mail.setReplyTo('recruiting@acme.com');
   mail.setSenderDisplayName('HR Recruiting');
   mail.setSaveAsActivity(false);  
 
Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

    }  
    public PageReference redirectToMyVF() { 
    PageReference myVFPage = new PageReference('/apex/myVFPage');
    myVFPage.setRedirect(true);
   // myVFPage.getParameters().put('myId', accId);
    return myVFPage;
}
}