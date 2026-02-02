public class opportunityTriggerHandler5 
{
    public static void afterInsertHandler(List<OpportunityContactRole> ocrL)
    {
        Set<Id> contactIds = new Set<Id>();
        Set<Id> oppIds = new Set<Id>();
        for (OpportunityContactRole ocr : ocrL)
        {
            if (ocr.ContactId != null && ocr.OpportunityId != null) 
            {
                contactIds.add(ocr.ContactId);
                oppIds.add(ocr.OpportunityId);
            }
        }
        if (contactIds.isEmpty() || oppIds.isEmpty())
        {
            return;
        }

        Map<Id, Contact> contactMap = new Map<Id, Contact>([SELECT Id, Email FROM Contact WHERE Id IN :contactIds]);

        List<Opportunity> oppsToUpdate = new List<Opportunity>();
        for (Opportunity opp : [
            SELECT Id, Customer_Email__c
            FROM Opportunity
            WHERE Id IN :oppIds
        ])
        {
            if (opp.Customer_Email__c == null)
            {
                for (OpportunityContactRole ocr : ocrL)
                {
                    if (ocr.OpportunityId == opp.Id &&
                        contactMap.containsKey(ocr.ContactId))
                    {

                        opp.Customer_Email__c =
                            contactMap.get(ocr.ContactId).Email;
                        oppsToUpdate.add(opp);
                        break;
                    }
                }
            }
        }
        if (!oppsToUpdate.isEmpty())
        {
            update oppsToUpdate;
        }
    
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        /*List<Opportunity> opp = new list<Opportunity>();
        for(Opportunity op : nop)
        {
            if(op.ContactId != null)
            {
                OpportunityContactRole ocr = new OpportunityContactRole();
                Contact co = new Contact();
                ocr.Id = co.Id;
                op.Customer_Email__c = co.Email;
                opp.add(op);
            }
        }
        if(!opp.isEmpty())
        {
            Insert opp;
        }
		*/
    }
}