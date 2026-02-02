public with sharing class opportunityTriggerHandler16
{
    public static void afterUpdateHandler(List<Opportunity> opps)
    {
        for (Opportunity opp : opps)
        {
            Decimal margin = opportunityTriggerHelper16.getMarginForOpportunity(opp.Id);
            if (margin != null && margin < 10) 
            {
                System.debug('Low margin opportunity: ' + opp.Id);
            }
        }
    }
}