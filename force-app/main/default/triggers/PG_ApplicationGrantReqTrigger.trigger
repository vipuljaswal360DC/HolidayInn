/* Trigger Name: PG_ApplicationGrantReqTrigger
* Usage: 
*/

trigger PG_ApplicationGrantReqTrigger on Application_Grant_Request_Form__c (before insert,after insert,after update) {
    
    
    if(trigger.isBefore && trigger.isInsert){
        for(Application_Grant_Request_Form__c apGRF:trigger.new){
            if(apGRF.Date_of_your_last_FY_End__c != null){
                
                
                apGRF.Date_of_your_last_FY_End__c = Date.parse(apGRF.Date_of_your_last_FY_End__c.month() + '/' + apGRF.Date_of_your_last_FY_End__c.day() + '/' + apGRF.Date_of_your_last_FY_End__c.year());
                
            }
            if(apGRF.Anticipated_Project_End_Date__c != null){
                
                
                apGRF.Anticipated_Project_End_Date__c =Date.parse(apGRF.Anticipated_Project_End_Date__c.month() + '/' + apGRF.Anticipated_Project_End_Date__c.day() + '/' + apGRF.Anticipated_Project_End_Date__c.year());
                
            }
            
            if(apGRF.Anticipated_Project_Start_Date__c != null){
                
                
                apGRF.Anticipated_Project_Start_Date__c =Date.parse(apGRF.Anticipated_Project_Start_Date__c.month() + '/' + apGRF.Anticipated_Project_Start_Date__c.day() + '/' + apGRF.Anticipated_Project_Start_Date__c.year());
                
            }
            
            
        }
        
    }
    if(trigger.isAfter){
        if(!PG_ApplicationSurveyLogUtilityClass.isRecursive){
            PG_ApplicationSurveyLogUtilityClass.isRecursive = true;
            
            PG_ApplicationGrantReqBatchClass batchRef = new PG_ApplicationGrantReqBatchClass(trigger.new);
            database.executeBatch(batchRef, 1);
        }
    }
}