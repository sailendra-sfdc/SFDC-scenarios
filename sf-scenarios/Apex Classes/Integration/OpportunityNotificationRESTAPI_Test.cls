@IsTest
public class OpportunityNotificationRESTAPI_Test {

    @IsTest
    static void testClosedWonNotification() {

        Test.setMock(HttpCalloutMock.class,
                     new OpportunityNotificationMockRESTAPI());

        Account acc = new Account(Name='Test Acc');
        insert acc;

        Opportunity opp = new Opportunity(
            Name='Test Opp',
            AccountId=acc.Id,
            StageName='Prospecting',
            CloseDate=Date.today(),
            Amount=1000
        );
        insert opp;

        Test.startTest();

        opp.StageName = 'Closed Won';
        update opp;

        Test.stopTest();

        Opportunity updatedOpp = [
            SELECT Last_Notification_Id__c,
                   Last_Notification_Time__c
            FROM Opportunity
            WHERE Id = :opp.Id
        ];

        System.assertEquals('MSG123',
            updatedOpp.Last_Notification_Id__c);

        System.assertNotEquals(null,
            updatedOpp.Last_Notification_Time__c);
    }
}