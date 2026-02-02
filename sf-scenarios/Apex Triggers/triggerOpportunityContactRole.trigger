trigger triggerOpportunityContactRole on OpportunityContactRole (after insert)
{
     if (Trigger.isAfter && Trigger.isInsert)
     {
        opportunityTriggerHandler5.afterInsertHandler(Trigger.new);
    }
}