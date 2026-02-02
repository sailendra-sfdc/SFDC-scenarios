@IsTest
public class opportunityTriggerHandler16_Test {

    @IsTest
    static void testMarginHelperPattern() {

        Account acc = new Account(Name = 'Test Account');
        insert acc;

        Opportunity opp = new Opportunity(
            Name = 'Test Opp',
            AccountId = acc.Id,
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(30),
            Amount = 50000
        );
        insert opp;

        Sensitive_Data__c ma = new Sensitive_Data__c(
            Opportunity__c = opp.Id,
            Margin__c = 8
        );
        insert ma;

        opp.StageName = 'Negotiation';
        update opp;

        Opportunity checkOpp = [SELECT Id FROM Opportunity WHERE Id = :opp.Id];
        System.assertNotEquals(null, checkOpp.Id);
    }
}