public class DevHubList {
    static String completeURL = '';
    @AuraEnabled
    public static Object ListValidate(String url ,String orgname,String usermail){        
        DevHubList hublist = new DevHubList();   
        completeURL = url; 
        // String usermail = UserInfo.getUserEmail();
        System.debug('usermail------------'+usermail); 
         Blob usermailblob = Blob.valueOf(usermail);
        String tempEncodedusermail = EncodingUtil.base64Encode(usermailblob);
        System.debug('tempEncodedusermail'+tempEncodedusermail); 
       // String orgname = usermail.split('@')[1];
       
       
        
        System.debug('orgname------------'+orgname);
       Blob  orgnameblob = Blob.valueOf(orgname);
         System.debug('orgnameblob------------'+orgnameblob);
        String tempEncodeorgname= EncodingUtil.base64Encode(orgnameblob);  
        System.debug('tempEncodeorgname___________'+tempEncodeorgname);
      /*  String usermail1 = UserInfo.getUserEmail();
        Blob usermailblob = Blob.valueOf(F0BE3YXV0b3JhYml0LmNvbS1Rb1JPa2I=8300A);
        String tempEncodedusermail = EncodingUtil.base64Decode(usermailblob);
        System.debug('tempEncodedusermail'+tempEncodedusermail); */
        HttpRequest req = hublist.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ws=\"http://ws.service.rabit.com/\"><soapenv:Header/><soapenv:Body><ws:getSfdxHubHistory><orgname>abcde'+tempEncodeorgname+'abcde</orgname><username>abcde'+tempEncodedusermail+'abcde</username></ws:getSfdxHubHistory></soapenv:Body></soapenv:Envelope>';
                         
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = hublist.invokeWebService(http, req);
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
        req.setTimeout(120000);
        return req;
    }
    
    public HttpResponse invokeWebService(Http h, HttpRequest req){
        HttpResponse res = h.send(req);
        return res;
    }
 
}