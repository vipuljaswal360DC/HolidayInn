/********************************************
Name= AnnualParticipationModificationTrigger
Created By: 360degreeCloud
Date Created : 28/5/2020
Purpose:This trigger creates a new Annual Participation record  or update the Annual participation records 
        when a new confirmed Team Member record 
        It is created for a project. 
Version : 1.0  
*************************************************/


trigger AnnualParticipationModificationTrigger on Team_Member__c (before insert,after insert,before Update,after Update,after Delete,After Undelete) 
{
    if(trigger.isAfter && trigger.isInsert)
    {
        AnnualParticipationHandlerClass.createOrUpdateParticipationFromTeamMem(trigger.new);
    }
    
    // Update People when TM is inserted 
    /*if(trigger.isAfter && trigger.isInsert )
    {
        AnnualParticipationHandlerClass.UpdatePeopleAppFromTM(trigger.new);
    }*/
    
    // Update People when TM is  Deleted
    
    if(trigger.isAfter && trigger.isDelete)
    {
        AnnualParticipationHandlerClass.UpdatePeopleAppFromTM(trigger.old);
    }
    
    // Update People when TM record is undeleted
    if(trigger.isAfter && trigger.isUndelete)
    {
        AnnualParticipationHandlerClass.UpdatePeopleAppFromTM(trigger.new);
    }
    
    // Update People when TM is  updated
    
    if(trigger.isAfter && trigger.isUpdate)
    {
        list<Team_Member__c> TMList= new List<Team_Member__c>();
        For(Team_Member__c tm:trigger.new){
            //|| (trigger.oldMap != null && trigger.oldMap.get(tm.id).Project__c != null && trigger.oldMap.get(tm.id).Project__c != tm.Project__c)
            if((trigger.oldMap != null && trigger.oldMap.get(tm.id).Name__c != null && trigger.oldMap.get(tm.id).Name__c != tm.Name__c)
               ){
               
                   TMList.add(trigger.oldMap.get(tm.id));
                   TMList.add(tm);
            
            }
        
        }
        
        if(TMList.size() > 0){
            
            AnnualParticipationHandlerClass.UpdatePeopleAppFromTM(TMList);
        
        }
        
        
    }
}