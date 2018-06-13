Public Class ArVaultEditSave{

    public ArVaultEditSave() {

    }


    public ArVaultEditSave(ApexPages.StandardController controller) {

    }

Public List<ARVault__c> ar{set;get;}
List <ARVault__c> arvault = new List <ARVault__c> ();

public void save(){
update ar;
}
}