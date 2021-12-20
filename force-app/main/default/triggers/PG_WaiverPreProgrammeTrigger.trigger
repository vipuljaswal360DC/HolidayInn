/* Trigger Name: PG_WaiverPreProgrammeTrigger
 * Usage: 
 */

trigger PG_WaiverPreProgrammeTrigger on Waiver_Pre_programme_Survey_Form__c (before insert,after insert,after update) {
    
    /*if(trigger.isBefore && trigger.isInsert ){
        for(Application_Survey_Form__c aSFObj:trigger.new){
            
            if(aSFObj.Grant_Use__c.containsIgnoreCase('sim') || aSFObj.Grant_Use__c.containsIgnoreCase('si')){
                aSFObj.Grant_Use__c='Yes';
            }
            if(aSFObj.Home_Office_Country__c.containsIgnoreCase('Brasil') || aSFObj.Organization_Country__c.containsIgnoreCase('Brasil') || aSFObj.Team_Captain_Home_Office_Country__c.containsIgnoreCase('Brasil')){
                
                aSFObj.Home_Office_Country__c='Brazil';
                aSFObj.Organization_Country__c='Brazil';
                aSFObj.Team_Captain_Home_Office_Country__c='Brazil';
            }
        }
    }*/
    
    if(trigger.isAfter && trigger.isInsert ){
        
        
        if(!PG_ApplicationSurveyLogUtilityClass.isRecursive){
            
            PG_ApplicationSurveyLogUtilityClass.isRecursive = true;
            PG_WaiverPreProgrammeSurveyBatchClass batchRef = new PG_WaiverPreProgrammeSurveyBatchClass(trigger.new);
            database.executeBatch(batchRef, 1);
        
        }
    }
    if(trigger.isAfter && trigger.isUpdate){
        list<Waiver_Pre_programme_Survey_Form__c> waiverSurveyList= new list<Waiver_Pre_programme_Survey_Form__c>();
        
        for(Waiver_Pre_programme_Survey_Form__c aSFObj:trigger.new){
            if(trigger.old != null && trigger.oldMap != null && trigger.oldMap.get(aSFObj.id).Synced__c == false && aSFObj.Synced__c==true){
                waiverSurveyList.add(aSFObj);
            }
        }
        if(!waiverSurveyList.isEmpty() && waiverSurveyList.size() > 0 && !PG_ApplicationSurveyLogUtilityClass.isRecursive){
            PG_ApplicationSurveyLogUtilityClass.isRecursive = true;
            PG_WaiverPreProgrammeSurveyBatchClass batchRef = new PG_WaiverPreProgrammeSurveyBatchClass(waiverSurveyList);
            database.executeBatch(batchRef, 1);
        
        }
        
    }
}