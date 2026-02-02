trigger triggerOpportunityLineItem on OpportunityLineItem (after insert)
{
    if(trigger.isAfter && trigger.isInsert)
    {
        opportunityTriggerHandler8.afterInsertHandler(trigger.new);
    }
}