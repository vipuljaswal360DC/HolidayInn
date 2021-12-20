/* Class Name: PG_WaiverPreProgrammeSurveyBatchClass
* Usage: This batch class will update the data of Annual Participation post verifying the contacts and will create the log for the same if verification failed.
* 
*/

public class PG_WaiverPreProgrammeSurveyBatchClass implements Database.Batchable<Waiver_Pre_programme_Survey_Form__c>{

public List<Waiver_Pre_programme_Survey_Form__c> applicationSurveyDataList; //List of Waiver_Pre_programme_Survey_Form data

/* Method Name: PG_WaiverPreProgrammeSurveyBatchClass
* Type: Constructor
* Parameter: List of Waiver_Pre_programme_Survey_Form data
*/
public PG_WaiverPreProgrammeSurveyBatchClass(List<Waiver_Pre_programme_Survey_Form__c> applicationSurveyDataList){
    this.applicationSurveyDataList = applicationSurveyDataList;
}

/* Method Name: start
* Type: Standard Method
*/
public List<Waiver_Pre_programme_Survey_Form__c> start(Database.BatchableContext BC){
    return applicationSurveyDataList;
}

/* Method Name: execute
* Type: Standard Method
*/
public void execute(Database.BatchableContext BC, List<Waiver_Pre_programme_Survey_Form__c> applicationSurveyDataList){            
    if(applicationSurveyDataList != null && applicationSurveyDataList.size()>0){
        
        Waiver_Pre_programme_Survey_Form__c appObj = applicationSurveyDataList[0];    //Waiver_Pre_programme_Survey_Form reference
        Savepoint sp = Database.setSavepoint();                             //Set Savepoint
        
        try{
            
            //Processing data for contact
            Contact conObj;
            if(appObj.Contact_Work_Email__c != null && appObj.Contact_Work_Email__c != ''){            
                String contactName = appObj.Contact_First_Name__c.trim().replaceAll('[ ]{2,}', ' ') + ' '+ appObj.Contact_Last_Name__c.trim().replaceAll('[ ]{2,}', ' ');
                String contactEmail = appObj.Contact_Work_Email__c;
                
                //Calling the utility class method to check if contact exist or not from email
                PG_ContactUtilityClass.ContactInfoWrapper contactInfoWrapperEmail = PG_ContactUtilityClass.validateOrgContact(contactEmail, contactName, 'Email');
                
                //Creating error log if any found
                if(contactInfoWrapperEmail.status == 'Error'){
                    Database.rollback(sp);
                    PG_ApplicationSurveyLogUtilityClass.createLogForWaiverForm(appObj, contactInfoWrapperEmail.status, contactInfoWrapperEmail.message);
                    return;
                }
                
                //Creating contact record if not exist
                if(contactInfoWrapperEmail.isContactExist){
                    conObj = contactInfoWrapperEmail.con;
                    if(conObj.High_Risk__c != null && conObj.High_Risk__c){
                        Database.rollback(sp);
                        PG_ApplicationSurveyLogUtilityClass.createLogForWaiverForm(appObj, 'Warning','Conatct : '+ conObj.Name+' is at High Risk.');
                        return;
                    }else if(appObj.Company_Affiliation__c != null &&(conObj.Company_Affiliation__c.trim().replaceAll('[ ]{2,}', ' ') != appObj.Company_Affiliation__c.trim().replaceAll('[ ]{2,}', ' '))){
                        Database.rollback(sp);
                        PG_ApplicationSurveyLogUtilityClass.createLogForWaiverForm(appObj, 'Error', 'Contact Company Affiliation ' + (conObj.Company_Affiliation__c.trim().replaceAll('[ ]{2,}', ' ')) + ' of Contact '+conObj.Name+' is not Same with Waiver App Company Affiliation : '+appObj.Company_Affiliation__c);
                        return;
                    }else if(conObj.Department != null){
                        If(appObj.Contact_BusUnitAnglo__c != null && ((conObj.Department.trim().replaceAll('[ ]{2,}', ' ') != appObj.Contact_BusUnitAnglo__c.trim().replaceAll('[ ]{2,}', ' ')))){
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLogForWaiverForm(appObj, 'Error', 'Contact Company ' + conObj.Company_Affiliation__c.trim().replaceAll('[ ]{2,}', ' ') + ' and Business Unit ' + (conObj.Department.trim().replaceAll('[ ]{2,}', ' ')) + ' Of Contact '+conObj.Name+' is not Same with Waiver App Business unit Anglo:'+appObj.Contact_BusUnitAnglo__c);
                            return;
                            
                        }else if(appObj.Contact_BusUnitDebeers__c != null && (conObj.Department.trim().replaceAll('[ ]{2,}', ' ') != appObj.Contact_BusUnitDebeers__c.trim().replaceAll('[ ]{2,}', ' '))){
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLogForWaiverForm(appObj, 'Error', 'Contact Company ' + conObj.Company_Affiliation__c.trim().replaceAll('[ ]{2,}', ' ') + ' and Business Unit ' + (conObj.Department.trim().replaceAll('[ ]{2,}', ' '))+  'Of Contact '+conObj.Name+' is not Same with Waiver App Business Unit Debeers:'+appObj.Contact_BusUnitAnglo__c);
                            return;
                        }
                        //system.debug('--appObj.Home_Office_Country__c-'+appObj.Home_Office_Country__c.trim().replaceAll('[ ]{2,}', ' ')+conObj.Home_Office__c.trim().replaceAll('[ ]{2,}', ' '));
                    
                    }else if(!conObj.notActive__c){
                        //conObj = PG_ContactUtilityClass.updateContact(conObj,appObj.Contact_First_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.Contact_Last_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.Contact_Phone_Number__c,appObj.Contact_Work_Email__c,appObj.Contact_Title__c,'','','','','','',appObj.Home_Office_Country__c); 
                    }else{
                        Database.rollback(sp);
                        PG_ApplicationSurveyLogUtilityClass.createLogForWaiverForm(appObj, 'Error', 'Contact '+conObj.Name+' is not active.');
                        return;
                    }
                    
                    if(appObj.Home_Office_Country__c != null && appObj.Home_Office_Country__c != '' ){
                        
                        if(conObj.Home_Office__c != appObj.Home_Office_Country__c.trim().replaceAll('[ ]{2,}', ' ')){
                            system.debug('--appObj.Home_Office_Country__c-'+appObj.Home_Office_Country__c);
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLogForWaiverForm(appObj, 'Error', 'Location of Contact '+conObj.Name+' is not Same with Waiver App Home Office Country : '+appObj.Home_Office_Country__c);
                            return;
                            
                        }else{}
                        
                    }
                }else{
                    //Calling the utility class method to check if contact exist or not from email
                    PG_ContactUtilityClass.ContactInfoWrapper contactInfoWrapperName = PG_ContactUtilityClass.validateOrgContact(contactEmail, contactName, 'Name');
                    
                    //Creating error log if any found
                    if(contactInfoWrapperName.status == 'Error'){
                        Database.rollback(sp);
                        PG_ApplicationSurveyLogUtilityClass.createLogForWaiverForm(appObj, contactInfoWrapperName.status, contactInfoWrapperName.message);
                        return;
                    }
                    if(contactInfoWrapperName.isContactExist){
                        conObj = contactInfoWrapperName.con;
                        if(conObj.High_Risk__c != null && conObj.High_Risk__c){
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLogForWaiverForm(appObj, 'Error', 'Conatct '+conObj.Name+' is at High Risk.');
                            return;
                        } else if(appObj.Company_Affiliation__c != null &&(conObj.Company_Affiliation__c.trim().replaceAll('[ ]{2,}', ' ') != appObj.Company_Affiliation__c.trim().replaceAll('[ ]{2,}', ' '))){
                        Database.rollback(sp);
                        PG_ApplicationSurveyLogUtilityClass.createLogForWaiverForm(appObj, 'Error', 'Contact Company Affiliation ' + (conObj.Company_Affiliation__c.trim().replaceAll('[ ]{2,}', ' ')) + ' of Contact '+conObj.Name+' is not Same with Waiver App Company Affiliation : '+appObj.Company_Affiliation__c);
                        return;
                    }else if(conObj.Department != null){
                        If(appObj.Contact_BusUnitAnglo__c != null && ((conObj.Department.trim().replaceAll('[ ]{2,}', ' ') != appObj.Contact_BusUnitAnglo__c.trim().replaceAll('[ ]{2,}', ' ')))){
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLogForWaiverForm(appObj, 'Error', 'Contact Company ' + conObj.Company_Affiliation__c.trim().replaceAll('[ ]{2,}', ' ') + ' and Business Unit ' + (conObj.Department.trim().replaceAll('[ ]{2,}', ' ')) + ' Of Contact '+conObj.Name+' is not Same with Waiver App Business unit Anglo:'+appObj.Contact_BusUnitAnglo__c);
                            return;
                            
                        }else if(appObj.Contact_BusUnitDebeers__c != null && (conObj.Department.trim().replaceAll('[ ]{2,}', ' ') != appObj.Contact_BusUnitDebeers__c.trim().replaceAll('[ ]{2,}', ' '))){
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLogForWaiverForm(appObj, 'Error', 'Contact Company ' + conObj.Company_Affiliation__c.trim().replaceAll('[ ]{2,}', ' ') + ' and Business Unit ' + (conObj.Department.trim().replaceAll('[ ]{2,}', ' '))+  'Of Contact '+conObj.Name+' is not Same with Waiver App Business Unit Debeers:'+appObj.Contact_BusUnitAnglo__c);
                            return;
                        }
                        //system.debug('--appObj.Home_Office_Country__c-'+appObj.Home_Office_Country__c.trim().replaceAll('[ ]{2,}', ' ')+conObj.Home_Office__c.trim().replaceAll('[ ]{2,}', ' '));
                    
                    }else if(!conObj.notActive__c){
                            //conObj = PG_ContactUtilityClass.updateContact(conObj,appObj.Contact_First_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.Contact_Last_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.Contact_Phone_Number__c,appObj.Contact_Work_Email__c,appObj.Contact_Title__c,'','','','','','',appObj.Home_Office_Country__c); 
                        }else{
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLogForWaiverForm(appObj, 'Error','Conatct '+ conObj.Name+' is not active.');
                            return;
                        }
                        if(appObj.Home_Office_Country__c != null && appObj.Home_Office_Country__c != '' ){
                            
                            if(conObj.Home_Office__c != appObj.Home_Office_Country__c.trim().replaceAll('[ ]{2,}', ' ')){
                                system.debug('--appObj.Home_Office_Country__c-'+appObj.Home_Office_Country__c);
                                Database.rollback(sp);
                                PG_ApplicationSurveyLogUtilityClass.createLogForWaiverForm(appObj, 'Error', 'Location of Contact '+conObj.Name+' is not Same with Waiver App Home Office Country : '+appObj.Home_Office_Country__c);
                                return;
                                
                            }else{}
                            
                        }   
                    }else{
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLogForWaiverForm(appObj, 'Error', 'No Contact Found With Name '+contactName);
                            return;
                    }
                }
            }
            
            //Processing data for Annual Participation
            if(appObj.Annual_Participation_Name__c != null && conObj != null){
                list<Participation__c> AnnualPartObjList =new list<Participation__c>([select id,Name,Counter__c,Application_Round__c,LineManager_Approval_PDF__c,Participation_Year__c,Person__c,WaiverPre_programme_Survey_PDF__c,Workshop_Check_In__c from Participation__c where Name=: appObj.Annual_Participation_Name__c AND Person__c=:conObj.id limit 1]);
                system.debug('--AnnualPartObjList-'+AnnualPartObjList.size());
                if(AnnualPartObjList.size()==0){
                    
                        Database.rollback(sp);
                        PG_ApplicationSurveyLogUtilityClass.createLogForWaiverForm(appObj,'Error', 'No Annual Participation Record Found With Name '+appObj.Annual_Participation_Name__c);
                        return;
                }else  if(AnnualPartObjList.size()>0 && AnnualPartObjList.size() == 1){
                    if(appObj.Waiver_Pre_programme_Survey_PDF__c != null){
                        AnnualPartObjList[0].WaiverPre_programme_Survey_PDF__c=appObj.Waiver_Pre_programme_Survey_PDF__c;
                    }
                    
                    update AnnualPartObjList;
                    
                }
                
            }else{
                        Database.rollback(sp);
                        PG_ApplicationSurveyLogUtilityClass.createLogForWaiverForm(appObj,'Error', 'No Annual Participation Record Found For Contact Name '+appObj.Contact_First_Name__c+' '+appObj.Contact_Last_Name__c);
                        return;
            }
           Waiver_Pre_programme_Survey_Form__c appObjToUpdate = [select id,Status__c from Waiver_Pre_programme_Survey_Form__c where Id=:appObj.Id limit 1];
           appObjToUpdate.Status__c= 'Success';
           appObjToUpdate.Synced__c=true;
           PG_ApplicationSurveyLogUtilityClass.isRecursive = true;
           update appObjToUpdate;
        }catch(Exception e){
            System.debug('-----Exception-----'+e.getMessage()+'----Line number----'+e.getLineNumber());
            Database.rollback(sp);
            if(e.getMessage().contains('DUPLICATES_DETECTED')){
                if(PG_ContactUtilityClass.insertingContact){
                    PG_ApplicationSurveyLogUtilityClass.createLogForWaiverForm(appObj, 'Error', 'Possible duplicates found for Contact :  '+ PG_ContactUtilityClass.contactName);
                }
                
            }else{
                PG_ApplicationSurveyLogUtilityClass.createLogForWaiverForm(appObj, 'Error', e.getMessage());
            }
            
            return;
            
        }
        
    }
}

/* Method Name: finish
* Type: Standard Method
*/
public void finish(Database.BatchableContext BC){
}
}