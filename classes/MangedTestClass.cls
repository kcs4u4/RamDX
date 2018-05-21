public class MangedTestClass {
     
    public selectOption[] myOptions{set;get;}
    public MangedTestClass(){
        selectOption op1= new selectOption('none','none');
        selectOption op2=new selectOption('Java','Java');
        selectOption op3=new selectOption('Oracle','Ora');
        myOptions =new SelectOption[]{op1,op2,op3};
    }
           
        
    
}