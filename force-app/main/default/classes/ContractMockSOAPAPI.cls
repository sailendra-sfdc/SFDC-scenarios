@IsTest
public class ContractMockSOAPAPI implements WebServiceMock {

    public void doInvoke(
        Object stub,
        Object request,
        Map<String, Object> response,
        String endpoint,
        String soapAction,
        String requestName,
        String responseNS,
        String responseName,
        String responseType
    ) {

        exampleComContractSOAPAPI.createContractResponse_element res =
            new exampleComContractSOAPAPI.createContractResponse_element();

        res.contractId = 'CONTRACT123';

        response.put('response_x', res);
    }
}