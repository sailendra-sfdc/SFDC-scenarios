public class opportunityTriggerHandler19 
{
    public static void beforeInsertUpdateHandler(list<Opportunity> oppL)
    {
        Date today = Date.today();
        for (Opportunity opp : oppL)
        {
            if (opp.CloseDate != null && opp.CloseDate < today && opp.StageName != 'Closed Won' && opp.StageName != 'Closed Lost')
            {
                opp.CloseDate.addError('Close Date cannot be in the past unless the Opportunity is Closed.');
            }
        }
    }
}