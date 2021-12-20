/* Trigger Name: PG_ApplicationSurveyTrigger
* Usage: 
*/

trigger PG_ApplicationSurveyTrigger on Application_Survey_Form__c (before insert,after insert,after update) {
    
    if(trigger.isBefore && trigger.isInsert ){
        for(Application_Survey_Form__c aSFObj:trigger.new){
            System.debug('aSFObj '+aSFObj);
            if(aSFObj.Grant_Use__c != null && aSFObj.Grant_Use__c != 'undefined'){
                if(aSFObj.Grant_Use__c.containsIgnoreCase('sim') || aSFObj.Grant_Use__c.containsIgnoreCase('si')){
                    aSFObj.Grant_Use__c='Yes';
                }   
            }
            if(aSFObj.Resubmission_Flag__c != null && aSFObj.Resubmission_Flag__c != 'undefined'){
                if(aSFObj.Resubmission_Flag__c.containsIgnoreCase('sim') || aSFObj.Resubmission_Flag__c.containsIgnoreCase('si')){
                    aSFObj.Resubmission_Flag__c='Yes';
                }
            }
            if((aSFObj.Home_Office_Country__c != null || aSFObj.Organization_Country__c != null || aSFObj.Team_Captain_Home_Office_Country__c != null) && aSFObj.Status__c != 'In-Progress'){
                if(aSFObj.Home_Office_Country__c.containsIgnoreCase('Brasil') || aSFObj.Organization_Country__c.containsIgnoreCase('Brasil') || aSFObj.Team_Captain_Home_Office_Country__c.containsIgnoreCase('Brasil')){                  
                    aSFObj.Home_Office_Country__c='Brazil';
                    aSFObj.Organization_Country__c='Brazil';
                    aSFObj.Team_Captain_Home_Office_Country__c='Brazil';
                }
            }
        }
    }
    
    if(trigger.isAfter && trigger.isInsert ){
        list<Application_Survey_Form__c> appSurveyRoundAList= new list<Application_Survey_Form__c>();
        list<Application_Survey_Form__c> appSurveyRoundBList= new list<Application_Survey_Form__c>();
        for(Application_Survey_Form__c aSFObj:trigger.new){
            if(aSFObj.Resubmission_Flag__c == 'No' && aSFObj.Status__c != 'In-Progress'){
                appSurveyRoundAList.add(aSFObj);
            }else if(aSFObj.Resubmission_Flag__c == 'Yes' && aSFObj.Status__c != 'In-Progress'){
                appSurveyRoundBList.add(aSFObj);
            }
        }
        if(!appSurveyRoundAList.isEmpty() && appSurveyRoundAList.size() > 0){
            PG_ApplicationSurveyBatchClass batchRef = new PG_ApplicationSurveyBatchClass(appSurveyRoundAList);
            database.executeBatch(batchRef, 1);
            
        }else if(!appSurveyRoundBList.isEmpty() && appSurveyRoundBList.size() > 0){
            PG_ApplicationSurveyBatchClassRoundB batchRef = new PG_ApplicationSurveyBatchClassRoundB(appSurveyRoundBList);
            database.executeBatch(batchRef, 1);
            
        }
        
        
        /*PG_ApplicationSurveyUtilityClass ref = new PG_ApplicationSurveyUtilityClass();
ref.processData(trigger.new);*/
    }
    if(trigger.isAfter && trigger.isUpdate){
        list<Application_Survey_Form__c> appSurveyRoundAList= new list<Application_Survey_Form__c>();
        list<Application_Survey_Form__c> appSurveyRoundBList= new list<Application_Survey_Form__c>();
        for(Application_Survey_Form__c aSFObj:trigger.new){
            if(trigger.old != null && trigger.oldMap != null && trigger.oldMap.get(aSFObj.id).Stop_Resync__c == false && aSFObj.Stop_Resync__c==true && aSFObj.Resubmission_Flag__c == 'No'){
                appSurveyRoundAList.add(aSFObj);
            }else if(trigger.old != null && trigger.oldMap != null && trigger.oldMap.get(aSFObj.id).Stop_Resync__c == false && aSFObj.Stop_Resync__c== true && aSFObj.Resubmission_Flag__c == 'Yes'){
                appSurveyRoundBList.add(aSFObj);
            }
        }
        if(!appSurveyRoundAList.isEmpty() && appSurveyRoundAList.size() > 0 && !PG_ApplicationSurveyLogUtilityClass.isRecursive){
            PG_ApplicationSurveyLogUtilityClass.isRecursive = true;
            PG_ApplicationSurveyBatchClass batchRef = new PG_ApplicationSurveyBatchClass(appSurveyRoundAList);
            System.debug('PG_ApplicationSurveyBatchClass - '+appSurveyRoundAList);
            database.executeBatch(batchRef, 1);
            
        }else if(!appSurveyRoundBList.isEmpty() && appSurveyRoundBList.size() > 0 && !PG_ApplicationSurveyLogUtilityClass.isRecursive){
            PG_ApplicationSurveyLogUtilityClass.isRecursive = true;
            PG_ApplicationSurveyBatchClassRoundB batchRef = new PG_ApplicationSurveyBatchClassRoundB(appSurveyRoundBList);
            System.debug('PG_ApplicationSurveyBatchClassRoundB - '+appSurveyRoundAList);
            database.executeBatch(batchRef, 1);
            
        }
        
    }
}