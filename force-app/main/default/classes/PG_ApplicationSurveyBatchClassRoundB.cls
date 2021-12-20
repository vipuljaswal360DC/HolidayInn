/* Class Name: PG_ApplicationSurveyBatchClassRoundB 
* Usage: This batch class will insert the data of account, contacts and project conditionally and will create the log for the same  for Round B Application
* 
*/

public class PG_ApplicationSurveyBatchClassRoundB implements Database.Batchable<Application_Survey_Form__c>{
    
    public List<Application_Survey_Form__c> applicationSurveyDataList; //List of Application_Survey_Form data
    
    /* Method Name: PG_ApplicationSurveyBatchClassRoundB
    * Type: Constructor
    * Parameter: List of Application_Survey_Form data
    */
    public PG_ApplicationSurveyBatchClassRoundB(List<Application_Survey_Form__c> applicationSurveyDataList){
        this.applicationSurveyDataList = applicationSurveyDataList;
    }
    
    /* Method Name: start
    * Type: Standard Method
    */
    public List<Application_Survey_Form__c> start(Database.BatchableContext BC){
        return applicationSurveyDataList;
    }
    
    /* Method Name: execute
    * Type: Standard Method
    */
    public void execute(Database.BatchableContext BC, List<Application_Survey_Form__c> applicationSurveyDataList){            
        if(applicationSurveyDataList != null && applicationSurveyDataList.size()>0){
            
            Application_Survey_Form__c appObj = applicationSurveyDataList[0];    //Application_Survey_Form reference
            Savepoint sp = Database.setSavepoint();                             //Set Savepoint
            
           try{
                //Processing data for account
                Account accObj;
                if(appObj.Organization_Name__c.trim().replaceAll('[ ]{2,}', ' ') != null && appObj.Organization_Name__c.trim().replaceAll('[ ]{2,}', ' ') != ''){
                    String accountName = appObj.Organization_Name__c.trim().replaceAll('[ ]{2,}', ' ');
                    
                    //Calling the utility class method to check if account exist or not
                    PG_AccountUtilityClass.AccountInfoWrapper accountInfoWrapper = PG_AccountUtilityClass.validateAccount(accountName);
                    
                    //Creating error log if any found
                    if(accountInfoWrapper.status == 'Error'){
                        Database.rollback(sp);
                        PG_ApplicationSurveyLogUtilityClass.createLog(appObj, accountInfoWrapper.status, accountInfoWrapper.message);
                        return;
                    }
                    
                    //Creating account record if not exist
                    if(accountInfoWrapper.isAccountExist){
                        accObj = accountInfoWrapper.acc;
                        if(accObj.High_Risk__c!= null && accObj.High_Risk__c){
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLog(appObj, 'Error', 'Host Org '+accObj.Name+' is at High Risk.');
                            return;
                            }else{
                            accObj = PG_AccountUtilityClass.updateAccount(accObj, accountName,appObj.Organisation_Full_Name__c,appObj.Organisation_Mission_and_Vision__c,appObj.Organisation_Website__c,appObj.Partner_Organisation_Communication__c,appObj.Partner_organisation_Participated_before__c,appObj.Partner_Organisation_registered_entity__c,appObj.Partner_Organisation_Sector_Activities__c,appObj.Organization_City_Town__c,appObj.Organization_Country__c,appObj.Organization_Geographic_Coverage__c,appObj.Organization_Post_Code__c,appObj.Organization_State_Province_Country__c,appObj.Organization_Street__c, appObj.Target_Beneficiaries__c,'','');
                            }
                    }else{
                        //No Account Found
                        Database.rollback(sp);
                        PG_ApplicationSurveyLogUtilityClass.createLog(appObj, 'Error', accountInfoWrapper.message);
                        return;
                    }
                }
                
                
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
                        PG_ApplicationSurveyLogUtilityClass.createLog(appObj, contactInfoWrapperEmail.status, contactInfoWrapperEmail.message);
                        return;
                    }
                    
                    //Creating contact record if not exist
                    if(contactInfoWrapperEmail.isContactExist){
                        conObj = contactInfoWrapperEmail.con;
                        if(conObj.High_Risk__c!= null && conObj.High_Risk__c){
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLog(appObj, 'Error', conObj.Name+' is at High Risk.');
                            return;
                        }else if(!conObj.notActive__c){
                            conObj = PG_ContactUtilityClass.updateContact(conObj,appObj.Contact_First_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.Contact_Last_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.Contact_Phone_Number__c,appObj.Contact_Work_Email__c,appObj.Contact_Title__c,'','','','','','',appObj.Home_Office_Country__c); 
                        }else{
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLog(appObj, 'Error', conObj.Name+' is not active.');
                            return;
                        }
                    }else{
                        //Calling the utility class method to check if contact exist or not from email
                        PG_ContactUtilityClass.ContactInfoWrapper contactInfoWrapperName = PG_ContactUtilityClass.validateOrgContact(contactEmail, contactName, 'Name');
                        
                        //Creating error log if any found
                        if(contactInfoWrapperName.status == 'Error'){
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLog(appObj, contactInfoWrapperName.status, contactInfoWrapperName.message);
                            return;
                        }
                        if(contactInfoWrapperName.isContactExist){
                            conObj = contactInfoWrapperName.con;
                            if(conObj.High_Risk__c!= null && conObj.High_Risk__c){
                                Database.rollback(sp);
                                PG_ApplicationSurveyLogUtilityClass.createLog(appObj, 'Error', conObj.Name+' is at High Risk.');
                                return;
                            
                            }else if(!conObj.notActive__c){
                                conObj = PG_ContactUtilityClass.updateContact(conObj,appObj.Contact_First_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.Contact_Last_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.Contact_Phone_Number__c,appObj.Contact_Work_Email__c,appObj.Contact_Title__c,'','','','','','',appObj.Home_Office_Country__c); 
                            }else{
                                Database.rollback(sp);
                                PG_ApplicationSurveyLogUtilityClass.createLog(appObj, 'Error', conObj.Name+' is not active.');
                                return;
                            }
                        }else{
                            conObj = PG_ContactUtilityClass.createContact(accObj,appObj.Contact_First_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.Contact_Last_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.Contact_Phone_Number__c,appObj.Contact_Work_Email__c,appObj.Contact_Title__c,'','','','','','',appObj.Home_Office_Country__c);
                        }
                    }
                }
                
                //Processing data for Project
                Projects__c projObj;
                if(appObj.Project_Name__c.trim().replaceAll('[ ]{2,}', ' ') != null && appObj.Project_Name__c.trim().replaceAll('[ ]{2,}', ' ') != ''){
                    String projectName = appObj.Project_Name__c.trim().replaceAll('[ ]{2,}', ' ');
                    
                    system.debug('-projectName --'+projectName);
                    //Calling the utility class method to check if project exist or not
                    PG_ProjectUtilityClass.ProjectInfoWrapper projectInfoWrapper = PG_ProjectUtilityClass.validateProjectForRoundBApplication(projectName);
                    
                    //Checking round B created Projects exists or not
                    PG_ProjectUtilityClass.ProjectInfoWrapper projectInfoWrapper1 = PG_ProjectUtilityClass.validateProject(appObj.Project_Name__c+'-'+appObj.Application_Round__c);
                    
                    if(projectInfoWrapper1.status == 'Error'){
                        Database.rollback(sp);
                        PG_ApplicationSurveyLogUtilityClass.createLog(appObj, projectInfoWrapper1.status, projectInfoWrapper1.message);
                        return;
                    }
                    if(projectInfoWrapper1.isProjectExist){
                        Database.rollback(sp);
                        PG_ApplicationSurveyLogUtilityClass.createLog(appObj, projectInfoWrapper1.status, projectInfoWrapper1.message);
                        return;
                    }
                    
                    //Creating error log if any found
                    system.debug('--projectInfoWrapper.status-'+projectInfoWrapper.status);
                    if(projectInfoWrapper.status == 'Error'){
                        Database.rollback(sp);
                        PG_ApplicationSurveyLogUtilityClass.createLog(appObj, projectInfoWrapper.status, projectInfoWrapper.message);
                        return;
                    }
                    // Checking Round B Proj Host org Different with Existing Project.
                    if(projectInfoWrapper.isProjectExist){
                        
                        String RoundAHostOrg;
                        String RoundBHostOrg;
                        Projects__c projHostObj = projectInfoWrapper.proj;
                        Account AccountObj =[select id,name from Account where id=:projHostObj.Host_Organization__c limit 1];
                        if(AccountObj != null && AccountObj.Name != null && AccountObj.Name != ''){
                            RoundAHostOrg = AccountObj.Name.trim().replaceAll('[ ]{2,}', ' ');
                        }
                        if(appObj.Organization_Name__c!= null && appObj.Organization_Name__c !=''){
                          RoundBHostOrg = appObj.Organization_Name__c.trim().replaceAll('[ ]{2,}', ' ');
                        }
                        Boolean HostOrgDiffCheck =RoundAHostOrg.equals(RoundBHostOrg);
                        if(!HostOrgDiffCheck){
                            //creating Log for different host org for two rounds of project.
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLog(appObj, 'Error', 'Host org is different for Project '+appObj.Project_Name__c+'-'+appObj.Application_Round__c);
                            return;
                        }
                        
                    }
                    //Creating project record if not exist
                    if(projectInfoWrapper.isProjectExist){
                        projObj = projectInfoWrapper.proj;
                        projObj = PG_ProjectUtilityClass.createProjectRoundB(projObj,accObj,conObj,appObj,appObj.Project_Name__c+'-'+appObj.Application_Round__c,appObj.Project_Timeline__c,appObj.Project_Type__c,appObj.Grant_Amount__c,appObj.Sustainability_Alignment__c,appObj.Project_Objective__c,appObj.Project_Background__c,appObj.Project_Beneficiaries__c,appObj.Level_of_Commitment__c,appObj.Level_of_Effort__c,appObj.Grant_Use__c,appObj.Team_Skills__c,appObj.Team_Diversity__c,appObj.Activities_to_Obtain_Objective__c,appObj.Application_Cycle__c,appObj.Application_Round__c,appObj.Grant_Narrative__c);
                    }else{
                        //No Project Found
                        Database.rollback(sp);
                        PG_ApplicationSurveyLogUtilityClass.createLog(appObj, 'Error', projectInfoWrapper.message);
                        return;
                    }
                    
                }
                
                
                //Default Team memeber Account Name
                Account defaultAccount;
                String defaultAccountName = Label.Default_Team_memeber_Account_Name;
                if(defaultAccountName != null && defaultAccountName != null){
                    //Calling the utility class method to check if account exist or not
                    PG_AccountUtilityClass.AccountInfoWrapper accountInfoWrapper = PG_AccountUtilityClass.validateAccount(defaultAccountName);
                    
                    //Creating error log if any found
                    if(accountInfoWrapper.status == 'Error'){
                        Database.rollback(sp);
                        PG_ApplicationSurveyLogUtilityClass.createLog(appObj, accountInfoWrapper.status, accountInfoWrapper.message);
                        return;
                    }
                    
                    //Creating log record if not exist
                    if(accountInfoWrapper.isAccountExist){
                        defaultAccount = accountInfoWrapper.acc;
                    }else{
                        Database.rollback(sp);
                        PG_ApplicationSurveyLogUtilityClass.createLog(appObj, 'Error', 'No Account Exist with name '+ defaultAccountName);
                        return;
                        //accObj = PG_AccountUtilityClass.createAccount(accountName,appObj.Organisation_Full_Name__c,appObj.Organisation_Mission_and_Vision__c,appObj.Organisation_Website__c,appObj.Partner_Organisation_Communication__c,appObj.Partner_organisation_Participated_before__c,appObj.Partner_Organisation_registered_entity__c,appObj.Partner_Organisation_Sector_Activities__c,appObj.Organization_City_Town__c,appObj.Organization_Country__c,appObj.Organization_Geographic_Coverage__c,appObj.Organization_Post_Code__c,appObj.Organization_State_Province_Country__c,appObj.Organization_Street__c,appObj.Target_Beneficiaries__c);
                    }
                }
                
                
                //Processing data for team captain
                if(appObj.Team_captain_Work_Email__c != null && appObj.Team_captain_Work_Email__c != '' && projObj != null){
                    String contactName = appObj.Team_captain_First_Name__c.trim().replaceAll('[ ]{2,}', ' ') + ' '+ appObj.Team_captain_Last_Name__c.trim().replaceAll('[ ]{2,}', ' ');
                    String contactEmail = appObj.Team_captain_Work_Email__c;
                    
                    //Calling the utility class method to check if contact exist or not
                    PG_ContactUtilityClass.ContactInfoWrapper contactInfoWrapperEmail = PG_ContactUtilityClass.validateOrgContact(contactEmail, contactName, 'Email');
                    
                    //Creating error log if any found
                    if(contactInfoWrapperEmail.status == 'Error'){
                        Database.rollback(sp);
                        PG_ApplicationSurveyLogUtilityClass.createLog(appObj, contactInfoWrapperEmail.status, contactInfoWrapperEmail.message);
                        return;
                    }
                    
                    //system.debug('---projRoundBObj-'+projObj);
                    //Creating contact record if not exist
                    Contact captainObj;
                    if(contactInfoWrapperEmail.isContactExist){
                        captainObj = contactInfoWrapperEmail.con;
                        if(captainObj.High_Risk__c!= null && captainObj.High_Risk__c){
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLog(appObj, 'Error', captainObj.Name+' is at High Risk.');
                            return;
                        }else if(!captainObj.notActive__c){
                            captainObj = PG_ContactUtilityClass.updateContact(captainObj,appObj.Team_captain_First_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.Team_captain_Last_Name__c.trim().replaceAll('[ ]{2,}', ' '),'',appObj.Team_captain_Work_Email__c,appObj.Team_captain_Job_Title__c,appObj.Team_Captain_Line_Manager_Full_Name__c,appObj.Team_Captain_Line_Manager_Work_Email__c,appObj.Team_captain_Home_Office_City__c,appObj.Team_Captain_Company_Affiliation__c,appObj.Team_Captain_BusUnitAnglo__c,appObj.Team_Captain_BusUnitDebeers__c,appObj.Team_Captain_Home_Office_Country__c);
                        }else{
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLog(appObj, 'Error', captainObj.Name+' is not active.');
                            return;
                        }
                    }else{
                        //Calling the utility class method to check if contact exist or not from email
                        PG_ContactUtilityClass.ContactInfoWrapper contactInfoWrapperName = PG_ContactUtilityClass.validateOrgContact(contactEmail, contactName, 'Name');
                        
                        //Creating error log if any found
                        if(contactInfoWrapperName.status == 'Error'){
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLog(appObj, contactInfoWrapperName.status, contactInfoWrapperName.message);
                            return;
                        }
                        if(contactInfoWrapperName.isContactExist){
                            captainObj = contactInfoWrapperName.con;
                            if(captainObj.High_Risk__c!= null && captainObj.High_Risk__c){
                                Database.rollback(sp);
                                PG_ApplicationSurveyLogUtilityClass.createLog(appObj, 'Error', captainObj.Name+' is at High Risk.');
                                return;
                            }else if(!captainObj.notActive__c){
                                captainObj = PG_ContactUtilityClass.updateContact(captainObj,appObj.Team_captain_First_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.Team_captain_Last_Name__c.trim().replaceAll('[ ]{2,}', ' '),'',appObj.Team_captain_Work_Email__c,appObj.Team_captain_Job_Title__c,appObj.Team_Captain_Line_Manager_Full_Name__c,appObj.Team_Captain_Line_Manager_Work_Email__c,appObj.Team_captain_Home_Office_City__c,appObj.Team_Captain_Company_Affiliation__c,appObj.Team_Captain_BusUnitAnglo__c,appObj.Team_Captain_BusUnitDebeers__c,appObj.Team_Captain_Home_Office_Country__c);
                            }else{
                                Database.rollback(sp);
                                PG_ApplicationSurveyLogUtilityClass.createLog(appObj, 'Error', captainObj.Name+' is not active.');
                                return;
                            }
                        }else{
                            captainObj = PG_ContactUtilityClass.createContact(defaultAccount,appObj.Team_captain_First_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.Team_captain_Last_Name__c.trim().replaceAll('[ ]{2,}', ' '),'',appObj.Team_captain_Work_Email__c,appObj.Team_captain_Job_Title__c,appObj.Team_Captain_Line_Manager_Full_Name__c,appObj.Team_Captain_Line_Manager_Work_Email__c,appObj.Team_captain_Home_Office_City__c,appObj.Team_Captain_Company_Affiliation__c,appObj.Team_Captain_BusUnitAnglo__c,appObj.Team_Captain_BusUnitDebeers__c,appObj.Team_Captain_Home_Office_Country__c);
                        }
                    }
                    
                    //Creating Team member record
                    if(captainObj != null){
                        PG_TeamMemberUtilityClass.TeamMemberInfoWrapper tmWrapper =  PG_TeamMemberUtilityClass.createTeamMember(captainObj, projObj, true);
                        if(tmWrapper.status == 'Error'){
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLog(appObj, tmWrapper.status, tmWrapper.message);
                            return;
                        }
                    }
                }
                
                
                //Processing data for team member 1
                if(appObj.Team_Member_1_Work_Email__c != null && appObj.Team_Member_1_Work_Email__c != '' && projObj != null){
                    String contactName = appObj.Team_Member_1_First_Name__c.trim().replaceAll('[ ]{2,}', ' ') + ' '+ appObj.Team_Member_1_Last_Name__c.trim().replaceAll('[ ]{2,}', ' ');
                    String contactEmail = appObj.Team_Member_1_Work_Email__c;
                    
                    //Calling the utility class method to check if contact exist or not
                    PG_ContactUtilityClass.ContactInfoWrapper contactInfoWrapperEmail = PG_ContactUtilityClass.validateOrgContact(contactEmail, contactName, 'Email');
                    
                    //Creating error log if any found
                    if(contactInfoWrapperEmail.status == 'Error'){
                        Database.rollback(sp);
                        PG_ApplicationSurveyLogUtilityClass.createLog(appObj, contactInfoWrapperEmail.status, contactInfoWrapperEmail.message);
                        return;
                    }
                    
                    //Creating contact record if not exist
                    Contact tm1Obj;
                    if(contactInfoWrapperEmail.isContactExist){
                        tm1Obj = contactInfoWrapperEmail.con;
                        if(tm1Obj.High_Risk__c != null && tm1Obj.High_Risk__c){
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLog(appObj, 'Error', tm1Obj.Name+' is at High Risk.');
                            return;
                        } else if(!tm1Obj.notActive__c){
                            tm1Obj = PG_ContactUtilityClass.updateContact(tm1Obj,appObj.Team_Member_1_First_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.Team_Member_1_Last_Name__c.trim().replaceAll('[ ]{2,}', ' '),'',appObj.Team_Member_1_Work_Email__c,appObj.Team_Member_1_Job_Title__c,appObj.Team_Member_1_Line_Manager_Full_Name__c,appObj.Team_Member_1_Line_Manager_Work_Email__c,appObj.Team_Member_1_Office_City__c,appObj.Team_Member_1_Company_Affiliation__c,appObj.Team_Member_1_BusUnitAnglo__c,appObj.Team_Member_1_BusUnitDebeers__c,appObj.Team_Member_1_Home_Office_Country__c);
                        }else{
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLog(appObj, 'Error', tm1Obj.Name+' is not active.');
                            return;
                        }
                    }else{
                        //Calling the utility class method to check if contact exist or not from email
                        PG_ContactUtilityClass.ContactInfoWrapper contactInfoWrapperName = PG_ContactUtilityClass.validateOrgContact(contactEmail, contactName, 'Name');
                        
                        //Creating error log if any found
                        if(contactInfoWrapperName.status == 'Error'){
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLog(appObj, contactInfoWrapperName.status, contactInfoWrapperName.message);
                            return;
                        }
                        if(contactInfoWrapperName.isContactExist){
                            tm1Obj = contactInfoWrapperName.con;
                            if(tm1Obj.High_Risk__c != null && tm1Obj.High_Risk__c){
                                Database.rollback(sp);
                                PG_ApplicationSurveyLogUtilityClass.createLog(appObj, 'Error', tm1Obj.Name+' is at High Risk.');
                                return;
                            }else if(!tm1Obj.notActive__c){
                                tm1Obj = PG_ContactUtilityClass.updateContact(tm1Obj,appObj.Team_Member_1_First_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.Team_Member_1_Last_Name__c.trim().replaceAll('[ ]{2,}', ' '),'',appObj.Team_Member_1_Work_Email__c,appObj.Team_Member_1_Job_Title__c,appObj.Team_Member_1_Line_Manager_Full_Name__c,appObj.Team_Member_1_Line_Manager_Work_Email__c,appObj.Team_Member_1_Office_City__c,appObj.Team_Member_1_Company_Affiliation__c,appObj.Team_Member_1_BusUnitAnglo__c,appObj.Team_Member_1_BusUnitDebeers__c,appObj.Team_Member_1_Home_Office_Country__c);
                            }else{
                                Database.rollback(sp);
                                PG_ApplicationSurveyLogUtilityClass.createLog(appObj, 'Error', tm1Obj.Name+' is not active.');
                                return;
                            }
                        }else{
                            tm1Obj = PG_ContactUtilityClass.createContact(defaultAccount,appObj.Team_Member_1_First_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.Team_Member_1_Last_Name__c.trim().replaceAll('[ ]{2,}', ' '),'',appObj.Team_Member_1_Work_Email__c,appObj.Team_Member_1_Job_Title__c,appObj.Team_Member_1_Line_Manager_Full_Name__c,appObj.Team_Member_1_Line_Manager_Work_Email__c,appObj.Team_Member_1_Office_City__c,appObj.Team_Member_1_Company_Affiliation__c,appObj.Team_Member_1_BusUnitAnglo__c,appObj.Team_Member_1_BusUnitDebeers__c,appObj.Team_Member_1_Home_Office_Country__c);
                        }
                    }
                    
                    //Creating Team member record
                    if(tm1Obj != null){
                        PG_TeamMemberUtilityClass.TeamMemberInfoWrapper tmWrapper =  PG_TeamMemberUtilityClass.createTeamMember(tm1Obj, projObj, false);
                        if(tmWrapper.status == 'Error'){
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLog(appObj, tmWrapper.status, tmWrapper.message);
                            return;
                        }
                    }
                }
                
                //Processing data for team member 2
                if(appObj.Team_Member_2_Work_Email__c != null && appObj.Team_Member_2_Work_Email__c != '' && projObj != null){
                    String contactName = appObj.Team_Member_2_First_Name__c.trim().replaceAll('[ ]{2,}', ' ') + ' '+ appObj.Team_Member_2_Last_Name__c.trim().replaceAll('[ ]{2,}', ' ');
                    String contactEmail = appObj.Team_Member_2_Work_Email__c;
                    
                    //Calling the utility class method to check if contact exist or not
                    PG_ContactUtilityClass.ContactInfoWrapper contactInfoWrapperEmail = PG_ContactUtilityClass.validateOrgContact(contactEmail, contactName, 'Email');
                    
                    //Creating error log if any found
                    if(contactInfoWrapperEmail.status == 'Error'){
                        Database.rollback(sp);
                        PG_ApplicationSurveyLogUtilityClass.createLog(appObj, contactInfoWrapperEmail.status, contactInfoWrapperEmail.message);
                        return;
                    }
                    
                    //Creating contact record if not exist
                    Contact tm2Obj;
                    if(contactInfoWrapperEmail.isContactExist){
                        tm2Obj = contactInfoWrapperEmail.con;
                        if(tm2Obj.High_Risk__c != null && tm2Obj.High_Risk__c){
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLog(appObj, 'Error', tm2Obj.Name+' is at High Risk.');
                            return;
                        } else if(!tm2Obj.notActive__c){
                            tm2Obj = PG_ContactUtilityClass.updateContact(tm2Obj,appObj.Team_Member_2_First_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.Team_Member_2_Last_Name__c.trim().replaceAll('[ ]{2,}', ' '),'',appObj.Team_Member_2_Work_Email__c,appObj.Team_Member_2_Job_Title__c,appObj.Team_Member_2_Line_Manager_Full_Name__c,appObj.Team_Member_2_Line_Manager_Work_Email__c,appObj.Team_Member_2_Office_City__c,appObj.Team_Member_2_Company_Affiliation__c,appObj.Team_Member_2_BusUnitAnglo__c,appObj.Team_Member_2_BusUnitDebeers__c,appObj.Team_Member_2_Home_Office_Country__c);
                        }else{
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLog(appObj, 'Error', tm2Obj.Name+' is not active.');
                            return;
                        }
                    }else{
                        //Calling the utility class method to check if contact exist or not from email
                        PG_ContactUtilityClass.ContactInfoWrapper contactInfoWrapperName = PG_ContactUtilityClass.validateOrgContact(contactEmail, contactName, 'Name');
                        
                        //Creating error log if any found
                        if(contactInfoWrapperName.status == 'Error'){
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLog(appObj, contactInfoWrapperName.status, contactInfoWrapperName.message);
                            return;
                        }
                        if(contactInfoWrapperName.isContactExist){
                            tm2Obj = contactInfoWrapperName.con;
                            if(tm2Obj.High_Risk__c != null && tm2Obj.High_Risk__c){
                                Database.rollback(sp);
                                PG_ApplicationSurveyLogUtilityClass.createLog(appObj, 'Error', tm2Obj.Name+' is at High Risk.');
                                return;
                            }else if(!tm2Obj.notActive__c){
                                tm2Obj = PG_ContactUtilityClass.updateContact(tm2Obj,appObj.Team_Member_2_First_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.Team_Member_2_Last_Name__c.trim().replaceAll('[ ]{2,}', ' '),'',appObj.Team_Member_2_Work_Email__c,appObj.Team_Member_2_Job_Title__c,appObj.Team_Member_2_Line_Manager_Full_Name__c,appObj.Team_Member_2_Line_Manager_Work_Email__c,appObj.Team_Member_2_Office_City__c,appObj.Team_Member_2_Company_Affiliation__c,appObj.Team_Member_2_BusUnitAnglo__c,appObj.Team_Member_2_BusUnitDebeers__c,appObj.Team_Member_2_Home_Office_Country__c);
                            }else{
                                Database.rollback(sp);
                                PG_ApplicationSurveyLogUtilityClass.createLog(appObj, 'Error', tm2Obj.Name+' is not active.');
                                return;
                            }
                        }else{
                            tm2Obj = PG_ContactUtilityClass.createContact(defaultAccount,appObj.Team_Member_2_First_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.Team_Member_2_Last_Name__c.trim().replaceAll('[ ]{2,}', ' '),'',appObj.Team_Member_2_Work_Email__c,appObj.Team_Member_2_Job_Title__c,appObj.Team_Member_2_Line_Manager_Full_Name__c,appObj.Team_Member_2_Line_Manager_Work_Email__c,appObj.Team_Member_2_Office_City__c,appObj.Team_Member_2_Company_Affiliation__c,appObj.Team_Member_2_BusUnitAnglo__c,appObj.Team_Member_2_BusUnitDebeers__c,appObj.Team_Member_2_Home_Office_Country__c);
                        }
                    }
                    
                    //Creating Team member record
                    if(tm2Obj != null){
                        PG_TeamMemberUtilityClass.TeamMemberInfoWrapper tmWrapper =  PG_TeamMemberUtilityClass.createTeamMember(tm2Obj, projObj, false);
                        if(tmWrapper.status == 'Error'){
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLog(appObj, tmWrapper.status, tmWrapper.message);
                            return;
                        }
                    }
                }
                
                
                //Processing data for team member 3
                if(appObj.Team_Member_3_Work_Email__c != null && appObj.Team_Member_3_Work_Email__c != '' && projObj != null){
                    String contactName = appObj.Team_Member_3_First_Name__c.trim().replaceAll('[ ]{2,}', ' ') + ' '+ appObj.Team_Member_3_Last_Name__c.trim().replaceAll('[ ]{2,}', ' ');
                    String contactEmail = appObj.Team_Member_3_Work_Email__c;
                    
                    //Calling the utility class method to check if contact exist or not
                    PG_ContactUtilityClass.ContactInfoWrapper contactInfoWrapperEmail = PG_ContactUtilityClass.validateOrgContact(contactEmail, contactName, 'Email');
                    
                    //Creating error log if any found
                    if(contactInfoWrapperEmail.status == 'Error'){
                        Database.rollback(sp);
                        PG_ApplicationSurveyLogUtilityClass.createLog(appObj, contactInfoWrapperEmail.status, contactInfoWrapperEmail.message);
                        return;
                    }
                    
                    //Creating contact record if not exist
                    Contact tm3Obj;
                    if(contactInfoWrapperEmail.isContactExist){
                        tm3Obj = contactInfoWrapperEmail.con;
                        if(tm3Obj.High_Risk__c!= null && tm3Obj.High_Risk__c){
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLog(appObj, 'Error', tm3Obj.Name+' is at High Risk.');
                            return;
                        }else if(!tm3Obj.notActive__c){
                            tm3Obj = PG_ContactUtilityClass.updateContact(tm3Obj,appObj.Team_Member_3_First_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.Team_Member_3_Last_Name__c.trim().replaceAll('[ ]{2,}', ' '),'',appObj.Team_Member_3_Work_Email__c,appObj.Team_Member_3_Job_Title__c,appObj.Team_Member_3_Line_Manager_Full_Name__c,appObj.Team_Member_3_Line_Manager_Work_Email__c,appObj.Team_Member_3_Office_City__c,appObj.Team_Member_3_Company_Affiliation__c,appObj.Team_Member_3_BusUnitAnglo__c,appObj.Team_Member_3_BusUnitDebeers__c,appObj.Team_Member_3_Home_Office_Country__c);
                        }else{
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLog(appObj, 'Error', tm3Obj.Name+' is not active.');
                            return;
                        }
                    }else{
                        //Calling the utility class method to check if contact exist or not from email
                        PG_ContactUtilityClass.ContactInfoWrapper contactInfoWrapperName = PG_ContactUtilityClass.validateOrgContact(contactEmail, contactName, 'Name');
                        
                        //Creating error log if any found
                        if(contactInfoWrapperName.status == 'Error'){
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLog(appObj, contactInfoWrapperName.status, contactInfoWrapperName.message);
                            return;
                        }
                        if(contactInfoWrapperName.isContactExist){
                            tm3Obj = contactInfoWrapperName.con;
                            if(tm3Obj.High_Risk__c != null && tm3Obj.High_Risk__c){
                                Database.rollback(sp);
                                PG_ApplicationSurveyLogUtilityClass.createLog(appObj, 'Error', tm3Obj.Name+' is at High Risk.');
                                return;
                            }else if(!tm3Obj.notActive__c){
                                tm3Obj = PG_ContactUtilityClass.updateContact(tm3Obj,appObj.Team_Member_3_First_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.Team_Member_3_Last_Name__c.trim().replaceAll('[ ]{2,}', ' '),'',appObj.Team_Member_3_Work_Email__c,appObj.Team_Member_3_Job_Title__c,appObj.Team_Member_3_Line_Manager_Full_Name__c,appObj.Team_Member_3_Line_Manager_Work_Email__c,appObj.Team_Member_3_Office_City__c,appObj.Team_Member_3_Company_Affiliation__c,appObj.Team_Member_3_BusUnitAnglo__c,appObj.Team_Member_3_BusUnitDebeers__c,appObj.Team_Member_3_Home_Office_Country__c);
                            }else{
                                Database.rollback(sp);
                                PG_ApplicationSurveyLogUtilityClass.createLog(appObj, 'Error', tm3Obj.Name+' is not active.');
                                return;
                            }
                        }else{
                            tm3Obj = PG_ContactUtilityClass.createContact(defaultAccount,appObj.Team_Member_3_First_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.Team_Member_3_Last_Name__c.trim().replaceAll('[ ]{2,}', ' '),'',appObj.Team_Member_3_Work_Email__c,appObj.Team_Member_3_Job_Title__c,appObj.Team_Member_3_Line_Manager_Full_Name__c,appObj.Team_Member_3_Line_Manager_Work_Email__c,appObj.Team_Member_3_Office_City__c,appObj.Team_Member_3_Company_Affiliation__c,appObj.Team_Member_3_BusUnitAnglo__c,appObj.Team_Member_3_BusUnitDebeers__c,appObj.Team_Member_3_Home_Office_Country__c);
                        }
                    }
                    
                    //Creating Team member record
                    if(tm3Obj != null){
                        PG_TeamMemberUtilityClass.TeamMemberInfoWrapper tmWrapper =  PG_TeamMemberUtilityClass.createTeamMember(tm3Obj, projObj, false);
                        if(tmWrapper.status == 'Error'){
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLog(appObj, tmWrapper.status, tmWrapper.message);
                            return;
                        }
                    }
                }
                
                
                //Processing data for team member 4
                if(appObj.Team_Member_4_Work_Email__c != null && appObj.Team_Member_4_Work_Email__c != '' && projObj != null){
                    String contactName = appObj.Team_Member_4_First_Name__c.trim().replaceAll('[ ]{2,}', ' ') + ' '+ appObj.Team_Member_4_Last_Name__c.trim().replaceAll('[ ]{2,}', ' ');
                    String contactEmail = appObj.Team_Member_4_Work_Email__c;
                    
                    //Calling the utility class method to check if contact exist or not
                    PG_ContactUtilityClass.ContactInfoWrapper contactInfoWrapperEmail = PG_ContactUtilityClass.validateOrgContact(contactEmail, contactName, 'Email');
                    
                    //Creating error log if any found
                    if(contactInfoWrapperEmail.status == 'Error'){
                        Database.rollback(sp);
                        PG_ApplicationSurveyLogUtilityClass.createLog(appObj, contactInfoWrapperEmail.status, contactInfoWrapperEmail.message);
                        return;
                    }
                    
                    //Creating contact record if not exist
                    Contact tm4Obj;
                    if(contactInfoWrapperEmail.isContactExist){
                        tm4Obj = contactInfoWrapperEmail.con;
                        if(tm4Obj.High_Risk__c != null && tm4Obj.High_Risk__c){
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLog(appObj, 'Error', tm4Obj.Name+' is at High Risk.');
                            return;
                        }else if(!tm4Obj.notActive__c){
                            tm4Obj = PG_ContactUtilityClass.updateContact(tm4Obj,appObj.Team_Member_4_First_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.Team_Member_4_Last_Name__c.trim().replaceAll('[ ]{2,}', ' '),'',appObj.Team_Member_4_Work_Email__c,appObj.Team_Member_4_Job_Title__c,appObj.Team_Member_4_Line_Manager_Full_Name__c,appObj.Team_Member_4_Line_Manager_Work_Email__c,appObj.Team_Member_4_Office_City__c,appObj.Team_Member_4_Company_Affiliation__c,appObj.Team_Member_4_BusUnitAnglo__c,appObj.Team_Member_4_BusUnitDebeers__c,appObj.Team_Member_4_Home_Office_Country__c);
                        }else{
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLog(appObj, 'Error', tm4Obj.Name+' is not active.');
                            return;
                        }
                    }else{
                        //Calling the utility class method to check if contact exist or not from email
                        PG_ContactUtilityClass.ContactInfoWrapper contactInfoWrapperName = PG_ContactUtilityClass.validateOrgContact(contactEmail, contactName, 'Name');
                        
                        //Creating error log if any found
                        if(contactInfoWrapperName.status == 'Error'){
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLog(appObj, contactInfoWrapperName.status, contactInfoWrapperName.message);
                            return;
                        }
                        if(contactInfoWrapperName.isContactExist){
                            tm4Obj = contactInfoWrapperName.con;
                            if(tm4Obj.High_Risk__c != null && tm4Obj.High_Risk__c){
                                Database.rollback(sp);
                                PG_ApplicationSurveyLogUtilityClass.createLog(appObj, 'Error', tm4Obj.Name+' is at High Risk.');
                                return;
                            }else if(!tm4Obj.notActive__c){
                                tm4Obj = PG_ContactUtilityClass.updateContact(tm4Obj,appObj.Team_Member_4_First_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.Team_Member_4_Last_Name__c.trim().replaceAll('[ ]{2,}', ' '),'',appObj.Team_Member_4_Work_Email__c,appObj.Team_Member_4_Job_Title__c,appObj.Team_Member_4_Line_Manager_Full_Name__c,appObj.Team_Member_4_Line_Manager_Work_Email__c,appObj.Team_Member_4_Office_City__c,appObj.Team_Member_4_Company_Affiliation__c,appObj.Team_Member_4_BusUnitAnglo__c,appObj.Team_Member_4_BusUnitDebeers__c,appObj.Team_Member_4_Home_Office_Country__c);
                            }else{
                                Database.rollback(sp);
                                PG_ApplicationSurveyLogUtilityClass.createLog(appObj, 'Error', tm4Obj.Name+' is not active.');
                                return;
                            }
                        }else{
                            tm4Obj = PG_ContactUtilityClass.createContact(defaultAccount,appObj.Team_Member_4_First_Name__c.trim().replaceAll('[ ]{2,}', ' '),appObj.Team_Member_4_Last_Name__c.trim().replaceAll('[ ]{2,}', ' '),'',appObj.Team_Member_4_Work_Email__c,appObj.Team_Member_4_Job_Title__c,appObj.Team_Member_4_Line_Manager_Full_Name__c,appObj.Team_Member_4_Line_Manager_Work_Email__c,appObj.Team_Member_4_Office_City__c,appObj.Team_Member_4_Company_Affiliation__c,appObj.Team_Member_4_BusUnitAnglo__c,appObj.Team_Member_4_BusUnitDebeers__c,appObj.Team_Member_4_Home_Office_Country__c);
                        }
                    }
                    
                    //Creating Team member record
                    if(tm4Obj != null){
                        PG_TeamMemberUtilityClass.TeamMemberInfoWrapper tmWrapper =  PG_TeamMemberUtilityClass.createTeamMember(tm4Obj, projObj, false);
                        if(tmWrapper.status == 'Error'){
                            Database.rollback(sp);
                            PG_ApplicationSurveyLogUtilityClass.createLog(appObj, tmWrapper.status, tmWrapper.message);
                            return;
                        }
                    }
                }
               
               Application_Survey_Form__c appObjToUpdate = [select id,Status__c from Application_Survey_Form__c where Id=:appObj.Id limit 1];
               appObjToUpdate.Status__c = 'Success';
               appObjToUpdate.Stop_Resync__c=true;
               PG_ApplicationSurveyLogUtilityClass.isRecursive = true;
               update appObjToUpdate;
            }catch(Exception e){
                System.debug('-----Exception-----'+e.getMessage()+'----Line number----'+e.getLineNumber());
                Database.rollback(sp);
                if(e.getMessage().contains('DUPLICATES_DETECTED')){
                    if(PG_ContactUtilityClass.insertingContact){
                        PG_ApplicationSurveyLogUtilityClass.createLog(appObj, 'Error', 'Possible duplicates found for Contact :  '+ PG_ContactUtilityClass.contactName);
                    }else if(PG_AccountUtilityClass.insertingAccount){
                        PG_ApplicationSurveyLogUtilityClass.createLog(appObj, 'Error', 'Possible duplicates found for Account :  '+appObj.Organization_Name__c);
                    }
                    
                }else{
                    PG_ApplicationSurveyLogUtilityClass.createLog(appObj, 'Error', e.getMessage());
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