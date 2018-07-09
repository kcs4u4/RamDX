public class Price_Update_on_A {
    
    public static void Asprice(List<A__c> books){
        
        For(A__c a:books){
            
            a.price__c *=0.9;
        }
    }

}