public with sharing class DXLoginActivity {  
    static String completeURL = Label.DX_API2;
    // static String completeURL = '';
    string encryptString;
    @AuraEnabled
    public static Object createDevhub(String name,String hubname,String code){        
        DXLoginActivity loginActivity = new DXLoginActivity();   
        String id = ArAppSingleTon.randomStringGenerator(); 
        String OAuth = 'OAuth';
        String usermail = UserInfo.getUserEmail();
        String orgname = usermail.split('@')[1]+'-QoROkb';
        Boolean t = true;
        HttpRequest req = loginActivity.buildWebServiceRequest();
        String reqBody = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ws=\"http://ws.service.rabit.com/\"><soapenv:Body><ws:registerSfdxHubWithOAuth><orgname>'+orgname+'</orgname><hurregrequestobj><sfdxhub><orgname>'+orgname+'</orgname><hubname>'+hubname+'</hubname><createdby>'+usermail+'</createdby><uid>'+id+'</uid><sfacctype>'+OAuth+'</sfacctype><code>'+code+'</code><sfhuburl>'+'https://login.salesforce.com'+'</sfhuburl><isnew>'+t+'</isnew></sfdxhub></hurregrequestobj> </ws:registerSfdxHubWithOAuth></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = loginActivity.invokeWebService(http, req);
        return loginActivity.getResponseData(res,reqBody);        
    }   
    @AuraEnabled
    public static Object getDevHubList(){   
        DXLoginActivity loginActivity = new DXLoginActivity();       
        String usermail = UserInfo.getUserEmail();
        System.debug('usermail------------'+usermail);
        String orgname = usermail.split('@')[1]+'-QoROkb';
        System.debug('orgname------------'+orgname);
       
        HttpRequest req = loginActivity.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ws=\"http://ws.service.rabit.com/\"><soapenv:Header/><soapenv:Body><ws:getSfdxHubHistoryJson><orgname>'+orgname+'</orgname><username>'+usermail+'</username></ws:getSfdxHubHistoryJson></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = loginActivity.invokeWebService(http, req);
        System.debug('Login String: ' + res.toString());
        System.debug('Login StatusCode: ' + res.getStatusCode());
        System.debug('Login Status: ' + res.getStatus());
        System.debug('Login Body: ' + res.getBody());    
        System.debug('Login Soap Body -?  ' + reqBody);
        System.debug('reponse- ' + res.getBody());
        
        return res.getBody();        
    }  
    @AuraEnabled
    public static Object unregisterDevHub(string id){        
        DXLoginActivity unregister = new DXLoginActivity();   
        
        String usermail = UserInfo.getUserEmail();
        String orgname= usermail.split('@')[1]+'-QoROkb';
        // get hub id from Dx LoginActivity Controller
        String hubids=id;
        HttpRequest req = unregister.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ws=\"http://ws.service.rabit.com/\"><soapenv:Header/><soapenv:Body><ws:unRegisterSfdxHub><orgname>'+orgname+'</orgname><sfdxhubids>'+hubids+'</sfdxhubids></ws:unRegisterSfdxHub></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = unregister.invokeWebService(http, req);
        return unregister.getResponseData(res,reqBody);      
    }   
    @AuraEnabled
    public static Object createScracthOrg(String hubid,String hubname,String hubuserid,String scrorgname,String scrorgusername,String Edition){
        DXLoginActivity loginActivity = new DXLoginActivity();   
        String orgid = ArAppSingleTon.randomStringGenerator(); 
        
        String createdby = UserInfo.getUserEmail();
        String orgname=createdby.split('@')[1]+'-QoROkb';
        Boolean t = true; 
        System.debug('hubname----'+hubname);
        System.debug('hubuserid----'+hubuserid);
        System.debug('hubid----'+hubid);
        HttpRequest req =loginActivity.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:createSfdxScratchOrg><orgname>'+orgname+'</orgname><scratchorgobj><sandbox orgname="'+orgname+'" id="'+orgid+'" hubid="'+hubid+'" hubname="'+hubname+'" name="'+scrorgname+'" createdby="'+createdby+'" hubuserid="'+hubuserid+'" username="'+scrorgusername+'" isnew="'+t+'" edition="'+edition+'"/></scratchorgobj></ws:createSfdxScratchOrg></soapenv:Body></soapenv:Envelope>';        
        req.setBody(reqBody);
        System.debug('reqBody----'+reqBody);
        Http http = new Http();     
        HttpResponse res = loginActivity.invokeWebService(http, req);
        return loginActivity.getResponseData(res,reqBody);        
    }   
    
    @AuraEnabled
    public static Object ScratchOrgList(String hubid,String hubname){        
        DXLoginActivity getScratchOrgList = new DXLoginActivity();   
        
        String createdby = UserInfo.getUserEmail();
        System.debug('createdby------------'+createdby); 
        String orgname = createdby.split('@')[1]+'-QoROkb';
        System.debug('orgname------------'+orgname);
        HttpRequest req = getScratchOrgList.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getSfdxScratchOrgs><orgname>'+orgname+'</orgname><scrorgrequest><sandbox orgname="'+orgname+'" hubid="'+hubid+'" hubname="'+hubname+'" createdby="'+createdby+'"/></scrorgrequest></ws:getSfdxScratchOrgs></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getScratchOrgList.invokeWebService(http, req);
        System.debug('Login String: ' + res.toString());
        System.debug('Login StatusCode: ' + res.getStatusCode());
        System.debug('Login Status: ' + res.getStatus());
        System.debug('Login Body: ' + res.getBody());    
        System.debug('Login Soap Body -?  ' + reqBody);
        System.debug('reponse- ' + res.getBody());
        return res.getBody();        
    } 
    @AuraEnabled
    public static Object ScratchOrgDelete(String soid,String soname,String sousername,String hubuserid){
        DXLoginActivity ScratchOrgDelete = new DXLoginActivity();   
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        HttpRequest req = ScratchOrgDelete.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:deleteScratchOrg><orgname>'+orgname+'</orgname><deleteorg><sandbox id="'+soid+'" name="'+soname+'" hubuserid="'+hubuserid+'" username="'+sousername+'"/></deleteorg></ws:deleteScratchOrg></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = ScratchOrgDelete.invokeWebService(http, req);
        return ScratchOrgDelete.getResponseData(res,reqBody);
    }
    @AuraEnabled
    public static Object AccessType(String username,String password,String accesskey,String scope,String type){
        DXLoginActivity getAccessdetails = new DXLoginActivity();   
        String EnValue = ArAppSingleTon.encodeValue(password,5);
        System.debug('EnValue-----'+EnValue);
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        String userid='ZmzZ4vMlsRRtENXp';
        String AccessValue='<accesskey userid="'+userid+'" accesskey="'+accesskey+'" username="'+username+'" password="'+EnValue+'" scope="'+scope+'" type="'+type+'"/>';
        System.debug('AccessValue-----'+AccessValue);
        String EncodeValue = ArAppSingleTon.encodeValue(AccessValue,5);
        String DecodeValue = ArAppSingleTon.decodeValue(EncodeValue,5);
        System.debug('DecodeValue-----'+DecodeValue); 
        String EncodeValueofDecode = ArAppSingleTon.encodeValue(DecodeValue,5);
        System.debug('EncodeValueofDecode-----'+EncodeValueofDecode);
        String DecodeValue1 = ArAppSingleTon.decodeValue(EncodeValueofDecode,5);
        System.debug('DecodeValue1-----'+DecodeValue1); 
        boolean t=true;
        HttpRequest req = getAccessdetails.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:saveCredential><orgname>'+orgname+'</orgname><user>'+userid+'</user><info>'+EncodeValueofDecode+'</info><new>'+t+'</new></ws:saveCredential></soapenv:Body></soapenv:Envelope>'; 
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getAccessdetails.invokeWebService(http, req);
        // res.setBodyAsBlob(body);
        return getAccessdetails.getResponseData(res,reqBody);
    }
    @AuraEnabled
    public static Object AllCredentials(){
        DXLoginActivity getAllCredentials = new DXLoginActivity();   
        
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        String userid='ZmzZ4vMlsRRtENXp';
        HttpRequest req = getAllCredentials.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getAllCredentials><orgname>'+orgname+'</orgname><user>'+userid+'</user></ws:getAllCredentials></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getAllCredentials.invokeWebService(http, req);
        return getAllCredentials.getEncryptResponseData(res,reqBody,getAllCredentials,5);
    }
    
    @AuraEnabled
    public static Object Vcsplugins(){
        DXLoginActivity getVcsplugins = new DXLoginActivity();   
        
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';    
        HttpRequest req = getVcsplugins.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getPlugins><orgname>'+orgname+'</orgname></ws:getPlugins></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getVcsplugins.invokeWebService(http, req);
        return getVcsplugins.getEncryptResponseData(res,reqBody,getVcsplugins,5);
    }
    public void parseXML(DOM.XMLNode node,DXLoginActivity obj) {
        if (node.getNodeType() == DOM.XMLNodeType.ELEMENT) {
            system.debug(node.getName());
            if(node.getName()=='return'){
                system.debug('----------------entered-------------');
                system.debug('----------------text-------------'+node.getText());
                obj.encryptString = node.getText();
            }
            else{
                for (Dom.XMLNode child: node.getChildElements()) {
                    parseXML(child,obj);
                }
            }
        }
    }
    @AuraEnabled
    public static Object validateSCMCredentials(String url,String accesskey,string type){
        DXLoginActivity getvalidateSCMCredentials = new DXLoginActivity();   
        
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        String userid='ZmzZ4vMlsRRtENXp';
        HttpRequest req = getvalidateSCMCredentials.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:validateSCMCredentials><orgname>'+orgname+'</orgname><scmurl>'+url+'</scmurl><accesskey>'+accesskey+'</accesskey><userid>'+userid+'</userid><scmtype>'+type+'</scmtype><branchname/></ws:validateSCMCredentials></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getvalidateSCMCredentials.invokeWebService(http, req);
        return getvalidateSCMCredentials.getResponseData(res,reqBody);
    }
    @AuraEnabled
    public static Object registerSCMRepository(String url,String accesskey,string type,String DisplayName,Boolean isChange){
        DXLoginActivity getregisterSCMRepository = new DXLoginActivity();   
        String orgid = ArAppSingleTon.randomStringGenerator();
        
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        // user has to be register fot generate userid
        String userid='ZmzZ4vMlsRRtENXp';
        HttpRequest req = getregisterSCMRepository.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:registerSCMRepository><orgname>'+orgname+'</orgname><repositoryobj><repository id="'+orgid+'" name="'+DisplayName+'" remoteurl="'+url+'" scmtype="'+type+'" accesskey="'+accesskey+'" scmhost="'+type+'" registeredby="'+createdby+'" registeredid="'+userid+'"/></repositoryobj><ischanged>'+isChange+'</ischanged><userid>'+userid+'</userid></ws:registerSCMRepository></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getregisterSCMRepository.invokeWebService(http, req);
        return getregisterSCMRepository.getResponseData(res,reqBody);
    }
    
    @AuraEnabled
    public static Object UserRepositories(){
        DXLoginActivity getUserRepositories = new DXLoginActivity();   
        
        String createdby = UserInfo.getUserEmail();
        String EnValue = ArAppSingleTon.encodeValue(createdby,5);
        String orgname = createdby.split('@')[1]+'-QoROkb';
        HttpRequest req = getUserRepositories.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getUserRepositories><orgname>'+orgname+'</orgname><username>'+EnValue+'</username></ws:getUserRepositories></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getUserRepositories.invokeWebService(http, req);
        return getUserRepositories.getEncryptResponseData(res,reqBody,getUserRepositories,5);
    }
    
    @AuraEnabled
    public static Object SCMRepoDetails(String repoid){
        DXLoginActivity getSCMRepoDetails = new DXLoginActivity();   
        
        String createdby = UserInfo.getUserEmail();
        String EnUserValue = ArAppSingleTon.encodeValue(createdby,5);
        String orgname = createdby.split('@')[1]+'-QoROkb';
        String EnOrgValue = ArAppSingleTon.encodeValue(orgname,5);
        HttpRequest req = getSCMRepoDetails.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:getSCMRepoDetails><orgname>'+EnOrgValue+'</orgname><username>'+EnUserValue+'</username><repoid>'+repoid+'</repoid></web:getSCMRepoDetails></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getSCMRepoDetails.invokeWebService(http, req);
        return getSCMRepoDetails.getEncryptResponseData(res,reqBody,getSCMRepoDetails,5);
    }
    
    @AuraEnabled
    public static Object Branches(String repoid){
        DXLoginActivity getBranches = new DXLoginActivity();   
        
        String createdby = UserInfo.getUserEmail();
        String EnUserValue = ArAppSingleTon.encodeValue(createdby,5);
        String orgname = createdby.split('@')[1]+'-QoROkb';
        String EnOrgValue = ArAppSingleTon.encodeValue(orgname,5);
        HttpRequest req = getBranches.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getBranches><orgname>'+orgname+'</orgname><username>'+EnUserValue+'</username><repoid>'+repoid+'</repoid></ws:getBranches></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getBranches.invokeWebService(http, req);
        return getBranches.getResponseData(res,reqBody);
    }
    
    @AuraEnabled
    public static Object Versions(String repoid ,String branchName){
        DXLoginActivity getVersions = new DXLoginActivity();  
        String createdby = UserInfo.getUserEmail();
        String EnUserValue = ArAppSingleTon.encodeValue(createdby,5);
        String orgname = createdby.split('@')[1]+'-QoROkb';
        String EnOrgValue = ArAppSingleTon.encodeValue(orgname,5);
        HttpRequest req = getVersions.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:getSCMRevisions><orgname>'+orgName+'</orgname><repoid>'+repoid+'</repoid><scmtype>git</scmtype><branchname>'+branchName+'</branchname></web:getSCMRevisions></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getVersions.invokeWebService(http, req);
        return getVersions.getResponseData(res,reqBody);
    }
    @AuraEnabled
    public static Object SFOrgsWithOAuth(String sforgname,String orgtype,String code,String env,String sfurl){        
        DXLoginActivity registerSFOrgsWithOAuth = new DXLoginActivity();   
        String uid = ArAppSingleTon.randomStringGenerator(); 
        
        String OAuth = 'OAuth';
        String createdBy = UserInfo.getUserEmail();
        String orgname = createdBy.split('@')[1]+'-QoROkb';
        Boolean t = true;
        HttpRequest req = registerSFOrgsWithOAuth.buildWebServiceRequest();
        String reqBody = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:registerSFOrgsWithOAuth><orgname>'+orgName+'</orgname><createdby>'+createdby+'</createdby><uid>'+uid+'</uid><sforgname>'+sforgname+'</sforgname><sforgtype>'+orgtype+'</sforgtype><environment>'+env+'</environment><sforgurl>'+sfurl+'</sforgurl><code>'+code+'</code><isnew>'+t+'</isnew></ws:registerSFOrgsWithOAuth></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = registerSFOrgsWithOAuth.invokeWebService(http, req);
        return registerSFOrgsWithOAuth.getResponseData(res,reqBody);        
    }
    @AuraEnabled
    public static Object SBLabelExists(String labelname){
        DXLoginActivity getSBLabelExists = new DXLoginActivity(); 
        
        String createdby = UserInfo.getUserEmail();
        String EnUserValue = ArAppSingleTon.encodeValue(createdby,5);
        String orgname = createdby.split('@')[1]+'-QoROkb';
        String EnOrgValue = ArAppSingleTon.encodeValue(orgname,5);
        HttpRequest req = getSBLabelExists.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:isSBLabelExists><orgname>'+EnOrgValue+'</orgname><labelname>'+labelname+'</labelname></ws:isSBLabelExists></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getSBLabelExists.invokeWebService(http, req);
        return getSBLabelExists.getResponseData(res,reqBody);
    }
    
    @AuraEnabled
    public static Object registerSFOrgs(String sforgname,String orgtype,String env,String sfurl,String username,string password,string token){
        DXLoginActivity getregisterSFOrgs = new DXLoginActivity();   
        
        String uid = ArAppSingleTon.randomStringGenerator(); 
        String createdby = UserInfo.getUserEmail();
        String EnUserValue = ArAppSingleTon.encodeValue(createdby,5);
        String Enpassword=ArAppSingleTon.encodeValue(password,5);
        String orgname = createdby.split('@')[1]+'-QoROkb';
        boolean t=true;  
        HttpRequest req = getregisterSFOrgs.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:registerSFOrgs><orgname>'+orgname+'</orgname><createdby>'+createdby+'</createdby><uid>'+uid+'</uid><sforgname>'+sforgname+'</sforgname><sforgtype>'+orgtype+'</sforgtype><environment>'+env+'</environment><sforgurl>'+sfurl+'</sforgurl><username>'+username+'</username><password>'+Enpassword+'</password><stoken>'+token+'</stoken><isnew>'+t+'</isnew></web:registerSFOrgs></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getregisterSFOrgs.invokeWebService(http, req);
        return getregisterSFOrgs.getResponseData(res,reqBody);
    }
    @AuraEnabled
    public static Object SanboxesHistory(){
        DXLoginActivity getSanboxesHistory = new DXLoginActivity();   
        
        String createdby = UserInfo.getUserEmail();
        String EnValue = ArAppSingleTon.encodeValue(createdby,5);
        System.debug('EnValue****'+EnValue);
        String orgname = createdby.split('@')[1]+'-QoROkb';
        String Enorgname = ArAppSingleTon.encodeValue(orgname,5);
        System.debug('Enorgname******'+Enorgname);
        HttpRequest req = getSanboxesHistory.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getSanboxesHistory><orgname>'+Enorgname+'</orgname><username>'+EnValue+'</username></ws:getSanboxesHistory></soapenv:Body></soapenv:Envelope>'; 
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getSanboxesHistory.invokeWebService(http, req);
        return getSanboxesHistory.getEncryptResponseData(res,reqBody,getSanboxesHistory,5);
    }
    @AuraEnabled
    public static Object SBDetails(String UID){
        DXLoginActivity getSBDetails = new DXLoginActivity();   
        
        String createdby = UserInfo.getUserEmail();
        String EnValue = ArAppSingleTon.encodeValue(createdby,5);
        System.debug('EnValue****'+EnValue);
        String orgname = createdby.split('@')[1]+'-QoROkb';
        String Enorgname = ArAppSingleTon.encodeValue(orgname,5);
        System.debug('Enorgname******'+Enorgname);
        HttpRequest req = getSBDetails.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getSBDetails><orgname>'+Enorgname+'</orgname><username>'+EnValue+'</username><sandbox>'+UID+'</sandbox></ws:getSBDetails></soapenv:Body></soapenv:Envelope>'; 
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getSBDetails.invokeWebService(http, req);
        return getSBDetails.getEncryptResponseData(res,reqBody,getSBDetails,5);
    }
    @AuraEnabled
    public static Object SourcePackageManifest(String repoid ,String labelName, String destOrgId,string dpmsource,String type,String branch){
        DXLoginActivity getSourcePackageManifest = new DXLoginActivity();   
        
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        HttpRequest req = getSourcePackageManifest.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getSourcePackageManifest><orgname>'+orgname+'</orgname><projectname/><buildnumber/><sourceorgid/><destinationorgid>'+destorgid+'</destinationorgid><labelname>'+labelName+'</labelname><deploymentsource>'+dpmsource+'</deploymentsource><filternode><packagetype>released,deleted,deprecated,unmanaged,null</packagetype><createddate condition="equals"/><createdby/><lastmodifieddate condition="equals"/><lastmodifiedby/><metadatatype/><isprofilesonly>false</isprofilesonly><includepicklists>false</includepicklists><skippermissions>false</skippermissions></filternode><scmnode><repository>'+repoid+'</repository><type>'+type+'</type><branch>'+branch+'</branch></scmnode><username>'+createdby+'</username><scmlabel/><releaselabelid/><isprofilesonly>false</isprofilesonly></ws:getSourcePackageManifest></soapenv:Body></soapenv:Envelope>';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getSourcePackageManifest.invokeWebService(http, req);
        return getSourcePackageManifest.getResponseData(res,reqBody);
    }
    
    @AuraEnabled
    public static Object Agents(){
        DXLoginActivity getAgents = new DXLoginActivity();   
        
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1];
        HttpRequest req = getAgents.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getAgents><orgname>'+orgname+'</orgname></ws:getAgents></soapenv:Body></soapenv:Envelope>';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getAgents.invokeWebService(http, req);
        return getAgents.getEncryptResponseData(res,reqBody,getAgents,5);
    }
    @AuraEnabled
    public static Object MembersForMetadataType(String Metadatatype,String labelName,string dpmsource){
        DXLoginActivity getMembersForMetadataType = new DXLoginActivity();   
        
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        HttpRequest req = getMembersForMetadataType.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getMembersForMetadataType><orgname>'+orgname+'</orgname><projectname/><buildnumber/><sourceorgid/><labelname>'+labelname+'</labelname><deploymentsource>'+dpmsource+'</deploymentsource><metadatatype memberscontain="">'+Metadatatype+'</metadatatype><filternode><packagetype>released,deleted,deprecated,unmanaged,null</packagetype><createddate condition="equals"/><createdby/><lastmodifieddate condition="equals"/><lastmodifiedby/><metadatatype/><isprofilesonly>false</isprofilesonly><includepicklists>false</includepicklists><skippermissions>false</skippermissions></filternode><username>'+createdby+'</username></ws:getMembersForMetadataType></soapenv:Body></soapenv:Envelope> ';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getMembersForMetadataType.invokeWebService(http, req);
        return getMembersForMetadataType.getResponseData(res,reqBody);
    }
    
    @AuraEnabled
    public static object deployMetadata(String destOrgId,String agentid , string labelname,string dpmsource,string metadata,string repoid,string type,string branch){
        DXLoginActivity getdeployMetadata = new DXLoginActivity();
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        HttpRequest req = getdeployMetadata.buildWebServiceRequest();
        Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(metadata);
        system.debug('-------------------metadata-----------------'+metadata);
        string xmlstr = '';
        for(string key:m.keySet()){
            system.debug('---------------key-----------'+key);
            list<object> members = (list<object>)m.get(key);
            system.debug('---------------members-----------'+members);
            if(members.size()==0){
                xmlstr+='<metadatatype name="'+key+'" allmembers="true"></metadatatype>';
            }
            else{
                xmlstr+='<metadatatype name="'+key+'" allmembers="false">';
                for(integer i=0;i<members.size();i++){
                    xmlstr+='<member name="'+members[i]+'" />';
                }
                xmlstr+='</metadatatype>';
            }
        }
        system.debug('-------------------xmlstr-----------------'+xmlstr);
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:deployMetadata><orgname>'+orgname+'</orgname><projectname></projectname><buildnumber></buildnumber><sourceorgid></sourceorgid><destinationorgid>'+destOrgId+'</destinationorgid><labelname>'+labelname+'</labelname><deploymentsource>'+dpmsource+'</deploymentsource><deploymenttype>custom</deploymenttype><username>'+createdby+'</username><description></description><agentid>'+agentid+'</agentid><orgcompare>false</orgcompare><skipwarnings>false</skipwarnings><skipdestructivechanges>false</skipdestructivechanges><metadatanode><srcusername></srcusername><deploylog>'+xmlstr+'</deploylog></metadatanode><filternode><packagetype>released,deleted,deprecated,unmanaged,null</packagetype><createddate condition="equals" /><createdby /><lastmodifieddate condition="equals" /><lastmodifiedby /><metadatatype>Profile</metadatatype><isprofilesonly>false</isprofilesonly><includepicklists>false</includepicklists></filternode><scmnode>    <repository>'+repoid+'</repository>    <type>'+type+'</type><branch>'+branch+'</branch></scmnode><skipnonexistpermisions>false</skipnonexistpermisions><validatedeploy>false</validatedeploy><orgbackup>false</orgbackup><testlevel>NoTestRun</testlevel><selectedtests></selectedtests><scmlabel></scmlabel><releaselabelid></releaselabelid><destructivenode /><isprofilesonly>false</isprofilesonly><packagezip>undefined</packagezip></web:deployMetadata></soapenv:Body></soapenv:Envelope>';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getdeployMetadata.invokeWebService(http, req);
        Object deployMetadata= getdeployMetadata.getResponseData(res,reqBody);
        System.debug('deployMetadata*****'+deployMetadata);
        if(res.getStatusCode()==200){
            
            return DeploymentIterations(labelname,destOrgId);
            //ResponseData DeploymentIteration= (ResponseData)JSON.deserialize(String.valueOf(DeploymentIterations(labelname).getResponseData(res,reqBody)), ResponseData.class);
            
            
        }
        else{
            return deployMetadata;
        }
        return null;
        // return getdeployMetadata.getResponseData(res,reqBody);
    }
    
    
    @AuraEnabled
    public static Object DeploymentIterations(String labelname,string destOrgId){
        DXLoginActivity getDeploymentIterations = new DXLoginActivity();
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        HttpRequest req = getDeploymentIterations.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:getDeploymentIterations><orgname>'+orgname+'</orgname><labelname>'+labelname+'</labelname></web:getDeploymentIterations></soapenv:Body></soapenv:Envelope>';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getDeploymentIterations.invokeWebService(http, req);
        return getDeploymentIterations.getEncryptResponseData(res,reqBody,getDeploymentIterations,5);
        
    }
    @AuraEnabled
    public static Object DeploymentStatus(string destOrgId,string asyncid){
        DXLoginActivity getDeploymentStatus = new DXLoginActivity();
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        HttpRequest req = getDeploymentStatus.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getDeploymentStatus><orgname>'+orgname+'</orgname><sforgid>'+destOrgId+'</sforgid><asyncid>'+asyncid+'</asyncid></ws:getDeploymentStatus></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getDeploymentStatus.invokeWebService(http, req);
        return getDeploymentStatus.getResponseData(res,reqBody);
    }
    
    @AuraEnabled
    public static Object PromotionLog(string labelname){
        DXLoginActivity getPromotionLog = new DXLoginActivity();
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        HttpRequest req = getPromotionLog.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getPromotionLog><orgname>'+orgname+'</orgname><projectname>'+labelname+'</projectname><buildnumber>1</buildnumber></ws:getPromotionLog></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getPromotionLog.invokeWebService(http, req);
        return getPromotionLog.getResponseData(res,reqBody);
    }
    
    /* Ez commit Code Starts here */ 
    @AuraEnabled
    public static Object SalesForceUsersSCMMapping(){
        DXLoginActivity getSalesForceUsersSCMMapping = new DXLoginActivity();
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        HttpRequest req = getSalesForceUsersSCMMapping.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:getSalesForceUsersSCMMapping><orgname>'+orgname+'</orgname></web:getSalesForceUsersSCMMapping></soapenv:Body></soapenv:Envelope>';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getSalesForceUsersSCMMapping.invokeWebService(http, req);
        return getSalesForceUsersSCMMapping.getEncryptResponseData(res,reqBody,getSalesForceUsersSCMMapping,5);
    }
    
    @AuraEnabled
    public static Object fetchUserChangesFromSfOrg(string sforgid,string repoid,string branch){
        DXLoginActivity getfetchUserChangesFromSfOrg = new DXLoginActivity();
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        HttpRequest req = getfetchUserChangesFromSfOrg.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:fetchUserChangesFromSfOrg><orgname>'+orgname+'</orgname><sforgid>'+sforgid+'</sforgid><userslist>All</userslist><include><manageablestate><state>released,deleted,deprecated,unmanaged,null</state></manageablestate></include><modifieddate/><repoid>'+repoid+'</repoid><branchname>'+branch+'</branchname><skipmappings>false</skipmappings><triggeredby>'+createdby+'</triggeredby></web:fetchUserChangesFromSfOrg></soapenv:Body> </soapenv:Envelope>';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getfetchUserChangesFromSfOrg.invokeWebService(http, req);
        return getfetchUserChangesFromSfOrg.getResponseData(res,reqBody);
    }
    
    
    @AuraEnabled
    public static object commitChangesToSCM(String usersList,String sforgid,string metadata,string repoid,string branch){
        DXLoginActivity getcommitChangesToSCM= new DXLoginActivity();
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        HttpRequest req = getcommitChangesToSCM.buildWebServiceRequest();
        Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(metadata);
        system.debug('-------------------metadata-----------------'+metadata);
        string xmlstr = '';
        for(string key:m.keySet()){
            system.debug('---------------key-----------'+key);
            list<object> members = (list<object>)m.get(key);
            system.debug('---------------members-----------'+members);
            xmlstr+='<types name="'+key+'">';
            for(integer i=0;i<members.size();i++){
                xmlstr+='<members name="'+members[i]+'" />';
            }
            xmlstr+='</types>';
        } 
        system.debug('-------------------xmlstr-----------------'+xmlstr);
        system.debug('-------------------xmlstr-----------------'+xmlstr);
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:commitChangesToSCM><orgname>'+orgname+'</orgname><sforgid>'+sforgid+'</sforgid><committedby>'+createdby+'</committedby><userslist><user id="'+usersList+'"><label type="none"/>'+xmlstr+'<profilesonly>false</profilesonly><comment>multicommits</comment></user></userslist><repoid>'+repoid+'</repoid><branchname>'+branch+'</branchname><skipmappings>true</skipmappings></web:commitChangesToSCM></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getcommitChangesToSCM.invokeWebService(http, req);
        return getcommitChangesToSCM.getResponseData(res,reqBody);
    }

     @AuraEnabled
    public static Object AdditionalMetadataTypes(string sforgid){
        DXLoginActivity AdditionalMetadataTypes = new DXLoginActivity();
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        HttpRequest req = AdditionalMetadataTypes.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getMetadataTypes><orgName>'+orgName+'</orgName><sforgid>'+sforgid+'</sforgid></ws:getMetadataTypes></soapenv:Body></soapenv:Envelope>';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = AdditionalMetadataTypes.invokeWebService(http, req);
        return AdditionalMetadataTypes.getResponseData(res,reqBody);
    }
    
      @AuraEnabled
    public static Object  getAdditionalMetadataTypes(string sforgid){
        DXLoginActivity   getAdditionalMetadataTypes = new DXLoginActivity();
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        HttpRequest req = getAdditionalMetadataTypes.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:getMetadataMembers><orgName>'+orgName+'</orgName><sforgid>'+sforgid+'</sforgid><type>ApexClass</type></web:getMetadataMembers></soapenv:Body></soapenv:Envelope>';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getAdditionalMetadataTypes.invokeWebService(http, req);
        return getAdditionalMetadataTypes.getResponseData(res,reqBody);
    }
    
    
    public object getResponseData(HttpResponse res,String reqBody){
        System.debug('Login String: ' + res.toString());
        System.debug('Login StatusCode: ' + res.getStatusCode());
        System.debug('Login Status: ' + res.getStatus());
        System.debug('Login Body: ' + res.getBody());    
        System.debug('Login Soap Body -?  ' + reqBody);
        System.debug('reponse- ' + res.getBody());        
        ResponseData resObj = new ResponseData();
        resObj.statusCode = res.getStatusCode();
        resObj.Resbody = res.getBody();
        resObj.Response = res.getStatus();
        return JSON.serialize(resObj); 
    }
    public object getEncryptResponseData(HttpResponse res,String reqBody,DXLoginActivity obj,Integer len){
        DOM.Document doc=new DOM.Document();
        doc.load(res.getBody());
        DOM.XmlNode rootNode=doc.getRootElement();
        obj.parseXML(rootNode,obj);
        system.debug('----------------resText----------------------'+obj.encryptString);
        //String finalVal = rootNode.getChildElements()[0].getChildElements()[0].getChildElements()[0].getText();
        String finalVal = obj.encryptString;
        ResponseData resObj = new ResponseData();
        resObj.statusCode = res.getStatusCode();
        if(finalVal!=null){
            resObj.Resbody = ArAppSingleTon.decodeValue(finalVal,len);
        }
        else{
            resObj.Resbody = res.getBody();
        }
        resObj.Response = res.getStatus();
        return JSON.serialize(resObj);
    }    
      @AuraEnabled
    Public static object getuserInfo(){
      
        Map<String,Object> info = new Map<String,Object>(); 
        String createdby = UserInfo.getUserEmail();
        info.put('email',UserInfo.getUserEmail());
        info.put('name',UserInfo.getUserName());
       System.debug('info'+info);
        return info.get('email');
       
    }
    public HttpRequest buildWebServiceRequest(){
        Continuation con = new Continuation(40);

        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setHeader('Content-Type', 'text/xml; charset=utf-8');   
        req.setEndpoint(completeURL); 
        req.setTimeout(120000);
        return req;
    }
    
    public HttpResponse invokeWebService(Http h, HttpRequest req){
        HttpResponse res = h.send(req);
        return res;
    }
    public class ResponseData{
        public Integer statusCode;
        public String Resbody; 
        public String Response;
    }
    
    
}