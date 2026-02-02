@IsTest
public class CalculatorMockSOAPAPI implements WebServiceMock {

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
        tempuriOrg2SOAPAPI.AddResponse_element resp =
            new tempuriOrg2SOAPAPI.AddResponse_element();

        resp.AddResult = 15;
        response.put('response_x', resp);
    }
}