public class opportunityTriggerHandler13
{
    private static Boolean isRunning = false;
    public static void afterInsertUpdate(List<Opportunity> opps) 
    {
        if (isRunning) return;
        isRunning = true;
        Discount_Policy__c policy = Discount_Policy__c.getOrgDefaults();
        if (policy == null || policy.High_Value_Amount__c == null) 
        {
            isRunning = false;
            return;
        }
        Decimal threshold = policy.High_Value_Amount__c;
        
        Set<Id> highValueOppIds = new Set<Id>();
        for (Opportunity opp : opps)
        {
            if (opp.Amount != null && opp.Amount > threshold)
            {
                highValueOppIds.add(opp.Id);
            }
        }
        if (highValueOppIds.isEmpty())
        {
            isRunning = false;
            return;
        }

        List<UserRole> roles =[SELECT Id FROM UserRole WHERE Name = 'DirectorDirectSales'];
        if (roles.isEmpty())
        {
            isRunning = false;
            return;
        }
        Id salesDirectorRoleId = roles[0].Id;
        List<User> salesDirectors =[SELECT Id FROM User WHERE UserRoleId = :salesDirectorRoleId];
        if (salesDirectors.isEmpty()) 
        {
            isRunning = false;
            return;
        }
        List<OpportunityShare> shares = new List<OpportunityShare>();

        for (Id oppId : highValueOppIds)
        {
            for (User u : salesDirectors)
            {
                OpportunityShare os = new OpportunityShare();
                os.OpportunityId = oppId;
                os.UserOrGroupId = u.Id;
                os.RowCause = Schema.OpportunityShare.RowCause.Manual;
                shares.add(os);
            }
        }
        if (!shares.isEmpty())
        {
            insert shares;
        }
        isRunning = false;
    }
}