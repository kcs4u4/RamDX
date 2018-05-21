public with sharing class testClass {  
    static String completeURL = Label.DX_API2;
    public String requestLabel;
    public HttpResponse res;
    // static String completeURL = '';
    string encryptString;
    @AuraEnabled
    public static Object createDevhub(String name,String hubname,String code){        
        testClass loginActivity = new testClass();   
        String id = ArAppSingleTon.randomStringGenerator(); 
        String OAuth = 'OAuth';
        String usermail = UserInfo.getUserEmail();
        String orgname = usermail.split('@')[1]+'-QoROkb';
        Boolean t = true;
        String reqBody = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ws=\"http://ws.service.rabit.com/\"><soapenv:Body><ws:registerSfdxHubWithOAuth><orgname>'+orgname+'</orgname><hurregrequestobj><sfdxhub><orgname>'+orgname+'</orgname><hubname>'+hubname+'</hubname><createdby>'+usermail+'</createdby><uid>'+id+'</uid><sfacctype>'+OAuth+'</sfacctype><code>'+code+'</code><sfhuburl>'+'https://login.salesforce.com'+'</sfhuburl><isnew>'+t+'</isnew></sfdxhub></hurregrequestobj> </ws:registerSfdxHubWithOAuth></soapenv:Body></soapenv:Envelope>';
        Object req = loginActivity.buildWebServiceRequest(reqBody);
        
        return loginActivity.getResponseData(loginActivity.res,reqBody);        
    }   
    @AuraEnabled
    public static Object getDevHubList(){   
        testClass loginActivity = new testClass();       
        String usermail = UserInfo.getUserEmail();
        System.debug('usermail------------'+usermail);
        String orgname = usermail.split('@')[1]+'-QoROkb';
        System.debug('orgname------------'+orgname);
        
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ws=\"http://ws.service.rabit.com/\"><soapenv:Header/><soapenv:Body><ws:getSfdxHubHistoryJson><orgname>'+orgname+'</orgname><username>'+usermail+'</username></ws:getSfdxHubHistoryJson></soapenv:Body></soapenv:Envelope>';
        Object req = loginActivity.buildWebServiceRequest(reqBody);
             
        
        System.debug('------------res------------------'+loginActivity.res);
        System.debug('Login String: ' + loginActivity.res.toString());
        System.debug('Login StatusCode: ' + loginActivity.res.getStatusCode());
        System.debug('Login Status: ' + loginActivity.res.getStatus());
        System.debug('Login Body: ' + loginActivity.res.getBody());    
        //System.debug('Login Soap Body -?  ' + reqBody);
        System.debug('reponse- ' + loginActivity.res.getBody());
        
        return loginActivity.res.getBody();        
    }  
    @AuraEnabled
    public static Object unregisterDevHub(string id){        
        testClass unregister = new testClass();   
        
        String usermail = UserInfo.getUserEmail();
        String orgname= usermail.split('@')[1]+'-QoROkb';
        // get hub id from Dx LoginActivity Controller
        String hubids=id;
        
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ws=\"http://ws.service.rabit.com/\"><soapenv:Header/><soapenv:Body><ws:unRegisterSfdxHub><orgname>'+orgname+'</orgname><sfdxhubids>'+hubids+'</sfdxhubids></ws:unRegisterSfdxHub></soapenv:Body></soapenv:Envelope>';
        Object req = unregister.buildWebServiceRequest(reqBody);

        
        return unregister.getResponseData(unregister.res,reqBody);      
    }   
    @AuraEnabled
    public static Object createScracthOrg(String hubid,String hubname,String hubuserid,String scrorgname,String scrorgusername,String Edition){
        testClass loginActivity = new testClass();   
        String orgid = ArAppSingleTon.randomStringGenerator(); 
        
        String createdby = UserInfo.getUserEmail();
        String orgname=createdby.split('@')[1]+'-QoROkb';
        Boolean t = true; 
        System.debug('hubname----'+hubname);
        System.debug('hubuserid----'+hubuserid);
        System.debug('hubid----'+hubid);
        
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:createSfdxScratchOrg><orgname>'+orgname+'</orgname><scratchorgobj><sandbox orgname="'+orgname+'" id="'+orgid+'" hubid="'+hubid+'" hubname="'+hubname+'" name="'+scrorgname+'" createdby="'+createdby+'" hubuserid="'+hubuserid+'" username="'+scrorgusername+'" isnew="'+t+'" edition="'+edition+'"/></scratchorgobj></ws:createSfdxScratchOrg></soapenv:Body></soapenv:Envelope>';        
        Object req =loginActivity.buildWebServiceRequest(reqBody);
        System.debug('reqBody----'+reqBody);
             
        
        return loginActivity.getResponseData(loginActivity.res,reqBody);        
    }   
    
    @AuraEnabled
    public static Object ScratchOrgList(String hubid,String hubname){        
        testClass getScratchOrgList = new testClass();   
        
        String createdby = UserInfo.getUserEmail();
        System.debug('createdby------------'+createdby); 
        String orgname = createdby.split('@')[1]+'-QoROkb';
        System.debug('orgname------------'+orgname);
        
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getSfdxScratchOrgs><orgname>'+orgname+'</orgname><scrorgrequest><sandbox orgname="'+orgname+'" hubid="'+hubid+'" hubname="'+hubname+'" createdby="'+createdby+'"/></scrorgrequest></ws:getSfdxScratchOrgs></soapenv:Body></soapenv:Envelope>';
        
        Object req = getScratchOrgList.buildWebServiceRequest(reqBody);     
        
        System.debug('Login String: ' + getScratchOrgList.res.toString());
        System.debug('Login StatusCode: ' + getScratchOrgList.res.getStatusCode());
        System.debug('Login Status: ' + getScratchOrgList.res.getStatus());
        System.debug('Login Body: ' + getScratchOrgList.res.getBody());    
        System.debug('Login Soap Body -?  ' + reqBody);
        System.debug('reponse- ' + getScratchOrgList.res.getBody());
        return getScratchOrgList.res.getBody();        
    } 
    @AuraEnabled
    public static Object ScratchOrgDelete(String soid,String soname,String sousername,String hubuserid){
        testClass ScratchOrgDelete = new testClass();   
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:deleteScratchOrg><orgname>'+orgname+'</orgname><deleteorg><sandbox id="'+soid+'" name="'+soname+'" hubuserid="'+hubuserid+'" username="'+sousername+'"/></deleteorg></ws:deleteScratchOrg></soapenv:Body></soapenv:Envelope>';
        
        Object req = ScratchOrgDelete.buildWebServiceRequest(reqBody);     
        
        return ScratchOrgDelete.getResponseData(ScratchOrgDelete.res,reqBody);
    }
    @AuraEnabled
    public static Object AccessType(String username,String password,String accesskey,String scope,String type){
        testClass getAccessdetails = new testClass();   
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
        
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:saveCredential><orgname>'+orgname+'</orgname><user>'+userid+'</user><info>'+EncodeValueofDecode+'</info><new>'+t+'</new></ws:saveCredential></soapenv:Body></soapenv:Envelope>'; 
        Object req = getAccessdetails.buildWebServiceRequest(reqBody);
             
        
        // res.setBodyAsBlob(body);
        return getAccessdetails.getResponseData(getAccessdetails.res,reqBody);
    }
    @AuraEnabled
    public static Object AllCredentials(){
        testClass getAllCredentials = new testClass();   
        
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        String userid='ZmzZ4vMlsRRtENXp';
        
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getAllCredentials><orgname>'+orgname+'</orgname><user>'+userid+'</user></ws:getAllCredentials></soapenv:Body></soapenv:Envelope>';
        
        Object req = getAllCredentials.buildWebServiceRequest(reqBody);     
        
        return getAllCredentials.getEncryptResponseData(getAllCredentials.res,reqBody,getAllCredentials,5);
    }
    
    @AuraEnabled
    public static Object Vcsplugins(){
        testClass getVcsplugins = new testClass();   
        
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';    
        
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getPlugins><orgname>'+orgname+'</orgname></ws:getPlugins></soapenv:Body></soapenv:Envelope>';
        
        Object req = getVcsplugins.buildWebServiceRequest(reqBody);     
        
        return getVcsplugins.getEncryptResponseData(getVcsplugins.res,reqBody,getVcsplugins,5);
    }
    public void parseXML(DOM.XMLNode node,testClass obj) {
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
        testClass getvalidateSCMCredentials = new testClass();   
        
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        String userid='ZmzZ4vMlsRRtENXp';
        
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:validateSCMCredentials><orgname>'+orgname+'</orgname><scmurl>'+url+'</scmurl><accesskey>'+accesskey+'</accesskey><userid>'+userid+'</userid><scmtype>'+type+'</scmtype><branchname/></ws:validateSCMCredentials></soapenv:Body></soapenv:Envelope>';
        
        Object req = getvalidateSCMCredentials.buildWebServiceRequest(reqBody);     
        
        return getvalidateSCMCredentials.getResponseData(getvalidateSCMCredentials.res,reqBody);
    }
    @AuraEnabled
    public static Object registerSCMRepository(String url,String accesskey,string type,String DisplayName,Boolean isChange){
        testClass getregisterSCMRepository = new testClass();   
        String orgid = ArAppSingleTon.randomStringGenerator();
        
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        // user has to be register fot generate userid
        String userid='ZmzZ4vMlsRRtENXp';
        
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:registerSCMRepository><orgname>'+orgname+'</orgname><repositoryobj><repository id="'+orgid+'" name="'+DisplayName+'" remoteurl="'+url+'" scmtype="'+type+'" accesskey="'+accesskey+'" scmhost="'+type+'" registeredby="'+createdby+'" registeredid="'+userid+'"/></repositoryobj><ischanged>'+isChange+'</ischanged><userid>'+userid+'</userid></ws:registerSCMRepository></soapenv:Body></soapenv:Envelope>';
        
        Object req = getregisterSCMRepository.buildWebServiceRequest(reqBody);     
        
        return getregisterSCMRepository.getResponseData(getregisterSCMRepository.res,reqBody);
    }
    
    @AuraEnabled
    public static Object UserRepositories(){
        testClass getUserRepositories = new testClass();   
        
        String createdby = UserInfo.getUserEmail();
        String EnValue = ArAppSingleTon.encodeValue(createdby,5);
        String orgname = createdby.split('@')[1]+'-QoROkb';
        
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getUserRepositories><orgname>'+orgname+'</orgname><username>'+EnValue+'</username></ws:getUserRepositories></soapenv:Body></soapenv:Envelope>';
        
        Object req = getUserRepositories.buildWebServiceRequest(reqBody);     
        
        return getUserRepositories.getEncryptResponseData(getUserRepositories.res,reqBody,getUserRepositories,5);
    }
    
    @AuraEnabled
    public static Object SCMRepoDetails(String repoid){
        testClass getSCMRepoDetails = new testClass();   
        
        String createdby = UserInfo.getUserEmail();
        String EnUserValue = ArAppSingleTon.encodeValue(createdby,5);
        String orgname = createdby.split('@')[1]+'-QoROkb';
        String EnOrgValue = ArAppSingleTon.encodeValue(orgname,5);
        
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:getSCMRepoDetails><orgname>'+EnOrgValue+'</orgname><username>'+EnUserValue+'</username><repoid>'+repoid+'</repoid></web:getSCMRepoDetails></soapenv:Body></soapenv:Envelope>';
        
        Object req = getSCMRepoDetails.buildWebServiceRequest(reqBody);     
        
        return getSCMRepoDetails.getEncryptResponseData(getSCMRepoDetails.res,reqBody,getSCMRepoDetails,5);
    }
    
    @AuraEnabled
    public static Object Branches(String repoid){
        testClass getBranches = new testClass();   
        
        String createdby = UserInfo.getUserEmail();
        String EnUserValue = ArAppSingleTon.encodeValue(createdby,5);
        String orgname = createdby.split('@')[1]+'-QoROkb';
        String EnOrgValue = ArAppSingleTon.encodeValue(orgname,5);
        
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getBranches><orgname>'+orgname+'</orgname><username>'+EnUserValue+'</username><repoid>'+repoid+'</repoid></ws:getBranches></soapenv:Body></soapenv:Envelope>';
        
        Object req = getBranches.buildWebServiceRequest(reqBody);     
        
        return getBranches.getResponseData(getBranches.res,reqBody);
    }
    
    @AuraEnabled
    public static Object Versions(String repoid ,String branchName){
        testClass getVersions = new testClass();  
        String createdby = UserInfo.getUserEmail();
        String EnUserValue = ArAppSingleTon.encodeValue(createdby,5);
        String orgname = createdby.split('@')[1]+'-QoROkb';
        String EnOrgValue = ArAppSingleTon.encodeValue(orgname,5);
        
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:getSCMRevisions><orgname>'+orgName+'</orgname><repoid>'+repoid+'</repoid><scmtype>git</scmtype><branchname>'+branchName+'</branchname></web:getSCMRevisions></soapenv:Body></soapenv:Envelope>';
        
        Object req = getVersions.buildWebServiceRequest(reqBody);     
        
        return getVersions.getResponseData(getVersions.res,reqBody);
    }
    @AuraEnabled
    public static Object SFOrgsWithOAuth(String sforgname,String orgtype,String code,String env,String sfurl){        
        testClass registerSFOrgsWithOAuth = new testClass();   
        String uid = ArAppSingleTon.randomStringGenerator(); 
        
        String OAuth = 'OAuth';
        String createdBy = UserInfo.getUserEmail();
        String orgname = createdBy.split('@')[1]+'-QoROkb';
        Boolean t = true;
        
        String reqBody = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:registerSFOrgsWithOAuth><orgname>'+orgName+'</orgname><createdby>'+createdby+'</createdby><uid>'+uid+'</uid><sforgname>'+sforgname+'</sforgname><sforgtype>'+orgtype+'</sforgtype><environment>'+env+'</environment><sforgurl>'+sfurl+'</sforgurl><code>'+code+'</code><isnew>'+t+'</isnew></ws:registerSFOrgsWithOAuth></soapenv:Body></soapenv:Envelope>';
        
        Object req = registerSFOrgsWithOAuth.buildWebServiceRequest(reqBody);     
        
        return registerSFOrgsWithOAuth.getResponseData(registerSFOrgsWithOAuth.res,reqBody);        
    }
    @AuraEnabled
    public static Object SBLabelExists(String labelname){
        testClass getSBLabelExists = new testClass(); 
        
        String createdby = UserInfo.getUserEmail();
        String EnUserValue = ArAppSingleTon.encodeValue(createdby,5);
        String orgname = createdby.split('@')[1]+'-QoROkb';
        String EnOrgValue = ArAppSingleTon.encodeValue(orgname,5);
        
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:isSBLabelExists><orgname>'+EnOrgValue+'</orgname><labelname>'+labelname+'</labelname></ws:isSBLabelExists></soapenv:Body></soapenv:Envelope>';
        
        Object req = getSBLabelExists.buildWebServiceRequest(reqBody);     
        
        return getSBLabelExists.getResponseData(getSBLabelExists.res,reqBody);
    }
    
    @AuraEnabled
    public static Object registerSFOrgs(String sforgname,String orgtype,String env,String sfurl,String username,string password,string token){
        testClass getregisterSFOrgs = new testClass();   
        
        String uid = ArAppSingleTon.randomStringGenerator(); 
        String createdby = UserInfo.getUserEmail();
        String EnUserValue = ArAppSingleTon.encodeValue(createdby,5);
        String Enpassword=ArAppSingleTon.encodeValue(password,5);
        String orgname = createdby.split('@')[1]+'-QoROkb';
        boolean t=true;  
        
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:registerSFOrgs><orgname>'+orgname+'</orgname><createdby>'+createdby+'</createdby><uid>'+uid+'</uid><sforgname>'+sforgname+'</sforgname><sforgtype>'+orgtype+'</sforgtype><environment>'+env+'</environment><sforgurl>'+sfurl+'</sforgurl><username>'+username+'</username><password>'+Enpassword+'</password><stoken>'+token+'</stoken><isnew>'+t+'</isnew></web:registerSFOrgs></soapenv:Body></soapenv:Envelope>';
        
        Object req = getregisterSFOrgs.buildWebServiceRequest(reqBody);     
        
        return getregisterSFOrgs.getResponseData(getregisterSFOrgs.res,reqBody);
    }
    @AuraEnabled
    public static Object SanboxesHistory(){
        testClass getSanboxesHistory = new testClass();   
        
        String createdby = UserInfo.getUserEmail();
        String EnValue = ArAppSingleTon.encodeValue(createdby,5);
        System.debug('EnValue****'+EnValue);
        String orgname = createdby.split('@')[1]+'-QoROkb';
        String Enorgname = ArAppSingleTon.encodeValue(orgname,5);
        System.debug('Enorgname******'+Enorgname);
        
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getSanboxesHistory><orgname>'+Enorgname+'</orgname><username>'+EnValue+'</username></ws:getSanboxesHistory></soapenv:Body></soapenv:Envelope>'; 
        
        Object req = getSanboxesHistory.buildWebServiceRequest(reqBody);     
        
        return getSanboxesHistory.getEncryptResponseData(getSanboxesHistory.res,reqBody,getSanboxesHistory,5);
    }
    @AuraEnabled
    public static Object SBDetails(String UID){
        testClass getSBDetails = new testClass();   
        
        String createdby = UserInfo.getUserEmail();
        String EnValue = ArAppSingleTon.encodeValue(createdby,5);
        System.debug('EnValue****'+EnValue);
        String orgname = createdby.split('@')[1]+'-QoROkb';
        String Enorgname = ArAppSingleTon.encodeValue(orgname,5);
        System.debug('Enorgname******'+Enorgname);
        
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getSBDetails><orgname>'+Enorgname+'</orgname><username>'+EnValue+'</username><sandbox>'+UID+'</sandbox></ws:getSBDetails></soapenv:Body></soapenv:Envelope>'; 
        
        Object req = getSBDetails.buildWebServiceRequest(reqBody);     
        
        return getSBDetails.getEncryptResponseData(getSBDetails.res,reqBody,getSBDetails,5);
    }
    @AuraEnabled
    public static Object SourcePackageManifest(String repoid ,String labelName, String destOrgId,string dpmsource,String type,String branch){
        testClass getSourcePackageManifest = new testClass();   
        
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getSourcePackageManifest><orgname>'+orgname+'</orgname><projectname/><buildnumber/><sourceorgid/><destinationorgid>'+destorgid+'</destinationorgid><labelname>'+labelName+'</labelname><deploymentsource>'+dpmsource+'</deploymentsource><filternode><packagetype>released,deleted,deprecated,unmanaged,null</packagetype><createddate condition="equals"/><createdby/><lastmodifieddate condition="equals"/><lastmodifiedby/><metadatatype/><isprofilesonly>false</isprofilesonly><includepicklists>false</includepicklists><skippermissions>false</skippermissions></filternode><scmnode><repository>'+repoid+'</repository><type>'+type+'</type><branch>'+branch+'</branch></scmnode><username>'+createdby+'</username><scmlabel/><releaselabelid/><isprofilesonly>false</isprofilesonly></ws:getSourcePackageManifest></soapenv:Body></soapenv:Envelope>';  
        
        Object req = getSourcePackageManifest.buildWebServiceRequest(reqBody);     
        
        return getSourcePackageManifest.getResponseData(getSourcePackageManifest.res,reqBody);
    }
    
    @AuraEnabled
    public static Object Agents(){
        testClass getAgents = new testClass();   
        
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1];
        
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getAgents><orgname>'+orgname+'</orgname></ws:getAgents></soapenv:Body></soapenv:Envelope>';  
        
        Object req = getAgents.buildWebServiceRequest(reqBody);     
        
        return getAgents.getEncryptResponseData(getAgents.res,reqBody,getAgents,5);
    }
    @AuraEnabled
    public static Object MembersForMetadataType(String Metadatatype,String labelName,string dpmsource){
        testClass getMembersForMetadataType = new testClass();   
        
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getMembersForMetadataType><orgname>'+orgname+'</orgname><projectname/><buildnumber/><sourceorgid/><labelname>'+labelname+'</labelname><deploymentsource>'+dpmsource+'</deploymentsource><metadatatype memberscontain="">'+Metadatatype+'</metadatatype><filternode><packagetype>released,deleted,deprecated,unmanaged,null</packagetype><createddate condition="equals"/><createdby/><lastmodifieddate condition="equals"/><lastmodifiedby/><metadatatype/><isprofilesonly>false</isprofilesonly><includepicklists>false</includepicklists><skippermissions>false</skippermissions></filternode><username>'+createdby+'</username></ws:getMembersForMetadataType></soapenv:Body></soapenv:Envelope> ';  
        
        Object req = getMembersForMetadataType.buildWebServiceRequest(reqBody);     
        
        return getMembersForMetadataType.getResponseData(getMembersForMetadataType.res,reqBody);
    }
    
    @AuraEnabled
    public static object deployMetadata(String destOrgId,String agentid , string labelname,string dpmsource,string metadata,string repoid,string type,string branch){
        testClass getdeployMetadata = new testClass();
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        
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
        
        Object req = getdeployMetadata.buildWebServiceRequest(reqBody);     
        
        Object deployMetadata= getdeployMetadata.getResponseData(getdeployMetadata.res,reqBody);
        System.debug('deployMetadata*****'+deployMetadata);
        if(getdeployMetadata.res.getStatusCode()==200){
            
            return DeploymentIterations(labelname,destOrgId);
            //ResponseData DeploymentIteration= (ResponseData)JSON.deserialize(String.valueOf(DeploymentIterations(labelname).getResponseData(res,reqBody)), ResponseData.class);
            
            
        }
        else{
            return deployMetadata;
        }
        return null;
        // return getdeployMetadata.getResponseData(getdeployMetadata.res,reqBody);
    }
    
    
    @AuraEnabled
    public static Object DeploymentIterations(String labelname,string destOrgId){
        testClass getDeploymentIterations = new testClass();
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:getDeploymentIterations><orgname>'+orgname+'</orgname><labelname>'+labelname+'</labelname></web:getDeploymentIterations></soapenv:Body></soapenv:Envelope>';  
        
        Object req = getDeploymentIterations.buildWebServiceRequest(reqBody);     
        
        return getDeploymentIterations.getEncryptResponseData(getDeploymentIterations.res,reqBody,getDeploymentIterations,5);
        
    }
    @AuraEnabled
    public static Object DeploymentStatus(string destOrgId,string asyncid){
        testClass getDeploymentStatus = new testClass();
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getDeploymentStatus><orgname>'+orgname+'</orgname><sforgid>'+destOrgId+'</sforgid><asyncid>'+asyncid+'</asyncid></ws:getDeploymentStatus></soapenv:Body></soapenv:Envelope>';
        
        Object req = getDeploymentStatus.buildWebServiceRequest(reqBody);     
        
        return getDeploymentStatus.getResponseData(getDeploymentStatus.res,reqBody);
    }
    
    @AuraEnabled
    public static Object PromotionLog(string labelname){
        testClass getPromotionLog = new testClass();
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getPromotionLog><orgname>'+orgname+'</orgname><projectname>'+labelname+'</projectname><buildnumber>1</buildnumber></ws:getPromotionLog></soapenv:Body></soapenv:Envelope>';
        
        Object req = getPromotionLog.buildWebServiceRequest(reqBody);     
        
        return getPromotionLog.getResponseData(getPromotionLog.res,reqBody);
    }
    
    /* Ez commit Code Starts here */ 
    @AuraEnabled
    public static Object SalesForceUsersSCMMapping(){
        testClass getSalesForceUsersSCMMapping = new testClass();
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:getSalesForceUsersSCMMapping><orgname>'+orgname+'</orgname></web:getSalesForceUsersSCMMapping></soapenv:Body></soapenv:Envelope>';  
        
        Object req = getSalesForceUsersSCMMapping.buildWebServiceRequest(reqBody);     
        
        return getSalesForceUsersSCMMapping.getEncryptResponseData(getSalesForceUsersSCMMapping.res,reqBody,getSalesForceUsersSCMMapping,5);
    }
    
    @AuraEnabled
    public static Object fetchUserChangesFromSfOrg(string sforgid,string repoid,string branch){
        testClass getfetchUserChangesFromSfOrg = new testClass();
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:fetchUserChangesFromSfOrg><orgname>'+orgname+'</orgname><sforgid>'+sforgid+'</sforgid><userslist>All</userslist><include><manageablestate><state>released,deleted,deprecated,unmanaged,null</state></manageablestate></include><modifieddate/><repoid>'+repoid+'</repoid><branchname>'+branch+'</branchname><skipmappings>false</skipmappings><triggeredby>'+createdby+'</triggeredby></web:fetchUserChangesFromSfOrg></soapenv:Body> </soapenv:Envelope>';  
        
        Object req = getfetchUserChangesFromSfOrg.buildWebServiceRequest(reqBody);     
        
        return getfetchUserChangesFromSfOrg.getResponseData(getfetchUserChangesFromSfOrg.res,reqBody);
    }
    
    
    @AuraEnabled
    public static object commitChangesToSCM(String usersList,String sforgid,string metadata,string repoid,string branch){
        testClass getcommitChangesToSCM= new testClass();
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        
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
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:commitChangesToSCM><orgname>'+orgname+'</orgname><sforgid>'+sforgid+'</sforgid><committedby>'+createdby+'</committedby><userslist><user id="'+usersList+'"><label type="none"/>'+xmlstr+'<profilesonly>false</profilesonly><comment>multicommits</comment></user></userslist><repoid>'+repoid+'</repoid><branchname>'+branch+'</branchname><skipmappings>false</skipmappings></web:commitChangesToSCM></soapenv:Body></soapenv:Envelope>';
        
        Object req = getcommitChangesToSCM.buildWebServiceRequest(reqBody);     
        
        return getcommitChangesToSCM.getResponseData(getcommitChangesToSCM.res,reqBody);
    }

     @AuraEnabled
    public static Object AdditionalMetadataTypes(string sforgid){
        testClass AdditionalMetadataTypes = new testClass();
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:getMetadataTypes><orgName>'+orgName+'</orgName><sforgid>'+sforgid+'</sforgid></ws:getMetadataTypes></soapenv:Body></soapenv:Envelope>';  
        
        Object req = AdditionalMetadataTypes.buildWebServiceRequest(reqBody);     
        
        return AdditionalMetadataTypes.getResponseData(AdditionalMetadataTypes.res,reqBody);
    }
    
      @AuraEnabled
    public static Object  getAdditionalMetadataTypes(string sforgid){
        testClass   getAdditionalMetadataTypes = new testClass();
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1]+'-QoROkb';
        
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:getMetadataMembers><orgName>'+orgName+'</orgName><sforgid>'+sforgid+'</sforgid><type>ApexClass</type></web:getMetadataMembers></soapenv:Body></soapenv:Envelope>';  
        
        Object req = getAdditionalMetadataTypes.buildWebServiceRequest(reqBody);     
        
        return getAdditionalMetadataTypes.getResponseData(getAdditionalMetadataTypes.res,reqBody);
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
    public object getEncryptResponseData(HttpResponse res,String reqBody,testClass obj,Integer len){
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
    public Object buildWebServiceRequest(String reqBody){
        Continuation con = new Continuation(40);
        con.continuationMethod='invokeWebService';
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setHeader('Content-Type', 'text/xml; charset=utf-8');   
        req.setEndpoint(completeURL); 
        req.setBody(reqBody);
        //req.setTimeout(120000);
        this.requestLabel = con.addHttpRequest(req);
        system.debug('------------req-----------'+req);
        return con;
    }
    
    public Object invokeWebService(){
        system.debug(this.requestLabel);
        HttpResponse res= Continuation.getResponse(this.requestLabel);
        
        this.res = res;
        system.debug(this.res);
        return null;
    }
    public class ResponseData{
        public Integer statusCode;
        public String Resbody; 
        public String Response;
    } 
}