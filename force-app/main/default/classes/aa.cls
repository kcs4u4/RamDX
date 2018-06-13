public class aa {
  String samp = System.Label.DX_API;
 //  public Flow.Interview.newFlow myFlow {get; set;}

StaticResource static_resource = [SELECT Id, SystemModStamp
                              FROM StaticResource 
                              WHERE Name = 'FullCalendar'
                              LIMIT 1];
                       String myUrl = PageReference.forResource('FullCalendar').getUrl();    
                
// Id devRecordTypeId = Schema.SObjectType.Branch__c.getRecordTypeInfosByName().get('NEWTEST').getRecordTypeId(); 

 String samp1=samp+System.Label.DX_API2;
public void submitForApproval()
{
 AssignmentRule AR = new AssignmentRule();
AR = [select id from AssignmentRule where SobjectType = 'Case' and Active = true limit 1];
/*      // Create an approval request for the Opportunity
    Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
    req1.setComments('Submitting request for approval automatically using Trigger');
    req1.setObjectId(opp.id);
  //  req1.setNextApproverIds(new Id[] {opp.Next_Approver__c});

    // Submit the approval request for the Opportunity
    Approval.ProcessResult result = Approval.process(req1); */

}  
 public List<Schema.FieldSetMember> getFields() {
        return SObjectType.Branch2__c.FieldSets.Test.getFields();
    }
   
                           
public static void sendEmail(ID recipient, ID candidate) {

EmailTemplate templateId = [Select id from EmailTemplate where name = ' EmailSample'];
 PageReference pdf = Page.renderaspdf;
 PageReference pr = new PageReference('/apex/myFormComposition');
//New instance of a single email message
Messaging.SingleEmailMessage mail = 
        new Messaging.SingleEmailMessage();

// Who you are sending the email to
mail.setTargetObjectId(recipient);

// The email template ID used for the email
mail.setTemplateId('00X0K000001i079');
      mail.setTemplateID(templateId.Id); 

mail.setWhatId(candidate);    
mail.setBccSender(false);
mail.setUseSignature(false);
mail.setReplyTo('recruiting@acme.com');
mail.setSenderDisplayName('HR Recruiting');
mail.setSaveAsActivity(false);  


Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

} 
}