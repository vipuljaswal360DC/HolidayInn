/* ClassName: PG_ApplicationSurveyUtilityClass
 * Usage: 
 */ 
public class PG_ApplicationSurveyUtilityClass {
   /* -------------All Varibales description-------------
    * contactEmailList: Used to store the contact email from the Application_Survey_Form__c object
    * contactNameList: Used to store the contact name from the Application_Survey_Form__c object
    * organisationNameList: Used to store the account name from the Application_Survey_Form__c object
    * contactUpdateList: Used to store the contact which have to update
    * contactInsertList: Used to store the contact which have to Insert
    * accountUpdateList: Used to store the account which have to update
    * accountInsertList: Used to store the account which have to Insert
    * logsInsertMap: Map used for store the log data corresponding to the Application_Survey_Form which to be insert
    * contactRecordInsertForList: Set used to store the Application_Survey_Form for which we have to insert contacts
    * accountRecordInsertForList: Set used to store the Application_Survey_Form for which we have to insert accounts
    * projectRecordInsertForList: Set used to store the Application_Survey_Form for which we have to insert projects
    * projectNameList: Used to store the project name from the Application_Survey_Form__c object
    * teamcaptainNameList:Used to store the team captain name from the Application_Survey_Form__c object
    * teamcaptainEmailList: Used to store the team captain email from the Application_Survey_Form__c object
    * teamMember1NameList: Used to store the team member 1 name from the Application_Survey_Form__c object
    * teamMember1EmailList: Used to store the team member 1 email from the Application_Survey_Form__c object
    * teamMember2NameList: Used to store the team member 2 name from the Application_Survey_Form__c object
    * teamMember2EmailList: Used to store the team member 2 email from the Application_Survey_Form__c object
    * teamMember3NameList: Used to store the team member 3 name from the Application_Survey_Form__c object
    * teamMember3EmailList: Used to store the team member 3 email from the Application_Survey_Form__c object
    * teamMember4NameList: Used to store the team member 4 name from the Application_Survey_Form__c object
    * teamMember4EmailList: Used to store the team member 4 email from the Application_Survey_Form__c object
    * teamMember5NameList: Used to store the team member 5 name from the Application_Survey_Form__c object
    * teamMember5EmailList: Used to store the team member 5 email from the Application_Survey_Form__c object
    * teamcaptainExistMap: Map used for store the contact if any exist for entered information corresponding to the Application_Survey_Form which to be insert
    * teamMember1ExistMap: Map used for store the contact if any exist for entered information corresponding to the Application_Survey_Form which to be insert
    * teamMember2ExistMap: Map used for store the contact if any exist for entered information corresponding to the Application_Survey_Form which to be insert
    * teamMember3ExistMap: Map used for store the contact if any exist for entered information corresponding to the Application_Survey_Form which to be insert
    * teamMember4ExistMap: Map used for store the contact if any exist for entered information corresponding to the Application_Survey_Form which to be insert
    * teamMember5ExistMap: Map used for store the contact if any exist for entered information corresponding to the Application_Survey_Form which to be insert
    * projectInsertList: Used to store the projects which have to Insert
    
    List<String> contactEmailList = new List<String>();
    List<String> contactNameList = new List<String>();
    List<String> organisationNameList = new List<String>();
    
    List<Contact> contactUpdateList = new List<Contact>();
    List<Contact> contactInsertList = new List<Contact>();
    List<Account> accountUpdateList = new List<Account>();
    List<Account> accountInsertList = new List<Account>();
    
    Map<String,Application_Survey_Form_Logs__c> logsInsertMap = new Map<String,Application_Survey_Form_Logs__c>();
    Set<Application_Survey_Form__c> contactRecordInsertForList = new Set<Application_Survey_Form__c>();
    Set<Application_Survey_Form__c> accountRecordInsertForList = new Set<Application_Survey_Form__c>();
    Set<Application_Survey_Form__c> projectRecordInsertForList = new Set<Application_Survey_Form__c>();
    
    List<String> projectNameList = new List<String>(); 
    List<String> teamcaptainNameList = new List<String>();
    List<String> teamcaptainEmailList = new List<String>();
    List<String> teamMember1NameList = new List<String>();
    List<String> teamMember1EmailList = new List<String>();
    List<String> teamMember2NameList = new List<String>();
    List<String> teamMember2EmailList = new List<String>();
    List<String> teamMember3NameList = new List<String>();
    List<String> teamMember3EmailList = new List<String>();
    List<String> teamMember4NameList = new List<String>();
    List<String> teamMember4EmailList = new List<String>();
    List<String> teamMember5NameList = new List<String>();
    List<String> teamMember5EmailList = new List<String>();
    
    Map<String, Contact> teamcaptainExistMap = new Map<String, Contact>();
    Map<String, Contact> teamMember1ExistMap = new Map<String, Contact>();
    Map<String, Contact> teamMember2ExistMap = new Map<String, Contact>();
    Map<String, Contact> teamMember3ExistMap = new Map<String, Contact>();
    Map<String, Contact> teamMember4ExistMap = new Map<String, Contact>();
    Map<String, Contact> teamMember5ExistMap = new Map<String, Contact>();
    
    List<Projects__c> projectInsertList = new List<Projects__c>();
    List<Team_Member__c> teamMemberInsertList = new List<Team_Member__c>();
    
    public void processData(List<Application_Survey_Form__c> applicationSurveyDataList){
        //Adding the necessary informations into list 
        for(Application_Survey_Form__c appObj : applicationSurveyDataList){
            system.debug('>>>>>>>'+appObj);
            
            contactEmailList.add(appObj.Contact_Work_Email__c);
            String contactName = appObj.Contact_First_Name__c.trim() + ' '+ appObj.Contact_Last_Name__c.trim();
            contactNameList.add(contactName);
            
            organisationNameList.add(appObj.Organization_Name__c.trim());
            projectNameList.add(appObj.Project_Name__c.trim());
            
            if(appObj.Team_captain_Work_Email__c != null){
                teamcaptainEmailList.add(appObj.Team_captain_Work_Email__c);
                String teamcaptainName = appObj.Team_captain_First_Name__c.trim() + ' '+ appObj.Team_captain_Last_Name__c.trim();
                teamcaptainNameList.add(teamcaptainName);
            }
                        
            if(appObj.Team_Member_1_Work_Email__c != null){
                teamMember1EmailList.add(appObj.Team_Member_1_Work_Email__c);
                String teamMember1Name = appObj.Team_Member_1_First_Name__c.trim() + ' '+ appObj.Team_Member_1_Last_Name__c.trim();
                teamMember1NameList.add(teamMember1Name);
            }
            
            if(appObj.Team_Member_2_Work_Email__c != null){
                teamMember2EmailList.add(appObj.Team_Member_2_Work_Email__c);
                String teamMember2Name = appObj.Team_Member_2_First_Name__c.trim() + ' '+ appObj.Team_Member_2_Last_Name__c.trim();
                teamMember2NameList.add(teamMember2Name);
            }
            
            if(appObj.Team_Member_3_Work_Email__c != null){
                teamMember3EmailList.add(appObj.Team_Member_3_Work_Email__c);
                String teamMember3Name = appObj.Team_Member_3_First_Name__c.trim() + ' '+ appObj.Team_Member_3_Last_Name__c.trim();
                teamMember3NameList.add(teamMember3Name);
            }
            
            if(appObj.Team_Member_4_Work_Email__c != null){
                teamMember4EmailList.add(appObj.Team_Member_4_Work_Email__c);
                String teamMember4Name = appObj.Team_Member_4_First_Name__c.trim() + ' '+ appObj.Team_Member_4_Last_Name__c.trim();
                teamMember4NameList.add(teamMember4Name);
            }
            
            if(appObj.Team_Member_5_Work_Email__c != null){
                teamMember5EmailList.add(appObj.Team_Member_5_Work_Email__c);
                String teamMember5Name = appObj.Team_Member_5_First_Name__c.trim() + ' '+ appObj.Team_Member_5_Last_Name__c.trim();
                teamMember5NameList.add(teamMember5Name);
            }
        }
        
        
        //Searching the contacts by using emails
        if(contactEmailList != null && contactEmailList.size()>0){
            
            //Calling the Utility class method to search contacts using the emails
            Map<String,List<Contact>> existEmailvsContactMap = PG_ContactUtilityClass.searchContactByEmail(contactEmailList);
            
            //Checking if more than one contact exist with an email and creating logs for the same
            if(existEmailvsContactMap != null && existEmailvsContactMap.size()>0){
                Set<String> contactNameSet = new Set<String>(contactNameList);
                for(Application_Survey_Form__c appObj: applicationSurveyDataList){
                    if(appObj.Contact_Work_Email__c != null && appObj.Contact_Work_Email__c != ''){
                        if(existEmailvsContactMap.containsKey(appObj.Contact_Work_Email__c) && existEmailvsContactMap.get(appObj.Contact_Work_Email__c).size()==1){
                            Contact conObj = existEmailvsContactMap.get(appObj.Contact_Work_Email__c)[0];
                            if(contactNameSet.contains(conObj.Name)){
                                //Contact fields which we have to update
                                contactUpdateList.add(conObj);
                                contactNameSet.remove(conObj.Name);
                            }else{
                                String contactName = appObj.Contact_First_Name__c.trim() + ' '+ appObj.Contact_Last_Name__c.trim();
                                contactNameSet.remove(contactName);
                                if(logsInsertMap.containsKey(appObj.Id)){
                                    Application_Survey_Form_Logs__c logObj = logsInsertMap.get(appObj.Id);
                                    logObj.Error_Description__c += '\n Contact exist but with another name';
                                }else{
                                    Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c();
                                    logObj.Application_Survey_Form__c = appObj.Id;
                                    logObj.Status__c = 'Failed';
                                    logObj.Error_Description__c = 'Contact exist but with another name';
                                    logsInsertMap.put(appObj.Id,logObj);
                                } 
                            }
                        }else if(existEmailvsContactMap.containsKey(appObj.Contact_Work_Email__c) && existEmailvsContactMap.get(appObj.Contact_Work_Email__c).size()>1){
                            // Error Logs creation
                            if(logsInsertMap.containsKey(appObj.Id)){
                                Application_Survey_Form_Logs__c logObj = logsInsertMap.get(appObj.Id);
                                logObj.Error_Description__c += '\n More than 1 contact exist with the entered email';
                            }else{
                                Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c();
                                logObj.Application_Survey_Form__c = appObj.Id;
                                logObj.Status__c = 'Failed';
                                logObj.Error_Description__c = 'More than 1 contact exist with the entered email';
                                logsInsertMap.put(appObj.Id,logObj);
                            }                        
                            
                        }
                    }else{
                        // Error Logs creation
                        String contactName = appObj.Contact_First_Name__c.trim() + ' '+ appObj.Contact_Last_Name__c.trim();
                        contactNameSet.remove(contactName);
                        if(logsInsertMap.containsKey(appObj.Id)){
                            Application_Survey_Form_Logs__c logObj = logsInsertMap.get(appObj.Id);
                            logObj.Error_Description__c += '\n No email id entered for contact';
                        }else{
                            Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c();
                            logObj.Application_Survey_Form__c = appObj.Id;
                            logObj.Status__c = 'Failed';
                            logObj.Error_Description__c = 'No email id entered for contact';
                            logsInsertMap.put(appObj.Id,logObj);
                        }  
                    }
                    
                }
                if(contactNameSet != null){
                    contactNameList = new List<String>(contactNameSet);
                }
            }
        }
        
        //Searching the contacts by using name
        if(contactNameList != null && contactNameList.size()>0){
            
            //Calling the Utility class method to search contacts using the name
            Map<String,List<Contact>> existNamevsContactMap = PG_ContactUtilityClass.searchContactByName(contactNameList);
            if(existNamevsContactMap != null && existNamevsContactMap.size()>0){
                
                //Checking if any contact exist with name but not from email and creating logs for the same
                for(Application_Survey_Form__c appObj: applicationSurveyDataList){
                    String contactName = appObj.Contact_First_Name__c.trim() + ' '+ appObj.Contact_Last_Name__c.trim();
                    
                    if(existNamevsContactMap.containsKey(contactName) && existNamevsContactMap.get(contactName).size()>0){
                        //contactRecordInsertForList.remove(appObj);
                        // Error Logs creation
                        if(logsInsertMap.containsKey(appObj.Id)){
                            Application_Survey_Form_Logs__c logObj = logsInsertMap.get(appObj.Id);
                            logObj.Error_Description__c += '\n Contact exist with another email';
                        }else{
                            Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c();
                            logObj.Application_Survey_Form__c = appObj.Id;
                            logObj.Status__c = 'Failed';
                            logObj.Error_Description__c = 'Contact exist with another email';
                            logsInsertMap.put(appObj.Id,logObj);
                        }
                    }else if(!existNamevsContactMap.containsKey(contactName)){
                        contactRecordInsertForList.add(appObj);
                    }
                }
            }else{
                Set<String> contactNameSet = new Set<String>(contactNameList);
                
                //Adding the data into the set to create contact data
                for(Application_Survey_Form__c appObj: applicationSurveyDataList){
                    String contactName = appObj.Contact_First_Name__c.trim() + ' '+ appObj.Contact_Last_Name__c.trim();
                    
                    if(contactNameSet.contains(contactName)){
                        contactRecordInsertForList.add(appObj);
                    }
                }
            }
        }
        
        //Searching the accounts by using name
        if(organisationNameList != null && organisationNameList.size()>0){
            
            Map<String,Account> existAccObj = new Map<String,Account>();  //Account reference if any exist
            
            //Calling the Utility class method to search account using the name
            Map<String,List<Account>> existNamevsAccountMap = PG_AccountUtilityClass.searchAccountByName(organisationNameList);
            
            //Checking if more than one account exist with name and creating logs for the same
            if(existNamevsAccountMap != null && existNamevsAccountMap.size()>0){
                
                Set<String> organisationNameSet = new Set<String>(organisationNameList);
                for(Application_Survey_Form__c appObj: applicationSurveyDataList){
                    
                    //Creating contact record if no contact exist for that account
                    if(existNamevsAccountMap.containsKey(appObj.Organization_Name__c.trim()) && existNamevsAccountMap.get(appObj.Organization_Name__c.trim()).size()==1){
                        Account accObj = existNamevsAccountMap.get(appObj.Organization_Name__c.trim())[0];
                        existAccObj.put(appObj.id,accObj);
                        if(contactRecordInsertForList.contains(appObj)){
                            Contact conObj = new Contact(firstname = appObj.Contact_First_Name__c.trim(),
                                                         lastname = appObj.Contact_Last_Name__c.trim(),
                                                         phone = appObj.Contact_Phone_Number__c,
                                                         email = appObj.Contact_Work_Email__c,
                                                         title = appObj.Contact_Title__c,
                                                         accountId = accObj.Id
                                                        );
                            contactInsertList.add(conObj);
                        }
                        if(organisationNameSet.contains(accObj.Name)){
                            //Account fields which we have to update
                            accountUpdateList.add(accObj);
                            organisationNameSet.remove(accObj.Name);
                        }else{
                            accountRecordInsertForList.add(appObj);
                        }
                        
                        //Creating error logs
                    }else if(existNamevsAccountMap.containsKey(appObj.Organization_Name__c.trim()) && existNamevsAccountMap.get(appObj.Organization_Name__c.trim()).size()>1){
                        //Error Logs creation
                        if(logsInsertMap.containsKey(appObj.Id)){
                            Application_Survey_Form_Logs__c logObj = logsInsertMap.get(appObj.Id);
                            logObj.Error_Description__c += '\n More than 1 account exist with the entered name';
                        }else{
                            Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c();
                            logObj.Application_Survey_Form__c = appObj.Id;
                            logObj.Status__c = 'Failed';
                            logObj.Error_Description__c = 'More than 1 account exist with the entered name';
                            logsInsertMap.put(appObj.Id,logObj);
                        }
                    }
                }
            }else{
                accountRecordInsertForList.addAll(applicationSurveyDataList);
            }
            
            //Searching projects by using name
            if(projectNameList != null && projectNameList.size()>0){
                
                //Calling the Utility class method to search proejcts using the name
                Map<String,List<Projects__c>> existNamevsProjectMap = PG_ProjectUtilityClass.searchProjectByName(projectNameList);
                
                //Checking if any project exist with the name 
                if(existNamevsProjectMap != null && existNamevsProjectMap.size()>0){
                    
                    Set<String> projectNameSet = new Set<String>(projectNameList);
                    for(Application_Survey_Form__c appObj: applicationSurveyDataList){
                        
                        //Creating logs if project exist
                        if(existNamevsProjectMap.containsKey(appObj.Project_Name__c.trim()) && existNamevsProjectMap.get(appObj.Project_Name__c.trim()).size()>0){
                            if(logsInsertMap.containsKey(appObj.Id)){
                                Application_Survey_Form_Logs__c logObj = logsInsertMap.get(appObj.Id);
                                logObj.Error_Description__c += '\n Project Exist for the entered project name';
                            }else{
                                Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c();
                                logObj.Application_Survey_Form__c = appObj.Id;
                                logObj.Status__c = 'Failed';
                                logObj.Error_Description__c = 'Project Exist for the entered project name';
                                logsInsertMap.put(appObj.Id,logObj);
                            }
                        }else{
                            projectRecordInsertForList.add(appObj);
                        }
                    }
                }else{
                    projectRecordInsertForList.addAll(applicationSurveyDataList);
                }
            }  
            
            //Team captain Check
            if(teamcaptainEmailList != null && teamcaptainEmailList.size()>0){
                
                //Calling the Utility class method to search team captain using the emails
                Map<String,List<Contact>> existEmailvsTeamcaptainMap = PG_ContactUtilityClass.searchContactByEmail(teamcaptainEmailList);
                
                //Checking if more than one contact exist with an email and creating logs for the same
                if(existEmailvsTeamcaptainMap != null && existEmailvsTeamcaptainMap.size()>0){
                    Set<String> contactNameSet = new Set<String>(teamcaptainNameList);
                    for(Application_Survey_Form__c appObj: applicationSurveyDataList){
                        if(existEmailvsTeamcaptainMap.containsKey(appObj.Team_captain_Work_Email__c) && existEmailvsTeamcaptainMap.get(appObj.Team_captain_Work_Email__c).size()==1){
                            Contact conObj = existEmailvsTeamcaptainMap.get(appObj.Team_captain_Work_Email__c)[0];
                            if(contactNameSet.contains(conObj.Name)){
                                teamcaptainExistMap.put(appObj.Id, conObj);
                                contactNameSet.remove(conObj.Name);
                            }else{
                                String contactName = appObj.Contact_First_Name__c.trim() + ' '+ appObj.Contact_Last_Name__c.trim();
                                contactNameSet.remove(contactName);
                                if(logsInsertMap.containsKey(appObj.Id)){
                                    Application_Survey_Form_Logs__c logObj = logsInsertMap.get(appObj.Id);
                                    logObj.Error_Description__c += '\n Team captain exist but with another name';
                                }else{
                                    Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c();
                                    logObj.Application_Survey_Form__c = appObj.Id;
                                    logObj.Status__c = 'Failed';
                                    logObj.Error_Description__c = 'Team captain exist but with another name';
                                    logsInsertMap.put(appObj.Id,logObj);
                                } 
                            }
                            
                        }else if(existEmailvsTeamcaptainMap.containsKey(appObj.Team_captain_Work_Email__c) && existEmailvsTeamcaptainMap.get(appObj.Team_captain_Work_Email__c).size()>1){
                            // Error Logs creation
                            if(logsInsertMap.containsKey(appObj.Id)){
                                Application_Survey_Form_Logs__c logObj = logsInsertMap.get(appObj.Id);
                                logObj.Error_Description__c += '\n More than 1 contact exist with the entered team captain email';
                            }else{
                                Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c();
                                logObj.Application_Survey_Form__c = appObj.Id;
                                logObj.Status__c = 'Failed';
                                logObj.Error_Description__c = 'More than 1 contact exist with the entered team captain email';
                                logsInsertMap.put(appObj.Id,logObj);
                            }                        
                        }
                    }
                    if(contactNameSet != null){
                        teamcaptainNameList = new List<String>(contactNameSet);
                    }
                }
            }
            
            //Searching the team captain by using name
            if(teamcaptainNameList != null && teamcaptainNameList.size()>0){
                
                //Calling the Utility class method to search team captain using the name
                Map<String,List<Contact>> existNamevsTeamcaptainMap = PG_ContactUtilityClass.searchContactByName(teamcaptainNameList);
                if(existNamevsTeamcaptainMap != null && existNamevsTeamcaptainMap.size()>0){
                    
                    //Checking if any team captain exist with name but not from email and creating logs for the same
                    for(Application_Survey_Form__c appObj: applicationSurveyDataList){
                        String teamcaptainName = appObj.Team_captain_First_Name__c.trim() + ' '+ appObj.Team_captain_Last_Name__c.trim();
                        
                        if(existNamevsTeamcaptainMap.containsKey(teamcaptainName) && existNamevsTeamcaptainMap.get(teamcaptainName).size()>0){
                            //contactRecordInsertForList.remove(appObj);
                            // Error Logs creation
                            if(logsInsertMap.containsKey(appObj.Id)){
                                Application_Survey_Form_Logs__c logObj = logsInsertMap.get(appObj.Id);
                                logObj.Error_Description__c += '\n Team captain exist with another email';
                            }else{
                                Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c();
                                logObj.Application_Survey_Form__c = appObj.Id;
                                logObj.Status__c = 'Failed';
                                logObj.Error_Description__c = 'Team captain exist with another email';
                                logsInsertMap.put(appObj.Id,logObj);
                            }
                        }
                    }
                }
            }
            
            //Team Member 1 Check
            if(teamMember1EmailList != null && teamMember1EmailList.size()>0){
                
                //Calling the Utility class method to search team member1 using the emails
                Map<String,List<Contact>> existEmailvsTeamMemberMap = PG_ContactUtilityClass.searchContactByEmail(teamMember1EmailList);
                
                //Checking if more than one contact exist with an email and creating logs for the same
                if(existEmailvsTeamMemberMap != null && existEmailvsTeamMemberMap.size()>0){
                    Set<String> contactNameSet = new Set<String>(teamMember1NameList);
                    for(Application_Survey_Form__c appObj: applicationSurveyDataList){
                        if(appObj.Team_Member_1_Work_Email__c != null && existEmailvsTeamMemberMap.containsKey(appObj.Team_Member_1_Work_Email__c) && existEmailvsTeamMemberMap.get(appObj.Team_Member_1_Work_Email__c).size()==1){
                            Contact conObj = existEmailvsTeamMemberMap.get(appObj.Team_Member_1_Work_Email__c)[0];
                            if(contactNameSet.contains(conObj.Name)){
                                teamMember1ExistMap.put(appObj.Id, conObj);
                                contactNameSet.remove(conObj.Name);
                            }else{
                                String contactName = appObj.Contact_First_Name__c.trim() + ' '+ appObj.Contact_Last_Name__c.trim();
                                contactNameSet.remove(contactName);
                                if(logsInsertMap.containsKey(appObj.Id)){
                                    Application_Survey_Form_Logs__c logObj = logsInsertMap.get(appObj.Id);
                                    logObj.Error_Description__c += '\n Team member 1 exist but with another name';
                                }else{
                                    Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c();
                                    logObj.Application_Survey_Form__c = appObj.Id;
                                    logObj.Status__c = 'Failed';
                                    logObj.Error_Description__c = 'Team member 1 exist but with another name';
                                    logsInsertMap.put(appObj.Id,logObj);
                                } 
                            }
                        }else if(appObj.Team_Member_1_Work_Email__c != null && existEmailvsTeamMemberMap.containsKey(appObj.Team_Member_1_Work_Email__c) && existEmailvsTeamMemberMap.get(appObj.Team_Member_1_Work_Email__c).size()>1){
                            // Error Logs creation
                            if(logsInsertMap.containsKey(appObj.Id)){
                                Application_Survey_Form_Logs__c logObj = logsInsertMap.get(appObj.Id);
                                logObj.Error_Description__c += '\n More than 1 contact exist with the entered team member 1 email';
                            }else{
                                Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c();
                                logObj.Application_Survey_Form__c = appObj.Id;
                                logObj.Status__c = 'Failed';
                                logObj.Error_Description__c = 'More than 1 contact exist with the entered team member 1 email';
                                logsInsertMap.put(appObj.Id,logObj);
                            }                        
                        }
                    }
                    if(contactNameSet != null){
                        teamMember1NameList = new List<String>(contactNameSet);
                    }
                }
            }
            
            //Searching the team member 1 by using name
            if(teamMember1NameList != null && teamMember1NameList.size()>0){
                
                //Calling the Utility class method to search team captain using the name
                Map<String,List<Contact>> existNamevsTeamMemberMap = PG_ContactUtilityClass.searchContactByName(teamMember1NameList);
                if(existNamevsTeamMemberMap != null && existNamevsTeamMemberMap.size()>0){
                    
                    //Checking if any team captain exist with name but not from email and creating logs for the same
                    for(Application_Survey_Form__c appObj: applicationSurveyDataList){
                        String teamMemberName = appObj.Team_Member_1_First_Name__c.trim() + ' '+ appObj.Team_Member_1_Last_Name__c.trim();
                        
                        if(appObj.Team_Member_1_Work_Email__c != null && existNamevsTeamMemberMap.containsKey(teamMemberName) && existNamevsTeamMemberMap.get(teamMemberName).size()>0){
                            //contactRecordInsertForList.remove(appObj);
                            // Error Logs creation
                            if(logsInsertMap.containsKey(appObj.Id)){
                                Application_Survey_Form_Logs__c logObj = logsInsertMap.get(appObj.Id);
                                logObj.Error_Description__c += '\n Team member 1 exist with another email';
                            }else{
                                Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c();
                                logObj.Application_Survey_Form__c = appObj.Id;
                                logObj.Status__c = 'Failed';
                                logObj.Error_Description__c = 'Team member 1 exist with another email';
                                logsInsertMap.put(appObj.Id,logObj);
                            }
                        }
                    }
                }
            }
            
            
            //Team Member 2 Check
            if(teamMember2EmailList != null && teamMember2EmailList.size()>0){
                
                //Calling the Utility class method to search team member2 using the emails
                Map<String,List<Contact>> existEmailvsTeamMemberMap = PG_ContactUtilityClass.searchContactByEmail(teamMember2EmailList);
                
                //Checking if more than one contact exist with an email and creating logs for the same
                if(existEmailvsTeamMemberMap != null && existEmailvsTeamMemberMap.size()>0){
                    Set<String> contactNameSet = new Set<String>(teamMember2NameList);
                    for(Application_Survey_Form__c appObj: applicationSurveyDataList){
                        if(appObj.Team_Member_2_Work_Email__c != null && existEmailvsTeamMemberMap.containsKey(appObj.Team_Member_2_Work_Email__c) && existEmailvsTeamMemberMap.get(appObj.Team_Member_2_Work_Email__c).size()==1){
                            Contact conObj = existEmailvsTeamMemberMap.get(appObj.Team_Member_2_Work_Email__c)[0];
                            if(contactNameSet.contains(conObj.Name)){
                                teamMember2ExistMap.put(appObj.Id, conObj);
                                contactNameSet.remove(conObj.Name);
                            }else{
                                String contactName = appObj.Contact_First_Name__c.trim() + ' '+ appObj.Contact_Last_Name__c.trim();
                                contactNameSet.remove(contactName);
                                if(logsInsertMap.containsKey(appObj.Id)){
                                    Application_Survey_Form_Logs__c logObj = logsInsertMap.get(appObj.Id);
                                    logObj.Error_Description__c += '\n Team member 2 exist but with another name';
                                }else{
                                    Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c();
                                    logObj.Application_Survey_Form__c = appObj.Id;
                                    logObj.Status__c = 'Failed';
                                    logObj.Error_Description__c = 'Team member 2 exist but with another name';
                                    logsInsertMap.put(appObj.Id,logObj);
                                } 
                            }
                        }else if(appObj.Team_Member_2_Work_Email__c != null && existEmailvsTeamMemberMap.containsKey(appObj.Team_Member_2_Work_Email__c) && existEmailvsTeamMemberMap.get(appObj.Team_Member_2_Work_Email__c).size()>1){
                            // Error Logs creation
                            if(logsInsertMap.containsKey(appObj.Id)){
                                Application_Survey_Form_Logs__c logObj = logsInsertMap.get(appObj.Id);
                                logObj.Error_Description__c += '\n More than 1 contact exist with the entered team member 2 email';
                            }else{
                                Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c();
                                logObj.Application_Survey_Form__c = appObj.Id;
                                logObj.Status__c = 'Failed';
                                logObj.Error_Description__c = 'More than 1 contact exist with the entered team member 2 email';
                                logsInsertMap.put(appObj.Id,logObj);
                            }                        
                        }
                    }
                    if(contactNameSet != null){
                        teamMember2NameList = new List<String>(contactNameSet);
                    }
                }
            }
            
            //Searching the team member 2 by using name
            if(teamMember2NameList != null && teamMember2NameList.size()>0){
                
                //Calling the Utility class method to search team captain using the name
                Map<String,List<Contact>> existNamevsTeamMemberMap = PG_ContactUtilityClass.searchContactByName(teamMember2NameList);
                if(existNamevsTeamMemberMap != null && existNamevsTeamMemberMap.size()>0){
                    
                    //Checking if any team captain exist with name but not from email and creating logs for the same
                    for(Application_Survey_Form__c appObj: applicationSurveyDataList){
                        String teamMemberName = appObj.Team_Member_2_First_Name__c.trim() + ' '+ appObj.Team_Member_2_Last_Name__c.trim();
                        
                        if(appObj.Team_Member_2_Work_Email__c != null && existNamevsTeamMemberMap.containsKey(teamMemberName) && existNamevsTeamMemberMap.get(teamMemberName).size()>0){
                            //contactRecordInsertForList.remove(appObj);
                            // Error Logs creation
                            if(logsInsertMap.containsKey(appObj.Id)){
                                Application_Survey_Form_Logs__c logObj = logsInsertMap.get(appObj.Id);
                                logObj.Error_Description__c += '\n Team member 2 exist with another email';
                            }else{
                                Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c();
                                logObj.Application_Survey_Form__c = appObj.Id;
                                logObj.Status__c = 'Failed';
                                logObj.Error_Description__c = 'Team member 2 exist with another email';
                                logsInsertMap.put(appObj.Id,logObj);
                            }
                        }
                    }
                }
            }
            
            
            
            //Team Member 3 Check
            if(teamMember3EmailList != null && teamMember3EmailList.size()>0){
                
                //Calling the Utility class method to search team member1 using the emails
                Map<String,List<Contact>> existEmailvsTeamMemberMap = PG_ContactUtilityClass.searchContactByEmail(teamMember3EmailList);
                
                //Checking if more than one contact exist with an email and creating logs for the same
                if(existEmailvsTeamMemberMap != null && existEmailvsTeamMemberMap.size()>0){
                    Set<String> contactNameSet = new Set<String>(teamMember3NameList);
                    for(Application_Survey_Form__c appObj: applicationSurveyDataList){
                        if(appObj.Team_Member_3_Work_Email__c != null && existEmailvsTeamMemberMap.containsKey(appObj.Team_Member_3_Work_Email__c) && existEmailvsTeamMemberMap.get(appObj.Team_Member_3_Work_Email__c).size()==1){
                            Contact conObj = existEmailvsTeamMemberMap.get(appObj.Team_Member_3_Work_Email__c)[0];
                            if(contactNameSet.contains(conObj.Name)){
                                teamMember3ExistMap.put(appObj.Id, conObj);
                                contactNameSet.remove(conObj.Name);
                            }else{
                                String contactName = appObj.Contact_First_Name__c.trim() + ' '+ appObj.Contact_Last_Name__c.trim();
                                contactNameSet.remove(contactName);
                                if(logsInsertMap.containsKey(appObj.Id)){
                                    Application_Survey_Form_Logs__c logObj = logsInsertMap.get(appObj.Id);
                                    logObj.Error_Description__c += '\n Team member 3 exist but with another name';
                                }else{
                                    Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c();
                                    logObj.Application_Survey_Form__c = appObj.Id;
                                    logObj.Status__c = 'Failed';
                                    logObj.Error_Description__c = 'Team member 3 exist but with another name';
                                    logsInsertMap.put(appObj.Id,logObj);
                                } 
                            }
                        }else if(appObj.Team_Member_3_Work_Email__c != null && existEmailvsTeamMemberMap.containsKey(appObj.Team_Member_3_Work_Email__c) && existEmailvsTeamMemberMap.get(appObj.Team_Member_3_Work_Email__c).size()>1){
                            // Error Logs creation
                            if(logsInsertMap.containsKey(appObj.Id)){
                                Application_Survey_Form_Logs__c logObj = logsInsertMap.get(appObj.Id);
                                logObj.Error_Description__c += '\n More than 1 contact exist with the entered team member 3 email';
                            }else{
                                Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c();
                                logObj.Application_Survey_Form__c = appObj.Id;
                                logObj.Status__c = 'Failed';
                                logObj.Error_Description__c = 'More than 1 contact exist with the entered team member 3 email';
                                logsInsertMap.put(appObj.Id,logObj);
                            }                        
                        }
                    }
                    if(contactNameSet != null){
                        teamMember3NameList = new List<String>(contactNameSet);
                    }
                }
            }
            
            //Searching the team member 3 by using name
            if(teamMember3NameList != null && teamMember3NameList.size()>0){
                
                //Calling the Utility class method to search team captain using the name
                Map<String,List<Contact>> existNamevsTeamMemberMap = PG_ContactUtilityClass.searchContactByName(teamMember3NameList);
                if(existNamevsTeamMemberMap != null && existNamevsTeamMemberMap.size()>0){
                    
                    //Checking if any team captain exist with name but not from email and creating logs for the same
                    for(Application_Survey_Form__c appObj: applicationSurveyDataList){
                        String teamMemberName = appObj.Team_Member_3_First_Name__c.trim() + ' '+ appObj.Team_Member_3_Last_Name__c.trim();
                        
                        if(appObj.Team_Member_3_Work_Email__c != null && existNamevsTeamMemberMap.containsKey(teamMemberName) && existNamevsTeamMemberMap.get(teamMemberName).size()>0){
                            //contactRecordInsertForList.remove(appObj);
                            // Error Logs creation
                            if(logsInsertMap.containsKey(appObj.Id)){
                                Application_Survey_Form_Logs__c logObj = logsInsertMap.get(appObj.Id);
                                logObj.Error_Description__c += '\n Team member 3 eixst with another email';
                            }else{
                                Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c();
                                logObj.Application_Survey_Form__c = appObj.Id;
                                logObj.Status__c = 'Failed';
                                logObj.Error_Description__c = 'Team member 3 exist with another email';
                                logsInsertMap.put(appObj.Id,logObj);
                            }
                        }
                    }
                }
            }
            
            
            //Team Member 4 Check
            if(teamMember4EmailList != null && teamMember4EmailList.size()>0){
                
                //Calling the Utility class method to search team member1 using the emails
                Map<String,List<Contact>> existEmailvsTeamMemberMap = PG_ContactUtilityClass.searchContactByEmail(teamMember4EmailList);
                
                //Checking if more than one contact exist with an email and creating logs for the same
                if(existEmailvsTeamMemberMap != null && existEmailvsTeamMemberMap.size()>0){
                    Set<String> contactNameSet = new Set<String>(teamMember4NameList);
                    for(Application_Survey_Form__c appObj: applicationSurveyDataList){
                        if(appObj.Team_Member_4_Work_Email__c != null && existEmailvsTeamMemberMap.containsKey(appObj.Team_Member_4_Work_Email__c) && existEmailvsTeamMemberMap.get(appObj.Team_Member_4_Work_Email__c).size()==1){
                            Contact conObj = existEmailvsTeamMemberMap.get(appObj.Team_Member_4_Work_Email__c)[0];
                            if(contactNameSet.contains(conObj.Name)){
                                teamMember4ExistMap.put(appObj.Id, conObj);
                                contactNameSet.remove(conObj.Name);
                            }else{
                                String contactName = appObj.Contact_First_Name__c.trim() + ' '+ appObj.Contact_Last_Name__c.trim();
                                contactNameSet.remove(contactName);
                                if(logsInsertMap.containsKey(appObj.Id)){
                                    Application_Survey_Form_Logs__c logObj = logsInsertMap.get(appObj.Id);
                                    logObj.Error_Description__c += '\n Team member 4 exist but with another name';
                                }else{
                                    Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c();
                                    logObj.Application_Survey_Form__c = appObj.Id;
                                    logObj.Status__c = 'Failed';
                                    logObj.Error_Description__c = 'Team member 4 exist but with another name';
                                    logsInsertMap.put(appObj.Id,logObj);
                                } 
                            }
                        }else if(appObj.Team_Member_4_Work_Email__c != null && existEmailvsTeamMemberMap.containsKey(appObj.Team_Member_4_Work_Email__c) && existEmailvsTeamMemberMap.get(appObj.Team_Member_4_Work_Email__c).size()>1){
                            // Error Logs creation
                            if(logsInsertMap.containsKey(appObj.Id)){
                                Application_Survey_Form_Logs__c logObj = logsInsertMap.get(appObj.Id);
                                logObj.Error_Description__c += '\n More than 1 contact exist with the entered team member 4 email';
                            }else{
                                Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c();
                                logObj.Application_Survey_Form__c = appObj.Id;
                                logObj.Status__c = 'Failed';
                                logObj.Error_Description__c = 'More than 1 contact exist with the entered team member 4 email';
                                logsInsertMap.put(appObj.Id,logObj);
                            }                        
                        }
                    }
                    if(contactNameSet != null){
                        teamMember4NameList = new List<String>(contactNameSet);
                    }
                }
            }
            
            //Searching the team member 4 by using name
            if(teamMember4NameList != null && teamMember4NameList.size()>0){
                
                //Calling the Utility class method to search team captain using the name
                Map<String,List<Contact>> existNamevsTeamMemberMap = PG_ContactUtilityClass.searchContactByName(teamMember4NameList);
                if(existNamevsTeamMemberMap != null && existNamevsTeamMemberMap.size()>0){
                    
                    //Checking if any team captain exist with name but not from email and creating logs for the same
                    for(Application_Survey_Form__c appObj: applicationSurveyDataList){
                        String teamMemberName = appObj.Team_Member_4_First_Name__c.trim() + ' '+ appObj.Team_Member_4_Last_Name__c.trim();
                        
                        if(appObj.Team_Member_4_Work_Email__c != null && existNamevsTeamMemberMap.containsKey(teamMemberName) && existNamevsTeamMemberMap.get(teamMemberName).size()>0){
                            //contactRecordInsertForList.remove(appObj);
                            // Error Logs creation
                            if(logsInsertMap.containsKey(appObj.Id)){
                                Application_Survey_Form_Logs__c logObj = logsInsertMap.get(appObj.Id);
                                logObj.Error_Description__c += '\n Team member 4 exist with another email';
                            }else{
                                Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c();
                                logObj.Application_Survey_Form__c = appObj.Id;
                                logObj.Status__c = 'Failed';
                                logObj.Error_Description__c = 'Team member 4 exist with another email';
                                logsInsertMap.put(appObj.Id,logObj);
                            }
                        }
                    }
                }
            }
            
            
            //Team Member 5 Check
            if(teamMember5EmailList != null && teamMember5EmailList.size()>0){
                
                //Calling the Utility class method to search team member1 using the emails
                Map<String,List<Contact>> existEmailvsTeamMemberMap = PG_ContactUtilityClass.searchContactByEmail(teamMember5EmailList);
                
                //Checking if more than one contact exist with an email and creating logs for the same
                if(existEmailvsTeamMemberMap != null && existEmailvsTeamMemberMap.size()>0){
                    Set<String> contactNameSet = new Set<String>(teamMember5NameList);
                    for(Application_Survey_Form__c appObj: applicationSurveyDataList){
                        if(appObj.Team_Member_5_Work_Email__c != null && existEmailvsTeamMemberMap.containsKey(appObj.Team_Member_5_Work_Email__c) && existEmailvsTeamMemberMap.get(appObj.Team_Member_5_Work_Email__c).size()==1){
                            Contact conObj = existEmailvsTeamMemberMap.get(appObj.Team_Member_5_Work_Email__c)[0];
                            if(contactNameSet.contains(conObj.Name)){
                                teamMember5ExistMap.put(appObj.Id, conObj);
                                contactNameSet.remove(conObj.Name);
                            }else{
                                String contactName = appObj.Contact_First_Name__c.trim() + ' '+ appObj.Contact_Last_Name__c.trim();
                                contactNameSet.remove(contactName);
                                if(logsInsertMap.containsKey(appObj.Id)){
                                    Application_Survey_Form_Logs__c logObj = logsInsertMap.get(appObj.Id);
                                    logObj.Error_Description__c += '\n Team member 5 exist but with another name';
                                }else{
                                    Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c();
                                    logObj.Application_Survey_Form__c = appObj.Id;
                                    logObj.Status__c = 'Failed';
                                    logObj.Error_Description__c = 'Team member 5 exist but with another name';
                                    logsInsertMap.put(appObj.Id,logObj);
                                } 
                            }
                        }else if(appObj.Team_Member_5_Work_Email__c != null && existEmailvsTeamMemberMap.containsKey(appObj.Team_Member_5_Work_Email__c) && existEmailvsTeamMemberMap.get(appObj.Team_Member_5_Work_Email__c).size()>1){
                            // Error Logs creation
                            if(logsInsertMap.containsKey(appObj.Id)){
                                Application_Survey_Form_Logs__c logObj = logsInsertMap.get(appObj.Id);
                                logObj.Error_Description__c += '\n More than 1 contact exist with the entered team member 5 email';
                            }else{
                                Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c();
                                logObj.Application_Survey_Form__c = appObj.Id;
                                logObj.Status__c = 'Failed';
                                logObj.Error_Description__c = 'More than 1 contact exist with the entered team member 5 email';
                                logsInsertMap.put(appObj.Id,logObj);
                            }                        
                        }
                    }
                    if(contactNameSet != null){
                        teamMember5NameList = new List<String>(contactNameSet);
                    }
                }
            }
            
            //Searching the team member 5 by using name
            if(teamMember5NameList != null && teamMember5NameList.size()>0){
                
                //Calling the Utility class method to search team captain using the name
                Map<String,List<Contact>> existNamevsTeamMemberMap = PG_ContactUtilityClass.searchContactByName(teamMember5NameList);
                if(existNamevsTeamMemberMap != null && existNamevsTeamMemberMap.size()>0){
                    
                    //Checking if any team captain exist with name but not from email and creating logs for the same
                    for(Application_Survey_Form__c appObj: applicationSurveyDataList){
                        String teamMemberName = appObj.Team_Member_5_First_Name__c.trim() + ' '+ appObj.Team_Member_5_Last_Name__c.trim();
                        
                        if(appObj.Team_Member_5_Work_Email__c != null && existNamevsTeamMemberMap.containsKey(teamMemberName) && existNamevsTeamMemberMap.get(teamMemberName).size()>0){
                            //contactRecordInsertForList.remove(appObj);
                            // Error Logs creation
                            if(logsInsertMap.containsKey(appObj.Id)){
                                Application_Survey_Form_Logs__c logObj = logsInsertMap.get(appObj.Id);
                                logObj.Error_Description__c += '\n Team member 5 exist with another email';
                            }else{
                                Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c();
                                logObj.Application_Survey_Form__c = appObj.Id;
                                logObj.Status__c = 'Failed';
                                logObj.Error_Description__c = 'Team member 5 exist with another email';
                                logsInsertMap.put(appObj.Id,logObj);
                            }
                        }
                    }
                }
            }
            
            //Creating logs and roll back the process
            if(logsInsertMap != null && logsInsertMap.size()>0){
                insert logsInsertMap.values();
                
                return;
                
             //Creating the record   
            }else{
                
                //Creating accounts, contacts, projects                
                if(accountRecordInsertForList != null && accountRecordInsertForList.size()>0){
                    for(Application_Survey_Form__c appObj: accountRecordInsertForList){
                        
                        //Creating contact records
                        Account accRef = new Account(External_Id__c = appObj.Id+appObj.Organization_Name__c); //Creating ref object for account
                        
                        Contact conObj = new Contact(firstname = appObj.Contact_First_Name__c.trim(),
                                                     lastname = appObj.Contact_Last_Name__c.trim(),
                                                     phone = appObj.Contact_Phone_Number__c,
                                                     email = appObj.Contact_Work_Email__c,
                                                     title = appObj.Contact_Title__c,
                                                     Line_Manager__c = appObj.Line_Manager_Name__c,
                                                     Line_Manager_Email__c = appObj.Line_Manager_Work_Email__c,
                                                     Home_Office__c = appObj.Home_Office_Country__c,
                                                     Account = accRef
                                                    );

                        contactInsertList.add(conObj);
                        
                        Projects__c projectRef = new Projects__c(External_Id__c = appObj.Id+appObj.Project_Name__c);
                         
                        //Calling method: createTeamCaptionAndMember
                        createTeamCaptionAndMember(appObj,projectRef,accRef);
                        
                        //Creating Project records
                        Projects__c projectObj = new Projects__c(Name = appObj.Project_Name__c,
                                                                 Project_Objective__c = appObj.Project_Objective__c,
                                                                 Project_Background__c = appObj.Project_Background__c,
                                                                 Project_Beneficiaries__c = appObj.Project_Beneficiaries__c,
                                                                 Level_of_Commitment__c = appObj.Level_of_Commitment__c,
                                                                 Level_of_Effort__c = appObj.Level_of_Effort__c,
                                                                 Grant_Use__c = appObj.Grant_Use__c,
                                                                 Team_Skills__c = appObj.Team_Skills__c,
                                                                 Team_Diversity__c = appObj.Team_Diversity__c,
                                                                 Activities_to_Obtain_Objectives__c = appObj.Activities_to_Obtain_Objective__c,
                                                                 External_Id__c = appObj.Id+appObj.Project_Name__c,
                                                                 Host_Organization__r = accRef
                                                                );
                                                
                        projectInsertList.add(projectObj);
                        
                        //Creating Account records
                        Account accObj = new Account();
                        accObj.Name = appObj.Organization_Name__c.trim();
                        accObj.External_Id__c = appObj.Id+appObj.Organization_Name__c;
                        accountInsertList.add(accObj);
                    }
                }else if(projectRecordInsertForList != null && projectRecordInsertForList.size()>0){
                    if(existAccObj != null && existAccObj.size()>0){
                        for(Application_Survey_Form__c appObj: applicationSurveyDataList){
                            if(existAccObj.containsKey(appObj.Id)){
                                Projects__c projectRef = new Projects__c(External_Id__c = appObj.Id+appObj.Project_Name__c);
                                //Calling method: createTeamCaptionAndMember
                                createTeamCaptionAndMember(appObj,projectRef,existAccObj.get(appObj.Id));
                                Projects__c projectObj = new Projects__c(Name = appObj.Project_Name__c,
                                                                         Project_Objective__c = appObj.Project_Objective__c,
                                                                         Project_Background__c = appObj.Project_Background__c,
                                                                         Project_Beneficiaries__c = appObj.Project_Beneficiaries__c,
                                                                         Level_of_Commitment__c = appObj.Level_of_Commitment__c,
                                                                         Level_of_Effort__c = appObj.Level_of_Effort__c,
                                                                         Grant_Use__c = appObj.Grant_Use__c,
                                                                         Team_Skills__c = appObj.Team_Skills__c,
                                                                         Team_Diversity__c = appObj.Team_Diversity__c,
                                                                         Activities_to_Obtain_Objectives__c = appObj.Activities_to_Obtain_Objective__c,
                                                                         External_Id__c = appObj.Id+appObj.Project_Name__c,
                                                                         Host_Organization__c = existAccObj.get(appObj.Id).Id
                                                                        );
                                projectInsertList.add(projectObj);
                            }
                        }
                    }
                }
                
                //Inserting the account and contact records
                Savepoint sp; // Savepoint variable
                try{
                    
                    sp = Database.setSavepoint(); //Set Savepoint
                    
                    if(contactInsertList != null && projectInsertList!= null && accountInsertList != null && teamMemberInsertList != null){
                        SObject[] sobjList = new List<SObject>();
                        sobjList.addAll(accountInsertList);
                        sobjList.addAll(contactInsertList);
                        sobjList.addAll(projectInsertList);
                        sobjList.addAll(teamMemberInsertList);
                        Database.SaveResult[] results = Database.insert(sobjList);
                    }else{
                        if(accountInsertList != null && accountInsertList.size()>0){
                            Database.SaveResult[] results = Database.insert(accountInsertList);
                        }
                        if(contactInsertList != null && contactInsertList.size()>0){
                            Database.SaveResult[] results = Database.insert(contactInsertList);
                        }
                        if(projectInsertList != null && projectInsertList.size()>0){
                            Database.SaveResult[] results = Database.insert(projectInsertList);
                        }
                        if(teamMemberInsertList != null && teamMemberInsertList.size()>0){
                            Database.SaveResult[] results = Database.insert(teamMemberInsertList);
                        }
                    } 
                    
                    
                    
                }catch(Exception e){
                    System.debug('----Exception----'+e.getMessage()+'----line number---'+e.getLineNumber());
                    //Error Logs creation
                    
                }
            }           
        }
    }
    
    //Mthod used to create the Team captain and Team member records
    public void createTeamCaptionAndMember(Application_Survey_Form__c appObj, Projects__c projectRef, Account accRef){
        //Creating Team captain record
        if(teamcaptainExistMap != null && teamcaptainExistMap.containsKey(appObj.Id)){
            Team_Member__c teamMember = new Team_Member__c(Name__c = teamcaptainExistMap.get(appObj.Id).Id,
                                                           Project__r = projectRef,
                                                           Team_Captain__c = true
                                                          );
            teamMemberInsertList.add(teamMember);
        }else{
            Contact teamcaptainRef = new Contact(External_Id__c = appObj.Id+appObj.Team_captain_Work_Email__c);
            
            Team_Member__c teamMember = new Team_Member__c(Name__r = teamcaptainRef,
                                                           Project__r = projectRef,
                                                           Team_Captain__c = true
                                                          );
            teamMemberInsertList.add(teamMember);
            
            Contact teamcaptainObj = new Contact(firstname = appObj.Team_captain_First_Name__c.trim(),
                                                 lastname = appObj.Team_captain_Last_Name__c.trim(),
                                                 email = appObj.Team_captain_Work_Email__c,
                                                 title = appObj.Team_captain_Job_Title__c,
                                                 Company_Affiliation__c = appObj.Company_Affiliation__c,
                                                 Home_Office__c = appObj.Team_captain_Home_Office_City__c,
                                                 Account = accRef,
                                                 External_Id__c = appObj.Id+appObj.Team_captain_Work_Email__c       
                                                );
            
            contactInsertList.add(teamcaptainObj);
        }
        
        //Creating Team member 1 record
        if(appObj.Team_Member_1_Work_Email__c != null){
            if(teamMember1ExistMap != null && teamMember1ExistMap.containsKey(appObj.Id)){
                Team_Member__c teamMember = new Team_Member__c(Name__c = teamMember1ExistMap.get(appObj.Id).Id,
                                                               Project__r = projectRef
                                                              );
                teamMemberInsertList.add(teamMember);
            }else{
                Contact conRef = new Contact(External_Id__c = appObj.Id+appObj.Team_Member_1_Work_Email__c);
                
                Team_Member__c teamMember = new Team_Member__c(Name__r = conRef,
                                                               Project__r = projectRef
                                                              );
                teamMemberInsertList.add(teamMember);
                
                Contact teamObj = new Contact(firstname = appObj.Team_Member_1_First_Name__c.trim(),
                                              lastname = appObj.Team_Member_1_Last_Name__c.trim(),
                                              email = appObj.Team_Member_1_Work_Email__c,
                                              title = appObj.Team_Member_1_Job_Title__c,
                                              Company_Affiliation__c = appObj.Team_Member_1_Company_Affiliation__c,
                                              Line_Manager__c = appObj.Team_Member_1_Line_Manager_Full_Name__c,
                                              Line_Manager_Email__c = appObj.Team_Member_1_Line_Manager_Work_Email__c,
                                              Home_Office__c = appObj.Team_Member_1_Home_Office_Country__c,
                                              Account = accRef,
                                              External_Id__c = appObj.Id+appObj.Team_Member_1_Work_Email__c      
                                             );
                
                contactInsertList.add(teamObj);
            }
        }
        
        //Creating Team member 2 record
        if(appObj.Team_Member_2_Work_Email__c != null){
            if(teamMember2ExistMap != null && teamMember2ExistMap.containsKey(appObj.Id)){
                Team_Member__c teamMember = new Team_Member__c(Name__c = teamMember2ExistMap.get(appObj.Id).Id,
                                                               Project__r = projectRef
                                                              );
                teamMemberInsertList.add(teamMember);
            }else{
                Contact conRef = new Contact(External_Id__c = appObj.Id+appObj.Team_Member_2_Work_Email__c);
                
                Team_Member__c teamMember = new Team_Member__c(Name__r = conRef,
                                                               Project__r = projectRef
                                                              );
                teamMemberInsertList.add(teamMember);
                
                Contact teamObj = new Contact(firstname = appObj.Team_Member_2_First_Name__c.trim(),
                                              lastname = appObj.Team_Member_2_Last_Name__c.trim(),
                                              email = appObj.Team_Member_2_Work_Email__c,
                                              title = appObj.Team_Member_2_Job_Title__c,
                                              Company_Affiliation__c = appObj.Team_Member_2_Company_Affiliation__c,
                                              Line_Manager__c = appObj.Team_Member_2_Line_Manager_Full_Name__c,
                                              Line_Manager_Email__c = appObj.Team_Member_2_Line_Manager_Work_Email__c,
                                              Home_Office__c = appObj.Team_Member_2_Home_Office_Country__c,
                                              Account = accRef,
                                              External_Id__c = appObj.Id+appObj.Team_Member_2_Work_Email__c        
                                             );
                
                contactInsertList.add(teamObj);
            }
        }
        //Creating Team member 3 record
        if(appObj.Team_Member_3_Work_Email__c != null){
            if(teamMember3ExistMap != null && teamMember3ExistMap.containsKey(appObj.Id)){
                Team_Member__c teamMember = new Team_Member__c(Name__c = teamMember3ExistMap.get(appObj.Id).Id,
                                                               Project__r = projectRef
                                                              );
                teamMemberInsertList.add(teamMember);
            }else{
                Contact conRef = new Contact(External_Id__c = appObj.Id+appObj.Team_Member_3_Work_Email__c);
                
                Team_Member__c teamMember = new Team_Member__c(Name__r = conRef,
                                                               Project__r = projectRef
                                                              );
                teamMemberInsertList.add(teamMember);
                
                Contact teamObj = new Contact(firstname = appObj.Team_Member_3_First_Name__c.trim(),
                                              lastname = appObj.Team_Member_3_Last_Name__c.trim(),
                                              email = appObj.Team_Member_3_Work_Email__c,
                                              title = appObj.Team_Member_3_Job_Title__c,
                                              Company_Affiliation__c = appObj.Team_Member_3_Company_Affiliation__c,
                                              Line_Manager__c = appObj.Team_Member_3_Line_Manager_Full_Name__c,
                                              Line_Manager_Email__c = appObj.Team_Member_3_Line_Manager_Work_Email__c,
                                              Home_Office__c = appObj.Team_Member_3_Home_Office_Country__c,
                                              Account = accRef,
                                              External_Id__c = appObj.Id+appObj.Team_Member_3_Work_Email__c        
                                             );
                
                contactInsertList.add(teamObj);
            }
        }
        
        //Creating Team member 4 record
        if(appObj.Team_Member_4_Work_Email__c != null){
            if(teamMember4ExistMap != null && teamMember4ExistMap.containsKey(appObj.Id)){
                Team_Member__c teamMember = new Team_Member__c(Name__c = teamMember4ExistMap.get(appObj.Id).Id,
                                                               Project__r = projectRef
                                                              );
                teamMemberInsertList.add(teamMember);
            }else{
                Contact conRef = new Contact(External_Id__c = appObj.Id+appObj.Team_Member_4_Work_Email__c);
                
                Team_Member__c teamMember = new Team_Member__c(Name__r = conRef,
                                                               Project__r = projectRef
                                                              );
                teamMemberInsertList.add(teamMember);
                
                Contact teamObj = new Contact(firstname = appObj.Team_Member_4_First_Name__c.trim(),
                                              lastname = appObj.Team_Member_4_Last_Name__c.trim(),
                                              email = appObj.Team_Member_4_Work_Email__c,
                                              title = appObj.Team_Member_4_Job_Title__c,
                                              Company_Affiliation__c = appObj.Team_Member_4_Company_Affiliation__c,
                                              Line_Manager__c = appObj.Team_Member_4_Line_Manager_Full_Name__c,
                                              Line_Manager_Email__c = appObj.Team_Member_4_Line_Manager_Work_Email__c,
                                              Home_Office__c = appObj.Team_Member_4_Home_Office_Country__c,
                                              Account = accRef,
                                              External_Id__c = appObj.Id+appObj.Team_Member_4_Work_Email__c        
                                             );
                
                contactInsertList.add(teamObj);
            }
        }
        
        //Creating Team member 5 record
        /*if(appObj.Team_Member_5_Work_Email__c != null){
            if(teamMember5ExistMap != null && teamMember5ExistMap.containsKey(appObj.Id)){
                Team_Member__c teamMember = new Team_Member__c(Name__c = teamMember5ExistMap.get(appObj.Id).Id,
                                                               Project__r = projectRef
                                                              );
                teamMemberInsertList.add(teamMember);
            }else{
                Contact conRef = new Contact(External_Id__c = appObj.Id+appObj.Team_Member_5_Work_Email__c);
                
                Team_Member__c teamMember = new Team_Member__c(Name__r = conRef,
                                                               Project__r = projectRef
                                                              );
                teamMemberInsertList.add(teamMember);
                
                Contact teamObj = new Contact(firstname = appObj.Team_Member_5_First_Name__c.trim(),
                                              lastname = appObj.Team_Member_5_Last_Name__c.trim(),
                                              email = appObj.Team_Member_5_Work_Email__c,
                                              title = appObj.Team_Member_5_Job_Title__c,
                                              Company_Affiliation__c = appObj.Team_Member_5_Company_Affiliation__c,
                                              Line_Manager__c = appObj.Team_Member_5_Line_Manager_Full_Name__c,
                                              Line_Manager_Email__c = appObj.Team_Member_5_Line_Manager_Work_Email__c,
                                              Home_Office__c = appObj.Team_Member_5_Home_Office_Country__c,
                                              Account = accRef,
                                              External_Id__c = appObj.Id+appObj.Team_Member_5_Work_Email__c        
                                             );
                
                contactInsertList.add(teamObj);
            }
        }
    }*/
}