public class OpportunityTriggerHandler8 {

    private static Boolean isRunning = false; 

    public static void afterInsertHandler(List<OpportunityLineItem> lineItems)
    {
        if (isRunning) return;
        isRunning = true;
        Set<Id> pricebookEntryIds = new Set<Id>();
        for (OpportunityLineItem oli : lineItems)
        {
            if (oli.PricebookEntryId != null)
            {
                pricebookEntryIds.add(oli.PricebookEntryId);
            }
        }
        if (pricebookEntryIds.isEmpty()) return;

        Map<Id, Id> pbeToProductMap = new Map<Id, Id>();
        for (PricebookEntry pbe : [
            SELECT Id, Product2Id
            FROM PricebookEntry
            WHERE Id IN :pricebookEntryIds
        ]) 
        {
            pbeToProductMap.put(pbe.Id, pbe.Product2Id);
        }
        if (pbeToProductMap.isEmpty()) return;

        Map<Id, Product_Margin__c> productCostMap =
            new Map<Id, Product_Margin__c>(
                [
                    SELECT Product__c, Product_Cost__c
                    FROM Product_Margin__c
                    WHERE Product__c IN :pbeToProductMap.values()
                ]
            );

        if (productCostMap.isEmpty()) return;

        List<OpportunityLineItem> toUpdate = new List<OpportunityLineItem>();
        for (OpportunityLineItem oli : lineItems) 
        {
            if (oli.PricebookEntryId == null) continue;
            Id productId = pbeToProductMap.get(oli.PricebookEntryId);
            if (productId != null && productCostMap.containsKey(productId)) 
            {
                toUpdate.add(new OpportunityLineItem(Id = oli.Id, Product_Margin_Cost__c = productCostMap.get(productId).Product_Cost__c));
            }
        }
        if (!toUpdate.isEmpty()) 
        {
            update toUpdate;
        }
        isRunning = false;
    }
}









/*public class opportunityTriggerHandler8 {

    public static void afterInsertHandler(List<OpportunityLineItem> lineItems) {

        // 1️⃣ Collect PricebookEntryIds
        Set<Id> pricebookEntryIds = new Set<Id>();
        for (OpportunityLineItem oli : lineItems) {
            if (oli.PricebookEntryId != null) {
                pricebookEntryIds.add(oli.PricebookEntryId);
            }
        }

        if (pricebookEntryIds.isEmpty()) {
            return;
        }

        // 2️⃣ Map PricebookEntry → Product2
        Map<Id, Id> pbeToProductMap = new Map<Id, Id>();
        for (PricebookEntry pbe : [
            SELECT Id, Product2Id
            FROM PricebookEntry
            WHERE Id IN :pricebookEntryIds
        ]) {
            pbeToProductMap.put(pbe.Id, pbe.Product2Id);
        }

        if (pbeToProductMap.isEmpty()) {
            return;
        }

        // 3️⃣ Query Product_Margin__c
        Map<Id, Product_Margin__c> productCostMap =
            new Map<Id, Product_Margin__c>(
                [
                    SELECT Product__c, Product_Cost__c
                    FROM Product_Margin__c
                    WHERE Product__c IN :pbeToProductMap.values()
                ]
            );

        if (productCostMap.isEmpty()) {
            return;
        }

        List<OpportunityLineItem> toUpdate = new List<OpportunityLineItem>();

        for (OpportunityLineItem oli : lineItems) {

            if (oli.PricebookEntryId == null) {
                continue;
            }

            Id productId = pbeToProductMap.get(oli.PricebookEntryId);

            if (productId != null && productCostMap.containsKey(productId)) {

                toUpdate.add(new OpportunityLineItem(
                    Id = oli.Id,
                    Product_Margin_Cost__c = productCostMap.get(productId).Product_Cost__c));
            }
        }

        if (!toUpdate.isEmpty()) {
            update toUpdate;
        }
    }
}*/
