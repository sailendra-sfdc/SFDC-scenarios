public class opportunityTriggerHandler18 
{
    public static void afterUpdateHandler(List<Opportunity> newOpps, Map<Id, Opportunity> oldOppMap)
    {
        List<Task> tasksToInsert = new List<Task>();
        Map<Id, User> salesManagers = new Map<Id, User>
            ([
                SELECT Id
                FROM User
                WHERE UserRole.Name = 'Sales Manager'
                AND IsActive = true
            ]);
        if (salesManagers.isEmpty())
        {
            return;
        }
        Id salesManagerId = salesManagers.values()[0].Id;

        for (Opportunity newOpp : newOpps)
        {
            Opportunity oldOpp = oldOppMap.get(newOpp.Id);
            if (newOpp.StageName == 'Closed Lost' && oldOpp.StageName != 'Closed Lost' && newOpp.Reason__c == 'Price')
            {
                Task t = new Task();
                t.Subject = 'Review Closed Lost Opportunity (Price)';
                t.WhatId = newOpp.Id;
                t.OwnerId = salesManagerId;
                t.ActivityDate = Date.today().addDays(1);
                t.Status = 'Not Started';
                t.Priority = 'High';

                tasksToInsert.add(t);
            }
        }
        if (!tasksToInsert.isEmpty())
        {
            insert tasksToInsert;
        }
    }
}