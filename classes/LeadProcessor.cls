global class LeadProcessor implements Database.Batchable<SObject>{
    
    global DataBase.QueryLocator Start (DataBase.BatchableContext bc){

        return DataBase.getQueryLocator([select LeadSource from Lead]);
    }
    
    Global void execute(Database.BatchableContext bc ,List<Lead> Scope){
        
        for(lead l1:Scope){
            
            l1.LeadSource ='Dreamforce';
        }
        update Scope;
    }
    
    global void finish(DataBase.BatchableContext bc){}
    
}