public class LeadConvertQueueableLWC2 implements Queueable, Database.AllowsCallouts {

    private Id leadId;

    public LeadConvertQueueableLWC2(Id leadId) {
        this.leadId = leadId;
    }

    public void execute(QueueableContext qc) {

        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Messaging_API/post');
        req.setMethod('POST');
        req.setHeader('Content-Type','application/json');
        req.setBody('{"lead":"' + leadId + '"}');

        Http http = new Http();
        HttpResponse res = http.send(req);

        if(res.getStatusCode() != 200){
            throw new AuraHandledException('Notification failed');
        }

        Map<String,Object> data =
            (Map<String,Object>) JSON.deserializeUntyped(res.getBody());

        String messageId = 'MSG-' + String.valueOf(leadId).substring(0,5);

        Database.LeadConvert lc = new Database.LeadConvert();
        lc.setLeadId(leadId);
        lc.setConvertedStatus('Closed - Converted');
        lc.setDoNotCreateOpportunity(false);

        Database.LeadConvertResult result =
            Database.convertLead(lc);

        if(result.isSuccess()){
            update new Account(
                Id = result.getAccountId(),
                Notification_Id__c = messageId
            );
        }
    }
}