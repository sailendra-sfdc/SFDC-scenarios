public class opportunityTriggerHandler10
{
    public static void afterUpdateHandler(list<Opportunity> nop, map<id,Opportunity> oop)
    {
        list<Opportunity_Probability_History__c> ophL = new list<Opportunity_Probability_History__c>();
        for(Opportunity op : nop)
        {
            Opportunity opp = oop.get(op.Id);
            if(op.Probability != opp.Probability)
            {
                Opportunity_Probability_History__c oph = new Opportunity_Probability_History__c();
                oph.Opportunity__c = op.Id;
                oph.Name = op.Name;
                oph.Old_Probability__c = opp.Probability;
                oph.New_Probability__c = op.Probability;
                ophL.add(oph);
            }
        }
        if(!ophL.isEmpty())
        {
            Insert ophL;
        }
    }
}