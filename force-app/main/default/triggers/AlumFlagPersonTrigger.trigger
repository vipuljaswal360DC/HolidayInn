/*This trigger updates the alum flag on the person if there is any participation exist for that person*/

trigger AlumFlagPersonTrigger on Participation__c (after insert, after update, after delete,after undelete) 
{
    if(trigger.isAfter)
    {
        if(trigger.isInsert || trigger.isUpdate || trigger.isdelete || trigger.isUndelete)
        {
            AnnualParticipationHandlerClass.setAlumFlag(trigger.new,trigger.old);
            AnnualParticipationHandlerClass.UpdatePeopleFromAP(trigger.new);
            
        }
        if(trigger.isdelete ){
            AnnualParticipationHandlerClass.UpdatePeopleFromAP(trigger.old);
        }
    }
}