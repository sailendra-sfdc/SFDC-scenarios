public without sharing class opportunityTriggerHelper16 
{
    public static Decimal getMarginForOpportunity(Id oppId)
    {
        List<Sensitive_Data__c> records = [SELECT Margin__c FROM Sensitive_Data__c WHERE Opportunity__c = :oppId LIMIT 1];
        if (records.isEmpty())
        {
             return null;
        }
        return records[0].Margin__c;
    }
}