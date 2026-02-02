@IsTest
public class CalculatorSOAPAPI_Test {

    @IsTest
    static void testAdd() {

        Test.setMock(
            WebServiceMock.class,
            new CalculatorMockSOAPAPI()
        );

        tempuriOrg2SOAPAPI.CalculatorSoap soap =
            new tempuriOrg2SOAPAPI.CalculatorSoap();

        Integer result = soap.Add(10, 5);

        System.assertEquals(15, result);
    }
}