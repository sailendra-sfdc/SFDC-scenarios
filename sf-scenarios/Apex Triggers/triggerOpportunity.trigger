trigger triggerOpportunity on Opportunity (before insert, before update, after insert, after update, after delete, after undelete) 
{
    if(trigger.isAfter && trigger.isInsert)
    {
        opportunityTriggerHandler1.afterInsertHandler(trigger.new);
    }
    if(trigger.isAfter && trigger.isUpdate)
    {
        opportunityTriggerHandler2.afterUpdateHandler(trigger.new, trigger.oldMap);
        
        opportunityTriggerHandler4.afterUpdateHandler(trigger.new, trigger.oldMap);
        
        opportunityTriggerHandler6.afterUpdateHandler(trigger.new, trigger.oldMap);
        
        opportunityTriggerHandler9.afterUpdateHandler(trigger.new, trigger.oldMap);
        
        opportunityTriggerHandler10.afterUpdateHandler(trigger.new, trigger.oldMap);
                
        opportunityTriggerHandler15.afterUpdateHandler(trigger.new, trigger.oldMap);
        
        opportunityTriggerHandler16.afterUpdateHandler(trigger.new);
        
        opportunityTriggerHandler18.afterUpdateHandler(trigger.new, trigger.oldMap);
        
        OpportunityTriggerHandlerRESTAPI.afterUpdateHandler(trigger.new, trigger.oldMap);
        
        OpportunityTriggerHandlerSOAPAPI.afterUpdateHandler(trigger.new, trigger.oldMap);
    }
    if(trigger.isBefore && trigger.isUpdate)
    {
        opportunityTriggerHandler3.beforeUpdateHandler(trigger.new, trigger.oldMap);
        
        opportunityTriggerHandler14.beforeUpdateHandler(trigger.new, trigger.oldMap);
        
        opportunityTriggerHandler15.beforeUpdateHandler(trigger.new, trigger.oldMap);
    }
    if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate))
    {
        opportunityTriggerHandler7.afterInsertHandler(trigger.new);
        
        //opportunityTriggerHandlerAccount.afterInsertUpdate(trigger.new);
        
        opportunityTriggerHandler13.afterInsertUpdate(trigger.new);
    }
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate))
    {
        opportunityTriggerHandler19.beforeInsertUpdateHandler(trigger.new);
    }
    if(trigger.isBefore && trigger.isInsert)
    {
        opportunityTriggerHandler11.beforeInsertHandler(trigger.new);
        
        opportunityTriggerHandler15.beforeInsertHandler(trigger.new);
        
        opportunityTriggerHandler20.beforeInsertHandler(trigger.new);
    }
    if(trigger.isAfter)
    {
        if(trigger.isInsert || trigger.isUpdate)
        {
           opportunityTriggerHandler12.afterInsertUpdateDeleteHandler(trigger.new, trigger.oldMap);
        }
        if(trigger.isDelete)
        {
            opportunityTriggerHandler12.afterInsertUpdateDeleteHandler(null, trigger.oldMap);
        }
        
        opportunityTriggerHandler17.afterHandler();
    }
}