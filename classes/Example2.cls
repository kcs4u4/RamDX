public  with sharing class Example2 {
    public Attachment attach {get;set;}
    public Case c{get;set;}
    Public Contact contactObj; 
    Public string companyName{get;set;}
    public string Emailval {get;set;}
    public string subjectval {get;set;}
    public Boolean rendered{set;get;}
    Public string userPriority {get;set;}
    Public string featureTypeVal {get;set;}
    

      public boolean show{get;set;}
     public boolean show1{get;set;}
       public boolean hide{get;set;}
    public boolean hide1{get;set;}
    
    public string emailValue {get;set;}
    public List<Case> caseListAll {get;Set;}
    public List<Case> caseList {get;Set;}
    public Boolean hideTable {get;set;}
    
    public Example2(ApexPages.StandardController controller){
         emailValue= ApexPages.currentPage().getParameters().get('useremail');
    searchCaseList(emailValue);
        System.debug('email'+emailValue);
    }
    
    public Example2(){

        attach = new Attachment();
        c = new Case();
          show=true;
    
       hide=false;
         show1=true;
    
       hide1=false;
        
    }
    
    
    
    
    public void searchCases(){
        searchCaseList(emailValue);   
    }
    
public Boolean searchCaseList(String searchString){
 system.debug('---CheckCall---');
        caseListAll = new List<Case>();
        caseList = new List<Case>();
        if(!String.isBlank(searchString))
        caseListAll = [SELECT CaseNumber, SuppliedName, Subject, Status, Reason, Type, SuppliedEmail, SuppliedCompany, Login_Url__c FROM Case WHERE SuppliedEmail =: searchString ORDER BY CaseNumber desc];

        for(Case c: caseListAll){
            if(c.Reason != 'Other' && c.Type != 'Other' && c.SuppliedEmail != '')
            {
                caseList.add(c);                
            }            
        }
        
        hideTable = !caseList.isEmpty();
        return hideTable;
    }    

    
    

    public void InvokeShow()
{
      show=false;
      hide=true;
      system.debug('Inside InvokeShow:');
}
     public void InvokeShow1()
{
      show1=false;
      hide1=true;
      system.debug('Inside InvokeShow:');
}
    
    public void Invokehide()
{
      show=true;
      hide=false;
}
    

 
 
     public List<SelectOption> Category
    {
        get
        {
            List<SelectOption> options = new List<SelectOption>();
            Schema.DescribeFieldResult fieldResult = case.Reason.getDescribe();
            
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
            for( Schema.PicklistEntry f : ple)
                options.add(new SelectOption(f.getLabel(), f.getValue()));
            return options;
            
        }
    }
    
    public List<SelectOption> Priority1
    {
        get
        {
            System.debug('aaa');
            List<SelectOption> options = new List<SelectOption>();
            Schema.DescribeFieldResult fieldResult = case.Priority.getDescribe();
            
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
            for( Schema.PicklistEntry f : ple)
                options.add(new SelectOption(f.getLabel(), f.getValue()));
            return options;
            
        }
    }
        
     public PageReference Save1()
    {
        
   
        System.debug('aaaaaa');
        //searchdata();
        Boolean okayToSave = true;
      //  webtoCasePage = true;
     //   rendered =false;
        
        try {
             if(contactObj!=null){
c.Contactid = contactObj.id;
}
            if (c.SuppliedName=='')
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.Severity.ERROR,'Please enter your name'));
                okayToSave = false;
                //return null;
                System.debug('SuppliedName');
            }
            if (string.isblank(c.SuppliedEmail))
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.Severity.ERROR,'Please enter your email address'));
                okayToSave = false;
                //return null;
                //
             System.debug('SuppliedEmail');
            }
            if (string.isblank(c.Subject))
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.Severity.ERROR,'Please enter the Subject for your case'));
                okayToSave = false;
                //return null;
            }
            if( !okayToSave ) {
              //  return null;
            }
            System.debug('beforeinsert');
            insert c;
            System.debug('insert');
          /*  if(attach.name!=null && attach.body!=null){
                attach.ParentId = c.id;
                insert attach;} */
        } catch(System.DMLException e) {
            ApexPages.addMessages(e);
            return null;
        } 
      PageReference pg = new PageReference('https://kcs-dev-ed.my.salesforce.com/500/o');
        pg.setRedirect(true);
        return null;
    }
    public PageReference OpenCase(){
        
        c= [select id,SuppliedName,SuppliedEmail,CaseType__c,Subject,reason,Priority,description,Login_Url__c,Instance__c,SuppliedCompany from Case];
     //   PageReference redirect = new PageReference('/apex/OpenCase');
            rendered  = true; 
        return null ;
        
    }
     public Case getc(){
   return c;
   }
    
    }