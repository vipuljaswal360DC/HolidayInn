/* Class Name: PG_ApplicationGrantReqBatchClass
 * Usage: This batch class will insert the data of account, contacts and project conditionally and will create the log for the same.
 * 
 */

public class PG_ApplicationGrantReqBatchClass implements Database.Batchable<Application_Grant_Request_Form__c>,Database.Stateful,Database.AllowsCallouts{
    
    public List<Application_Grant_Request_Form__c> applicationGrantReqDataList; //List of Application_Survey_Form data
    public list<Grant_Request__c> successGrantReqDataList = new list<Grant_Request__c>();
    //public map<Grant_Request__c,Application_Grant_Request_Form__c> grantReqvsApplicationFormMap = new map<Grant_Request__c,Application_Grant_Request_Form__c>();
    
    
    /* Method Name: PG_ApplicationGrantReqBatchClass
   * Type: Constructor
   * Parameter: List of Application_Grant_Request_Form data
   */
    public PG_ApplicationGrantReqBatchClass(List<Application_Grant_Request_Form__c> applicationGrantReqDataList){
        this.applicationGrantReqDataList = applicationGrantReqDataList;
    }
    
    /* Method Name: start
   * Type: Standard Method
   */
    public List<Application_Grant_Request_Form__c> start(Database.BatchableContext BC){
        return applicationGrantReqDataList;
    }
    
    /* Method Name: execute
   * Type: Standard Method
   */
    public void execute(Database.BatchableContext BC, List<Application_Grant_Request_Form__c> applicationGrantReqDataList){ 
        if(applicationGrantReqDataList != null && applicationGrantReqDataList.size()>0){
            
            Application_Grant_Request_Form__c appObj = applicationGrantReqDataList[0];    //Application_Grant_Request_Form reference
            Savepoint sp = Database.setSavepoint();                                      //Set Savepoint
            
            try{
                //Processing data for account
                Account accObj;
                if(appObj.Organisation_Name__c.trim().replaceAll('[ ]{2,}', ' ') != null && appObj.Organisation_Name__c.trim().replaceAll('[ ]{2,}', ' ') != ''){
                    String accountName = appObj.Organisation_Name__c.trim().replaceAll('[ ]{2,}', ' ');
                    //Calling the utility class method to check if account exist or not
                    PG_AccountUtilityClass.AccountInfoWrapper accountInfoWrapper = PG_AccountUtilityClass.validateAccount(accountName);
                    
                    //Creating error log if any found
                    if(accountInfoWrapper.status == 'Error'){
                        Database.rollback(sp);
                        PG_ApplicationSurveyLogUtilityClass.createGrantReqLog(appObj, accountInfoWrapper.status, accountInfoWrapper.message);
                        return;
                    }
                    
                    //Creating account record if not exist
                    if(accountInfoWrapper.isAccountExist){
                        accObj = accountInfoWrapper.acc;
                        accObj = PG_AccountUtilityClass.updateAccount(accObj, accountName,'','','','','','','',appObj.Town_City__c,appObj.Country__c,'',appObj.Postal_Code__c,'',appObj.Registered_Address_Street__c, '',appObj.Registration_Number__c,appObj.Office_Phone_Number__c);
                    }else{
                        //No Account Found
                        Database.rollback(sp);
                        PG_ApplicationSurveyLogUtilityClass.createGrantReqLog(appObj, 'Error', accountInfoWrapper.message);
                        return;
                    }
                }
                
                
                
                //Processing data for Project
                Projects__c projObj;
                if(appObj.Project_Title__c.trim().replaceAll('[ ]{2,}', ' ') != null && appObj.Project_Title__c.trim().replaceAll('[ ]{2,}', ' ') != ''){
                    String projectName = appObj.Project_Title__c.trim().replaceAll('[ ]{2,}', ' ');
                    
                    //Calling the utility class method to check if project exist or not
                    PG_ProjectUtilityClass.ProjectInfoWrapper projectInfoWrapper = PG_ProjectUtilityClass.validateProjectForGrantReq(projectName);
                    
                    //Creating error log if any found
                    if(projectInfoWrapper.status == 'Error'){
                        Database.rollback(sp);
                        PG_ApplicationSurveyLogUtilityClass.createGrantReqLog(appObj, projectInfoWrapper.status, projectInfoWrapper.message);
                        return;
                    }
                    
                    //Creating project record if not exist
                    if(projectInfoWrapper.isProjectExist){
                        projObj = projectInfoWrapper.proj;
                        projObj = PG_ProjectUtilityClass.updateProject(projObj, 'Submitted', date.today());
                    }else{
                        //No Project Found
                        Database.rollback(sp);
                        PG_ApplicationSurveyLogUtilityClass.createGrantReqLog(appObj, 'Error', projectInfoWrapper.message);
                        return;
                    }
                }
                
                
                
                //Processing data for contact
                Contact conObj;
                if(appObj.POC_Email_Address__c != null && appObj.POC_Email_Address__c != ''){            
                    String contactName = appObj.POC_First_Name__c.trim().replaceAll('[ ]{2,}', ' ') + ' '+ appObj.POC_Last_Name__c.trim().replaceAll('[ ]{2,}', ' ');
                    String contactEmail = appObj.POC_Email_Address__c;
                    
                    //Calling the utility class method to check if contact exist or not from email
                    PG_ContactUtilityClass.ContactInfoWrapper contactInfoWrapperEmail = PG_ContactUtilityClass.validateOrgContact(contactEmail, contactName, 'Email');
                    
                    //Creating error log if any found
                    if(contactInfoWrapperEmail.status == 'Error'){
                        Database.rollback(sp);
                        PG_ApplicationSurveyLogUtilityClass.createGrantReqLog(appObj, contactInfoWrapperEmail.status, contactInfoWrapperEmail.message);
                        return;
                    }
                    
                    //Creating contact record if not exist
                    if(contactInfoWrapperEmail.isContactExist){
                        conObj = contactInfoWrapperEmail.con;
                        if(conObj.AccountId == accObj.Id){
                            if(!conObj.notActive__c){
                                conObj = PG_ContactUtilityClass.updateContact(conObj,appObj.POC_First_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.POC_Last_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.POC_Primary_Phone_Number__c,appObj.POC_Email_Address__c,appObj.POC_Job_Title_Role__c,'','','','','','',''); 
                            }else{
                                Database.rollback(sp);
                                PG_ApplicationSurveyLogUtilityClass.createGrantReqLog(appObj, 'Error', conObj.Name+' is not active.');
                                return;
                            }
                        }else{
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createGrantReqLog(appObj, 'Error', conObj.Name+' is linked with another organisation.');
                            return;
                        }
                        
                    }else{
                        //Calling the utility class method to check if contact exist or not from email
                        PG_ContactUtilityClass.ContactInfoWrapper contactInfoWrapperName = PG_ContactUtilityClass.validateOrgContact(contactEmail, contactName, 'Name');
                        
                        //Creating error log if any found
                        if(contactInfoWrapperName.status == 'Error'){
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createGrantReqLog(appObj, contactInfoWrapperName.status, contactInfoWrapperName.message);
                            return;
                        }
                        if(contactInfoWrapperName.isContactExist){
                            conObj = contactInfoWrapperName.con;
                            if(conObj.AccountId == accObj.Id){
                                if(!conObj.notActive__c){
                                    conObj = PG_ContactUtilityClass.updateContact(conObj,appObj.POC_First_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.POC_Last_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.POC_Primary_Phone_Number__c,appObj.POC_Email_Address__c,appObj.POC_Job_Title_Role__c,'','','','','','',''); 
                                }else{
                                    Database.rollback(sp);
                                    PG_ApplicationSurveyLogUtilityClass.createGrantReqLog(appObj, 'Error', conObj.Name+' is not active.');
                                    return;
                                }
                            }else{
                                Database.rollback(sp);
                                PG_ApplicationSurveyLogUtilityClass.createGrantReqLog(appObj, 'Error', conObj.Name+' is linked with another organisation.');
                                return;
                            }
                            
                        }else{
                            /*No Contact Found
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createGrantReqLog(appObj, 'Error', contactInfoWrapperName.message);
                            return;*/
                            conObj = PG_ContactUtilityClass.createContact(accObj,appObj.POC_First_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.POC_Last_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.POC_Primary_Phone_Number__c,appObj.POC_Email_Address__c,appObj.POC_Job_Title_Role__c,'','','','','','','');
                        }
                    }
                }
                
                
                //Processing data for team captain
                if(appObj.Team_Captain_Email_Address__c != null && appObj.Team_Captain_Email_Address__c != ''){
                    String contactName = appObj.Team_Captain_First_Name__c.trim().replaceAll('[ ]{2,}', ' ') + ' '+ appObj.Team_Captain_Last_Name__c.trim().replaceAll('[ ]{2,}', ' ');
                    String contactEmail = appObj.Team_Captain_Email_Address__c;
                    
                    //Calling the utility class method to check if contact exist or not
                    PG_ContactUtilityClass.ContactInfoWrapper contactInfoWrapperEmail = PG_ContactUtilityClass.validateOrgContact(contactEmail, contactName, 'Email');
                    
                    //Creating error log if any found
                    if(contactInfoWrapperEmail.status == 'Error'){
                        Database.rollback(sp);
                        PG_ApplicationSurveyLogUtilityClass.createGrantReqLog(appObj, contactInfoWrapperEmail.status, contactInfoWrapperEmail.message);
                        return;
                    }
                    
                    //Creating contact record if not exist
                    Contact captainObj;
                    if(contactInfoWrapperEmail.isContactExist){
                        captainObj = contactInfoWrapperEmail.con;
                        if(!captainObj.notActive__c){
                            captainObj = PG_ContactUtilityClass.updateContact(captainObj,appObj.Team_Captain_First_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.Team_Captain_Last_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.Team_Captain_Primary_Phone_Number__c,appObj.Team_Captain_Email_Address__c,'','','','',appObj.Team_Captain_Company_Affiliation__c,'','','');
                        }else{
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createGrantReqLog(appObj, 'Error', captainObj.Name+' is not active.');
                            return;
                        }
                    }else{
                        //Calling the utility class method to check if contact exist or not from email
                        PG_ContactUtilityClass.ContactInfoWrapper contactInfoWrapperName = PG_ContactUtilityClass.validateOrgContact(contactEmail, contactName, 'Name');
                        
                        //Creating error log if any found
                        if(contactInfoWrapperName.status == 'Error'){
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createGrantReqLog(appObj, contactInfoWrapperName.status, contactInfoWrapperName.message);
                            return;
                        }
                        if(contactInfoWrapperName.isContactExist){
                            captainObj = contactInfoWrapperName.con;
                            if(!captainObj.notActive__c){
                                captainObj = PG_ContactUtilityClass.updateContact(captainObj,appObj.Team_Captain_First_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.Team_Captain_Last_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.Team_Captain_Primary_Phone_Number__c,appObj.Team_Captain_Email_Address__c,'','','','',appObj.Team_Captain_Company_Affiliation__c,'','','');
                            }else{
                                Database.rollback(sp);
                                PG_ApplicationSurveyLogUtilityClass.createGrantReqLog(appObj, 'Error', captainObj.Name+' is not active.');
                                return;
                            }
                        }else{
                            //No Team Captain Found
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createGrantReqLog(appObj, 'Error', contactInfoWrapperName.message);
                            return;
                        }
                    }
                }
                
                
                //Processing data for Grant Request
                if(accObj != null && projObj != null){
                    String grantReqName = appObj.Organisation_Name__c.trim().replaceAll('[ ]{2,}', ' ')+'-'+appObj.Project_Title__c.trim().replaceAll('[ ]{2,}', ' ');
                    
                    //Calling the utility class method to check if project exist or not
                    PG_GrantRequestUtilityClass.GrantReqInfoWrapper grantReqInfoWrapper = PG_GrantRequestUtilityClass.validateGrantReq(grantReqName);
                    
                    //Creating error log if any found
                    if(grantReqInfoWrapper.status == 'Error'){
                        Database.rollback(sp);
                        PG_ApplicationSurveyLogUtilityClass.createGrantReqLog(appObj, grantReqInfoWrapper.status, grantReqInfoWrapper.message);
                        return;
                    }
                    
                    //Creating project record if not exist
                    if(grantReqInfoWrapper.isGrantReqExist){
                        //Grant Request Found
                        Database.rollback(sp);
                        PG_ApplicationSurveyLogUtilityClass.createGrantReqLog(appObj, 'Error', grantReqInfoWrapper.message);
                        return;
                    }else{
                        Grant_Request__c grantReqObj = PG_GrantRequestUtilityClass.createGrantReq(grantReqName, accObj, projObj, conObj, appObj);
                        if(grantReqObj!= null && grantReqObj.Id != null){
                            successGrantReqDataList.add(grantReqObj);
                            //grantReqvsApplicationFormMap.put(grantReqObj, appObj);
                        }
                    }
                }
                Application_Grant_Request_Form__c appObjToUpdate = [select id,Status__c from Application_Grant_Request_Form__c where Id=:appObj.Id limit 1];
                appObjToUpdate.Status__c = 'Success';
                PG_ApplicationSurveyLogUtilityClass.isRecursive = true;
                update appObjToUpdate;
                
            }catch(Exception e){
                System.debug('-----Exception-----'+e.getMessage()+'----Line number----'+e.getLineNumber());
                Database.rollback(sp);
                PG_ApplicationSurveyLogUtilityClass.createGrantReqLog(appObj, 'Error', e.getMessage());
                return;
            }
        }
    }
    
    /* Method Name: finish
   * Type: Standard Method
     */
    public void finish(Database.BatchableContext BC){
        System.debug('-----successGrantReqDataList-----'+successGrantReqDataList);
        if(successGrantReqDataList != null && successGrantReqDataList.size()>0){
            PG_DownloadAttachmentBatchClass batchRef = new PG_DownloadAttachmentBatchClass(successGrantReqDataList);
            database.executeBatch(batchRef, 1);
        }
    }
}