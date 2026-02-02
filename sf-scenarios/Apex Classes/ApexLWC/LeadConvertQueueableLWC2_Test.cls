@IsTest
public class LeadConvertQueueableLWC2_Test {

    @IsTest
    static void testProcess() {

        Test.setMock(HttpCalloutMock.class,new LeadConvertMockLWC2());

        Lead l = new Lead(
            LastName='Test',
            Company='TestCo',
            Status='Open - Not Contacted'
        );
        insert l;

        Test.startTest();
        System.enqueueJob(new LeadConvertQueueableLWC2(l.Id));
        Test.stopTest();

        Account acc = [
            SELECT Notification_Id__c
            FROM Account
            LIMIT 1
        ];

        System.assertNotEquals(null, acc.Notification_Id__c);
    }
}