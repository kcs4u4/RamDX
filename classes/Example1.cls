public class Example1 {
    
    public String MyName{set;get;}
    public ApexPages.StandardSetController stdCntrlr {get; set;}
 public Example1(ApexPages.StandardSetController controller) {
        stdCntrlr = controller;

}
   public Example1(String MyName){
        this.myName=Myname;
    }
    public void show(){
        
        List <Account> acc=[select id ,Name from Account where name=:MyName];
        for(Account a :acc){
            
            a.name='mr'+a.name;
            
            acc.add(a);
            
        }
        update acc;
        
    }
}