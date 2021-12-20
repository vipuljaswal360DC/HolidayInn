/* Class Name: PG_ApplicationSurveyLogUtilityClass
 * Usage: This class will create the application survey logs.
 * 
 */
public class PG_ApplicationSurveyLogUtilityClass {
    
    public static boolean isRecursive = false; //To prevent recursive flow
    /* Method Name: createLog
     * Usage: This method will create the application survey logs.
     * Return Type: void
     * Parameters: Appication survey form reference, Status and description
     */
    public static void createLog(Application_Survey_Form__c appObj, String status, String message){
        //Creating logs
        Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c(Application_Survey_Form__c = appObj.Id,
                                                                                    Status__c = status,
                                                                                    Error_Description__c = message);
        insert logObj;
        
        Application_Survey_Form__c appObjToUpdate = [select id,Status__c,Stop_Resync__c from Application_Survey_Form__c where Id=:appObj.Id limit 1];
        appObjToUpdate.Status__c = 'Failed';
        appObjToUpdate.Stop_Resync__c=false;
        PG_ApplicationSurveyLogUtilityClass.isRecursive = true;
        update appObjToUpdate;
    }
    
    /* Method Name: createLogForWaiverForm
     * Usage: This method will create the waiver survey Form logs.
     * Return Type: void
     * Parameters: Appication survey form reference, Status and description
     */
    public static void createLogForWaiverForm(Waiver_Pre_programme_Survey_Form__c appObj, String status, String message){
        //Creating logs
        Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c(Waiver_Pre_programme_Survey_Form__c = appObj.Id,
                                                                                    Status__c = status,
                                                                                    Error_Description__c = message);
        insert logObj;
        
        Waiver_Pre_programme_Survey_Form__c appObjToUpdate = [select id,Status__c,Synced__c from Waiver_Pre_programme_Survey_Form__c where Id=:appObj.Id limit 1];
        appObjToUpdate.Status__c = 'Failed';
        appObjToUpdate.Synced__c=false;
        PG_ApplicationSurveyLogUtilityClass.isRecursive = true;
        update appObjToUpdate;
    }
    
    
    /* Method Name: createGrantReqLog
     * Usage: This method will create the application grant request logs.
     * Return Type: void
     * Parameters: Appication grant request form reference, Status and description
     */
    public static void createGrantReqLog(Application_Grant_Request_Form__c appObj, String status, String message){
        //Creating logs
        Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c(Application_Grant_Request_Form__c = appObj.Id,
                                                                                    Status__c = status,
                                                                                    Error_Description__c = message);
        insert logObj;
        
        Application_Grant_Request_Form__c  appObjToUpdate = [select id,Status__c from Application_Grant_Request_Form__c  where Id=:appObj.Id limit 1];
        appObjToUpdate.Status__c = 'Failed';
        PG_ApplicationSurveyLogUtilityClass.isRecursive = true;
        update appObjToUpdate;
    }
}