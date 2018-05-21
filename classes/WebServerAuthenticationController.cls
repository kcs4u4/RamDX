/*
Details: This class will be used to get access token of other org in order to communicate to other org.
Steps to get Access token using REST API
1.  First create Domain name in target org. 
2.  Create Remote Access (or connected app) in soure org from where we are sending request. System will give Client Id(Consumer key field in Remote access) and 
Client secret(Consumer secret field in Remote access).
3.  Fetch code by specifying Client Id redirect URL (CallbackUrl specified in remote access) in request. System will prompt only once to login in target org and
will redirect to callback URL.
4. Fetch Code from URL and then request for Access token by specifying code,ClientId, consumer key and redirect url.
5. Parse JSON to get access token and fields returned by target org.
6. Update the External App field with values returned in JSON.

*/

public  class WebServerAuthenticationController {
    public String strExternalAppId{get;set;}
    public String strAuthcode{get;set;}
    public String StrAppName{get;set;}
    
    public External_Application__c EApp{get;set;}
    public WebServerAuthenticationController(){
        strExternalAppId=Apexpages.currentPage().getParameters().get('EAid'); 
        StrAppName=Apexpages.currentPage().getParameters().get('AppName');
        strAuthCode=ApexPages.currentPage().getparameters().get('code'); 
        EApp=new External_Application__c();
        if(StrAppName!=null && StrAppName!=''){
            for(External_Application__c ea:[select id,kcs_dev__Client_ID__c,Salesforce_Domain__c,kcs_dev__Consumer_secret__c,Callback_URL__c,Application_Name__c,Access_Token__c,ID__c,Instance_URL__c,Issued_at__c,Outh_Code__c,Refresh_Token__c,Signature__c from kcs_dev__External_Application__c where Application_Name__c=:StrAppName]){
                EApp=ea;
            }
        }
        system.debug('******SSSSSS;'+EApp);
        
    }
    public PageReference WebServerlogin(){
        system.debug('******strAuthCode;'+strAuthCode);
        system.debug('******EApp.Client_ID__c;'+EApp.Client_ID__c);
        system.debug('******EApp.Callback_URL__c;'+EApp.Callback_URL__c);
        system.debug('******EApp.Salesforce_Domain__c;'+EApp.Salesforce_Domain__c);
        if(strAuthCode==null || strAuthCode==''){
            if(EApp.Client_ID__c!=null && EApp.Client_ID__c!='' && EApp.Callback_URL__c!=null && EApp.Callback_URL__c!='' && EApp.Salesforce_Domain__c!=null && EApp.Salesforce_Domain__c!=''){
                
                PageReference p1=new PageReference('https://'+EApp.Salesforce_Domain__c+'/services/oauth2/authorize?response_type=code&client_id='+EApp.Client_ID__c.trim()+'&redirect_uri='+EApp.Callback_URL__c);
                p1.setRedirect(true);
                return p1;
            }
            else{
                ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR,'Please check if Cliend ID,Callback URL and domain name or target is present in '+EApp.Application_Name__c+' record. If not, Please specify these values first.'));
            }
        }else{
            Find_access_token_Webserver();
        }
        PageReference p1=new pageReference('/'+EApp.id);
        p1.setRedirect(true);
        return p1;
        
    }
    public void Find_access_token_Webserver(){
        if(strAuthCode!=null && strAuthCode!='' && StrAppName!=null && StrAppName!='' && EApp.kcs_dev__Consumer_secret__c!=null && EApp.kcs_dev__Consumer_secret__c!=''){
            HttpRequest req=createHTTPRequest();
            HTTPResponse res=sendRequest(req);
            EApp.Authorization_Server_Response__c=res.getBody();
            System.debug(res.getBody());
            ResponseParser(res.getBody());
            update EApp;
        }
    }
    public HttpRequest createHTTPRequest(){
        EApp.Outh_Code__c=strAuthCode;
        HttpRequest req = new HttpRequest();
        String endPointURL='https://'+EApp.Salesforce_Domain__c+'/services/oauth2/token?code='+strAuthCode+'&grant_type=authorization_code&client_id='+EApp.Client_ID__c+'&client_secret='+EApp.kcs_dev__Consumer_secret__c+'&redirect_uri='+EApp.Callback_URL__c;
        System.debug('******endPointURL:'+endPointURL);
        req.setEndpoint(endPointURL);
        req.setMethod('POST');
        return req;
    }
    public void ResponseParser(String response ){
        // Parse JSON response to get refresh_token values.
        JSONParser parser = JSON.createParser(response);
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
                String fieldName = parser.getText();
                parser.nextToken();
                if(fieldName == 'id') {
                    EApp.ID__c = parser.getText();
                    
                } else if(fieldName == 'issued_at'){
                    //EApp.Issued_at__c = parser.getIntegerValue();
                } else if(fieldName == 'scope'){
                    EApp.Scope__c = parser.gettext();
                } else if(fieldName == 'instance_url'){
                    EApp.Instance_URL__c = parser.gettext();
                    
                } else if(fieldName == 'refresh_token'){
                    EApp.Refresh_Token__c = parser.gettext();
                    
                } else if(fieldName == 'signature'){
                    EApp.Signature__c = parser.gettext();
                    
                } else if(fieldName == 'access_token'){
                    EApp.Access_Token__c= parser.gettext();
                    
                }
            }
        }
    }
    
    public HTTPResponse sendRequest(HttpRequest Req){
        Http http = new Http();
        HTTPResponse res = http.send(req);
        return res;
    }   
    
    
}