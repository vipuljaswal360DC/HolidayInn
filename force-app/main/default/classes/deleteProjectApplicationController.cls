global with sharing class deleteProjectApplicationController {
    @AuraEnabled @RemoteAction
    global static String fetchApplication(Id projectAppID){
        try{
            system.debug('projectAppID'+projectAppID);
            Application_Survey_Form__c pa = [Select Id, Submission_Status__c from Application_Survey_Form__c where Id=:projectAppID];
            if(pa.Submission_Status__c != NULL){
                system.debug('Submission_Status__c'+pa.Submission_Status__c);
                return pa.Submission_Status__c;
            }else{
                return pa.Submission_Status__c;
            }
        }
        catch(Exception e){
            return 'exception';
        }
    }
    @AuraEnabled @RemoteAction
    global static String updateStatus(Id projectAppID){
        try{
            Application_Survey_Form__c pa = [Select Id, Submission_Status__c from Application_Survey_Form__c where Id=:projectAppID];
            if(pa.Submission_Status__c != NULL){
                pa.Submission_Status__c = 'Withdrawn';
                update pa;
                return 'success';
            }else{
                return 'notInSubmission';
            }
        }
        catch(Exception e){
            return 'exception';
        }
    }
    @AuraEnabled @RemoteAction
    public static List<ListView> getListViews() {
        List<ListView> listviews =
            [SELECT Id, Name FROM ListView WHERE SobjectType = 'Application_Survey_Form__c'];
        
        // Perform isAccessible() check here
        return listviews;
    }
    @AuraEnabled
    global static Boolean isPortalUser(Id userId){
        try{
            Boolean IsPortalUser;
            system.debug('userId'+userId);
            User objUser = [Select Id, IsPortalEnabled from User where Id=:userId];
            if(objUser != null){
                if(objUser.IsPortalEnabled){
                    system.debug('IsPortalEnabled '+objUser.IsPortalEnabled);
                    IsPortalUser = True;
                }else{
                    IsPortalUser = False;
                }
            }else{
                IsPortalUser = Null;
            }
            return IsPortalUser;
        }
        catch(Exception e){
            return Null;
        }
    }
    @AuraEnabled 
    global static boolean deleteApplication(Id projectAppID){
        try{
            Boolean Status=false;
            Application_Survey_Form__c pa = [Select Id, Submission_Status__c from Application_Survey_Form__c where Id=:projectAppID];
            if(pa != NULL){
                delete pa;
                Status= true;
            }else{
                Status = false;
            }
            return Status;
        }
        catch(Exception e){
            return false;
        }
    }
}