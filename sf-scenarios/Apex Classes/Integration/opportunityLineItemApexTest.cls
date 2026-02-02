@isTest
public class opportunityLineItemApexTest {
/*
    @isTest
    static void testProductMarginCopied() {

        // 1️⃣ Product
        Product2 p = new Product2(Name='Pen', IsActive=true);
        insert p;

        // 2️⃣ PricebookEntry
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = p.Id,
            UnitPrice = 10,
            IsActive = true
        );
        insert pbe;

        // 3️⃣ Product Margin
        Product_Margin__c pm = new Product_Margin__c(
            Product__c = p.Id,
            Product_Cost__c = 7
        );
        insert pm;

        // 4️⃣ Account
        Account acc = new Account(Name='Test Acc');
        insert acc;

        // 5️⃣ Opportunity
        Opportunity opp = new Opportunity(
            Name='Pen Deal',
            AccountId=acc.Id,
            StageName='Prospecting',
            CloseDate=Date.today().addDays(10),
            Pricebook2Id=Test.getStandardPricebookId()
        );
        insert opp;

        // 6️⃣ OpportunityLineItem
        OpportunityLineItem oli = new OpportunityLineItem(
            OpportunityId = opp.Id,
            Quantity = 1,
            UnitPrice = 10,
            PricebookEntryId = pbe.Id
        );

        Test.startTest();
        insert oli;
        Test.stopTest();

        // 7️⃣ Assert
        OpportunityLineItem insertedOLI = [
            SELECT Product_Margin_Cost__c
            FROM OpportunityLineItem
            WHERE Id = :oli.Id
        ];

        System.assertEquals(
            7,
            insertedOLI.Product_Margin_Cost__c,
            'Product margin cost should be copied'
        );
    }*/
}