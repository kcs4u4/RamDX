public with sharing class LoginActivity {  
    static String completeURL = '';
    @AuraEnabled
    public static Object loginValidate(String url ,String name, String orgname, String hubname,String usermail ,String id,String OAuth ,String code,boolean t ){        
        LoginActivity loginActivity = new LoginActivity();   
      //  String randomUUID = ArAppSingleTon.randomStringGenerator();
    //    System.debug('Random ' + randomUUID);
        completeURL = url;
        HttpRequest req = loginActivity.buildWebServiceRequest();
        String reqBody = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ws=\"http://ws.service.rabit.com/\"><soapenv:Body><ws:registerSfdxHubWithOAuth><orgname>'+name+'</orgname><hurregrequestobj><sfdxhub><orgname>'+orgname+'</orgname><hubname>'+hubname+'</hubname><createdby>'+usermail+'</createdby><uid>'+id+'</uid><sfacctype>'+OAuth+'</sfacctype><code>'+code+'</code><sfhuburl>'+'https://login.salesforce.com'+'</sfhuburl><isnew>'+t+'</isnew></sfdxhub></hurregrequestobj> </ws:registerSfdxHubWithOAuth></soapenv:Body></soapenv:Envelope>';
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
    public HttpRequest buildWebServiceRequest(){
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setHeader('Content-Type', 'text/xml; charset=utf-8');   
        req.setEndpoint(completeURL); 
        return req;
    }
    
    public HttpResponse invokeWebService(Http h, HttpRequest req){
        HttpResponse res = h.send(req);
        return res;
    }
    
}