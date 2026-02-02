public class OpportunityTriggerHandlerRESTAPI 
{

    public static void afterUpdateHandler(List<Opportunity> newList, Map<Id,Opportunity> oldMap) 
    {
        List<Id> ids = new List<Id>();
        for (Opportunity o : newList) 
        {
            if (o.StageName == 'Closed Won' && oldMap.get(o.Id).StageName != 'Closed Won') 
            {
                ids.add(o.Id);
            }
        }

        if (!ids.isEmpty())
        {
            OpportunityNotificationServiceRESTAPI.sendNotification(ids);
        }
    }
}