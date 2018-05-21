global class batchAccountUpdate implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        
        String qry='select id,name from Account';
               
        return Database.getQueryLocator(qry);
        
    }
    global void execute(Database.BatchableContext bc ,List<Account> scope){
        for(Account a:scope){
            a.Name=a.Name+ 'u';
            
        }
        update scope;
    }
    global void finish(Database.BatchableContext bc){
        
    }
    
    global void execute(SchedulableContext sc){
        batchAccountUpdate b= new batchAccountUpdate();
        database.executebatch(b);
        
        
    }
        

}