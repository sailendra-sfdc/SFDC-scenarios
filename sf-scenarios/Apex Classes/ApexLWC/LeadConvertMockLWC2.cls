@IsTest
public class LeadConvertMockLWC2 implements HttpCalloutMock {
    public HttpResponse respond(HttpRequest req){
        HttpResponse res = new HttpResponse();
        res.setStatusCode(200);
        res.setBody('{"success":true,"messageId":"MSG123"}');
        return res;
    }
}