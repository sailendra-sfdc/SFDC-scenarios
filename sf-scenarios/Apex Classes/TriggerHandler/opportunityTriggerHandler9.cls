public class opportunityTriggerHandler9 
{
    private static decimal high_val_threshold = 1000000;
    public static void afterUpdateHandler(list<Opportunity> nop, map<id,Opportunity>oop)
    {
        Set<Id> accids = new Set<Id>();
        for (Opportunity opp : nop)
        {
            Opportunity oopp = oop.get(opp.Id);
            
            if (opp.StageName == 'Closed Won' && oopp.StageName != 'Closed Won' && opp.AccountId != null)
            {
                accids.add(opp.AccountId);
            }
        }
        if (accids.isEmpty())
        {
            return;
        }
        
         Map<Id, Decimal> accamom = new Map<Id, Decimal>();
        for (AggregateResult ar : [
            SELECT AccountId accId, SUM(Amount) totalAmt
            FROM Opportunity
            WHERE AccountId IN :accids
              AND StageName = 'Closed Won'
              AND LastModifiedDate = LAST_N_DAYS:30
            GROUP BY AccountId])
        {
            accamom.put((Id) ar.get('accId'),(Decimal) ar.get('totalAmt'));
        }
        
         List<Account> acctoup = new List<Account>();
        for (Id accId : accamom.keySet()) 
        {
            if (accamom.get(accId) > high_val_threshold)
            {
                acctoup.add(new Account(Id = accId,High_Value_Customer__c = true));
            }
        }
        
        if (!acctoup.isEmpty())
        {
            update acctoup;
        }
    }
}