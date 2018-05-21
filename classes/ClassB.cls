public class ClassB {
    
   
    Public  Set<String> setContactID = new Set<String>();
    public  void ClassBB()
   {
    
   List<B__c > lstCM= [Select id, kcs_dev__B_One__c from B__c];
       System.debug('lstCM'+lstCM);
    
    
    for (Integer i = 0; i< lstCM.size(); i++)
    {
        setContactID .add(lstCM[i].kcs_dev__B_One__c); // contains distict contacts
    } 
       System.debug('SetContactID' +setContactID);
   }
        
    
            
            }