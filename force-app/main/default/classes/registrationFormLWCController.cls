public without sharing class registrationFormLWCController {
    @AuraEnabled
    public static String checkWorkEmail(String email){
        String recordId;
        if(email != null){
            system.debug('lstConemailtact '+email);
            List<Contact> lstContact = [SELECT Id,FirstName,LastName,Department,Company_Affiliation__c,MailingCountry,AccountId,Alternative_Email__c,Email,MailingCity,Title FROM contact WHERE Email=:email OR Alternative_Email__c =:email];
            system.debug('lstContact'+lstContact);
            if(lstContact.size()>0){
                for(Contact con: lstContact){
                    recordId = con.Id;
                }
            }else{
                recordId ='No Contact Exists';
            }       
        }
        return recordId; 
    }  
    @AuraEnabled
    public static List<Contact> fetchContact(String email){
        List<Contact> lstContact;
        if(email != null){
            system.debug('fetchContact  email'+email);
            lstContact = [SELECT Id,FirstName,LastName,Department,Company_Affiliation__c,MailingCountry,Account.Name,Alternative_Email__c,Email,MailingCity,Title FROM contact WHERE Email=:email OR Alternative_Email__c =:email];
            system.debug('fetchContact lstContact'+lstContact);
        }
        return lstContact; 
    }
    
    @AuraEnabled
    public static String createUserAndContact(String FirstName,String SurName,String WorkEmail,String JobTitle, String MaillingCity,String UserName,String Password,String HomeOfficeCountry,String otherBusinessUnit,String CompanyAffiliation,String BusinessUnitAA,String BusinessUnitDB,String preferredLanguage){
        System.debug('username-> '+UserName);
        System.debug('WorkEmail-> '+WorkEmail);
        System.debug('FirstName-> '+FirstName);
        System.debug('SurName-> '+SurName);
        System.debug('Password-> '+Password);
        System.debug('otherBusinessUnit-> '+otherBusinessUnit);
        System.debug('BusinessUnitDB-> '+BusinessUnitDB);
        System.debug('BusinessUnitAA-> '+BusinessUnitAA);
        System.debug('preferredLanguage-> '+preferredLanguage);
        try{
            Id AccountId;
            String preferredLanguageLocaleKey;
            String preferredLocaleSidKey;
            List<Account> lstAccount;
            if(CompanyAffiliation != NULL || CompanyAffiliation != 'undefined' || CompanyAffiliation != null){
                lstAccount = [SELECT Id, Name FROM Account WHERE Name =:CompanyAffiliation Order by CreatedDate desc limit 1];
                system.debug('<---CompanyAffiliation---> '+CompanyAffiliation);
                system.debug('<---lstAccount---> '+lstAccount);
                if(lstAccount.size()>0){
                    AccountId = lstAccount[0].Id;
                    system.debug('<---AccountId---> '+AccountId);
                }
                
            }
            if(SurName != null){
                Contact objCon = new Contact();
                objCon.AccountId = AccountId;
                objCon.FirstName = FirstName;
                objCon.LastName = SurName;
                objCon.Email = WorkEmail;
                objCon.Title = JobTitle;
                objCon.MailingCity = MaillingCity;
                //objCon.Alternative_Email__c = AlternativeEmail;
                objCon.MailingCountry = HomeOfficeCountry;
                objCon.Company_Affiliation__c = CompanyAffiliation;
                if(BusinessUnitAA != null && otherBusinessUnit == null && BusinessUnitDB == null){
                    objCon.Department = BusinessUnitAA;
                    system.debug('<--- objCon.Department ---> '+ objCon.Department );
                }else if(BusinessUnitDB != null && otherBusinessUnit == null && BusinessUnitAA == null){
                    objCon.Department = BusinessUnitDB;
                    system.debug('<--- objCon.Department else if ---> '+ objCon.Department );
                }else{
                    objCon.Department = otherBusinessUnit;
                    system.debug('<--- objCon.Department else ---> '+ objCon.Department );
                } 
                Insert objCon;
                if(preferredLanguage != null || preferredLanguage != 'undefined'){
                    if(preferredLanguage == 'en_GB'){
                        preferredLocaleSidKey = 'en_GB';
                        preferredLanguageLocaleKey = 'en_US';
                    }else if(preferredLanguage == 'es'){
                        preferredLocaleSidKey = 'es';  
                        preferredLanguageLocaleKey = 'es';
                    }else if(preferredLanguage == 'pt_BR'){
                        preferredLocaleSidKey = 'pt_BR'; 
                        preferredLanguageLocaleKey = 'pt_BR';
                    }else{
                        preferredLocaleSidKey = 'en_US';  
                        preferredLanguageLocaleKey = 'en_US';
                    }
                }
                if(UserName == 'undefined' || UserName == '' || UserName == NULL){
                    UserName = WorkEmail;
                    //calling future method to create Community User
                    registrationFormLWCController.createCommunityUser(UserName,WorkEmail,preferredLocaleSidKey,preferredLanguageLocaleKey,FirstName,SurName,objCon.Id,AccountId,Password);
                }else{
                    //calling future method to create Community User
                    registrationFormLWCController.createCommunityUser(UserName,WorkEmail,preferredLocaleSidKey,preferredLanguageLocaleKey,FirstName,SurName,objCon.Id,AccountId,Password);
                }
            }
        } catch (Exception e) {
            system.debug('e.getMessage+   '+e.getMessage());
            system.debug('e.getLineNumber+   '+e.getLineNumber());
            system.debug('e.getCause+   '+e.getCause());
            String Error = e.getMessage();
            return Error;
        }
        return 'login';
    }
    @AuraEnabled
    public static String updateContactAndCreateUser(String FirstName,String SurName,String WorkEmail,String JobTitle, String MaillingCity,String UserName,String Password,String HomeOfficeCountry,String otherBusinessUnit,String CompanyAffiliation,String BusinessUnitAA,String BusinessUnitDB,String preferredLanguageCF,String conId){       
        try{
            system.debug('<---conId---> '+conId);
            Id AccoundID;
            List<Contact> updateContact;
            List<Contact> lstupdate = new List<Contact>();
            List<Account> lstAccount;
            String preferredLanguageLocaleKey;
            String preferredLocaleSidKey;
            
            if(CompanyAffiliation != NULL || CompanyAffiliation != 'undefined' || CompanyAffiliation != null){
                lstAccount = [SELECT Id, Name FROM Account WHERE Name =:CompanyAffiliation Order by CreatedDate desc limit 1];
                system.debug('<---CompanyAffiliation---> '+CompanyAffiliation);
                system.debug('<---lstAccount---> '+lstAccount);
                if(lstAccount.size()>0){
                    AccoundID = lstAccount[0].Id;
                    system.debug('<---AccoundID---> '+AccoundID);
                }
                
            }
            if(conId != NULL || conId != 'undefined'){
                system.debug('<---conId ---> '+conId);
                updateContact = [SELECT Id,FirstName,LastName,Department,Company_Affiliation__c,MailingCountry,Account.Name,Alternative_Email__c,Email,MailingCity,Title FROM contact WHERE Id=:conId];
                system.debug('<---updateContact ---> '+updateContact);
                for(Contact con:updateContact){
                    if(FirstName != null){
                        con.FirstName = FirstName;
                    }if(SurName != null){
                        con.LastName = SurName;
                    }if(CompanyAffiliation != null){
                        con.AccountId = AccoundID;
                    }if(WorkEmail != null){
                        con.Email = WorkEmail;
                    }if(JobTitle != null){
                        con.Title = JobTitle;
                    }if(MaillingCity != null){
                        con.MailingCity = MaillingCity;
                        /*}if(AlternativeEmail != null){
con.Alternative_Email__c = AlternativeEmail;*/
                    }if(HomeOfficeCountry != null){
                        con.MailingCountry = HomeOfficeCountry;
                    }if(CompanyAffiliation != null){
                        con.Company_Affiliation__c = CompanyAffiliation;
                    }if(BusinessUnitAA != null && otherBusinessUnit == null && BusinessUnitDB == null){
                        con.Department = BusinessUnitAA;
                    }else if(BusinessUnitDB != null && otherBusinessUnit == null && BusinessUnitAA == null){
                        con.Department = BusinessUnitDB;
                    }else{
                        con.Department = otherBusinessUnit;
                    } 
                    lstupdate.add(con);
                    system.debug('<---lstupdate---> '+lstupdate);
                }
            }
            if(lstupdate.size()>0){
                update lstupdate; 
                system.debug('<---lstupdate---> '+lstupdate);
            }
            if(preferredLanguageCF != null || preferredLanguageCF != 'undefined'){
                if(preferredLanguageCF == 'en_GB'){
                    preferredLocaleSidKey = 'en_GB';
                    preferredLanguageLocaleKey = 'en_US';
                }else if(preferredLanguageCF == 'es'){
                    preferredLocaleSidKey = 'es';  
                    preferredLanguageLocaleKey = 'es';
                }else if(preferredLanguageCF == 'pt_BR'){
                    preferredLocaleSidKey = 'pt_BR';  
                    preferredLanguageLocaleKey = 'pt_BR';
                }else{
                    preferredLocaleSidKey = 'en_US'; 
                    preferredLanguageLocaleKey = 'en_US';
                }
            }
            if(UserName == 'undefined' || UserName == '' || UserName == NULL){
                UserName = WorkEmail;
                //calling future method to create Community User
                registrationFormLWCController.createCommunityUser(UserName,WorkEmail,preferredLocaleSidKey,preferredLanguageLocaleKey,FirstName,SurName,conId,AccoundID,Password);
            }else{
                //calling future method to create Community User
                registrationFormLWCController.createCommunityUser(UserName,WorkEmail,preferredLocaleSidKey,preferredLanguageLocaleKey,FirstName,SurName,conId,AccoundID,Password);
            }
            
        }catch (Exception e) {
            system.debug('e.getMessage+   '+e.getMessage());
            system.debug('e.getLineNumber+   '+e.getLineNumber());
            system.debug('e.getCause+   '+e.getCause());
            String Error = e.getMessage();
            return Error;
        }
        return 'login';
    }
    @future
    public static void createCommunityUser(String username,String email,String preferredLocaleSidKey,String preferredLanguageLocaleKey,String firstName,String lastName,Id conId,Id AccId,String Password){
        System.debug('username-> '+username);
        System.debug('email-> '+email);
        System.debug('firstName-> '+firstName);
        System.debug('lastName-> '+lastName);
        System.debug('conId-> '+conId);
        System.debug('Password-> '+Password);
        try{
            List<User> lstUser = [SELECT Id, Name FROM USER WHERE ContactId =:conId];
            List<User> updateUser = new List<User>();
            String TimeZoneSidKeyUsr;
            if(preferredLocaleSidKey != null || preferredLocaleSidKey != 'undefined'){
                if(preferredLocaleSidKey == 'en_GB'){
                    TimeZoneSidKeyUsr='America/Danmarkshavn';
                }else if(preferredLocaleSidKey == 'es'){
                    TimeZoneSidKeyUsr='Europe/Madrid';
                }else if(preferredLocaleSidKey == 'pt_BR'){
                    TimeZoneSidKeyUsr='America/Araguaina';
                }else{
                    TimeZoneSidKeyUsr='America/Los_Angeles';
                }
            }
            
            Set<String> communityNicknameSet = new Set<String>();
            for(User usr : [Select Id, CommunityNickname From User Where CommunityNickname != null]){
                communityNicknameSet.add(usr.CommunityNickname);
            }
            String uniqueCommunityNickName;
            if(communityNicknameSet.isEmpty()){
                if(firstName.length() > 4){  
                    uniqueCommunityNickName = firstName.substring(0, 2)+ lastName.substring(0, 1) + String.valueOf( Integer.valueOf(Math.random() * 10000) );
                } else {
                    uniqueCommunityNickName = firstName + String.valueOf( Integer.valueOf(Math.random() * 10000) );
                }
            } else {
                for(Integer i=1; i <= 9999 ; i++){
                    if(firstName.length() > 4){     
                        uniqueCommunityNickName = firstName.substring(0, 2)+ lastName.substring(0, 1)+String.valueOf( Integer.valueOf(Math.random() * 10000) );
                    } else {
                        uniqueCommunityNickName = firstName + String.valueOf( Integer.valueOf(Math.random() * 10000) );
                    }
                    if(!communityNicknameSet.contains(uniqueCommunityNickName)){
                        break;
                    }
                }
            }
            Profile profile1 = [Select Id from Profile where name = 'Custom Customer Community Plus Login User'];
            if(lstUser.size() == 0){
                //UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
                User portalAccountOwner1 = new User(
                    //UserRoleId = portalRole.Id,
                    ProfileId = profile1.Id,
                    ContactId = conId,
                    Username = username,
                    Alias = uniqueCommunityNickName,
                    Email= email,
                    EmailEncodingKey='UTF-8',
                    Firstname= firstName,
                    Lastname= lastName,
                    LanguageLocaleKey= preferredLanguageLocaleKey,
                    LocaleSidKey= preferredLocaleSidKey,
                    TimeZoneSidKey= TimeZoneSidKeyUsr
                );
                string userId='';
                Database.insert(portalAccountOwner1);
                System.setPassword(portalAccountOwner1.id, password);
            }else if(lstUser.size()>0){
                String userIdExists;
                for(User objUsr:lstUser){
                    userIdExists = objUsr.Id;
                    objUsr.ProfileId = profile1.Id;
                    objUsr.Email= email;
                    objUsr.Username = username;
                    objUsr.FirstName = firstName;
                    objUsr.LastName = lastName;
                    objUsr.ContactId = conId;
                    objUsr.LocaleSidKey = preferredLocaleSidKey;
                    objUsr.LanguageLocaleKey = preferredLanguageLocaleKey;
                    objUsr.TimeZoneSidKey = TimeZoneSidKeyUsr;
                    updateUser.add(objUsr);
                }
                if(updateUser.size()>0){
                    Update updateUser;
                    System.setPassword(userIdExists, password);
                }
                
            }
            
        } catch (Exception e) {
            system.debug('e.getMessage+   '+e.getMessage());
            system.debug('e.getLineNumber+   '+e.getLineNumber());
            system.debug('e.getCause+   '+e.getCause());
            String Error = e.getMessage();
        }
    }
    @AuraEnabled
    public static List<User> findUser(String ContactId){
        List<User> lstUsers;
        if(ContactId != null || ContactId != 'undefined'){
            lstUsers =[SELECT LocaleSidKey FROM User WHERE ContactId=:ContactId limit 1];
        }
        return lstUsers;
    }
    @AuraEnabled
    public static List<User> checkUserName(String UserName){
        List<User> lstUsers;
        if(UserName != null || UserName != 'undefined'){
            lstUsers =[SELECT UserName FROM User WHERE Username=:UserName limit 1];
        }
        return lstUsers;
    }
}