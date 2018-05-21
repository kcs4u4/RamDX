/*** Controller ***/
public class exampleCon {
    String uname;

    public String getUsername() {
        return uname;
    }
            
    public PageReference sayHello() {
        uname = UserInfo.getName();
        return null;
    }
            
    public void setState(String n) {
        state = n;
    }
            
    public String getState() {
        return state;
    }
            
    public PageReference methodOne() {
        return null;
    }
            
    private String state = 'no';
    Public Integer Count=0;
    Public PageReference IncrementCounter(){
    count++;
    return null;
    }
    Public Integer getCount(){
    return count;
    }
    
}