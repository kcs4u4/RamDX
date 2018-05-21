public class ScrtchOrgLoginActivity {
    static String completeURL = '';
    @AuraEnabled
    /* public static Object loginValidate(String hubid,String hubname,String scrorgname,String createdby,String hubusermail,boolean t ){
         completeURL = Label.DX_API;
         ScrtchOrgLoginActivity loginActivity = new ScrtchOrgLoginActivity(); */
        public static Object loginValidate(String hubid,String hubname,String scrorgname,String hubusermail){
        ScrtchOrgLoginActivity loginActivity = new ScrtchOrgLoginActivity();   
        String orgid = ArAppSingleTon.randomStringGenerator(); 
        // String hubid ='6e1ba7a4ddbb1a8b3b39081a13f19f04';
        completeURL = Label.DX_API;
        String createdby = UserInfo.getUserEmail();
        // String hubusermail =UserInfo.getUserEmail(); 
        String orgname=createdby.split('@')[1];
        Boolean t = true; 
        HttpRequest req = loginActivity.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ws=\"http://ws.service.rabit.com/\"><soapenv:Header/><soapenv:Body><ws:createSfdxScratchOrg><orgname>'+orgname+'</orgname><scratchorgcreaterequestobj><sfdxscratchorg><orgname>'+orgname+'</orgname><id>'+orgid+'</id><hubid>'+hubid+'</hubid><hubname>'+hubname+'</hubname><scrorgname>'+scrorgname+'</scrorgname><createdby>'+createdby+'</createdby><hubuserid>'+hubusermail+'</hubuserid><isnew>'+true+'</isnew></sfdxscratchorg></scratchorgcreaterequestobj></ws:createSfdxScratchOrg></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        System.debug('reqBody----'+reqBody);
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
    public HttpRequest buildWebServiceRequest(){
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setHeader('Content-Type', 'text/xml; charset=utf-8');   
        req.setEndpoint(completeURL); 
        req.setTimeout(60000);
        return req;
    }
    
    public HttpResponse invokeWebService(Http h, HttpRequest req){
        HttpResponse res = h.send(req);
        return res;
    }
    
    
}