public class DemoController
{
    

    public PageReference somemethod()
    {
        //Check for some validation. like User is Authorized or not ?
       
        {
             //Means User is not Authorized for this operation, Add error on Visualforce page
             Apexpages.addMessage( new ApexPages.Message (ApexPages.Severity.ERROR, 'User is not Authorized to perform this Operation'));
             return null;
        }
        return Page.SomePage;
    }
    
    public void method1(){
        
         
    }
    
    public void method2(){
        
         
    }
}