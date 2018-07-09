public class Expense_Approval {
     Public ApexPages.StandardController StandardController ;
   Public ApexPages.StandardSetController StandardSetController ;
   public  List<Travel_Forecast_Form__c> expense{get;set;}
    public Expense_Approval(ApexPages.StandardSetController controller) {
        List<Travel_Forecast_Form__c> ExpRec = [SELECT Id,Name FROM Travel_Forecast_Form__c];
     //  ApexPages. StandardSetController ssc = new ApexPages. StandardSetController(ExpRec);
      StandardSetController = new ApexPages.StandardSetController(ExpRec);
    } 
  public void approveActionFunction(){      
  // Apex code for handling records from a List View goes here  
  List<Travel_Forecast_Form__c> selectedListViewRecords = (List<Travel_Forecast_Form__c>) standardSetController.getSelected();  
  system.debug(selectedListViewRecords);          
  try{           
  String idkey = UserInfo.getUserId();        
  Boolean hasAccess = false;     
  List<Profile> p = [SELECT Id, Name FROM Profile WHERE Name='System Administrator'];   
  if(UserInfo.getProfileId() == p[0].id)          
      hasAccess = true;             
  //List<Travel_Forecast_Form__c> recordList = new List<Travel_Forecast_Form__c>(TFFs[0]);  
  List<String> ids = new List<String>();          
  for(Travel_Forecast_Form__c rec: selectedListViewRecords){    
  
  ids.add(rec.id);    
  }               
  system.debug('ids'+ids); 
  List<Approval.ProcessWorkitemRequest> requests = new List<Approval.ProcessWorkitemRequest>();      
  List<ProcessInstanceWorkitem> workItems;   
  if(hasAccess)                 
      workItems = [SELECT Id, ProcessInstanceId FROM ProcessInstanceWorkitem WHERE ProcessInstance.TargetObjectId IN :ids ];   
  else               
      workItems = [SELECT Id, ProcessInstanceId FROM ProcessInstanceWorkitem WHERE ActorId = :idkey AND ProcessInstance.TargetObjectId IN :ids ]; 
  system.debug(workItems);                    
  for(ProcessInstanceWorkitem workItem : workItems){         
  Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();        
  req.setWorkitemId(workItem.Id);          
  //Valid values are: Approve, Reject, or Removed.  
  //Only system administrators can specify Removed.         
  req.setAction('Approve');              
  req.setComments('No Comment.');                  
  requests.add(req);               
  }            
  Approval.ProcessResult[] processResults = Approval.process(requests);   
  } catch ( Exception ex ){ //return null; system.debug(ex.getMessage());      
  }       
  }
}