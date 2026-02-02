@IsTest
public class OpportunityNotificationMockRESTAPI
implements HttpCalloutMock {

    public HTTPResponse respond(HTTPRequest req) {

        HttpResponse res = new HttpResponse();
        res.setStatusCode(200);
        res.setBody(
            '{"success": true, "messageId": "MSG123"}'
        );
        return res;
    }
}