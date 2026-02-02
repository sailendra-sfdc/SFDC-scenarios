public class opportunityTriggerHandler11
{
    public static void beforeInsertHandler(List<Opportunity> newOpps)
    {
        List<Opportunity_Routing_Rule__mdt> rules = [SELECT Region__c, Min_Amount__c, Target_Username__c FROM Opportunity_Routing_Rule__mdt];
        if (rules.isEmpty())
        {
            return;
        }

        Set<String> usernames = new Set<String>();
        for (Opportunity_Routing_Rule__mdt rule : rules)
        {
            if (rule.Target_Username__c != null) 
            {
                usernames.add(rule.Target_Username__c);
            }
        }
        if (usernames.isEmpty())
        {
            return;
        }

        Map<String, Id> usernameToUserId = new Map<String, Id>();
        for (User u : [SELECT Id, Username FROM User WHERE Username IN :usernames AND IsActive = true])
        {
            usernameToUserId.put(u.Username, u.Id);
        }

        for (Opportunity opp : newOpps) 
        {
            if (opp.Region__c == null || opp.Amount == null)
            {
                continue;
            }
            for (Opportunity_Routing_Rule__mdt rule : rules) 
            {
                if (opp.Region__c == rule.Region__c && opp.Amount >= rule.Min_Amount__c && usernameToUserId.containsKey(rule.Target_Username__c))
                {
                    opp.OwnerId = usernameToUserId.get(rule.Target_Username__c);
                    break;
                }
            }
        }
    }
}