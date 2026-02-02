public class opportunityTriggerHandler1 
{
    public static void afterInsertHandler(list<Opportunity> opps)
    {
        Opportunity__c config = Opportunity__c.getInstance('List');
        if(config == null || String.isBlank(config.OppCustom_List__c))
        {
            return;
        }
        list<Opportunity> opptur = new list<Opportunity>();
        for(Opportunity opp : opps)
        {
            if(String.isBlank(opp.Type))
            {
                Opportunity oppty = new Opportunity(
                    id = opp.Id,
                    Type = config.OppCustom_List__c
                );
                opptur.add(oppty);
            }
        }
        if(!opptur.isEmpty())
        {
            update opptur;
        }
    }
}