@IsTest
public class opportunityTriggerHandler17_Test
{
    @IsTest
    static void testManagerPipelineSummary() 
    {
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];

        User u = new User(
            Alias = 'mgr',
            Email = 'mgr@test.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Manager',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            ProfileId = p.Id,
            TimeZoneSidKey = 'Asia/Kolkata',
            UserName = 'mgr' + System.currentTimeMillis() + '@test.com'
        );
        insert u;

        System.runAs(u)
        {
            Account acc = new Account(Name = 'Test Account');
            insert acc;

            List<Opportunity> opps = new List<Opportunity>{
                new Opportunity(Name='Opp1', AccountId=acc.Id, StageName='Prospecting', CloseDate=Date.today(), Amount=10000),
                new Opportunity(Name='Opp2', AccountId=acc.Id, StageName='Negotiation', CloseDate=Date.today(), Amount=5000),
                new Opportunity(Name='Opp3', AccountId=acc.Id, StageName='Closed Won', CloseDate=Date.today(), Amount=8000)
            };

            insert opps;
        }

        opportunityTriggerHandler17.afterHandler();

        Manager_Pipeline_Summary__c summary = [
            SELECT Open_Opportunity_Count__c, Total_Pipeline_Amount__c
            FROM Manager_Pipeline_Summary__c
            LIMIT 1
        ];

        System.assertEquals(2, summary.Open_Opportunity_Count__c);
        System.assertEquals(15000, summary.Total_Pipeline_Amount__c);
    }
}