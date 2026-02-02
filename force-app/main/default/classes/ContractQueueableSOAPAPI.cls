public class ContractQueueableSOAPAPI
implements Queueable, Database.AllowsCallouts {

    List<Id> oppIds;

    public ContractQueueableSOAPAPI(List<Id> ids){
        oppIds = ids;
    }

    public void execute(QueueableContext qc){

        List<Opportunity> opps = [
            SELECT Id, Name, Amount, Account.Name
            FROM Opportunity
            WHERE Id IN :oppIds
        ];

        List<Opportunity> toUpdate = new List<Opportunity>();
        List<Contract_Integration_Log__c> logs = new List<Contract_Integration_Log__c>();

        exampleComContractSOAPAPI.ContractPort service =
            new exampleComContractSOAPAPI.ContractPort();

        for(Opportunity opp : opps){

            try {

                String contractId =
                    service.createContract(
                        opp.Name,
                        opp.Amount,
                        opp.Account.Name
                    );

                toUpdate.add(new Opportunity(
                    Id = opp.Id,
                    External_Contract_Id__c = contractId
                ));

            } catch (Exception e) {

                logs.add(new Contract_Integration_Log__c(
                    Opportunity__c = opp.Id,
                    Error_Message__c = e.getMessage()
                ));
            }
        }

        if(!toUpdate.isEmpty()) update toUpdate;
        if(!logs.isEmpty()) insert logs;
    }
}