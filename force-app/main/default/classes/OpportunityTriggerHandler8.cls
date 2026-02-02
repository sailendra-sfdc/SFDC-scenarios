public class OpportunityLineItemHandler8
{
    public static void beforeInsertHandler(List<OpportunityLineItem> lineItems)
    {
        Set<Id> pbeIds = new Set<Id>();
        for (OpportunityLineItem oli : lineItems) 
        {
            if (oli.PricebookEntryId != null)
            {
                pbeIds.add(oli.PricebookEntryId);
            }
        }
        if (pbeIds.isEmpty()) return;
        Map<Id, Id> pbeToProduct = new Map<Id, Id>();
        for (PricebookEntry pbe : [
            SELECT Id, Product2Id
            FROM PricebookEntry
            WHERE Id IN :pbeIds
        ])
        {
            pbeToProduct.put(pbe.Id, pbe.Product2Id);
        }
        Map<Id, Product_Margin__c> productMarginMap = new Map<Id, Product_Margin__c>();
        for (Product_Margin__c pm : [
            SELECT Product__c, Product_Cost__c
            FROM Product_Margin__c
            WHERE Product__c IN :pbeToProduct.values()
        ])
        {
            productMarginMap.put(pm.Product__c, pm);
        }

        for (OpportunityLineItem oli : lineItems) 
        {
            Id productId = pbeToProduct.get(oli.PricebookEntryId);
            if (productId != null && productMarginMap.containsKey(productId))
            {
                oli.Product_Margin_Cost__c = productMarginMap.get(productId).Product_Cost__c;
            }
        }
    }
}