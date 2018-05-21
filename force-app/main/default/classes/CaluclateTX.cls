public class CaluclateTX {
    
    Public Decimal tax{set ; get;}
    
    public Decimal CalcTax(Decimal amount){
        if(amount>50000)
        {
            tax=amount*0.20;
        }
        else{
            tax=amount*0.10;
        }
        return tax;
    }

}