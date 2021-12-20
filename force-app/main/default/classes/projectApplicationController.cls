/* Class Name: projectApplicationController
* Usage: This Apex Class is a controller for 'projectApplication' LWC component
* 
*/
public class projectApplicationController {
    /* Method Name: fetchProject
* Usage: This method will search Project by name and will return the result if it exist.
* Return Type: String of result
* Parameters: Name and type which we have to search of project (String)
*/
    @AuraEnabled
    public static String fetchProject(String projectName){
        String result;
        System.debug('projectName--> '+projectName);
        //querying for Projects with the parameter passed by 'projectApplication' LWC component
        List<Projects__c> lstProject = [SELECT Id, Name,Team_Captain__c FROM Projects__c WHERE Name=:projectName];
        System.debug('lstProject--> '+lstProject);
        //Checking if the list of project is not null
        if(lstProject.size()>0){
            result = 'Project Exists';
        }else{
            result = 'No Project Exists';
        }
        //returning the result
        return result;
    }
    /* Method Name: fetchOrganizations
* Usage: This method will search Organizations/Accounts by name and will return the List of Organizations/Accounts if it exist.
* Return Type: List of Organizations/Accounts
* Parameters: Name and type which we have to search of Organizations/Accounts (String)
*/
    @AuraEnabled
    public static List<Account> fetchOrganizations(String fullOrgName){
        System.debug('fullOrgName--> '+fullOrgName);
        List<Account> lstAccount;
        List<Contact> lstContact;
        //querying for Projects with the parameter passed by 'projectApplication' LWC component
        lstAccount = [SELECT Id,Name,Website,Registered_Entity__c,BillingStreet,BillingCity,BillingState,BillingCountry,BillingPostalCode,Mission_and_Vision_Statement__c,Sector_Activities__c,Geographic_Coverage__c,Target_Clients_or_Beneficiaries__c,Level_of_Commitment__c,(SELECT Contact.FirstName,Contact.LastName,Contact.Title,Contact.Email,Contact.Phone FROM Contacts limit 1) FROM Account WHERE Name=:fullOrgName limit 1];
        System.debug('lstAccount--> '+lstAccount);        
        //returning list of projects
        return lstAccount;
    }
    @AuraEnabled
    public static Contact fetchUserRelatedContactInfo(String userId){
        system.debug('userId -> '+userId);
        User objUser;
        Contact objContact;
        objUser = [SELECT Id,ContactId FROM User WHERE Id =:userId AND ContactId != NULL];
        if(objUser.ContactId != null || objUser.ContactId != 'undefined'|| objUser.ContactId != NULL ){
            objContact = [SELECT Id,FirstName,LastName,Title,Email,Company_Affiliation__c,Department,MailingCity,MailingCountry FROM Contact WHERE Id=:objUser.ContactId];   
        }
        return objContact; 
    }
    @AuraEnabled
    public static String createProjectApplication(String projectName,String firstName,String surname,String jobTitle,String workEmail,String homeOfficeCity,String HomeOfficeCountry,String otherHomeOfficeCountry,String CompanyAffiliation,String BusinessUnitAA,String BusinessUnitDB,String otherBusinessUnitAA,String otherBusinessUnitDB){
        
        if(HomeOfficeCountry == NULL || HomeOfficeCountry == 'undefined' || HomeOfficeCountry == null){
            HomeOfficeCountry = otherHomeOfficeCountry;
        }
        if(BusinessUnitAA == NULL || BusinessUnitAA == 'undefined' || BusinessUnitAA == null){
            BusinessUnitAA = otherBusinessUnitAA;
        }
        if(BusinessUnitDB == NULL || BusinessUnitDB == 'undefined' || BusinessUnitDB == null){
            BusinessUnitDB = otherBusinessUnitDB;
        }
        Application_Survey_Form__c objASF = new Application_Survey_Form__c(
            Project_Name__c = projectName,
            Team_captain_First_Name__c = firstName,
            Team_captain_Last_Name__c = surname,
            Team_captain_Job_Title__c = jobTitle,
            Team_captain_Work_Email__c = workEmail,
            Team_captain_Home_Office_City__c = homeOfficeCity,
            Team_Captain_Home_Office_Country__c = HomeOfficeCountry,
            Organization_Country__c = HomeOfficeCountry,
            Home_Office_Country__c = HomeOfficeCountry,
            Team_Captain_Company_Affiliation__c = CompanyAffiliation,
            Team_Captain_BusUnitAnglo__c = BusinessUnitAA,
            Team_Captain_BusUnitDebeers__c = BusinessUnitDB,
            Submission_Status__c = 'In Progress',
            Grant_Use__c = 'No',
            Resubmission_Flag__c = 'No',
            Application_Cycle__c = '2022',
            Application_Round__c = 'A'
        );
        try{
            Database.insert(objASF);
            return objASF.Id;
        }catch (Exception e) {
            system.debug('e.getMessage +   '+e.getMessage());
            system.debug('e.getLineNumber +   '+e.getLineNumber());
            system.debug('e.getCause +   '+e.getCause());
            String Error = e.getMessage();
            return Error;
        }
        
    }
    @AuraEnabled
    public static String updateProjectApp(String projectName,String firstName,String surname,String jobTitle,String workEmail,String homeOfficeCity,String HomeOfficeCountry,String otherHomeOfficeCountry,String CompanyAffiliation,String BusinessUnitAA,String BusinessUnitDB,String otherBusinessUnitAA,String otherBusinessUnitDB,String projectApplicationId){
        List<Application_Survey_Form__c> lstASF  = new List<Application_Survey_Form__c>();
        List<Application_Survey_Form__c> lstUpdate = new List<Application_Survey_Form__c>();
        if(HomeOfficeCountry == NULL || HomeOfficeCountry == 'undefined' || HomeOfficeCountry == null){
            HomeOfficeCountry = otherHomeOfficeCountry;
        }
        if(BusinessUnitAA == NULL || BusinessUnitAA == 'undefined' || BusinessUnitAA == null){
            BusinessUnitAA = otherBusinessUnitAA;
        }
        if(BusinessUnitDB == NULL || BusinessUnitDB == 'undefined' || BusinessUnitDB == null){
            BusinessUnitDB = otherBusinessUnitDB;
        }
        if(projectApplicationId != NULL){
            lstASF = [SELECT Id,Project_Name__c,Team_captain_First_Name__c,Team_captain_Last_Name__c,Team_captain_Job_Title__c,Team_captain_Work_Email__c,Team_captain_Home_Office_City__c,Team_Captain_Home_Office_Country__c,Home_Office_Country__c,Team_Captain_Company_Affiliation__c,Team_Captain_BusUnitAnglo__c,Team_Captain_BusUnitDebeers__c FROM Application_Survey_Form__c WHERE Id=:projectApplicationId];
        }
        if(lstASF.size()>0){ 
            for(Application_Survey_Form__c objASF : lstASF){
                objASF.Project_Name__c = projectName;
                objASF.Team_captain_First_Name__c = firstName;
                objASF.Team_captain_Last_Name__c = surname;
                objASF.Team_captain_Job_Title__c = jobTitle;
                objASF.Team_captain_Work_Email__c = workEmail;
                objASF.Team_captain_Home_Office_City__c = homeOfficeCity;
                objASF.Team_Captain_Home_Office_Country__c = HomeOfficeCountry;
                objASF.Organization_Country__c = HomeOfficeCountry;
                objASF.Home_Office_Country__c = HomeOfficeCountry;
                objASF.Team_Captain_Company_Affiliation__c = CompanyAffiliation;
                objASF.Team_Captain_BusUnitAnglo__c = BusinessUnitAA;
                objASF.Team_Captain_BusUnitDebeers__c = BusinessUnitDB;
                lstUpdate.add(objASF);
            }
        }
        try{
            Database.update(lstUpdate);
            return projectApplicationId;
        }catch (Exception e) {
            system.debug('e.getMessage +   '+e.getMessage());
            system.debug('e.getLineNumber +   '+e.getLineNumber());
            system.debug('e.getCause +   '+e.getCause());
            String Error = e.getMessage();
            return Error;
        }
        
    }
    @AuraEnabled
    public static String updateLineManagerInfo(String fullName,String workEmailLM,String noOfTeamMember,String projectApplicationId){
        List<Application_Survey_Form__c> lstASF = new List<Application_Survey_Form__c>();
        List<Application_Survey_Form__c> lstUpdate = new List<Application_Survey_Form__c>();
        String result = 'Error';
        if(projectApplicationId != NULL){
            lstASF = [SELECT Id,Team_Captain_Line_Manager_Full_Name__c,Team_Captain_Line_Manager_Work_Email__c,Number_Of_Team_Members__c FROM Application_Survey_Form__c WHERE Id=:projectApplicationId];
        }
        if(lstASF.size()>0){
            for(Application_Survey_Form__c objASF : lstASF){
                objASF.Team_Captain_Line_Manager_Full_Name__c = fullName;
                objASF.Team_Captain_Line_Manager_Work_Email__c = workEmailLM;
                objASF.Number_Of_Team_Members__c = noOfTeamMember;
                lstUpdate.add(objASF);
            }   
        }
        try{
            if(lstUpdate.size()>0){
                Database.update(lstUpdate); 
                result = 'Success';  
            }
        }catch (Exception e) {
            system.debug('e.getMessage +   '+e.getMessage());
            system.debug('e.getLineNumber +   '+e.getLineNumber());
            system.debug('e.getCause +   '+e.getCause());
            String Error = e.getMessage();
            result = 'Error';
        }  
        return result;
    }
    @AuraEnabled
    public static String updateTeamMember1Info(String tm1FirstName,String tm1Surname,String tm1JobTitle,String tm1WorkEmail,String tm1HomeOfficeCity,String tm1HomeOfficeCountry,String tm1OtherHomeOfficeCountry,String tm1CompanyAffiliation,String tm1BusinessUnitAA,String tm1OtherBusinessUnitAA,String tm1BusinessUnitDB,String tm1OtherBusinessUnitBB,String tm1MfullName,String tm1MworkEmailLM,String projectApplicationId,String noOfTeamMember){
        if(tm1HomeOfficeCountry == NULL || tm1HomeOfficeCountry == 'undefined' || tm1HomeOfficeCountry == null){
            tm1HomeOfficeCountry = tm1OtherHomeOfficeCountry;
        }
        if(tm1BusinessUnitAA == NULL || tm1BusinessUnitAA == 'undefined' || tm1BusinessUnitAA == null){
            tm1BusinessUnitAA = tm1OtherBusinessUnitAA;
        }
        if(tm1BusinessUnitDB == NULL || tm1BusinessUnitDB == 'undefined' || tm1BusinessUnitDB == null){
            tm1BusinessUnitDB = tm1OtherBusinessUnitBB;
        }
        List<Application_Survey_Form__c> lstASF  = new List<Application_Survey_Form__c>();
        List<Application_Survey_Form__c> lstUpdate = new List<Application_Survey_Form__c>();
        String result = 'Error';
        if(projectApplicationId != NULL){
            lstASF = [SELECT Id,Team_Member_1_BusUnitAnglo__c,Team_Member_1_BusUnitDebeers__c,Team_Member_1_Company_Affiliation__c,Team_Member_1_First_Name__c,Team_Member_1_Home_Office_Country__c,Team_Member_1_Job_Title__c,Team_Member_1_Last_Name__c,Team_Member_1_Line_Manager_Full_Name__c,Team_Member_1_Line_Manager_Work_Email__c,Team_Member_1_Office_City__c,Team_Member_1_Work_Email__c FROM Application_Survey_Form__c WHERE Id=:projectApplicationId];
        }
        if(lstASF.size()>0){
            for(Application_Survey_Form__c objASF : lstASF){
                objASF.Team_Member_1_First_Name__c = tm1FirstName;
                objASF.Team_Member_1_Last_Name__c = tm1Surname;
                objASF.Team_Member_1_BusUnitAnglo__c = tm1BusinessUnitAA;
                objASF.Team_Member_1_BusUnitDebeers__c = tm1BusinessUnitDB;
                objASF.Team_Member_1_Company_Affiliation__c = tm1CompanyAffiliation;
                objASF.Team_Member_1_Office_City__c = tm1HomeOfficeCity;
                objASF.Team_Member_1_Home_Office_Country__c = tm1HomeOfficeCountry;
                objASF.Team_Member_1_Job_Title__c = tm1JobTitle;
                objASF.Team_Member_1_Line_Manager_Full_Name__c = tm1MfullName;
                objASF.Team_Member_1_Line_Manager_Work_Email__c = tm1MworkEmailLM;
                objASF.Team_Member_1_Work_Email__c =  tm1WorkEmail;
                lstUpdate.add(objASF);
            }   
        }
        try{
            if(lstUpdate.size()>0){
                Database.update(lstUpdate);
                result = 'Success';
            }
        }catch (Exception e) {
            system.debug('e.getMessage +   '+e.getMessage());
            system.debug('e.getLineNumber +   '+e.getLineNumber());
            system.debug('e.getCause +   '+e.getCause());
            String Error = e.getMessage();
            result = 'Error';
        }  
        return result;
    }
    @AuraEnabled
    public static String updateTeamMember2Info(String tm2FirstName,String tm2Surname,String tm2JobTitle,String tm2WorkEmail,String tm2HomeOfficeCity,String tm2HomeOfficeCountry,String tm2OtherHomeOfficeCountry,String tm2CompanyAffiliation,String tm2BusinessUnitAA,String tm2OtherBusinessUnitAA,String tm2BusinessUnitDB,String tm2OtherBusinessUnitDB,String tm2MfullName,String tm2MworkEmailLM,String projectApplicationId,String noOfTeamMember){
        if(tm2HomeOfficeCountry == NULL || tm2HomeOfficeCountry == 'undefined' || tm2HomeOfficeCountry == null){
            tm2HomeOfficeCountry = tm2OtherHomeOfficeCountry;
        }
        if(tm2BusinessUnitAA == NULL || tm2BusinessUnitAA == 'undefined' || tm2BusinessUnitAA == null){
            tm2BusinessUnitAA = tm2OtherBusinessUnitAA;
        }
        if(tm2BusinessUnitDB == NULL || tm2BusinessUnitDB == 'undefined' || tm2BusinessUnitDB == null){
            tm2BusinessUnitDB = tm2OtherBusinessUnitDB;
        }
        List<Application_Survey_Form__c> lstASF  = new List<Application_Survey_Form__c>();
        List<Application_Survey_Form__c> lstUpdate = new List<Application_Survey_Form__c>();
        String result = 'Error';
        if(projectApplicationId != NULL){
            lstASF = [SELECT Id,Team_Member_2_BusUnitAnglo__c,Team_Member_2_BusUnitDebeers__c,Team_Member_2_Company_Affiliation__c,Team_Member_2_First_Name__c,Team_Member_2_Home_Office_Country__c,Team_Member_2_Job_Title__c,Team_Member_2_Last_Name__c,Team_Member_2_Line_Manager_Full_Name__c,Team_Member_2_Line_Manager_Work_Email__c,Team_Member_2_Office_City__c,Team_Member_2_Work_Email__c FROM Application_Survey_Form__c WHERE Id=:projectApplicationId];
        }
        if(lstASF.size()>0){
            for(Application_Survey_Form__c objASF : lstASF){
                objASF.Team_Member_2_First_Name__c = tm2FirstName;
                objASF.Team_Member_2_Last_Name__c = tm2Surname;
                objASF.Team_Member_2_BusUnitAnglo__c = tm2BusinessUnitAA;
                objASF.Team_Member_2_BusUnitDebeers__c = tm2BusinessUnitDB;
                objASF.Team_Member_2_Office_City__c = tm2HomeOfficeCity;
                objASF.Team_Member_2_Company_Affiliation__c = tm2CompanyAffiliation;
                objASF.Team_Member_2_Home_Office_Country__c = tm2HomeOfficeCountry;
                objASF.Team_Member_2_Job_Title__c = tm2JobTitle;
                objASF.Team_Member_2_Line_Manager_Full_Name__c = tm2MfullName;
                objASF.Team_Member_2_Line_Manager_Work_Email__c = tm2MworkEmailLM;
                objASF.Team_Member_2_Work_Email__c =  tm2WorkEmail;
                lstUpdate.add(objASF);
            }   
        }
        try{
            if(lstUpdate.size()>0){
                Database.update(lstUpdate);
                result = 'Success';
            }
        }catch (Exception e) {
            system.debug('e.getMessage +   '+e.getMessage());
            system.debug('e.getLineNumber +   '+e.getLineNumber());
            system.debug('e.getCause +   '+e.getCause());
            String Error = e.getMessage();
            result = 'Error';
        }  
        return result;
    }
    @AuraEnabled
    public static String updateTeamMember3Info(String tm3FirstName,String tm3Surname,String tm3JobTitle,String tm3WorkEmail,String tm3HomeOfficeCity,String tm3HomeOfficeCountry,String tm3OtherHomeOfficeCountry,String tm3CompanyAffiliation,String tm3BusinessUnitAA,String tm3OtherBusinessUnitAA,String tm3BusinessUnitDB,String tm3OtherBusinessUnitDB,String tm3MfullName,String tm3MworkEmailLM,String projectApplicationId,String noOfTeamMember){
        if(tm3HomeOfficeCountry == NULL || tm3HomeOfficeCountry == 'undefined' || tm3HomeOfficeCountry == null){
            tm3HomeOfficeCountry = tm3OtherHomeOfficeCountry;
        }
        if(tm3BusinessUnitAA == NULL || tm3BusinessUnitAA == 'undefined' || tm3BusinessUnitAA== null){
            tm3BusinessUnitAA = tm3OtherBusinessUnitAA;
        }
        if(tm3BusinessUnitDB == NULL || tm3BusinessUnitDB == 'undefined' || tm3BusinessUnitDB == null){
            tm3BusinessUnitDB = tm3OtherBusinessUnitDB;
        }
        List<Application_Survey_Form__c> lstASF = new List<Application_Survey_Form__c>();
        List<Application_Survey_Form__c> lstUpdate = new List<Application_Survey_Form__c>();
        String result = 'Error';
        if(projectApplicationId != NULL){
            lstASF = [SELECT Id,Team_Member_3_BusUnitAnglo__c,Team_Member_3_BusUnitDebeers__c,Team_Member_3_Company_Affiliation__c,Team_Member_3_First_Name__c,Team_Member_3_Home_Office_Country__c,Team_Member_3_Job_Title__c,Team_Member_3_Last_Name__c,Team_Member_3_Line_Manager_Full_Name__c,Team_Member_3_Line_Manager_Work_Email__c,Team_Member_3_Office_City__c,Team_Member_3_Work_Email__c FROM Application_Survey_Form__c WHERE Id=:projectApplicationId];
        }
        if(lstASF.size()>0){
            for(Application_Survey_Form__c objASF : lstASF){
                objASF.Team_Member_3_First_Name__c = tm3FirstName;
                objASF.Team_Member_3_Last_Name__c = tm3Surname;
                objASF.Team_Member_3_BusUnitAnglo__c = tm3BusinessUnitAA;
                objASF.Team_Member_3_BusUnitDebeers__c = tm3BusinessUnitDB;
                objASF.Team_Member_3_Office_City__c = tm3HomeOfficeCity;
                objASF.Team_Member_3_Company_Affiliation__c = tm3CompanyAffiliation;
                objASF.Team_Member_3_Home_Office_Country__c = tm3HomeOfficeCountry;
                objASF.Team_Member_3_Job_Title__c = tm3JobTitle;
                objASF.Team_Member_3_Line_Manager_Full_Name__c = tm3MfullName;
                objASF.Team_Member_3_Line_Manager_Work_Email__c = tm3MworkEmailLM;
                objASF.Team_Member_3_Work_Email__c =  tm3WorkEmail;
                lstUpdate.add(objASF);
            }   
        }
        try{
            if(lstUpdate.size()>0){
                Database.update(lstUpdate);
                result = 'Success';
            }
        }catch (Exception e) {
            system.debug('e.getMessage +   '+e.getMessage());
            system.debug('e.getLineNumber +   '+e.getLineNumber());
            system.debug('e.getCause +   '+e.getCause());
            String Error = e.getMessage();
            result = 'Error';
        }  
        return result;
    }
    @AuraEnabled
    public static String updateTeamMember4Info(String tm4FirstName,String tm4Surname,String tm4JobTitle,String tm4WorkEmail,String tm4HomeOfficeCity,String tm4HomeOfficeCountry,String tm4OtherHomeOfficeCountry,String tm4CompanyAffiliation,String tm4BusinessUnitAA,String tm4OtherBusinessUnitAA,String tm4BusinessUnitDB,String tm4OtherBusinessUnitDB,String tm4MfullName,String tm4MworkEmailLM,String projectApplicationId,String noOfTeamMember){
        if(tm4HomeOfficeCountry == NULL || tm4HomeOfficeCountry == 'undefined' || tm4HomeOfficeCountry == null){
            tm4HomeOfficeCountry = tm4OtherHomeOfficeCountry;
        }
        if(tm4BusinessUnitAA == NULL || tm4BusinessUnitAA == 'undefined' || tm4BusinessUnitAA == null){
            tm4BusinessUnitAA = tm4OtherBusinessUnitAA;
        }
        if(tm4BusinessUnitDB == NULL || tm4BusinessUnitDB == 'undefined' || tm4BusinessUnitDB == null){
            tm4BusinessUnitDB = tm4OtherBusinessUnitDB;
        }
        List<Application_Survey_Form__c> lstASF  = new List<Application_Survey_Form__c>();
        List<Application_Survey_Form__c> lstUpdate = new List<Application_Survey_Form__c>();
        String result = 'Error';
        if(projectApplicationId != null){
            lstASF = [SELECT Id,Team_Member_4_BusUnitAnglo__c,Team_Member_4_BusUnitDebeers__c,Team_Member_4_Company_Affiliation__c,Team_Member_4_First_Name__c,Team_Member_4_Home_Office_Country__c,Team_Member_4_Job_Title__c,Team_Member_4_Last_Name__c,Team_Member_4_Line_Manager_Full_Name__c,Team_Member_4_Line_Manager_Work_Email__c,Team_Member_4_Office_City__c,Team_Member_4_Work_Email__c FROM Application_Survey_Form__c WHERE Id=:projectApplicationId];
        }
        if(lstASF.size()>0){
            for(Application_Survey_Form__c objASF : lstASF){
                objASF.Team_Member_4_First_Name__c = tm4FirstName;
                objASF.Team_Member_4_Last_Name__c = tm4Surname;
                objASF.Team_Member_4_BusUnitAnglo__c = tm4BusinessUnitAA;
                objASF.Team_Member_4_BusUnitDebeers__c = tm4BusinessUnitDB;
                objASF.Team_Member_4_Office_City__c = tm4HomeOfficeCity;
                objASF.Team_Member_4_Company_Affiliation__c = tm4CompanyAffiliation;
                objASF.Team_Member_4_Home_Office_Country__c = tm4HomeOfficeCountry;
                objASF.Team_Member_4_Job_Title__c = tm4JobTitle;
                objASF.Team_Member_4_Line_Manager_Full_Name__c = tm4MfullName;
                objASF.Team_Member_4_Line_Manager_Work_Email__c = tm4MworkEmailLM;
                objASF.Team_Member_4_Work_Email__c =  tm4WorkEmail;
                lstUpdate.add(objASF);
            }   
        }
        try{
            if(lstUpdate.size()>0){
                Database.update(lstUpdate); 
                result = 'Success';
            }
        }catch (Exception e) {
            system.debug('e.getMessage +   '+e.getMessage());
            system.debug('e.getLineNumber +   '+e.getLineNumber());
            system.debug('e.getCause +   '+e.getCause());
            String Error = e.getMessage();
            result = 'Error';
        }  
        return result;
    }
    @AuraEnabled
    public static String updateOrganizationAddress(String projectApplicationId,String isRegisteredEntity,String websiteURL,String fullOrgName,String participatedBefore,String street,String cityTown,String stateProvCountry,String postCode,String country,String otherCountry,String firstNamePOC,String surnamePOC,String titlePOC,String workEmailPOC,String phoneNumberPOC,String missionAndVision,List<String> sectorActivites,String otherSectorAC,String geographicCoverage,List<String> targetBeneficiaries,String otherTargetBenef,List<String> partnerOrgComm,String levelOfCommitment){
        if(country == null || country == 'undefined'){
            country = otherCountry;
        }
        if(otherSectorAC != null || otherSectorAC != 'undefined'){
            sectorActivites.add(otherSectorAC);
        }
        if(otherTargetBenef != null || otherTargetBenef != 'undefined'){
            targetBeneficiaries.add(otherTargetBenef);
        }
        for(Integer i=0;i<sectorActivites.size();i++){
            if(sectorActivites.get(i) == 'Other'){
                sectorActivites.remove(i);
            }
        }
        for(Integer i=0;i<targetBeneficiaries.size();i++){
            if(targetBeneficiaries.get(i) == 'Other'){
                targetBeneficiaries.remove(i);
            }
        }
        List<Application_Survey_Form__c> lstASF  = new List<Application_Survey_Form__c>();
        List<Application_Survey_Form__c> lstUpdate = new List<Application_Survey_Form__c>();
        String result = 'Error';
        if(projectApplicationId != NULL){
            lstASF = [SELECT Organization_Street__c,Organization_City_Town__c,Partner_Organisation_Communication__c,Organization_State_Province_Country__c,Organization_Post_Code__c,Organization_Country__c,Organization_Name__c,Organisation_Mission_and_Vision__c,Partner_organisation_Participated_before__c,Partner_Organisation_registered_entity__c,Contact_City__c,Contact_Phone_Number__c,Contact_First_Name__c,Contact_Last_Name__c,Organisation_Website__c,Contact_Work_Email__c,Contact_Title__c,Company_Affiliation__c,Contact_BusUnitAnglo__c,Contact_BusUnitDebeers__c,Target_Beneficiaries__c,Partner_Organisation_Sector_Activities__c FROM Application_Survey_Form__c WHERE Id=:projectApplicationId];
        }
        if(lstASF.size()>0){
            for(Application_Survey_Form__c objASF : lstASF){
                objASF.Organization_Street__c = street;
                objASF.Organization_City_Town__c = cityTown;
                objASF.Organization_State_Province_Country__c = stateProvCountry;
                objASF.Organization_Post_Code__c = postCode;
                objASF.Organization_Country__c = country;
                objASF.Organization_Name__c = fullOrgName;
                objASF.Organisation_Mission_and_Vision__c = missionAndVision;
                objASF.Partner_organisation_Participated_before__c = participatedBefore;
                objASF.Organisation_Website__c = websiteURL;
                objASF.Partner_Organisation_registered_entity__c = isRegisteredEntity;
                objASF.Contact_Phone_Number__c  = phoneNumberPOC;
                objASF.Contact_First_Name__c =  firstNamePOC;
                objASF.Contact_Last_Name__c = surnamePOC;
                objASF.Contact_Title__c = titlePOC;
                objASF.Contact_Work_Email__c = workEmailPOC;
                objASF.Partner_Organisation_Sector_Activities__c = String.join(sectorActivites, ';');
                objASF.Organization_Geographic_Coverage__c = geographicCoverage;
                objASF.Target_Beneficiaries__c = String.join(targetBeneficiaries, ';');
                objASF.Partner_Organisation_Communication__c = String.join(partnerOrgComm, ';');
                objASF.Level_of_Commitment__c = levelOfCommitment;
                lstUpdate.add(objASF);
            }
        }
        try{
            if(lstUpdate.size()>0){
                Database.update(lstUpdate);
                result = 'Success';
            }
        }catch (Exception e) {
            system.debug('e.getMessage +   '+e.getMessage());
            system.debug('e.getLineNumber +   '+e.getLineNumber());
            system.debug('e.getCause +   '+e.getCause());
            String Error = e.getMessage();
            result = 'Error';
        }  
        return result;
    } 
    @AuraEnabled
    public static String updateProjectInformation(String projectApplicationId,String projectObjective,String projectBackground,String activitesToObtain,String projectType,String corpSocialInvst,String otherSocialInvest,String projectSustainability,String teamSkills,String levelOfEffort,String teamDiversity,String projectBeneficiaries,String alignMiningPlan){
        system.debug('corpSocialInvst +   '+corpSocialInvst);
        system.debug('otherSocialInvest +   '+otherSocialInvest);
        if(corpSocialInvst == 'Other'){
            corpSocialInvst = otherSocialInvest;
            system.debug('corpSocialInvst +   '+corpSocialInvst);
        }
        List<Application_Survey_Form__c> lstASF  = new List<Application_Survey_Form__c>();
        List<Application_Survey_Form__c> lstUpdate = new List<Application_Survey_Form__c>();
        String result = 'Error';
        if(projectApplicationId != null){
            lstASF = [SELECT Project_Objective__c,Alignment_with_Sustainable_Mining_Plan__c,Project_Timeline__c,Project_Background__c,Activities_to_Obtain_Objective__c,Project_Type__c,Sustainability_Alignment__c,Team_Skills__c,Level_of_Effort__c,Team_Diversity__c,Project_Beneficiaries__c FROM Application_Survey_Form__c WHERE Id=:projectApplicationId];
        }
        if(lstASF.size()>0){
            for(Application_Survey_Form__c objASF : lstASF){
                objASF.Project_Objective__c = projectObjective;
                objASF.Project_Background__c = projectBackground;
                objASF.Activities_to_Obtain_Objective__c = activitesToObtain;
                objASF.Project_Type__c = projectType;
                objASF.Corporate_Social_Investment__c = corpSocialInvst;
                objASF.Project_Timeline__c = projectSustainability;
                objASF.Team_Skills__c = teamSkills;
                objASF.Level_of_Effort__c = levelOfEffort;
                objASF.Team_Diversity__c = teamDiversity;
                objASF.Project_Beneficiaries__c = projectBeneficiaries;
                objASF.Sustainability_Alignment__c = alignMiningPlan;
                lstUpdate.add(objASF);
            }
        }
        try{
            if(lstUpdate.size()>0){
                Database.update(lstUpdate);
                result = 'Success';
            }
        }catch (Exception e) {
            system.debug('e.getMessage +   '+e.getMessage());
            system.debug('e.getLineNumber +   '+e.getLineNumber());
            system.debug('e.getCause +   '+e.getCause());
            String Error = e.getMessage();
            result = 'Error';
        } 
        return result;
    }
    @AuraEnabled
    public static String updateGrantInfo(String projectApplicationId,String grantUse,String howMuchFunding,String grantNarrative){
        List<Application_Survey_Form__c> lstASF  = new List<Application_Survey_Form__c>();
        List<Application_Survey_Form__c> lstUpdate = new List<Application_Survey_Form__c>();
        String result = 'Error';
        if(projectApplicationId != NULL){
            lstASF = [SELECT Grant_Use__c,Grant_Amount__c,Grant_Narrative__c FROM Application_Survey_Form__c WHERE Id=:projectApplicationId];
        }
        if(lstASF.size()>0){
            for(Application_Survey_Form__c objASF : lstASF){
                objASF.Grant_Use__c = grantUse;
                objASF.Grant_Amount__c = howMuchFunding;
                objASF.Grant_Narrative__c = grantNarrative;
                lstUpdate.add(objASF);
            }
        }
        try{
            if(lstUpdate.size()>0){
                Database.update(lstUpdate);
                result = 'Success';
                
            }
            //return 'Success';     
        }catch (Exception e) {
            system.debug('e.getMessage +   '+e.getMessage());
            system.debug('e.getLineNumber +   '+e.getLineNumber());
            system.debug('e.getCause +   '+e.getCause());
            String Error = e.getMessage();
            result = 'Error';
        } 
        return result;
    }
    @AuraEnabled
    public static List<Application_Survey_Form__c> searchProjectApplicationByID(String recordId){
        System.debug('----Search Project Application Data----'+recordId);
        if(recordId != null){
            
            //Query All Fields of  Project Application
            DescribeSObjectResult describeResult = Application_Survey_Form__c.getSObjectType().getDescribe();  
            List<String> fieldNames = new List<String>( describeResult.fields.getMap().keySet() );  
            
            //SOQL to query the  Project Application with the given Id
            String query = 'SELECT '+String.join( fieldNames, ',') +' FROM ' +describeResult.getName() +' where Id =:recordId';
            List<Application_Survey_Form__c> projectApplicationList = Database.query( query );
            
            System.debug('---projectApplicationList---'+projectApplicationList);
            System.debug('---projectApplicationList---'+projectApplicationList.size());
            //retuning data
            if(projectApplicationList != null && projectApplicationList.size() > 0){
                return projectApplicationList;
            }
        }
        return null;
    }
}