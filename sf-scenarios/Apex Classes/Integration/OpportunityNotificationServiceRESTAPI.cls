public class OpportunityNotificationServiceRESTAPI {

    @future(callout=true)
    public static void sendNotification(List<Id> oppIds) {

        List<Opportunity> updates = new List<Opportunity>();

        for (Id oppId : oppIds) {

            try {
                HttpRequest req = new HttpRequest();
                req.setEndpoint('callout:Messaging_API/post');
                req.setMethod('POST');
                req.setHeader('Content-Type', 'application/json');
                req.setBody('{"id":"' + oppId + '"}');

                Http http = new Http();
                HttpResponse res = http.send(req);

                System.debug('HTTP STATUS: ' + res.getStatusCode());

                if (res.getStatusCode() == 200) {

                    updates.add(new Opportunity(
                        Id = oppId,
                        Last_Notification_Id__c = 'MSG-' + String.valueOf(oppId).substring(0,5),
                        Last_Notification_Time__c = System.now()
                    ));
                }

            } catch (Exception e) {
                System.debug('ERROR: ' + e.getMessage());
            }
        }

        if (!updates.isEmpty()) {
            update updates;
        }
    }
}