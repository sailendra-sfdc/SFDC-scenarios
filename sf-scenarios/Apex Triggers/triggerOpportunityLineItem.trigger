trigger OpportunityLineItemTrigger on OpportunityLineItem (before insert) {
    if (Trigger.isBefore && Trigger.isInsert) {
        OpportunityLineItemHandler8.beforeInsertHandler(Trigger.new);
    }
}