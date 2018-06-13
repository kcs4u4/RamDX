public class dataListCon{
 List<Account> accounts;
  
  public List<Account> getaccounts(){
  
    if(accounts==null) accounts=[select name from Account Limit 10];
    return accounts;
    }
    }