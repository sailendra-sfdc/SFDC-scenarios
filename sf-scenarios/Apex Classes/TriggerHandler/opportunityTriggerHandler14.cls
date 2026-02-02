public class opportunityTriggerHandler14 
{
    public static void beforeUpdateHandler(List<Opportunity> newOpps, Map<Id, Opportunity> oldOppMap)
    {
        Discount_Limit_Policy__c policy = Discount_Limit_Policy__c.getInstance(UserInfo.getUserId());
        if (policy == null || policy.Max_Discount__c == null) 
        {
            return;
        }
        Decimal maxAllowed = policy.Max_Discount__c;
        for (Opportunity opp : newOpps) 
        {
            Opportunity oldOpp = oldOppMap.get(opp.Id);
            if (opp.Overall_Discount__c == null) 
            {
                continue;
            }
            if (opp.Overall_Discount__c > maxAllowed) 
            {
                opp.Overall_Discount__c.addError('Your role allows maximum discount of ' +maxAllowed + '%. Please reduce the discount.');
            }
        }
    }
}