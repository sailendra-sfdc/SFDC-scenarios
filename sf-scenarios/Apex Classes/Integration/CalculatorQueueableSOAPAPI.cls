public class CalculatorQueueableSOAPAPI implements Queueable, Database.AllowsCallouts {

    Integer a;
    Integer b;

    public CalculatorQueueableSOAPAPI(Integer a, Integer b) {
        this.a = a;
        this.b = b;
    }

    public void execute(QueueableContext qc) {

        tempuriOrg2SOAPAPI.CalculatorSoap soap =
            new tempuriOrg2SOAPAPI.CalculatorSoap();

        Integer result = soap.Add(a, b);

        System.debug('SOAP Result = ' + result);
    }
}