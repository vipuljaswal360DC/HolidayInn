/* this trigger is called when a project object is updated by a user */
/* based on the project status it will update the annualParticipation counter for */
/* the team members in the project */
/* Project status changes to Accepted or Aprroved in principle, the counter is incremented */
/* check if the counter is decremented if the status changes from Accpeted or Approved in principle */
/* to another status */

trigger AnnualParticipationUpdateTrigger  on Projects__c (after update) 
{
    if(trigger.isAfter && trigger.isUpdate)
    {        
        AnnualParticipationHandlerClass.createOrUpdateParticipationFromProject(trigger.new,trigger.oldMap);
    }
}