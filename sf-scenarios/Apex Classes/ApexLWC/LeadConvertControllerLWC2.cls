public class LeadConvertControllerLWC2 {

    @AuraEnabled
    public static void convertAndNotify(Id leadId) {
        System.enqueueJob(new LeadConvertQueueableLWC2(leadId));
    }
}