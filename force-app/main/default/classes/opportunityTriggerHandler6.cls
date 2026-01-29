public class opportunityTriggerHandler6 
{
    public static void afterUpdateHandler(list<Opportunity> nopp,map<Id,Opportunity> oopp)
    {
        set<id> accids = new set<id>();
        for(Opportunity nopps : nopp)
        {
            Opportunity oopps = oopp.get(nopps.Id);
            if(nopps.StageName == 'Proposal/Price Quote' && oopps.StageName != 'Proposal/Price Quote' && nopps.AccountId != null)
            {
                accids.add(nopps.AccountId);
            }
        }
        if(accids.isEmpty())
        {
                return;
        }
        
        map<id,Account> accmap = new map<id,Account>([select id,Last_Quoted_Date__c from Account where id in :accids]);
        
        for(Account acc : accmap.Values())
        {
            acc.Last_Quoted_Date__c = date.today();
        }
        
        update accmap.Values();
        
        
        
        
        
        
        
        
        
       /* list<Opportunity> opp = [SELECT AccountId, Account.Name, COUNT(Id) FROM Opportunity GROUP BY AccountId, Account.Name];
        for(Opportunity opptu : op)
        {
            if(opptu.StageName == 'Proposal/Price Quote')
            {
                if(opptu.AccountId != '' || opptu.AccountId != null)
                {
                    map<id,Account> accMap = new map<id,Account>();
                    Account acc = new Account();
                    acc.Last_Quoted_Date__c = date.today();
                }
            }
        }*/
    }
}