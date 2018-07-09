/************************************************************
* Developer: Kaushal Kishore                                * 
* Type: Class                                               *
* Created Date: 19.07.2016                                  *
*************************************************************/
public class VFC_SubmitForReview {
    public Hotfix__c hotfixId = null;        
    public Hotfix__c ObjHotfix = null;
    public String message{get;set;}
    public String cancelBtnName{get;Set;}
    public Boolean displayConfBtn{get;Set;}
    PageReference pr = null;
        
    List<Hotfix__c> lstHotfix = new List<Hotfix__c>();
            
    public VFC_SubmitForReview(ApexPages.StandardController controller) {
         hotfixId = (Hotfix__c)controller.getRecord();
    }
    
    public PageReference UpdateRecordStatus() {
    
        ObjHotfix = [select id,RevisionCommit__c,Status__c,Hotfix_Assigned_To__c,CreatedById from Hotfix__c where id =:hotfixId.id];       
        if(this.ObjHotfix.Status__c == label.CLJUL16PAN01) //New
        { 
            if(this.ObjHotfix.RevisionCommit__c != null)
            {
                Hotfix__c objCreateHotfix = new Hotfix__c();
                objCreateHotfix.id = hotfixId.id; 
                objCreateHotfix.Status__c = label.CLJUL16PAN02; //Requested
                //objCreateHotfix.RecordTypeId = label.CLJUL16PAN08; //Validator
                lstHotfix.add(objCreateHotfix);
             }
             else
             {
                message = label.CLJUL16PAN14; //Please provide Revision Commit# before Requesting Hotfix
                displayConfBtn = true;
             }
         }   
         
        else if(this.ObjHotfix.Status__c == label.CLJUL16PAN02)
        {
            if(this.ObjHotfix.CreatedById != UserInfo.getUserId())
            {
                Hotfix__c objCreateHotfix = new Hotfix__c();
                objCreateHotfix.id = hotfixId.id; 
                objCreateHotfix.Status__c = label.CLJUL16PAN03; //Reviewed 
                //objCreateHotfix.RecordTypeId = label.CLJUL16PAN09; //Reviewer
                lstHotfix.add(objCreateHotfix);
            }
            else 
            { 
                message = label.CLJUL16PAN15; //'Requester Cannot Review the Hotfix';
                displayConfBtn = true;
            }
        }
            
        else if(this.ObjHotfix.Hotfix_Assigned_To__c == UserInfo.getUserId() && (this.ObjHotfix.Status__c != label.CLJUL16PAN02 || this.ObjHotfix.Status__c != label.CLJUL16PAN01))
        {
            Hotfix__c objCreateHotfix = new Hotfix__c();
            if(this.ObjHotfix.Status__c == label.CLJUL16PAN03){
                objCreateHotfix.id = hotfixId.id; 
                objCreateHotfix.Status__c = label.CLJUL16PAN04; 
                //objCreateHotfix.RecordTypeId = label.CLJUL16PAN10;
                lstHotfix.add(objCreateHotfix);                
            }
            else if(this.ObjHotfix.Status__c == label.CLJUL16PAN05) 
            { 
                objCreateHotfix.id = hotfixId.id; 
                objCreateHotfix.IsMigrated__c = true;
                objCreateHotfix.Status__c = label.CLJUL16PAN06; //Migrated
                //objCreateHotfix.RecordTypeId = label.CLJUL16PAN11; //Migrator
                lstHotfix.add(objCreateHotfix);
            }
            else if(this.ObjHotfix.Status__c == label.CLJUL16PAN06) 
            { 
                objCreateHotfix.id = hotfixId.id;
                objCreateHotfix.Status__c = label.CLJUL16PAN07; //Closed 
                //objCreateHotfix.RecordTypeId = label.CLJUL16PAN12; //Approved
                lstHotfix.add(objCreateHotfix);
            }
            else if(this.ObjHotfix.Status__c == 'Closed') 
            { 
                pr = new PageReference('/' + hotfixId.id);
                pr.setRedirect(true);
            }
        }
        else 
        { 
            message = label.CLJUL16PAN16; //'Only Release Team Can Submit for Validate/Merge/Close the Hotfix';
            displayConfBtn = true;
        }
        
        //Update record
        if(lstHotfix.size() > 0)
        {
            Update lstHotfix;
            pr = new PageReference('/' + hotfixId.id);
            pr.setRedirect(true);
        }
        return pr;
    }
    
    // Redirecting the User to Hotfix Details Page on cancellation and Confirmation
    public PageReference unLoadMe()
    {
        return new PageReference('/' + hotfixId.id);
    }
}