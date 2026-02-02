public class CalculatorSoapTestUtilSOAPAPI {

    public static Integer callAdd() {

        tempuriOrg2SOAPAPI.CalculatorSoap service =
            new tempuriOrg2SOAPAPI.CalculatorSoap();

        Integer result = service.Add(10, 20);
        return result;
    }
}