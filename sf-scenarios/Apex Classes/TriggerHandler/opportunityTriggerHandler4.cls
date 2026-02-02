public class opportunityTriggerHandler4 
{
    public static void afterUpdateHandler(list<Opportunity> nop, map<id,Opportunity>oop)
    {
        list<Opportunity_Date_History__c> odhisL = new list<Opportunity_Date_History__c>();
        for(Opportunity op : nop)
        {
            Opportunity opp = oop.get(op.Id);
            if(op.CloseDate != opp.CloseDate)
            {
                Opportunity_Date_History__c odhis = new Opportunity_Date_History__c();
                odhis.Opportunity__c = op.Id;
                odhis.Name = opp.Name;
                odhis.Old_Close_Date__c = opp.CloseDate;
                odhis.New_Close_Date__c = op.CloseDate;
                odhisL.add(odhis);
            }
        }
        if(!odhisL.isEmpty())
        {
            Insert odhisL;
        }
    }
}