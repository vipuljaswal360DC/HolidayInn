public class ParticipationTriggerHelper {
    Public static void childRecordExists(List<Participation__c> newTriggerList,List<Participation__c> oldTriggerList)
    {    
        Set<Id> contIds = New Set<Id>();
        if(newTriggerList!=Null)
        {            
            for(Participation__c objPart:newTriggerList)   
            {
                if(objPart.Person__c!=null)
                {
                    contIds.add(objPart.Person__c);
                }
            }
        }
        if(oldTriggerList!=Null)
        {
            for(Participation__c objPart:oldTriggerList)   
            {
                if(objPart.Person__c!=null)
                {
                    contIds.add(objPart.Person__c);
                }
            }
        }     
        list<Contact> contToUpdate = new list<Contact>();
        
        List<Contact> lstCont = [Select id, (Select id, Person__c from PriorParticipations__r ) from Contact where id IN : contIds];
      
        for(Contact cont : lstCont)
        {
            if(cont.PriorParticipations__r.size()>0)
            {             
                cont.Alum_Flag__c  = True;                
            }
            else
            {
                cont.Alum_Flag__c  = false;       
            }
            contToUpdate.add(cont);
        }
        update contToUpdate;        
    }
    
}