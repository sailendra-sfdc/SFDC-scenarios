@IsTest
public class ContractSOAPAPI_Test {

    @IsTest
    static void testSoapSuccess() {

        // 1️⃣ Register SOAP mock
        Test.setMock(
            WebServiceMock.class,
            new ContractMockSOAPAPI()
        );

        // 2️⃣ Test data
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            AccountId = acc.Id,
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(10),
            Amount = 5000
        );
        insert opp;

        // 3️⃣ Start async context
        Test.startTest();

        // Move to Closed Won (this triggers SOAP logic)
        opp.StageName = 'Closed Won';
        update opp;

        Test.stopTest();

        // 4️⃣ Verify result
        Opportunity updatedOpp = [
            SELECT External_Contract_Id__c
            FROM Opportunity
            WHERE Id = :opp.Id
        ];

        System.assertEquals(
            'CONTRACT123',
            updatedOpp.External_Contract_Id__c,
            'Contract Id should be updated from SOAP response'
        );
    }
}