public class A_XLS {
    
    public Id posId{get;set;}
    public Id DealsId{get;set;}
     

    Public A_XLS(Apexpages.StandardController controller){
        posId = controller.getRecord().Id;
        System.debug('posid'+posId);
    }
    public List<A__c> cs{get; set;}
    
    public A_XLS()
    {
    cs = new List<A__c>();
        List<A__c> a= [Select id,Email__c,Price__c from A__c where id=:posId  ];
       for (A__c c : a)
       {       
           cs.add(c);
       }
    }
}