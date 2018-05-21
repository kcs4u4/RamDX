global class CustomIterable implements Iterator<Account> {
    
    integer i;
    List<Account> accs;
    
    public CustomIterable(){
        
        accs=[select id,Name,NumberOfEmployees from Account where Name='Fasle'];
        i=0;
    }
    global boolean hasNext(){
        if(i>=accs.size()){
            return false;
        }
        else{
            return true;
        }
        }
    global Account Next(){
        if(i==8)
        {
            return null ;
        }
        i++;
        return accs[i-1];
    }
    
    }