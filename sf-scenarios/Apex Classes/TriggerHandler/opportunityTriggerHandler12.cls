public class opportunityTriggerHandler12 
{
    public static void afterInsertUpdateDeleteHandler(List<Opportunity> newOpps, Map<Id, Opportunity> oldOppMap)
    {
        Set<Id> userIds = new Set<Id>();
        if (newOpps != null)
        {
            for (Opportunity opp : newOpps) 
            {
                if (opp.OwnerId != null)
                {
                    userIds.add(opp.OwnerId);
                }
            }
        }
        if (oldOppMap != null)
        {
            for (Opportunity opp : oldOppMap.values())
            {
                if (opp.OwnerId != null)
                {
                    userIds.add(opp.OwnerId);
                }
            }
        }
        if (userIds.isEmpty())
        {
            return;
        }

        Map<Id, Integer> openCountByUser = new Map<Id, Integer>();
        for (AggregateResult ar : [
            SELECT OwnerId ownerId, COUNT(Id) oppCount
            FROM Opportunity
            WHERE OwnerId IN :userIds
              AND StageName NOT IN ('Closed Won', 'Closed Lost')
            GROUP BY OwnerId])
        {
            openCountByUser.put((Id) ar.get('ownerId'), (Integer) ar.get('oppCount'));
        }

        List<User> usersToUpdate = new List<User>();
        for (Id userId : userIds)
        {
            Integer count =openCountByUser.containsKey(userId) ? openCountByUser.get(userId) : 0;
            
            usersToUpdate.add(new User(Id = userId, Open_Opportunity_Count__c = count));
        }
        if (!usersToUpdate.isEmpty()) {
            update usersToUpdate;
        }
    }
}