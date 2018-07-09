public class DescribeFieldsExample {

public List<SelectOption> options;

public List<SelectOption> getOptions(){
 return options;
}

public String result {get;set;}

public DescribeFieldsExample (){
 options =  new List<SelectOption>();
 Schema.DescribeFieldResult obj = Account.Type.getDescribe();
 List<Schema.pickListEntry> p = obj.getPickListValues();
 for(Schema.PickListEntry x:p){
  SelectOption op = new SelectOption(x.getLabel(),x.getLabel());
  options.add(op);
 }

}

}