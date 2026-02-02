public class opportunityTriggerHandler20
{
    public static void beforeInsertHandler(List<Opportunity> newOpps)
    {
        Set<Id> accountIds = new Set<Id>();
        Set<String> dealNames = new Set<String>();
        for (Opportunity opp : newOpps)
        {
            if (opp.AccountId != null && opp.Deal_Name__c != null)
            {
                accountIds.add(opp.AccountId);
                dealNames.add(opp.Deal_Name__c);
            }
        }
        if (accountIds.isEmpty() || dealNames.isEmpty())
        {
            return;
        }

        Map<String, Opportunity> existingOpenOpps = new Map<String, Opportunity>();
        for (Opportunity opp : [
            SELECT Id, AccountId, Deal_Name__c
            FROM Opportunity
            WHERE AccountId IN :accountIds
              AND Deal_Name__c IN :dealNames
              AND StageName NOT IN ('Closed Won', 'Closed Lost')])
        {
            String key = opp.AccountId + '-' + opp.Deal_Name__c;
            existingOpenOpps.put(key, opp);
        }

        for (Opportunity opp : newOpps)
        {
            if (opp.AccountId == null || opp.Deal_Name__c == null)
            {
                continue;
            }
            String key = opp.AccountId + '-' + opp.Deal_Name__c;
            if (existingOpenOpps.containsKey(key))
            {
                opp.Deal_Name__c.addError('An open Opportunity with the same Deal Name already exists for this Account.');
            }
        }
    }
}