public with sharing class testPageExt {

public List<Account> quoteList {get;set;}
public List<contact> supllierList {get;set;}
public String supplierValue {get;set;}

    public testPageExt() {
        supllierList =[Select id, Name from contact];
        system.debug('*********'+supllierList );
        quoteList = null;
        getSupllieraction();
    }


    public List<Contact> getSupllieraction() {
        supllierList =[Select id, Name from contact];
        return supllierList ;
    }

    public void quoteaction() {
        quoteList = [Select id, name  from Account  ];
    }
}