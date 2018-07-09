public class AutoRabitTestClass{
    
    public Id posId{get;set;}
    public Id DealsId{get;set;}
     String test = Label.DX_API;

 
    Public AutoRabitTestClass(Apexpages.StandardController controller){
        posId = controller.getRecord().Id;
        System.debug('posid'+posId);
    }
    public List<AutoRabitTest__c > cs{get; set;}
    PageReference pr = new PageReference('/apex/AutoRabitTestPage1');
    public AutoRabitTestClass()
    {
    cs = new List<AutoRabitTest__c >();
        List<AutoRabitTest__c > a= [Select id,CounterParty__c,CP_Mail__c , CP_Phone__c from AutoRabitTest__c where id=:posId  ];
       for (AutoRabitTest__c  c : a)
       {       
           cs.add(c);
       }
    }
   
    
}