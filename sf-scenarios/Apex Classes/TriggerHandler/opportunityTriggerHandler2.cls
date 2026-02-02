public class opportunityTriggerHandler2
{
    public static void afterUpdateHandler(list<Opportunity> nop, map<id,Opportunity> oop)
    {
        list<Task> tk = new list<Task>();
         for (Opportunity opp : nop) {
            Opportunity oopp = oop.get(opp.Id);
            if (opp.StageName == 'Closed Won' && oopp.StageName != 'Closed Won')
            {
                Task t = new Task();
                t.Subject = 'Send Thank You Email';
                t.ActivityDate = Date.today().addDays(2);
                t.OwnerId = opp.OwnerId;
                t.WhatId = opp.Id;
                t.Status = 'Not Started';
                t.Priority = 'Normal';
                tk.add(t);
            }
        }
        if (!tk.isEmpty())
        {
            insert tk;
        }
    }
}