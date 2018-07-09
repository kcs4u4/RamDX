public class AInsertAction {
  @InvocableMethod(label='Insert Accounts' description='Inserts the accounts specified and returns the IDs of the new accounts.')
  public static List<ID> insertAccounts(List<A__C> accounts) {
    Database.SaveResult[] results = Database.insert(accounts);
    List<ID> aIds = new List<ID>();
    PageReference pdf = Page.myVFPage;
       

  
   
    for (Database.SaveResult result : results) {
      if (result.isSuccess()) {
        aIds.add(result.getId());
      }
    }
    return aIds;
  }
  
}