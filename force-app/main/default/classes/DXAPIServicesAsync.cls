public class DXAPIServicesAsync {
    public static String sessionId;
    @AuraEnabled @future(callout=true)
    public static void userLogin(){ 
        system.debug('-------------entered-------------userlogin');
        sessionId =null;
        DXAPIServices getuserLogin = new DXAPIServices();  
        HttpRequest req = getuserLogin.buildWebServiceRequest();
        String reqBody = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://ws.service.rabit.com/"><soapenv:Body><web:userLogin><usermail>09A63c3Jpbml2YXMuc0BhdXRvcmFiaXQuY29tDDB76</usermail><password>srinuUmFiaXRANzg5gtree</password><seccode/></web:userLogin></soapenv:Body></soapenv:Envelope>';
        req.setBody(reqBody);
        Http http = new Http();     
        HttpResponse res = getuserLogin.invokeWebService(http, req);
		DXAPI__c apiRec = new DXAPI__c();
        apiRec.name = res.getStatus();
        apiRec.Resbody__c = res.getBody();
        apiRec.statusCode__c = string.valueOf(res.getStatusCode());
        insert apiRec;        
    }
}