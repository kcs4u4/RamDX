public class AccessToken {
    static String completeURL = '';
     @AuraEnabled
    public static Object validateSCMCredentials(String accesskey,string type){
        DXLoginActivity getvalidateSCMCredentials = new DXLoginActivity();   
        String url='github';
        completeURL = Label.DX_API; 
        String createdby = UserInfo.getUserEmail();
        String orgname = createdby.split('@')[1];
        String userid='VENwJ6R4shLUjPV6';
        HttpRequest req = getvalidateSCMCredentials.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.service.rabit.com/"><soapenv:Header/><soapenv:Body><ws:validateSCMCredentials><orgname>'+orgname+'</orgname><scmurl>'+url+'</scmurl><accesskey>'+accesskey+'</accesskey><userid>'+userid+'</userid><scmtype>'+type+'</scmtype><branchname/></ws:validateSCMCredentials></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getvalidateSCMCredentials.invokeWebService(http, req);
        return getvalidateSCMCredentials.getResponseData(res,reqBody);
    }
  
    
     public List<Schema.FieldSetMember> getFields() {
        return SObjectType.Account.FieldSets.AccountFiledSet.getFields();
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
    public HttpRequest buildWebServiceRequest(){
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