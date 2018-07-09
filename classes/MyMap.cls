public class MyMap {
    
    Public List<String> MyResult{set ; get;}
    Public Map<String,String> map1{set; get;}
    
    Public MyMap(){
        
        MyResult= new List<String>();
        map1 = new Map<String,String>();
        
        map1.put('Hyd','Chandu');
        map1.put('Ind','Goud');
        map1.put('Ban', 'KCS');
    }
    
    public PageReference Show(){
        myResult.clear();
        Set<String> keys=map1.keySet();
        myResult.addAll(keys);
        System.debug('myResult'+myResult);
        return null;
    }
    
    Public PageReference Display(){
        myResult=map1.values();
return null;
    }    
}