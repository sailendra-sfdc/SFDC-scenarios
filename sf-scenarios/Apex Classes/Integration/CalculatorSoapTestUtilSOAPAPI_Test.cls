@IsTest
public class CalculatorSoapTestUtilSOAPAPI_Test {

    @IsTest
    static void testCallAdd() {

        Test.setMock(
            WebServiceMock.class,
            new CalculatorMockSOAPAPI() // the mock you already created
        );

        Integer result =
            CalculatorSoapTestUtilSOAPAPI.callAdd();

        System.assertEquals(15, result);
    }
}