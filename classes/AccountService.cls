global class AccountService{

webservice static String  CreateCustomer(String Name, String Phone ,String City){
Account objA=new Account();
objA.Name=Name;
objA.Phone =Phone ;
objA.BillingCity=City;
insert objA;

if(objA.Id!=Null){
return 'Success' ;
}else{

return 'failure';
}
}
}