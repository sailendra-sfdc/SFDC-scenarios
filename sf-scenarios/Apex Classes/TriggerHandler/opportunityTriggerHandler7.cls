public class opportunityTriggerHandler7 
{
    public static void afterInsertHandler(List<Opportunity> nopp)
    {
        Map<id,Integer> campcount = new Map<id,Integer>();
        for(Opportunity op : nopp)
        {
            if(op.CampaignId != null)
            {
              campcount.put(op.CampaignId, campcount.containsKey(op.CampaignId) ? campcount.get(op.CampaignId) + 1 : 1);
            }
        }
        
        if(campcount.isEmpty())
        {
            return;
        }
        
        map<id,Campaign> camps = new map<id,Campaign>([SELECT Id, Influenced_Opportunity_Count__c FROM Campaign where id in :campcount.keyset()]);
        
        for(Campaign cmp : camps.Values())
        {
            Decimal cont = cmp.Influenced_Opportunity_Count__c == null ? 0 : cmp.Influenced_Opportunity_Count__c;
            cmp.Influenced_Opportunity_Count__c = cont + campcount.get(cmp.Id);
        }
        
        update camps.Values();
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        /*
		public class opportunityTriggerHandler7 
{
    public static void afterInsertHandler(List<Opportunity> nopp, Map<Id,Opportunity> oopp)
    {
        set<id> campids = new set<id>();
        
        for(Opportunity op : nopp)
        {
            Opportunity oop = oopp.get(op.Id);
            if(op.CampaignId != null && op.CampaignId != '')
            {
                campids.add(op.CampaignId);
                
                Campaign cam = new Campaign();
                cam.Influenced_Opportunity_Count__c ++ ;
                
            }
        }
        
        if(campids.isEmpty())
        {
            return;
        }
        
        map<id,Campaign> camps = new map<id,Campaign>([SELECT Id, Influenced_Opportunity_Count__c FROM Campaign where id in :campids]);
        
        for(Campaign cmp : camps.Values())
        {
            cmp.Influenced_Opportunity_Count__c++;
        }
        
        update camps.Values();
    }
}
		*/
    }
}