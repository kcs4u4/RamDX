@RestResource(urlMapping='/Goud/*')
global class CheckAccount {
    
     @HttpGet
     global static List<Account> getAccount(){
        
         List<Account> acc=[select id ,name from Account];
        return acc;
    }

}