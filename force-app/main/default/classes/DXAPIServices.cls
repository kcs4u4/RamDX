public with sharing class DXAPIServices {  
    static String completeURL = Label.SFDX_Server; //'http://183.82.118.223:8589/rabit/rabitservices?wsdl';//
    // static String completeURL = '';
    public static String sessionId;
    string encryptString;
    @AuraEnabled
    public static Object userLogin(){  
        sessionId =null;
        DXAPIServices getuserLogin = new DXAPIServices();  
        HttpRequest req = getuserLogin.buildWebServiceRequest();
        String reqBody = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:userLogin><usermail>09A63c3Jpbml2YXMuc0BhdXRvcmFiaXQuY29tDDB76</usermail><password>srinuUmFiaXRANzg5gtree</password><seccode/></web:userLogin></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getuserLogin.invokeWebService(http, req);
        sessionId  = res.getHeader('Set-Cookie');
        //  sessionId  = sessionId.split('=')[1];  
        System.debug('sessionId***********'+sessionId);
        if(sessionId!=null)   
            updateSessionId(sessionId);  
        Object resObj = getuserLogin.getResponseData(res,reqBody,false);
        return resObj;        
    }   
    @future 
    public static void updateSessionId(String sessionId) {
        DXAPISettings__c dx = DXAPISettings__c.getValues('api');
        dx.sessionid__c = sessionId;
        update dx;
    }
    
    @AuraEnabled
    public static Object createDevhub(String name,String hubname,String code){        
        DXAPIServices loginActivity = new DXAPIServices();   
        String id = ArAppSingleTon.randomStringGenerator(); 
        String OAuth = 'OAuth';
        String usermail = UserInfo.getUserEmail();
        String orgname = usermail.split('@')[1]+'-QoROkb';
        Boolean t = true;
        HttpRequest req = loginActivity.buildWebServiceRequest();
        String xmlStr='<sfdxhub hubname="'+hubname+'" uid="'+id+'" sfacctype="'+OAuth+'" sfhuburl="'+'https://login.salesforce.com'+'" code="'+code+'" environment="'+'ProdDev'+ '" isnew="'+t+'"  />';
        String EnValue = ArAppSingleTon.encodeValue(xmlStr,5);
        String reqBody = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ws=\"http://ws.service.rabit.com/\"><soapenv:Header></soapenv:Header><soapenv:Body><ws:registerSfdxHubWithOAuth><hubregrequestobj>'+EnValue+'</hubregrequestobj> </ws:registerSfdxHubWithOAuth></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = loginActivity.invokeWebService(http, req);
        return  loginActivity.getResponseData(res,reqBody,true);        
    }   
    @AuraEnabled 
    public static Object getDevHubList(){   
        DXAPIServices loginActivity = new DXAPIServices();       
        String usermail = UserInfo.getUserEmail();
        System.debug('usermail------------'+usermail);
        String orgname = usermail.split('@')[1]+'-QoROkb';
        System.debug('orgname------------'+orgname);
        HttpRequest req = loginActivity.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws=\"http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getSfdxHubHistory></ws:getSfdxHubHistory></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();
        try{
            HttpResponse res = loginActivity.invokeWebService(http, req);
            System.debug('Login String: ' + res.toString());
            System.debug('Login StatusCode: ' + res.getStatusCode());
            System.debug('Login Status: ' + res.getStatus());
            System.debug('Login Body: ' + res.getBody());    
            System.debug('Login Soap Body -?  ' + reqBody);
            System.debug('reponse- ' + res.getBody());
            return  loginActivity.getEncryptResponseData(res,reqBody,loginActivity,5);             
        }
        catch(DmlException e) {
            return null;
        }
    }  
    @AuraEnabled
    public static Object unregisterDevHub(string hubname){        
        DXAPIServices unregister = new DXAPIServices();
        String usermail = UserInfo.getUserEmail();
        String orgname= usermail.split('@')[1]+'-QoROkb';
        // get hub id from Dx LoginActivity Controller
        String hubnames=hubname;
        String EnValue = ArAppSingleTon.encodeValue(hubnames,5);
        HttpRequest req = unregister.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ws=\"http://ws.service.rabit.com/\"><soapenv:Header/><soapenv:Body><ws:unRegisterSfdxHub><sfdxhubname>'+EnValue+'</sfdxhubname></ws:unRegisterSfdxHub></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = unregister.invokeWebService(http, req);
        Object resObj = unregister.getResponseData(res,reqBody,true);
        return  resObj;      
    }   
    @AuraEnabled
    public static Object createScracthOrg(String hubid,String hubname,String hubuserid,String scrorgname,String scrorgusername,String edition ,String features,String Preferences,String almuserstoryid,String durationdays,String organization,String adminemail,String country,String language,String description,String hassampledata){
        DXAPIServices loginActivity = new DXAPIServices();   
        String orgid = ArAppSingleTon.randomStringGenerator(); 
        String createdby = UserInfo.getUserEmail();
        String orgname=createdby.split('@')[1]+'-QoROkb';
        Boolean t = true; 
        String xmlStr='<sandbox id="'+orgid+'" hubkey="'+hubname+'" hubname="'+hubname+'" hubid="'+hubid+'"  name="'+scrorgname+'" hubuserid="'+hubuserid+'" orgusername="'+scrorgusername+'" isnew="'+t+'" authenticationtype="OAuth" edition="'+edition+'" features="'+features+'" Preferences="'+Preferences+'"  almuserstoryid="'+almuserstoryid+'"/>';
        String EnValue = ArAppSingleTon.encodeValue(xmlStr,5);
        System.debug('hubname----'+hubname);
        System.debug('hubuserid----'+hubuserid);
        System.debug('hubid----'+hubid);
        HttpRequest req =loginActivity.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:createSfdxScratchOrg><scratchorgobj>'+EnValue+'</scratchorgobj></ws:createSfdxScratchOrg></soapenv:Body></soapenv:Envelope>';        
        req.setBody(reqBody);
        System.debug('reqBody----'+reqBody);
        Http http = new Http();     
        HttpResponse res = loginActivity.invokeWebService(http, req);
        return loginActivity.getResponseData(res,reqBody,true);        
    }   
    //New create scratch org function
    @AuraEnabled
    public static Object newCreateScracthOrg(map<String,String> dataMap){
        system.debug(dataMap);
        DXAPIServices loginActivity = new DXAPIServices();   
        String orgid = ArAppSingleTon.randomStringGenerator(); 
        String createdby = UserInfo.getUserEmail();
        String orgname=createdby.split('@')[1]+'-QoROkb';
        Boolean t = true; 
        String xmlStr='<sandbox id="'+orgid+'" isnew="'+t+'" authenticationtype="OAuth" ';
        for(string key:dataMap.keySet()){
            system.debug('---------key-------------'+key);
            system.debug('---------value-------------'+dataMap.get(key));
            String attrVal = dataMap.get(key)!=null?String.valueOf(dataMap.get(key)):'';
            String val = attrVal.length()>0?attrVal:'';
            xmlStr+= ' '+key+'="'+val+'"';
        }
        //        xmlStr+= ' hubkey="'+dataMap.get('hubname').toLowerCase()+'" description="" srcorg="" templatename="" hassampledata="false"/>';

        xmlStr+= '/>';
        System.debug('---xmlStr----'+xmlStr);
        String EnValue = ArAppSingleTon.encodeValue(xmlStr,5);
        System.debug('hubname----'+dataMap.get('hubname'));
        System.debug('hubuserid----'+dataMap.get('hubuserid'));
        System.debug('hubid----'+dataMap.get('hubid'));
        HttpRequest req =loginActivity.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:createSfdxScratchOrg><scratchorgobj>'+EnValue+'</scratchorgobj></ws:createSfdxScratchOrg></soapenv:Body></soapenv:Envelope>';        
        req.setBody(reqBody);
        System.debug('reqBody----'+reqBody);
        Http http = new Http();     
        HttpResponse res = loginActivity.invokeWebService(http, req);
        return loginActivity.getResponseData(res,reqBody,true);         
    }  
    @AuraEnabled
    public static Object ScratchOrgList(String hubname){        
        DXAPIServices getScratchOrgList = new DXAPIServices();    
        String createdby = UserInfo.getUserEmail();
        System.debug('createdby------------'+createdby); 
        String orgname = createdby.split('@')[1]+'-QoROkb';
        System.debug('orgname------------'+orgname);
        HttpRequest req = getScratchOrgList.buildWebServiceRequest();
        String xmlStr='<sandbox hubkey="'+hubname+'"/>';
        String EnValue = ArAppSingleTon.encodeValue(xmlStr,5);
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getSfdxScratchOrgs><scrorgrequest>'+EnValue+'</scrorgrequest></ws:getSfdxScratchOrgs></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getScratchOrgList.invokeWebService(http, req);
        System.debug('Login String: ' + res.toString());
        System.debug('Login StatusCode: ' + res.getStatusCode());
        System.debug('Login Status: ' + res.getStatus());
        System.debug('Login Body: ' + res.getBody());    
        System.debug('Login Soap Body -?  ' + reqBody);
        System.debug('reponse- ' + res.getBody());
        return getScratchOrgList.getEncryptResponseData(res,reqBody,getScratchOrgList,5);        
    } 
    @AuraEnabled
    public static Object ScratchOrgDelete(String soid,String soname,String sousername,String hubuserid,String flag){
        System.debug('---soid---'+soid+'---soname---'+soname+'---sousername------'+sousername+'---hubuserid---'+hubuserid+'---flag---'+flag);
        DXAPIServices ScratchOrgDelete = new DXAPIServices();   
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        HttpRequest req = ScratchOrgDelete.buildWebServiceRequest();
        String xmlStr='<sandbox id="'+soid+'" name="'+soname+'" hubuserid="'+hubuserid+'" orgusername="'+sousername+'"/>';
        String EnValue = ArAppSingleTon.encodeValue(xmlStr,5);
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:deleteScratchOrg><orgdetails>'+EnValue+'</orgdetails><deletesforg>'+flag+'</deletesforg></ws:deleteScratchOrg></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = ScratchOrgDelete.invokeWebService(http, req);
        return ScratchOrgDelete.getResponseData(res,reqBody,true);
    }
    
    @AuraEnabled
    public static Object ScratchOrgURL(String soname){
        DXAPIServices getScratchOrgURL = new DXAPIServices();   
        HttpRequest req = getScratchOrgURL.buildWebServiceRequest();
        // String Ensoid = ArAppSingleTon.encodeValue(soid,5);
        String Ensoname = ArAppSingleTon.encodeValue(soname,5);
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header /><soapenv:Body><ws:getScratchOrgURL><sforgkey>'+Ensoname+'</sforgkey></ws:getScratchOrgURL></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getScratchOrgURL.invokeWebService(http, req);
        return getScratchOrgURL.getEncryptResponseData(res,reqBody,getScratchOrgURL,5);
    }
    
    @AuraEnabled
    public static Object sendOrgCredentials(String sousername,String emails){
        DXAPIServices sendOrgCredentials = new DXAPIServices();   
        HttpRequest req = sendOrgCredentials.buildWebServiceRequest();
        
        String Ensousername = ArAppSingleTon.encodeValue(sousername,5);
        String Enemails= ArAppSingleTon.encodeValue(emails,5);
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:sendScratchOrgCredentials><sforgname>'+Ensousername+'</sforgname><emails>'+Enemails+'</emails></ws:sendScratchOrgCredentials></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = sendOrgCredentials.invokeWebService(http, req);
        return sendOrgCredentials.getResponseData(res,reqBody,true);
    }
    @AuraEnabled
    public static Object OrgUserEmails(){
        DXAPIServices getOrgUserEmails = new DXAPIServices();   
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        HttpRequest req = getOrgUserEmails.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getOrgUserEmails></ws:getOrgUserEmails></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getOrgUserEmails.invokeWebService(http, req);
        return getOrgUserEmails.getEncryptResponseData(res,reqBody,getOrgUserEmails,5);
    }
    @AuraEnabled
    public static Object AccessType(String username,String password,String accesskey,String scope,String type){
        DXAPIServices getAccessdetails = new DXAPIServices();   
        String EnValue = ArAppSingleTon.encodeValue(password,5);
        System.debug('EnValue-----'+EnValue);
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        String AccessValue='<accesskey  accesskey="'+accesskey+'" username="'+username+'" password="'+EnValue+'" scope="'+scope+'" type="'+type+'"/>';
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
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:saveCredential><info>'+EncodeValueofDecode+'</info><new>'+t+'</new></ws:saveCredential></soapenv:Body></soapenv:Envelope>'; 
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getAccessdetails.invokeWebService(http, req);
        // res.setBodyAsBlob(body);
        return getAccessdetails.getResponseData(res,reqBody,false);
    }
    @AuraEnabled
    public static Object AllCredentials(){
        DXAPIServices getAllCredentials = new DXAPIServices(); String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';HttpRequest req = getAllCredentials.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getAllCredentials></ws:getAllCredentials></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getAllCredentials.invokeWebService(http, req);
        return getAllCredentials.getEncryptResponseData(res,reqBody,getAllCredentials,5);
    }
    
    @AuraEnabled
    public static Object Vcsplugins(){
        DXAPIServices getVcsplugins = new DXAPIServices();   
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';    
        HttpRequest req = getVcsplugins.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getPlugins><orgname>'+orgname+'</orgname></ws:getPlugins></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getVcsplugins.invokeWebService(http, req);
        return getVcsplugins.getEncryptResponseData(res,reqBody,getVcsplugins,5);
    }
    public void parseXML(DOM.XMLNode node,DXAPIServices obj) {
        if (node.getNodeType() == DOM.XMLNodeType.ELEMENT) {
            system.debug(node.getName());
            if(node.getName()=='return' || node.getName()=='faultstring' || node.getName()=='faultString'){
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
        DXAPIServices getvalidateSCMCredentials = new DXAPIServices();  
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        HttpRequest req = getvalidateSCMCredentials.buildWebServiceRequest();
        String Enurl=ArAppSingleTon.encodeValue(url,5);
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:validateSCMCredentials><scmurl>'+Enurl+'</scmurl><accesskey>'+accesskey+'</accesskey><scmtype>'+type+'</scmtype><branchname/></ws:validateSCMCredentials></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getvalidateSCMCredentials.invokeWebService(http, req);
        return getvalidateSCMCredentials.getResponseData(res,reqBody,true);
    }
    @AuraEnabled
    public static Object registerSCMRepository(String url,String accesskey,string type,String DisplayName,Boolean isChange){
        DXAPIServices getregisterSCMRepository = new DXAPIServices();   
        String orgid = ArAppSingleTon.randomStringGenerator(); 
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        // user has to be register fot generate userid
        HttpRequest req = getregisterSCMRepository.buildWebServiceRequest();
        String Request='<repository id="'+orgid+'" name="'+DisplayName+'" remoteurl="'+url+'" scmtype="'+type+'" accesskey="'+accesskey+'" scmhost="'+type+'" registeredby="'+createdby+'" />';
        String Enreq=ArAppSingleTon.encodeValue(Request,5);
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:registerSCMRepository><repositoryobj>'+Enreq+'</repositoryobj><ischanged>'+isChange+'</ischanged></ws:registerSCMRepository></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getregisterSCMRepository.invokeWebService(http, req);
        return getregisterSCMRepository.getResponseData(res,reqBody,true);
    }
    
    @AuraEnabled
    public static Object UserRepositories(){
        DXAPIServices getUserRepositories = new DXAPIServices();   
        String createdby = UserInfo.getUserEmail();
        String EnValue = ArAppSingleTon.encodeValue(createdby,5);
        String orgname = createdby.split('@')[1]+'-QoROkb';
        HttpRequest req = getUserRepositories.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getUserRepositories></ws:getUserRepositories></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getUserRepositories.invokeWebService(http, req);
        return getUserRepositories.getEncryptResponseData(res,reqBody,getUserRepositories,5);
    }
    
    @AuraEnabled
    public static Object SCMRepoDetails(String reponame){
        DXAPIServices getSCMRepoDetails = new DXAPIServices();   
        String createdby = UserInfo.getUserEmail();
        String EnUserValue = ArAppSingleTon.encodeValue(createdby,5);
        String orgname = createdby.split('@')[1]+'-QoROkb';
        String EnOrgValue = ArAppSingleTon.encodeValue(orgname,5);
        HttpRequest req = getSCMRepoDetails.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:getSCMRepoDetails><reponame>'+reponame+'</reponame></web:getSCMRepoDetails></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getSCMRepoDetails.invokeWebService(http, req);
        return getSCMRepoDetails.getEncryptResponseData(res,reqBody,getSCMRepoDetails,5);
    }
    @AuraEnabled
    public static Object BranchType(){
        DXAPIServices getBranchType = new DXAPIServices();   
        String createdby = UserInfo.getUserEmail();
        String EnUserValue = ArAppSingleTon.encodeValue(createdby,5);
        String orgname = createdby.split('@')[1]+'-QoROkb';
        String EnOrgValue = ArAppSingleTon.encodeValue(orgname,5);
        HttpRequest req = getBranchType.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:getBranchType></web:getBranchType></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getBranchType.invokeWebService(http, req);
        return getBranchType.getresponseData(res,reqBody,true);
    }
    @AuraEnabled
    public static Object createBranchType(String branchtype){
        DXAPIServices createBranchType = new DXAPIServices();   
        HttpRequest req = createBranchType.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:createBranchType><branchtypename>'+branchtype+'</branchtypename></web:createBranchType></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = createBranchType.invokeWebService(http, req);
        return createBranchType.getresponseData(res,reqBody,true);
    }
    @AuraEnabled
    public static Object RemoteBranches(String reponame){
        DXAPIServices getRemoteBranches = new DXAPIServices();   
        HttpRequest req = getRemoteBranches.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:getRemoteBranches><reponame>'+reponame+'</reponame></web:getRemoteBranches></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getRemoteBranches.invokeWebService(http, req);
        return getRemoteBranches.getresponseData(res,reqBody,true);
    } 
    @AuraEnabled
    public static Object Branches(String reponame){
        DXAPIServices getBranches = new DXAPIServices();   
        String createdby = UserInfo.getUserEmail();
        String EnUserValue = ArAppSingleTon.encodeValue(createdby,5);
        String orgname = createdby.split('@')[1]+'-QoROkb';
        String EnOrgValue = ArAppSingleTon.encodeValue(orgname,5);
        HttpRequest req = getBranches.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getBranches><reponame>'+reponame+'</reponame></ws:getBranches></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getBranches.invokeWebService(http, req);
        //return getBranches.getResponseData(res,reqBody,false);
        return getBranches.getEncryptResponseData(res,reqBody,getBranches,5);
    }
    @AuraEnabled
    public static Object convertApiSrcToSfdxSrc(String reponame, String repoid,String branchname, String scmtype, String foldername){
        DXAPIServices getconvertApiSrcToSfdxSrc = new DXAPIServices();   
        HttpRequest req = getconvertApiSrcToSfdxSrc.buildWebServiceRequest();
        String xmlstr='<branch reponame="'+reponame+'" repoid="'+repoid+'" name="'+branchname+'" scmtype="'+scmtype+'" sfdxfoldername="'+foldername+'"/>';
        String Enxmlstr = ArAppSingleTon.encodeValue(xmlstr,5);
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:convertApiSrcToSfdxSrc><branch>'+Enxmlstr+'</branch></ws:convertApiSrcToSfdxSrc></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getconvertApiSrcToSfdxSrc.invokeWebService(http, req);
        return getconvertApiSrcToSfdxSrc.getResponseData(res,reqBody,false);
    }
    @AuraEnabled
    public static Object revertSfdxSrcToApiSrc(String reponame, String repoid,String branchname, String scmtype, String foldername){
        DXAPIServices getrevertSfdxSrcToApiSrc = new DXAPIServices();   
        HttpRequest req = getrevertSfdxSrcToApiSrc.buildWebServiceRequest();
        String xmlstr='<branch reponame="'+reponame+'" repoid="'+repoid+'" name="'+branchname+'" scmtype="'+scmtype+'" sfdxfoldername="'+foldername+'"/>';
        String Enxmlstr = ArAppSingleTon.encodeValue(xmlstr,5);
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body> <ws:revertSfdxSrcToApiSrc><branch>'+Enxmlstr+'</branch></ws:revertSfdxSrcToApiSrc></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getrevertSfdxSrcToApiSrc.invokeWebService(http, req);
        return getrevertSfdxSrcToApiSrc.getResponseData(res,reqBody,false);
    }
    @AuraEnabled
    public static Object CreateBranch(String reponame, String Type, String scmtype ,String Parent, string DisplayName,string sfdxfoldername){
        DXAPIServices CreateBranch = new DXAPIServices();   
        HttpRequest req = CreateBranch.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:createBranch><reponame>'+reponame+'</reponame><branchtype>'+Type+'</branchtype><frombranch>'+Parent+'</frombranch><tobranch>nobranch</tobranch><branchname>'+DisplayName+'</branchname><scmtype>'+scmtype+'</scmtype><sfdxfoldername>'+sfdxfoldername+'</sfdxfoldername></ws:createBranch></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = CreateBranch.invokeWebService(http, req);
        return CreateBranch.getResponseData(res,reqBody,true);
    }
    @AuraEnabled
    public static Object deleteRepoBranch(String reponame, String branchname, String scmtype){
        DXAPIServices getdeleteRepoBranch = new DXAPIServices();   
        String Enreponame = ArAppSingleTon.encodeValue(reponame,5);
        HttpRequest req = getdeleteRepoBranch.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:deleteRepoBranch><reponame>'+Enreponame+'</reponame><branchnames>'+branchname+'</branchnames><scmtype>'+scmtype+'</scmtype></ws:deleteRepoBranch></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getdeleteRepoBranch.invokeWebService(http, req);
        return getdeleteRepoBranch.getResponseData(res,reqBody,true);
    }
    @AuraEnabled
    public static Object registerBranch(String reponame, String scmtype,String url,List<String> branches){
        DXAPIServices registerBranch = new DXAPIServices();   
        String Enreponame = ArAppSingleTon.encodeValue(reponame,5);
        HttpRequest req = registerBranch.buildWebServiceRequest();
        String xmlstr='';
        
        for( String branch:branches){
            Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(branch);
            if((Boolean)m.get('isSel'))
                xmlstr+='  <branch name="'+m.get('name')+'" date="'+m.get('date')+'" />';
        }
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:registerBranch><name>'+reponame+'</name><url>'+url+'</url><branchlist><branchlist>'+xmlstr+'</branchlist></branchlist><scmtype>'+scmtype+'</scmtype></ws:registerBranch></soapenv:Body></soapenv:Envelope>';
        system.debug('reqbody  '+reqbody);
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = registerBranch.invokeWebService(http, req);
        return registerBranch.getResponseData(res,reqBody,true);
    }
    @AuraEnabled
    public static Object saveModifyBranchXml(String reponame, String branchname, String branchparent, String Type){
        DXAPIServices saveModifyBranchXml = new DXAPIServices();  
        String Enreponame = ArAppSingleTon.encodeValue(reponame,5);
        HttpRequest req = saveModifyBranchXml.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header /><soapenv:Body><ws:saveModifyBranchXml><reponame>'+Enreponame+'</reponame><node><node><branch name="'+branchname+'" parent="'+branchparent+'" type="'+Type+'" /></node></node></ws:saveModifyBranchXml></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = saveModifyBranchXml.invokeWebService(http, req);
        return saveModifyBranchXml.getResponseData(res,reqBody,true);
    }
    @AuraEnabled
    public static Object Versions(String reponame ,String branchName){
        DXAPIServices getVersions = new DXAPIServices();  
        String Enreponame = ArAppSingleTon.encodeValue(reponame,5);
        HttpRequest req = getVersions.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:getSCMRevisions><reponame>'+Enreponame+'</reponame><scmtype>git</scmtype><branchname>'+branchName+'</branchname></web:getSCMRevisions></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getVersions.invokeWebService(http, req);
        return getVersions.getResponseData(res,reqBody,false);
    }
    @AuraEnabled
    public static Object SFOrgsWithOAuth(String sforgname,String orgtype,String code,String env,String sfurl){        
        DXAPIServices registerSFOrgsWithOAuth = new DXAPIServices();   
        String uid = ArAppSingleTon.randomStringGenerator(); 
        String OAuth = 'OAuth';
        String createdBy = UserInfo.getUserEmail();
        String orgname = createdBy.split('@')[1]+'-QoROkb';
        Boolean t = true;
        HttpRequest req = registerSFOrgsWithOAuth.buildWebServiceRequest();
        String reqBody = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:registerSFOrgsWithOAuth><uid>'+uid+'</uid><sforgname>'+sforgname+'</sforgname><sforgtype>'+orgtype+'</sforgtype><environment>'+env+'</environment><sforgurl>'+sfurl+'</sforgurl><code>'+code+'</code></ws:registerSFOrgsWithOAuth></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = registerSFOrgsWithOAuth.invokeWebService(http, req);
        return registerSFOrgsWithOAuth.getResponseData(res,reqBody,true);        
    }
    @AuraEnabled
    public static Object SBLabelExists(String labelname){
        DXAPIServices getSBLabelExists = new DXAPIServices(); 
        String createdby = UserInfo.getUserEmail();
        String EnUserValue = ArAppSingleTon.encodeValue(createdby,5);
        String orgname = createdby.split('@')[1]+'-QoROkb';
        String EnOrgValue = ArAppSingleTon.encodeValue(orgname,5);
        HttpRequest req = getSBLabelExists.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:isSBLabelExists><labelname>'+labelname+'</labelname></ws:isSBLabelExists></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getSBLabelExists.invokeWebService(http, req);
        return getSBLabelExists.getResponseData(res,reqBody,true);
    }
    
    @AuraEnabled
    public static Object registerSFOrgs(String sforgname,String orgtype,String env,String sfurl,String username,string password,string token){
        DXAPIServices getregisterSFOrgs = new DXAPIServices();   
        String uid = ArAppSingleTon.randomStringGenerator(); 
        String createdby = UserInfo.getUserEmail();
        String EnUserValue = ArAppSingleTon.encodeValue(createdby,5);
        String Enpassword=ArAppSingleTon.encodeValue(password,5);
        String orgname = createdby.split('@')[1]+'-QoROkb';
        boolean t=true;  
        HttpRequest req = getregisterSFOrgs.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:registerSFOrgs><uid>'+uid+'</uid><sforgname>'+sforgname+'</sforgname><sforgtype>'+orgtype+'</sforgtype><environment>'+env+'</environment><sforgurl>'+sfurl+'</sforgurl><username>'+username+'</username><password>'+Enpassword+'</password><stoken>'+token+'</stoken><isnew>'+t+'</isnew></web:registerSFOrgs></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getregisterSFOrgs.invokeWebService(http, req);
        return getregisterSFOrgs.getResponseData(res,reqBody,true);
    }
    @AuraEnabled
    public static Object SanboxesHistory(){
        DXAPIServices getSanboxesHistory = new DXAPIServices();  
        String createdby = UserInfo.getUserEmail();
        String EnValue = ArAppSingleTon.encodeValue(createdby,5);
        System.debug('EnValue****'+EnValue);
        String orgname = createdby.split('@')[1]+'-QoROkb';
        String Enorgname = ArAppSingleTon.encodeValue(orgname,5);
        System.debug('Enorgname******'+Enorgname);
        HttpRequest req = getSanboxesHistory.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getSanboxesHistory></ws:getSanboxesHistory></soapenv:Body></soapenv:Envelope>'; 
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getSanboxesHistory.invokeWebService(http, req);
        return getSanboxesHistory.getEncryptResponseData(res,reqBody,getSanboxesHistory,5);
    }
    @AuraEnabled
    public static Object SBDetails(String UID){
        DXAPIServices getSBDetails = new DXAPIServices();   
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
    public static Object SourcePackageManifest(String reponame ,String labelName, String destOrgname,String srcOrgname,string dpmsource,String type,String branch){
        DXAPIServices getSourcePackageManifest = new DXAPIServices();   
        System.debug('srcOrgname'+srcOrgname);
        String EnsrcOrgname = ArAppSingleTon.encodeValue(srcOrgname,5);
        String EndestOrgname = ArAppSingleTon.encodeValue(destOrgname,5);
        System.debug('EnsrcOrgname'+EnsrcOrgname);
        
        HttpRequest req = getSourcePackageManifest.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getSourcePackageManifest><projectname/><buildnumber/><sourceorgname>'+EnsrcOrgname+'</sourceorgname><destinationorgname>'+EndestOrgname+'</destinationorgname><labelname>'+labelName+'</labelname><deploymentsource>'+dpmsource+'</deploymentsource><filternode><packagetype>released,deleted,deprecated,unmanaged,null</packagetype><createddate condition="equals"/><createddate /><createddatecondition>equals</createddatecondition><createdby /><lastmodifieddate /><modifieddatecondition>equals</modifieddatecondition><metadatatype/><isprofilesonly>false</isprofilesonly><includepicklists>false</includepicklists><skippermissions>false</skippermissions></filternode><scmnode><reponame>'+reponame+'</reponame><type>'+type+'</type><branch>'+branch+'</branch></scmnode><scmlabel/><releaselabelid/><isprofilesonly>false</isprofilesonly></ws:getSourcePackageManifest></soapenv:Body></soapenv:Envelope>';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getSourcePackageManifest.invokeWebService(http, req);
        return getSourcePackageManifest.getResponseData(res,reqBody,false);
    }
    @AuraEnabled
    public static Object Agents(){
        DXAPIServices getAgents = new DXAPIServices(); 
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
    public static Object MembersForMetadataType(String Metadatatype,String srcOrgId,String srcOrgname,String labelName,string dpmsource){
        DXAPIServices getMembersForMetadataType = new DXAPIServices();   
        String createdby = UserInfo.getUserEmail();
        String EnsrcOrgname = ArAppSingleTon.encodeValue(srcOrgname,5);
        HttpRequest req = getMembersForMetadataType.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getMembersForMetadataType><projectname/><buildnumber/><sourceorgname>'+EnsrcOrgname+'</sourceorgname><labelname>'+labelname+'</labelname><deploymentsource>'+dpmsource+'</deploymentsource><metadatatype memberscontain="">'+Metadatatype+'</metadatatype><filternode><packagetype>released,deleted,deprecated,unmanaged,null</packagetype><createddate /><createddatecondition>equals</createddatecondition><createdby /><lastmodifieddate /><modifieddatecondition>equals</modifieddatecondition><lastmodifiedby/><metadatatype/><isprofilesonly>false</isprofilesonly><includepicklists>false</includepicklists><skippermissions>false</skippermissions></filternode></ws:getMembersForMetadataType></soapenv:Body></soapenv:Envelope> ';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getMembersForMetadataType.invokeWebService(http, req);
        return getMembersForMetadataType.getResponseData(res,reqBody,false);
    }
    @AuraEnabled
    public static Object SFOrgs(){
        DXAPIServices getSFOrgs = new DXAPIServices();   
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        HttpRequest req = getSFOrgs.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:getSFOrgs><module>deployment</module></web:getSFOrgs></soapenv:Body></soapenv:Envelope> ';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getSFOrgs.invokeWebService(http, req);
        return getSFOrgs.getEncryptResponseData(res,reqBody,getSFOrgs,5);
    }
    @AuraEnabled
    public static Object OrgDifference(String srcOrgname,String destorgname,String labelName, String dpmsource,string metadata,string reponame,string type,string branch, String revision){
        DXAPIServices getOrgDifference = new DXAPIServices();  
        String id = ArAppSingleTon.randomStringGenerator();
        HttpRequest req = getOrgDifference.buildWebServiceRequest();
        String EnsrcOrgname = ArAppSingleTon.encodeValue(srcOrgname,5);
        system.debug('------------destorgname---------------'+destorgname); 
        String EndestOrgname = ArAppSingleTon.encodeValue(destorgname,5);
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
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:getOrgDifference><projectname></projectname><buildnumber></buildnumber><sourceorgname>'+EnsrcOrgname+'</sourceorgname><destinationorgname>'+EndestOrgname+'</destinationorgname><labelname>'+labelName+'</labelname><deploymentsource>'+dpmsource+'</deploymentsource><deploymenttype>custom</deploymenttype><metadatanode><deploylog>'+xmlstr+'</deploylog></metadatanode><filternode><packagetype>released,deleted,deprecated,unmanaged,null</packagetype><createddate/><createddatecondition>equals</createddatecondition><createdby/><lastmodifieddate/><modifieddatecondition>equals</modifieddatecondition><lastmodifiedby/><metadatatype/><isprofilesonly>false</isprofilesonly><includepicklists>false</includepicklists><skippermissions>false</skippermissions></filternode><skipnonexistpermisions>false</skipnonexistpermisions><scmnode><repository>'+reponame+'</repository><type>'+type+'</type><branch>'+branch+'</branch><revision>'+revision+'</revision></scmnode><scmlabel></scmlabel><releaselabelid></releaselabelid><isprofilesonly>false</isprofilesonly><packagezip></packagezip><processid>'+id+'</processid></web:getOrgDifference></soapenv:Body></soapenv:Envelope>';  
        req.setBody(reqBody);
        
        Http http = new Http();     
        HttpResponse res = getOrgDifference.invokeWebService(http, req);
        system.debug('res-------'+res.getBody());
        //return getOrgDifference.getEncryptResponseData(res,reqBody,getOrgDifference,5);
        return getOrgDifference.getResponseData(res,reqBody,false);
    }
    
    @AuraEnabled
    public static Object metaDataFileDiff(String srcOrgname,String destOrgname,String labelName, String fullname,String dpmsource,string type){
        DXAPIServices getFileDiff = new DXAPIServices();   
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        HttpRequest req = getFileDiff.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:getFileDiff><labelname>'+labelname+'</labelname><packgname>unpackaged</packgname><metadatatype>'+type+'</metadatatype><srcmembername>'+fullname+'</srcmembername><destmembername></destmembername><sourcetype>'+dpmsource+'</sourcetype><sourceorgname>'+ArAppSingleTon.encodeValue(srcOrgname,5)+'</sourceorgname><destorgname>'+ArAppSingleTon.encodeValue(destOrgname,5)+'</destorgname></web:getFileDiff></soapenv:Body></soapenv:Envelope>';  
        system.debug('---reqBody----'+reqBody);
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getFileDiff.invokeWebService(http, req);
        system.debug('---res----'+res);
        return getFileDiff.getEncryptResponseData(res,reqBody,getFileDiff,5);
    }
    
    @AuraEnabled
    public static object deployMetadata(String destOrgId,String srcOrgId,String destOrgname,String srcOrgname,String srcusername,String agentid,string labelname,string dpmsource,string metadata,string repoid,string type,string branch){
        DXAPIServices getdeployMetadata = new DXAPIServices();
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
        String XmlValue='<metadatanode><srcusername>'+srcusername+'</srcusername><deploylog>'+xmlstr+'</deploylog></metadatanode>';
        String Enxmlstr = ArAppSingleTon.encodeValue(XmlValue,5);
        system.debug('-------------------xmlstr-----------------'+xmlstr);
        system.debug('-------------------xmlstr-----------------'+Enxmlstr);
        String EnsrcOrgname = ArAppSingleTon.encodeValue(srcOrgname,5);
        String EndestOrgname = ArAppSingleTon.encodeValue(destOrgname,5);
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:deployMetadata><projectname></projectname><buildnumber></buildnumber><sourceorgname>'+EnsrcOrgname+'</sourceorgname><destinationorgname>'+EndestOrgname+'</destinationorgname><labelname>'+labelname+'</labelname><deploymentsource>'+dpmsource+'</deploymentsource><deploymenttype>custom</deploymenttype><description></description><agentid>'+agentid+'</agentid><orgcompare>false</orgcompare><skipwarnings>false</skipwarnings><skipdestructivechanges>false</skipdestructivechanges><metadatanode>'+Enxmlstr+'</metadatanode><filternode><packagetype>released,deleted,deprecated,unmanaged,null</packagetype><createddate/><createddatecondition>equals</createddatecondition><createdby/><lastmodifieddate/><modifieddatecondition>equals</modifieddatecondition><lastmodifiedby/><metadatatype/><isprofilesonly>false</isprofilesonly><includepicklists>false</includepicklists></filternode><scmnode>    <repository>'+repoid+'</repository><type>'+type+'</type><branch>'+branch+'</branch></scmnode><skipnonexistpermisions>false</skipnonexistpermisions><validatedeploy>false</validatedeploy><orgbackup>false</orgbackup><testlevel>NoTestRun</testlevel><selectedtests></selectedtests><scmlabel></scmlabel><releaselabelid></releaselabelid><destructivenode /><isprofilesonly>false</isprofilesonly><packagezip></packagezip><iterationnumber>1</iterationnumber></web:deployMetadata></soapenv:Body></soapenv:Envelope>';  
        req.setBody(reqBody);
        
        Http http = new Http();     
        HttpResponse res = getdeployMetadata.invokeWebService(http, req);
        Object deployMetadata= getdeployMetadata.getResponseData(res,reqBody,false);
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
        DXAPIServices getDeploymentIterations = new DXAPIServices();
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        HttpRequest req = getDeploymentIterations.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:getDeploymentIterations><labelname>'+labelname+'</labelname></web:getDeploymentIterations></soapenv:Body></soapenv:Envelope>';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getDeploymentIterations.invokeWebService(http, req);
        return getDeploymentIterations.getEncryptResponseData(res,reqBody,getDeploymentIterations,5);
        
    }
    @AuraEnabled
    public static Object DeploymentStatus(string destOrgname,string asyncid){
        DXAPIServices getDeploymentStatus = new DXAPIServices();
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        HttpRequest req = getDeploymentStatus.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getDeploymentStatus><sforgname>'+destOrgname+'</sforgname><asyncid>'+asyncid+'</asyncid></ws:getDeploymentStatus></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getDeploymentStatus.invokeWebService(http, req);
        return getDeploymentStatus.getResponseData(res,reqBody,true);
    }
    @AuraEnabled
    public static Object PromotionLog(string labelname){
        DXAPIServices getPromotionLog = new DXAPIServices();
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        HttpRequest req = getPromotionLog.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getPromotionLog><projectname>'+labelname+'</projectname><buildnumber>1</buildnumber></ws:getPromotionLog></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getPromotionLog.invokeWebService(http, req);
        return getPromotionLog.getResponseData(res,reqBody,false);
    }
    /* Ez commit Code Starts here */ 
    @AuraEnabled
    public static Object SalesForceUsersSCMMapping(){
        DXAPIServices getSalesForceUsersSCMMapping = new DXAPIServices();
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        HttpRequest req = getSalesForceUsersSCMMapping.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:getSalesForceUsersSCMMapping></web:getSalesForceUsersSCMMapping></soapenv:Body></soapenv:Envelope>';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getSalesForceUsersSCMMapping.invokeWebService(http, req);
        return getSalesForceUsersSCMMapping.getEncryptResponseData(res,reqBody,getSalesForceUsersSCMMapping,5);
    }
    @AuraEnabled
    public static Object fetchUserChangesFromSfOrg(String usersList,string sforgname,string reponame,string branch){
        DXAPIServices getfetchUserChangesFromSfOrg = new DXAPIServices();
        String Ensforgname = ArAppSingleTon.encodeValue(sforgname,5);
        String Enreponame = ArAppSingleTon.encodeValue(reponame,5);
        HttpRequest req = getfetchUserChangesFromSfOrg.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:fetchUserChangesFromSfOrg><sforgname>'+Ensforgname+'</sforgname><userslist>'+usersList+'</userslist><include><manageablestate><state>released,deleted,deprecated,unmanaged,null</state></manageablestate></include><modifieddate/><reponame>'+Enreponame+'</reponame><branchname>'+branch+'</branchname></web:fetchUserChangesFromSfOrg></soapenv:Body> </soapenv:Envelope>';  
        system.debug('----------------------------------'+reqBody);
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getfetchUserChangesFromSfOrg.invokeWebService(http, req);
        return getfetchUserChangesFromSfOrg.getResponseData(res,reqBody,false);
    }
    @AuraEnabled
    public static object commitChangesToSCM(String dxfoldername, String usersList,String sforgname,string metadata,string reponame,string branch,String commitLabel,string comment){
        DXAPIServices getcommitChangesToSCM= new DXAPIServices();
        String Ensforgname = ArAppSingleTon.encodeValue(sforgname,5);
        String Enreponame = ArAppSingleTon.encodeValue(reponame,5);
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
                Map<String, Object> member = (Map<String, Object>)members[i];
                xmlstr+='<members name="'+member.get('fullname')+'" />';
            }
            xmlstr+='</types>';
        } 
        system.debug('-------------------xmlstr-----------------'+xmlstr);
        system.debug('-------------------xmlstr-----------------'+xmlstr);
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:commitChangesToSCM><sforgname>'+Ensforgname+'</sforgname><userslist><user id="'+usersList+'"><label type="'+commitLabel+'"/>'+xmlstr+'<profilesonly>false</profilesonly><comment>'+comment+'</comment><dxfoldername>'+dxfoldername+'</dxfoldername></user></userslist><reponame>'+Enreponame+'</reponame><branchname>'+branch+'</branchname></web:commitChangesToSCM></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getcommitChangesToSCM.invokeWebService(http, req);
        return getcommitChangesToSCM.getResponseData(res,reqBody,false);
    }
    @AuraEnabled
    public static Object AdditionalMetadataTypes(string sforgname){
        DXAPIServices AdditionalMetadataTypes = new DXAPIServices();
        String Ensforgname = ArAppSingleTon.encodeValue(sforgname,5);
        HttpRequest req = AdditionalMetadataTypes.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getMetadataTypes><sforgname>'+Ensforgname+'</sforgname></ws:getMetadataTypes></soapenv:Body></soapenv:Envelope>';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = AdditionalMetadataTypes.invokeWebService(http, req);
        return AdditionalMetadataTypes.getResponseData(res,reqBody,false);
    }
    @AuraEnabled
    public static Object  getMetadataTypeMembers(String sforgname,String metadataType){
        DXAPIServices getAdditionalMetadataTypes = new DXAPIServices();
        String Ensforgname = ArAppSingleTon.encodeValue(sforgname,5);
        HttpRequest req = getAdditionalMetadataTypes.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:getMetadataMembers><sforgname>'+Ensforgname+'</sforgname><type>'+metadataType+'</type></web:getMetadataMembers></soapenv:Body></soapenv:Envelope>';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getAdditionalMetadataTypes.invokeWebService(http, req);
        return getAdditionalMetadataTypes.getResponseData(res,reqBody,false);
    }
    @AuraEnabled
    public static Object  CommitLabels(string reponame,string branch){
        DXAPIServices  getCommitLabels = new DXAPIServices();
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        HttpRequest req = getCommitLabels.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getAllCommitLabelsHistory><reponame>'+reponame+'</reponame><branchname>'+branch+'</branchname></ws:getAllCommitLabelsHistory></soapenv:Body></soapenv:Envelope>';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getCommitLabels.invokeWebService(http, req);
        return getCommitLabels.getResponseData(res,reqBody,false);
    }
    @AuraEnabled
    public static Object  getReleaseLabels(string reponame,string branch){
        DXAPIServices  releaseLabels = new DXAPIServices();
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        HttpRequest req = releaseLabels.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:getReleaseHistoryByRepoNameAndBranch><reponame>'+ArAppSingleTon.encodeValue(reponame,5)+'</reponame><branchname>'+ArAppSingleTon.encodeValue(branch,5)+'</branchname></web:getReleaseHistoryByRepoNameAndBranch></soapenv:Body></soapenv:Envelope>';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = releaseLabels.invokeWebService(http, req);
        return releaseLabels.getResponseData(res,reqBody,false);
    }
    @AuraEnabled
    public static Object CommitLabelExist(string reponame,string branch,string labelname){
        DXAPIServices   getCommitLabelExist = new DXAPIServices();
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        HttpRequest req = getCommitLabelExist.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:isCommitLabelExist><reponame>'+reponame+'</reponame><branchurl>'+branch+'</branchurl><labelname>'+labelname+'</labelname></ws:isCommitLabelExist></soapenv:Body></soapenv:Envelope>';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getCommitLabelExist.invokeWebService(http, req);
        return getCommitLabelExist.getResponseData(res,reqBody,true);
    }
    @AuraEnabled
    public static object FileDifferencesForCompare(String usersList,String sforgname,string metadata,string reponame,string branch){
        DXAPIServices getFileDifferencesForCompare= new DXAPIServices();
        String Ensforgname = ArAppSingleTon.encodeValue(sforgname,5);
        String Enreponame = ArAppSingleTon.encodeValue(reponame,5);
        HttpRequest req = getFileDifferencesForCompare.buildWebServiceRequest();
        Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(metadata);
        system.debug('-------------------metadata-----------------'+metadata);
        string xmlstr = '';
        for(string key:m.keySet()){
            system.debug('---------------key-----------'+key);
            list<object> members = (list<object>)m.get(key);
            system.debug('---------------members-----------'+members);
            xmlstr+='<user id="'+usersList+'"><types name="'+key+'">';
            for(integer i=0;i<members.size();i++){
                Map<String, Object> member = (Map<String, Object>)members[i];
                xmlstr+='<members name="'+member.get('fullname')+'" filename="'+member.get('filename')+'" manageablestate="unmanaged" modifieddate="'+member.get('modifieddate')+'"/>';
            }
            xmlstr+='</types></user>';
        } 
        //  String Enxmlstr = ArAppSingleTon.encodeValue(xmlstr,5);
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:getFileDifferencesForCompare><sforgname>'+Ensforgname+'</sforgname><userslist>'+xmlstr+'</userslist><reponame>'+Enreponame+'</reponame><branchname>'+branch+'</branchname></web:getFileDifferencesForCompare></soapenv:Body></soapenv:Envelope>';
        system.debug('-------------------request-----------------'+reqBody);
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getFileDifferencesForCompare.invokeWebService(http, req);
        system.debug('-------------------response-----------------'+res.getBody());
        return getFileDifferencesForCompare.getEncryptResponseData(res,reqBody,getFileDifferencesForCompare,5);
    }
    
    @AuraEnabled
    public static Object ContentOfFilesDiff(string sforgname,string type,string fullName){
        DXAPIServices  getContentOfFilesDiff = new DXAPIServices();
        String Ensforgname = ArAppSingleTon.encodeValue(sforgname,5);
        HttpRequest req = getContentOfFilesDiff.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:getContentOfFilesDiff><sforgname>'+Ensforgname+'</sforgname><userid>All</userid><metadatatype>'+type+'</metadatatype><metadatamember>'+fullName+'</metadatamember></web:getContentOfFilesDiff></soapenv:Body></soapenv:Envelope>';  
        system.debug('-------------------request-----------------'+reqBody);
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getContentOfFilesDiff.invokeWebService(http, req);
        system.debug('-------------------response-----------------'+res.getBody());
        return getContentOfFilesDiff.getEncryptResponseData(res,reqBody,getContentOfFilesDiff,5);
    }
    
    @AuraEnabled
    public static Object Plugins(){
        DXAPIServices  getPlugins = new DXAPIServices();
        HttpRequest req = getPlugins.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header /><soapenv:Body><ws:getPlugins><orgname>null</orgname></ws:getPlugins></soapenv:Body></soapenv:Envelope>';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getPlugins.invokeWebService(http, req);
        return getPlugins.getEncryptResponseData(res,reqBody,getPlugins,5);
    }
    @AuraEnabled
    public static Object getReposMapped(){
        DXAPIServices  getReposMapped = new DXAPIServices();
        HttpRequest req = getReposMapped.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getReposMappedInMyProfile></ws:getReposMappedInMyProfile></soapenv:Body></soapenv:Envelope>';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getReposMapped.invokeWebService(http, req);
        return getReposMapped.getEncryptResponseData(res,reqBody,getReposMapped,5);
    }    
    @AuraEnabled
    public static Object ProjectsFromConnectors(string connectortype){
        DXAPIServices  getProjectsFromConnectors = new DXAPIServices();
        HttpRequest req = getProjectsFromConnectors.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:getProjectsFromConnectors><connectortype>'+connectortype+'</connectortype></web:getProjectsFromConnectors></soapenv:Body></soapenv:Envelope>';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getProjectsFromConnectors.invokeWebService(http, req);
        return getProjectsFromConnectors.getResponseData(res,reqBody,false);
    }
    @AuraEnabled
    public static Object PlannedForListFromALM(String projectkey,string connectortype){
        DXAPIServices  getPlannedForListFromALM = new DXAPIServices();
        HttpRequest req = getPlannedForListFromALM.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:getPlannedForListFromALM><connectortype>'+connectortype+'</connectortype><projectkey>'+projectkey+'</projectkey><querystring><params></params></querystring></web:getPlannedForListFromALM></soapenv:Body></soapenv:Envelope>';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getPlannedForListFromALM.invokeWebService(http, req);
        return getPlannedForListFromALM.getResponseData(res,reqBody,false);
    }
    @AuraEnabled
    public static Object AlmStories(String projectkey,string connectortype,string key,string id){
        DXAPIServices  getAlmStories = new DXAPIServices();
        HttpRequest req = getAlmStories.buildWebServiceRequest();
        String xmlStr='<almuserstory almSystem="'+connectortype+'" name="'+projectkey+'" id="'+id+'" key="'+key+'" />';
        String EnValue = ArAppSingleTon.encodeValue(xmlStr,5);
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header /><soapenv:Body><ws:getAlmStories><almnode>'+EnValue+'</almnode></ws:getAlmStories></soapenv:Body></soapenv:Envelope>';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getAlmStories.invokeWebService(http, req);
        return getAlmStories.getEncryptResponseData(res,reqBody,getAlmStories,5);
    }
    @AuraEnabled
    public static Object AlmWINotes(string workitemid){
        DXAPIServices  getAlmWINotes = new DXAPIServices();
        HttpRequest req = getAlmWINotes.buildWebServiceRequest();
        String xmlStr='<workitemsnote  workitemid="'+workitemid+'" />';
        String EnValue = ArAppSingleTon.encodeValue(xmlStr,5);
        //String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header /><soapenv:Body><ws:getAlmWINotes><almworkitemnote>'+EnValue+'</almworkitemnote></ws:getAlmWINotes></soapenv:Body></soapenv:Envelope>';  
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getAlmWINotes><almworkitemnote>'+EnValue+'</almworkitemnote></ws:getAlmWINotes></soapenv:Body></soapenv:Envelope>';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getAlmWINotes.invokeWebService(http, req);
        return getAlmWINotes.getEncryptResponseData(res,reqBody,getAlmWINotes,5);
    }
    @AuraEnabled
    public static Object addAlmNote(string workitemid,string note){
        DXAPIServices addAlmNote = new DXAPIServices();
        String xmlStr = '<workitemsnote workitemid="'+workitemid+'" notes="'+note+'"/>';
        String Enval = ArAppSingleTon.encodeValue(xmlStr,5);
        HttpRequest req = addAlmNote.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:saveAlmWINotes><almworkitemnote>'+Enval+'</almworkitemnote></ws:saveAlmWINotes></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = addAlmNote.invokeWebService(http, req);
        return addAlmNote.getResponseData(res,reqBody,true);
    }
    @AuraEnabled
    public static Object CommitsByFilter(string label){
        DXAPIServices  getCommitsByFilter = new DXAPIServices();
        HttpRequest req = getCommitsByFilter.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:getCommitsByFilter><repoid></repoid><branch></branch><label>'+label+'</label><fromdate></fromdate><todate></todate><committedby></committedby><committype>0</committype></web:getCommitsByFilter></soapenv:Body></soapenv:Envelope>';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getCommitsByFilter.invokeWebService(http, req);
        return getCommitsByFilter.getResponseData(res,reqBody,false);
    }
    @AuraEnabled
    public static Object createBranchOnALMStory(string createdby,string reponame,string type,string parent,string child,string name,string scmtype,string almworkitemid,string sfdxfoldername){
        DXAPIServices  createBranchOnALMStory = new DXAPIServices();
        HttpRequest req = createBranchOnALMStory.buildWebServiceRequest();
        String xmlStr='<branch createdby="'+createdby+'" reponame="'+reponame+'" type="'+type+'" parent="'+parent+'" child="'+child+'" name="'+name+'" scmtype="'+scmtype+'" almworkitemid="'+almworkitemid+'" sfdxfoldername="'+sfdxfoldername+'"/>';
        System.debug('--------------xmlStr---------------'+xmlStr);
        String EnValue = ArAppSingleTon.encodeValue(xmlStr,5);
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:createBranchOnALMStory><almbranch>'+EnValue+'</almbranch></ws:createBranchOnALMStory></soapenv:Body></soapenv:Envelope>';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = createBranchOnALMStory.invokeWebService(http, req);
        return createBranchOnALMStory.getResponseData(res,reqBody,false);
    }
    @AuraEnabled
    public static Object assignBranchOnALMStory(String reponame,String name,String almworkitemid){
        DXAPIServices  assignBranchOnALMStory = new DXAPIServices();
        HttpRequest req = assignBranchOnALMStory.buildWebServiceRequest();
        String xmlStr='<branch reponame="'+reponame+'" name="'+name+'" almworkitemid="'+almworkitemid+'"/>';
        System.debug('--------------xmlStr---------------'+xmlStr);
        String EnValue = ArAppSingleTon.encodeValue(xmlStr,5);
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:assignBranchOnALMStory><almbranch>'+EnValue+'</almbranch></ws:assignBranchOnALMStory></soapenv:Body></soapenv:Envelope>';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = assignBranchOnALMStory.invokeWebService(http, req);
        return assignBranchOnALMStory.getResponseData(res,reqBody,false);
    }
    @AuraEnabled
    public static Object registerBranchOnAlmStrory(String reponame,String url,String scmtype,String name,String lcd,String almworkitemid){
        DXAPIServices  registerBranchOnAlmStrory = new DXAPIServices();
        HttpRequest req = registerBranchOnAlmStrory.buildWebServiceRequest();
        String xmlStr='<branchlist><branch name="'+name+'" date="'+lcd+'"/></branchlist>';
        System.debug('--------------xmlStr---------------'+xmlStr);
        String EnValue = ArAppSingleTon.encodeValue(xmlStr,5);
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:registerBranchOnAlmStrory><id>'+ArAppSingleTon.encodeValue(reponame,5)+'</id><url>'+ArAppSingleTon.encodeValue(url,5)+'</url><branchlist>'+EnValue+'</branchlist><scmtype>'+ArAppSingleTon.encodeValue(scmtype,5)+'</scmtype><userstoryid>'+ArAppSingleTon.encodeValue(almworkitemid,5)+'</userstoryid></ws:registerBranchOnAlmStrory></soapenv:Body></soapenv:Envelope>';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = registerBranchOnAlmStrory.invokeWebService(http, req);
        return registerBranchOnAlmStrory.getResponseData(res,reqBody,false);
    }
    @AuraEnabled
    public static Object pullAlmProjects(String almType){
        DXAPIServices  getAlmProjects = new DXAPIServices();
        HttpRequest req = getAlmProjects.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:getProjectsFromConnectors><connectortype>'+almType+'</connectortype></web:getProjectsFromConnectors></soapenv:Body></soapenv:Envelope>';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getAlmProjects.invokeWebService(http, req);
        return getAlmProjects.getResponseData(res,reqBody,false);
    }
    @AuraEnabled
    public static Object getSprints(String almType,String projKey){
        DXAPIServices  getSprints = new DXAPIServices();
        HttpRequest req = getSprints.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:getPlannedForListFromALM><connectortype>'+almType+'</connectortype><projectkey>'+projKey+'</projectkey><querystring><params ></params></querystring></web:getPlannedForListFromALM></soapenv:Body></soapenv:Envelope>';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getSprints.invokeWebService(http, req);
        return getSprints.getResponseData(res,reqBody,false);
    }
    @AuraEnabled
    public static Object getSCMRevisions(String reponame,String branchname,String scmtype){
        DXAPIServices  getSCMRevisions = new DXAPIServices();
        HttpRequest req = getSCMRevisions.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:getSCMRevisions><reponame>'+reponame+'</reponame><scmtype>'+scmtype+'</scmtype><branchname>'+branchname+'</branchname></web:getSCMRevisions></soapenv:Body></soapenv:Envelope>';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getSCMRevisions.invokeWebService(http, req);
        return getSCMRevisions.getResponseData(res,reqBody,false);
    }
    @AuraEnabled
    public static Object submitMergeRequest(Boolean isdryrun,String frombranch,String mergelabelname,String message,String reponame,String scmtype,String tobranch,String emailtolist){
        DXAPIServices submitMergeRequest = new DXAPIServices();
        HttpRequest req = submitMergeRequest.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:submitMergeRequest><mergerequestobj><mergerequest><dryrun>'+isdryrun+'</dryrun><frombranch>'+frombranch+'</frombranch><mergelabelname>'+mergelabelname+'</mergelabelname><mergetype>B2B</mergetype><message>'+message+'</message><reponame>'+reponame+'</reponame><strategy>theirs</strategy><scmtype>'+scmtype+'</scmtype><tobranch>'+tobranch+'</tobranch><emailtolist>'+emailtolist+'</emailtolist><ismergenotify>false</ismergenotify></mergerequest></mergerequestobj></ws:submitMergeRequest></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = submitMergeRequest.invokeWebService(http, req);
        return submitMergeRequest.getResponseData(res,reqBody,false);
    }
    @AuraEnabled
    public static Object pullAllWorkItems(String almType,String projKey,String sprintName,String sprintId){
        DXAPIServices  pullAllWorkItems = new DXAPIServices();
        HttpRequest req = pullAllWorkItems.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:getWorkItemsByProject><projectkey>'+projKey+'</projectkey><querystring><params all="false"><modifieddate></modifieddate><project>'+projKey+'</project><status></status><workitemtypeid></workitemtypeid><sprintname>'+sprintName+'</sprintname><sprintid>'+sprintId+'</sprintid></params></querystring><connectortype>'+almType+'</connectortype></web:getWorkItemsByProject></soapenv:Body></soapenv:Envelope>'; 
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = pullAllWorkItems.invokeWebService(http, req);
        return pullAllWorkItems.getResponseData(res,reqBody,false);
    }
    @AuraEnabled
    public static Object getMetadata(String sfOrgName){
        DXAPIServices  getMetadata = new DXAPIServices();
        HttpRequest req = getMetadata.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getMetadataTypes><sforgname>'+ArAppSingleTon.encodeValue(sfOrgName,5)+'</sforgname></ws:getMetadataTypes></soapenv:Body></soapenv:Envelope>'; 
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getMetadata.invokeWebService(http, req);
        return getMetadata.getResponseData(res,reqBody,false);
    } 
    @AuraEnabled
    public static Object isMergeLabelExist(string label){
        DXAPIServices isMergeLabelExist = new DXAPIServices();
        HttpRequest req = isMergeLabelExist.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:isMergeLabelExist><labelname>'+label+'</labelname></ws:isMergeLabelExist></soapenv:Body></soapenv:Envelope>';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = isMergeLabelExist.invokeWebService(http, req);
        return isMergeLabelExist.getResponseData(res,reqBody,false);
    }
    @AuraEnabled
    public static Object deleteSFOrg(String orgId,String orgLabel){
        DXAPIServices deleteSFOrg = new DXAPIServices();
        HttpRequest req = deleteSFOrg.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:deleteSFOrgs><sforgids>'+orgId+','+orgLabel+'</sforgids></ws:deleteSFOrgs></soapenv:Body></soapenv:Envelope>';  
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = deleteSFOrg.invokeWebService(http, req);
        return deleteSFOrg.getResponseData(res,reqBody,false);
    }
    @auraEnabled
    public static list<map<string,string>> getCountryDetails(){
        list<map<string,string>> countryList = new list<map<string,string>>();
        for(dxCountries__c country:dxCountries__c.getall().values()){
            map<string,string> temp = new map<string,string>();
            temp.put('name',country.countyName__c);
            temp.put('code',country.name);
            countryList.add(temp);
        }
        return countryList;
    }
    @auraEnabled
    public static list<map<string,string>> getLanguageDetails(){
        list<map<string,string>> langList = new list<map<string,string>>();
        for(dxLanguages__c language:dxLanguages__c.getall().values()){
            map<string,string> temp = new map<string,string>();
            temp.put('name',language.LanguageName__c);
            temp.put('code',language.name);
            langList.add(temp);
        }
        return langList;
    }
    @auraEnabled
    public static list<string> getDxFeatures(){
        list<string> featureList = new list<string>();
        for(dxFeatures__c feature:dxFeatures__c.getall().values()){
            featureList.add(feature.name);
        }
        return featureList;
    }
    @auraEnabled
    public static list<string> getDxOrgPreference(){
        list<string> preferencesList = new list<string>();
        for(dxOrgPreference__c feature:dxOrgPreference__c.getall().values()){
            preferencesList.add(feature.preferenceLabel__c);
        }
        return preferencesList;
    }
    @AuraEnabled
    public static Object assignScratchOrgUSM(map<String,String> dataMap){
        DXAPIServices assignScratchOrgUSM = new DXAPIServices();   
        String xmlStr='<sandbox ';
        for(string key:dataMap.keySet()){
            system.debug('---------key-------------'+key);
            system.debug('---------value-------------'+dataMap.get(key));
            String attrVal = dataMap.get(key)!=null?String.valueOf(dataMap.get(key)):'';
            String val = attrVal.length()>0?attrVal:'';
            xmlStr+= ' '+key+'="'+val+'"';
        }
        xmlStr+= '/>';
        HttpRequest req = assignScratchOrgUSM.buildWebServiceRequest();
        String EnValue = ArAppSingleTon.encodeValue(xmlStr,5);
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:assignScratchOrg><assignorgnode>'+EnValue+'</assignorgnode></ws:assignScratchOrg></soapenv:Body></soapenv:Envelope>';  
        system.debug('---reqBody----'+reqBody);
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = assignScratchOrgUSM.invokeWebService(http, req);
        system.debug('---res----'+res);
        return assignScratchOrgUSM.getResponseData(res,reqBody,true);
    }
    public object getResponseData(HttpResponse res,String reqBody,Boolean all){
        System.debug('Response: ' + res.toString());
        System.debug('Response StatusCode: ' + res.getStatusCode());
        System.debug('Response Status: ' + res.getStatus());
        System.debug('Response Body: ' + res.getBody());    
        System.debug('Request Body -?  ' + reqBody);
        System.debug('reponse- ' + res.getBody());        
        ResponseData resObj = new ResponseData();
        resObj.statusCode = res.getStatusCode();
        resObj.Resbody = res.getBody();
        resObj.Response = res.getStatus();
        notifiManger(resObj);
        return JSON.serialize(resObj); 
    }
    public object getEncryptResponseData(HttpResponse res,String reqBody,DXAPIServices obj,Integer len){
        if(res!=null){
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
            System.debug('Response StatusCode: ' + res.getStatusCode());
            System.debug('Response Status: ' + res.getStatus());
            System.debug('Response Body: ' + res.getBody());    
            System.debug('Request Body -?  ' + reqBody);
            System.debug('reponse- ' + res.getBody());  
            //notifiManger(resObj);
            return JSON.serialize(resObj);            
        }
        else{
            return null;
        }
        
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
        try{
            HttpRequest req = new HttpRequest();
            req.setMethod('POST');
            req.setHeader('Content-Type', 'text/xml; charset=utf-8');   
            DXAPISettings__c dx = DXAPISettings__c.getValues('api');
            system.debug('/////////////////////////////'+dx.sessionid__c); 
            if(dx.sessionid__c!=null){
                req.setHeader('Cookie',dx.sessionid__c); 
            }
            req.setEndpoint(completeURL); 
            req.setTimeout(120000);
            return req;
        }
        catch(Exception e) {
            ResponseData resObj = new ResponseData();
            resObj.statusCode = 500;
            resObj.Resbody = '<faultstring>'+e.getMessage()+'</faultstring>';
            notifiManger(resObj);
            return null;
        }
    }
    public HttpResponse invokeWebService(Http h, HttpRequest req){
        try{
            HttpResponse res = h.send(req);
            return res;
        }
        catch(Exception e) {
            ResponseData resObj = new ResponseData();
            resObj.statusCode = 500;
            resObj.Resbody = '<faultstring>'+e.getMessage()+'</faultstring>';
            notifiManger(resObj);
            return null;
        }
    }
    public class ResponseData{
        public Integer statusCode;
        public String Resbody; 
        public String Response;
    } 
    @AuraEnabled @future
    public static void leavePage(){
        /*DXAPISettings__c dx = DXAPISettings__c.getValues('api');
dx.sessionid__c = '';
update dx;*/
    }
    public static void notifiManger(ResponseData resObj){
        //ResponseData notfyObj = (ResponseData) JSON.deserialize(String.valueOf(resObj), ResponseData.class);
        system.debug('-------------resObj---------------'+resObj);
        sendNotification(resObj.Resbody,resObj.statusCode);
    }
    public static void sendNotification(string resBodyStr,Integer statusCode){
        try{
            if(resBodyStr.startsWith('<')){
                DXAPIServices  obj = new DXAPIServices();
                DOM.Document doc=new DOM.Document();
                system.debug('------------resBodyStr-------------'+resBodyStr);
                doc.load(resBodyStr);
                DOM.XmlNode rootNode=doc.getRootElement();
                obj.parseXML(rootNode,obj);
                String message = obj.encryptString;
                system.debug('------------message-------------'+message);
                if(message!=null && message.length()>0){
                    Notification__e event = new Notification__e();
                    event.Message__c = message;
                    event.type__c = statusCode == 200?'success':statusCode == 1?'info':'error';
                    event.statuscode__c = Decimal.valueOf(statusCode);
                    Database.SaveResult result = EventBus.publish(event); 
                    system.debug('------------result-------------'+result.isSuccess());
                }	                
            }	 
        }
        catch(Exception e) {
            Notification__e event = new Notification__e();
            event.Message__c = e.getMessage();
            event.type__c = statusCode == 200?'success':statusCode == 1?'info':'error';
            event.statuscode__c = Decimal.valueOf(statusCode);
            Database.SaveResult result = EventBus.publish(event);
        }
    }
    @AuraEnabled
    public static String getSessionId() {
        return UserInfo.getSessionId();
    }
    @AuraEnabled
    public static Object appLauncherOptions(){ 
        return DXAppLauncher__c.getall().values();
    }
    
    //Old methods
    /*@AuraEnabled
public static Object AlmWINotes(string orgname,string workitemid){
DXAPIServices  getAlmWINotes = new DXAPIServices();
HttpRequest req = getAlmWINotes.buildWebServiceRequest();
String xmlStr='<workitemsnote orgname="'+orgname+'" workitemid="'+workitemid+'" />';
String EnValue = ArAppSingleTon.encodeValue(xmlStr,5);
//String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header /><soapenv:Body><ws:getAlmWINotes><almworkitemnote>'+EnValue+'</almworkitemnote></ws:getAlmWINotes></soapenv:Body></soapenv:Envelope>';  
String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getAlmWINotes><almworkitemnote>'+EnValue+'</almworkitemnote></ws:getAlmWINotes></soapenv:Body></soapenv:Envelope>';  
req.setBody(reqBody);
Http http = new Http();     
HttpResponse res = getAlmWINotes.invokeWebService(http, req);
return getAlmWINotes.getEncryptResponseData(res,reqBody,getAlmWINotes,5);
}*/
}