public class MAP_String {
    
    Public Map<String,List<String>> myMap =new Map<String,List<String>>();
    Public String mycity{set ; get;}
    Public List<SelectOption> city{set;get;}
    Public List<selectOption> Branch{set;get;}
    
    Public Map_String(){
    List<String> Hyd= new List<String>();
    Hyd.add('SrNagar');
    Hyd.add('Ameerpet');
    Hyd.add('Secbd');
    
    List<String> Bang=new List<String>();
    Bang.add('Marthali');
    Bang.add('SilKBoard');
    Bang.add('Hebbal');
        
    MyMap.put('Hyd',Hyd);
        MyMap.put('Bang',Bang);
    }
    
    public PageReference Show(){
  
        Set<String> keys=myMap.keySet();
        city=new List<SelectOption>();
        city.add(new selectOption('Null','None'));
        List<String> my =new List<String>();
        my.add('None');
        
        For(String a :keys){
            selectOption op1=new SelectOption(a,a);
            city.add(op1);
        }
        return null;
    }    

}