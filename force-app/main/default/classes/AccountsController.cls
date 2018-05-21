public class AccountsController {
  @AuraEnabled
  public static List<Account> getAccounts() {
    return [SELECT Id, name, industry, Type, NumberOfEmployees, TickerSymbol, Phone
    FROM Account Limit 1];
  }
}