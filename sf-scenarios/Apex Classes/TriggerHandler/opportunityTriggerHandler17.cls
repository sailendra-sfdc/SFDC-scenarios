public with sharing class opportunityTriggerHandler17 
{
    public static void afterHandler()
    {
        List<AggregateResult> results = [
            SELECT OwnerId managerId,
                   COUNT(Id) oppCount,
                   SUM(Amount) totalAmt
            FROM Opportunity
            WHERE StageName NOT IN ('Closed Won','Closed Lost')
            GROUP BY OwnerId
        ];

        Map<Id, Manager_Pipeline_Summary__c> newSummary = new Map<Id, Manager_Pipeline_Summary__c>();

        for (AggregateResult ar : results)
        {
            Id managerId = (Id) ar.get('managerId');
            Integer countOpp = (Integer) ar.get('oppCount');
            Decimal totalAmt = (Decimal) ar.get('totalAmt');

            newSummary.put(managerId,
                new Manager_Pipeline_Summary__c(
                    Manager__c = managerId,
                    Open_Opportunity_Count__c = countOpp,
                    Total_Pipeline_Amount__c = totalAmt
                )
            );
        }

        Map<Id, Manager_Pipeline_Summary__c> existing = new Map<Id, Manager_Pipeline_Summary__c>();
        for (Manager_Pipeline_Summary__c m :
            [SELECT Id, Manager__c FROM Manager_Pipeline_Summary__c])
        {
            existing.put(m.Manager__c, m);
        }

        List<Manager_Pipeline_Summary__c> toInsert = new List<Manager_Pipeline_Summary__c>();
        List<Manager_Pipeline_Summary__c> toUpdate = new List<Manager_Pipeline_Summary__c>();

        for (Id mgrId : newSummary.keySet())
        {
            Manager_Pipeline_Summary__c rec = newSummary.get(mgrId);

            if (existing.containsKey(mgrId)) {
                rec.Id = existing.get(mgrId).Id;
                toUpdate.add(rec);
            } else {
                toInsert.add(rec);
            }
        }

        if (!toInsert.isEmpty()) insert toInsert;
        if (!toUpdate.isEmpty()) update toUpdate;
    }
}