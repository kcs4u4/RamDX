public class UnregitserDevHub {
    static String completeURL = '';
    @AuraEnabled
    public static Object unregisterDevHub(){        
        UnregitserDevHub unregister = new UnregitserDevHub();   
        completeURL = Label.DX_API;
        String usermail = UserInfo.getUserEmail();
        String orgname= usermail.split('@')[1];
        // get hub id from Dx LoginActivity Controller
        String hubids='';
        HttpRequest req = unregister.buildWebServiceRequest();
        String reqBody ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ws=\"http://ws.service.rabit.com/\"><soapenv:Header/><soapenv:Body><ws:unRegisterSfdxHub><orgname>'+orgname+'</orgname><sfdxhubids>'+hubids+'</sfdxhubids></ws:unRegisterSfdxHub></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = unregister.invokeWebService(http, req); 
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
          System.debug('res-------' +res);
        return res;
      
    }
 

}