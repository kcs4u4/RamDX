@isTest
public class LeadProcessorTest {
    
    public static testmethod void test1(){
        
        List<lead> lstLead= new List<lead>();
        
        for(integer i=0 ;i<200 ;i++){
            
            lead led= new Lead();
            led.FirstName='abc';
            led.LastName='abc'+i;
            led.Company='auto'+i;
            
            lstLead.add(led);
        }
        
        insert lstLead;
        
        Test.startTest();
        
        LeadProcessor lp=new LeadProcessor();
        DataBase.executeBatch(lp);
        
        Test.stopTest();
    }

}