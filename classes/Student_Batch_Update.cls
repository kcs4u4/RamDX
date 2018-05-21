global class Student_Batch_Update implements Database.Batchable<sobject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc){
 
        return Database.getQueryLocator('select id,Name From Student__c');
          
    }
    
    global void execute (database.BatchableContext bc , List <Student__c> scope){
        
        for(Student__c s: scope){
            
            s.name= s.name+'.mr';
        }
        update scope;
    }
    global void finish(Database.BatchableContext bc){
       
    }

}