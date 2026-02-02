public class opportunityTriggerHandler3 
{
    public static void beforeUpdateHandler(list<Opportunity> oppn, map<id,Opportunity> oppo)
    {
        String UserRoleName = null;
        if(UserInfo.getUserRoleId() != null)
        {
            UserRoleName = [SELECT Name FROM UserRole
                            Where Id = :UserInfo.getUserRoleId()].Name;
        }
        for(Opportunity opp : oppn)
        {
            Opportunity opps = oppo.get(opp.Id);
            if(opps.StageName == 'Closed Won')
            {
                if(opps.Amount != opp.Amount)
                {
                    if(UserRoleName != 'Sales Manager')
                	{
                    	opp.Amount.addError('Stage is already Closed Won so Amount Cant be change');
                	}
                }
            }
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
                
        /*List<Opportunity> op = new List<Opportunity>();
        for(Opportunity opps : opp)
        {
            if(opps.StageName == 'Closed Won')
            {
                opps.Amount.addError('Stage is already Closed Won so Amount Cant be change');
                
            }
        }*/
    }
}