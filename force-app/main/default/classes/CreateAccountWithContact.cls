/**
 * @description Apex class to create an Account with a primary Contact and email.
 *              Uses Database methods with user mode for security.
 * @author Agentforce
 */
public with sharing class CreateAccountWithContact {
    
    public class Request {
        @InvocableVariable(required=true)
        public String accountName;
        
        @InvocableVariable
        public String contactFirstName;
        
        @InvocableVariable
        public String contactLastName;
        
        @InvocableVariable
        public String contactEmail;
    }

    public class Response {
        @InvocableVariable
        public Id accountId;
        @InvocableVariable
        public Id contactId;
        @InvocableVariable
        public Boolean success;
        @InvocableVariable
        public String message;
    }

    @InvocableMethod(label='Create Account with Contact' description='Creates Account and primary Contact with email')
    public static List<Response> execute(List<Request> requests) {
        List<Response> results = new List<Response>();
        
        if (requests == null || requests.isEmpty()) {
            Response res = new Response();
            res.success = false;
            res.message = 'No requests provided';
            results.add(res);
            return results;
        }
        
        for (Request req : requests) {
            Response res = new Response();
            
            if (req.accountName == null || req.accountName.trim() == '') {
                res.success = false;
                res.message = 'Account name is required';
                results.add(res);
                continue;
            }
            
            if (req.contactFirstName == null || req.contactFirstName.trim() == '') {
                res.success = false;
                res.message = 'Contact first name is required';
                results.add(res);
                continue;
            }
            
            if (req.contactLastName == null || req.contactLastName.trim() == '') {
                res.success = false;
                res.message = 'Contact last name is required';
                results.add(res);
                continue;
            }
            
            try {
                Account acc = new Account(
                    Name = req.accountName.trim()
                );
                
                Database.SaveResult accResult = Database.insert(acc, false, AccessLevel.USER_MODE);
                
                if (!accResult.isSuccess()) {
                    res.success = false;
                    res.message = 'Account creation failed: ' + getFirstErrorMessage(accResult);
                    results.add(res);
                    continue;
                }
                
                Id accountId = accResult.getId();
                res.accountId = accountId;
                
                Contact con = new Contact(
                    FirstName = req.contactFirstName.trim(),
                    LastName = req.contactLastName.trim(),
                    Email = (req.contactEmail == null) ? null : req.contactEmail.trim(),
                    AccountId = accountId
                );
                
                Database.SaveResult conResult = Database.insert(con, false, AccessLevel.USER_MODE);
                
                if (!conResult.isSuccess()) {
                    res.success = false;
                    res.message = 'Contact creation failed: ' + getFirstErrorMessage(conResult);
                    results.add(res);
                    continue;
                }
                
                res.contactId = conResult.getId();
                res.success = true;
                res.message = 'Successfully created Account and Contact';
                
            } catch (Exception e) {
                res.success = false;
                res.message = 'Unexpected error: ' + e.getMessage();
            }
            
            results.add(res);
        }
        
        return results;
    }
    
    private static String getFirstErrorMessage(Database.SaveResult result) {
        List<Database.Error> errors = result.getErrors();
        if (errors != null && !errors.isEmpty()) {
            return errors[0].getMessage();
        }
        return 'Unknown error';
    }
}