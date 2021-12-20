@isTest
public class TestPG_ApplicationGrantReqBatchClass {

    //All data found
    @isTest
    public static void TestMethod1(){
        
        account acc=new account() ;
        acc.Name='Test orgName';
        acc.Mission_and_Vision_Statement__c='mission and vission';
        acc.Founding_Year__c='0000';
        acc.Geographic_Coverage__c='coverage';
        acc.Registered_Entity__c='entity';
        acc.Necessary_Documents__c='necessary';
        acc.Target_Clients_or_Beneficiaries__c = 'targetBeneficiaries';
        acc.Sector_Activities__c = 'partnerActivities';
        acc.BillingCity = 'town';
        acc.BillingCountry = 'country';
        acc.BillingPostalCode = 'postCode';
        acc.BillingState = 'state';
        acc.BillingStreet = 'street';
        insert acc;
        
        Projects__c proj = new Projects__c();
        proj.Name = 'Test Proj Title';
        insert proj;
        
        Contact con = new contact();
        con.FirstName = 'Test first name';
        con.LastName = 'Test last name';
        con.Email = 'Test@test.com';
        con.AccountId = acc.Id;
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'Test capName';
        con1.LastName = 'Test CapLast';
        con1.Email = 'Test1@test.com';
        con1.AccountId = acc.Id;
        insert con1;
        
        Grant_Request__c grantReqObj = new Grant_Request__c(Grant_Request_Name__c = 'Test orgName-Test Proj Title',Organization__c = acc.Id,Project__c=proj.Id);
        insert grantReqObj;
       CreateAppGrantReq();
       
    }
    
    //Project data missing
     @isTest
    public static void TestMethod2(){
        account acc=new account() ;
        acc.Name='Test orgName';
        acc.Mission_and_Vision_Statement__c='mission and vission';
        acc.Founding_Year__c='0000';
        acc.Geographic_Coverage__c='coverage';
        acc.Registered_Entity__c='entity';
        acc.Necessary_Documents__c='necessary';
        acc.Target_Clients_or_Beneficiaries__c = 'targetBeneficiaries';
        acc.Sector_Activities__c = 'partnerActivities';
        acc.BillingCity = 'town';
        acc.BillingCountry = 'country';
        acc.BillingPostalCode = 'postCode';
        acc.BillingState = 'state';
        acc.BillingStreet = 'street';
        insert acc;
        
        CreateAppGrantReq();
       
    }
    
    //Contact Data missing
    @isTest
    public static void TestMethod3(){
        account acc=new account() ;
        acc.Name='Test orgName';
        acc.Mission_and_Vision_Statement__c='mission and vission';
        acc.Founding_Year__c='0000';
        acc.Geographic_Coverage__c='coverage';
        acc.Registered_Entity__c='entity';
        acc.Necessary_Documents__c='necessary';
        acc.Target_Clients_or_Beneficiaries__c = 'targetBeneficiaries';
        acc.Sector_Activities__c = 'partnerActivities';
        acc.BillingCity = 'town';
        acc.BillingCountry = 'country';
        acc.BillingPostalCode = 'postCode';
        acc.BillingState = 'state';
        acc.BillingStreet = 'street';
        insert acc;
        
        Projects__c proj = new Projects__c();
        proj.Name = 'Test Proj Title';
        insert proj;
       
       CreateAppGrantReq();
       
    }
    
    //Team captain data missing
    @isTest
    public static void TestMethod4(){
        account acc=new account() ;
        acc.Name='Test orgName';
        acc.Mission_and_Vision_Statement__c='mission and vission';
        acc.Founding_Year__c='0000';
        acc.Geographic_Coverage__c='coverage';
        acc.Registered_Entity__c='entity';
        acc.Necessary_Documents__c='necessary';
        acc.Target_Clients_or_Beneficiaries__c = 'targetBeneficiaries';
        acc.Sector_Activities__c = 'partnerActivities';
        acc.BillingCity = 'town';
        acc.BillingCountry = 'country';
        acc.BillingPostalCode = 'postCode';
        acc.BillingState = 'state';
        acc.BillingStreet = 'street';
        insert acc;
        
        Projects__c proj = new Projects__c();
        proj.Name = 'Test Proj Title';
        insert proj;
        
        Contact con = new contact();
        con.FirstName = 'Test first name';
        con.LastName = 'Test last name';
        con.Email = 'Test@test.com';
        con.AccountId = acc.Id;
        insert con;
        
       CreateAppGrantReq();
       
    }
    
    //Account Missing
    @isTest
    public static void TestMethod5(){
       CreateAppGrantReq();
       
    }
    
    //Different contact's account
    @isTest
    public static void TestMethod6(){
        account acc=new account() ;
        acc.Name='Test orgName';
        acc.Mission_and_Vision_Statement__c='mission and vission';
        acc.Founding_Year__c='0000';
        acc.Geographic_Coverage__c='coverage';
        acc.Registered_Entity__c='entity';
        acc.Necessary_Documents__c='necessary';
        acc.Target_Clients_or_Beneficiaries__c = 'targetBeneficiaries';
        acc.Sector_Activities__c = 'partnerActivities';
        acc.BillingCity = 'town';
        acc.BillingCountry = 'country';
        acc.BillingPostalCode = 'postCode';
        acc.BillingState = 'state';
        acc.BillingStreet = 'street';
        insert acc;
        
        Projects__c proj = new Projects__c();
        proj.Name = 'Test Proj Title';
        insert proj;
        
        account acc2 = new Account(Name= 'test');
        insert acc2;
        
        Contact con = new contact();
        con.FirstName = 'Test first name';
        con.LastName = 'Test last name';
        con.Email = 'Test@test.com';
        con.AccountId = acc2.Id;
        insert con;
       CreateAppGrantReq();
       
    }
    
    //Contact not active
    @isTest
    public static void TestMethod7(){
        account acc=new account() ;
        acc.Name='Test orgName';
        acc.Mission_and_Vision_Statement__c='mission and vission';
        acc.Founding_Year__c='0000';
        acc.Geographic_Coverage__c='coverage';
        acc.Registered_Entity__c='entity';
        acc.Necessary_Documents__c='necessary';
        acc.Target_Clients_or_Beneficiaries__c = 'targetBeneficiaries';
        acc.Sector_Activities__c = 'partnerActivities';
        acc.BillingCity = 'town';
        acc.BillingCountry = 'country';
        acc.BillingPostalCode = 'postCode';
        acc.BillingState = 'state';
        acc.BillingStreet = 'street';
        insert acc;
        
        Projects__c proj = new Projects__c();
        proj.Name = 'Test Proj Title';
        insert proj;
        
        Contact con = new contact();
        con.FirstName = 'Test first name';
        con.LastName = 'Test last name';
        con.Email = 'Test@test.com';
        con.AccountId = acc.Id;
        con.notActive__c = true;
        insert con;
       CreateAppGrantReq();
       
    }
    
    //contact with different email
    @isTest
    public static void TestMethod8(){
        account acc=new account() ;
        acc.Name='Test orgName';
        acc.Mission_and_Vision_Statement__c='mission and vission';
        acc.Founding_Year__c='0000';
        acc.Geographic_Coverage__c='coverage';
        acc.Registered_Entity__c='entity';
        acc.Necessary_Documents__c='necessary';
        acc.Target_Clients_or_Beneficiaries__c = 'targetBeneficiaries';
        acc.Sector_Activities__c = 'partnerActivities';
        acc.BillingCity = 'town';
        acc.BillingCountry = 'country';
        acc.BillingPostalCode = 'postCode';
        acc.BillingState = 'state';
        acc.BillingStreet = 'street';
        insert acc;
        
        Projects__c proj = new Projects__c();
        proj.Name = 'Test Proj Title';
        insert proj;
        
        Contact con = new contact();
        con.FirstName = 'Test first name';
        con.LastName = 'Test last name';
        con.Email = 'Test2@test.com';
        con.AccountId = acc.Id;
        con.notActive__c = true;
        insert con;
       CreateAppGrantReq();
       
    }
    
    //contact with different name
    @isTest
    public static void TestMethod13(){
        account acc=new account() ;
        acc.Name='Test orgName';
        acc.Mission_and_Vision_Statement__c='mission and vission';
        acc.Founding_Year__c='0000';
        acc.Geographic_Coverage__c='coverage';
        acc.Registered_Entity__c='entity';
        acc.Necessary_Documents__c='necessary';
        acc.Target_Clients_or_Beneficiaries__c = 'targetBeneficiaries';
        acc.Sector_Activities__c = 'partnerActivities';
        acc.BillingCity = 'town';
        acc.BillingCountry = 'country';
        acc.BillingPostalCode = 'postCode';
        acc.BillingState = 'state';
        acc.BillingStreet = 'street';
        insert acc;
        
        Projects__c proj = new Projects__c();
        proj.Name = 'Test Proj Title';
        insert proj;
        
        Contact con = new contact();
        con.FirstName = 'Test first name';
        con.LastName = 'Test last name111';
        con.Email = 'Test@test.com';
        con.AccountId = acc.Id;
        con.notActive__c = true;
        insert con;
       CreateAppGrantReq();
       
    }
    
    //Team captain with different email
    @isTest
    public static void TestMethod9(){
        account acc=new account() ;
        acc.Name='Test orgName';
        acc.Mission_and_Vision_Statement__c='mission and vission';
        acc.Founding_Year__c='0000';
        acc.Geographic_Coverage__c='coverage';
        acc.Registered_Entity__c='entity';
        acc.Necessary_Documents__c='necessary';
        acc.Target_Clients_or_Beneficiaries__c = 'targetBeneficiaries';
        acc.Sector_Activities__c = 'partnerActivities';
        acc.BillingCity = 'town';
        acc.BillingCountry = 'country';
        acc.BillingPostalCode = 'postCode';
        acc.BillingState = 'state';
        acc.BillingStreet = 'street';
        insert acc;
        
        Projects__c proj = new Projects__c();
        proj.Name = 'Test Proj Title';
        insert proj;
        
        Contact con = new contact();
        con.FirstName = 'Test first name';
        con.LastName = 'Test last name';
        con.Email = 'Test@test.com';
        con.AccountId = acc.Id;
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'Test capName';
        con1.LastName = 'Test CapLast';
        con1.Email = 'Test3@test.com';
        con1.AccountId = acc.Id;
        insert con1;
       CreateAppGrantReq();
       
    }
    
    //Team captain with different name
    @isTest
    public static void TestMethod10(){
        account acc=new account() ;
        acc.Name='Test orgName';
        acc.Mission_and_Vision_Statement__c='mission and vission';
        acc.Founding_Year__c='0000';
        acc.Geographic_Coverage__c='coverage';
        acc.Registered_Entity__c='entity';
        acc.Necessary_Documents__c='necessary';
        acc.Target_Clients_or_Beneficiaries__c = 'targetBeneficiaries';
        acc.Sector_Activities__c = 'partnerActivities';
        acc.BillingCity = 'town';
        acc.BillingCountry = 'country';
        acc.BillingPostalCode = 'postCode';
        acc.BillingState = 'state';
        acc.BillingStreet = 'street';
        insert acc;
        
        Projects__c proj = new Projects__c();
        proj.Name = 'Test Proj Title';
        insert proj;
        
        Contact con = new contact();
        con.FirstName = 'Test first name';
        con.LastName = 'Test last name';
        con.Email = 'Test@test.com';
        con.AccountId = acc.Id;
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'Test capName';
        con1.LastName = 'Test CapLast1111';
        con1.Email = 'Test1@test.com';
        con1.AccountId = acc.Id;
        insert con1;
       CreateAppGrantReq();
       
    }
    
    //Team captain not active
    @isTest
    public static void TestMethod11(){
        account acc=new account() ;
        acc.Name='Test orgName';
        acc.Mission_and_Vision_Statement__c='mission and vission';
        acc.Founding_Year__c='0000';
        acc.Geographic_Coverage__c='coverage';
        acc.Registered_Entity__c='entity';
        acc.Necessary_Documents__c='necessary';
        acc.Target_Clients_or_Beneficiaries__c = 'targetBeneficiaries';
        acc.Sector_Activities__c = 'partnerActivities';
        acc.BillingCity = 'town';
        acc.BillingCountry = 'country';
        acc.BillingPostalCode = 'postCode';
        acc.BillingState = 'state';
        acc.BillingStreet = 'street';
        insert acc;
        
        Projects__c proj = new Projects__c();
        proj.Name = 'Test Proj Title';
        insert proj;
        
        Contact con = new contact();
        con.FirstName = 'Test first name';
        con.LastName = 'Test last name';
        con.Email = 'Test@test.com';
        con.AccountId = acc.Id;
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'Test capName';
        con1.LastName = 'Test CapLast';
        con1.Email = 'Test1@test.com';
        con1.AccountId = acc.Id;
        con1.notActive__c = true;
        insert con1;
       CreateAppGrantReq();
       
    }
    
    //Grant req data missing
    @isTest
    public static void TestMethod12(){
        account acc=new account() ;
        acc.Name='Test orgName';
        acc.Mission_and_Vision_Statement__c='mission and vission';
        acc.Founding_Year__c='0000';
        acc.Geographic_Coverage__c='coverage';
        acc.Registered_Entity__c='entity';
        acc.Necessary_Documents__c='necessary';
        acc.Target_Clients_or_Beneficiaries__c = 'targetBeneficiaries';
        acc.Sector_Activities__c = 'partnerActivities';
        acc.BillingCity = 'town';
        acc.BillingCountry = 'country';
        acc.BillingPostalCode = 'postCode';
        acc.BillingState = 'state';
        acc.BillingStreet = 'street';
        insert acc;
        
        Projects__c proj = new Projects__c();
        proj.Name = 'Test Proj Title';
        insert proj;
        
        Contact con = new contact();
        con.FirstName = 'Test first name';
        con.LastName = 'Test last name';
        con.Email = 'Test@test.com';
        con.AccountId = acc.Id;
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'Test capName';
        con1.LastName = 'Test CapLast';
        con1.Email = 'Test1@test.com';
        con1.AccountId = acc.Id;
        insert con1;
       CreateAppGrantReq();
       
    }
    
    //Duplicate account data
    @isTest
    public static void TestMethod14(){
        account acc=new account() ;
        acc.Name='Test orgName';
        acc.Mission_and_Vision_Statement__c='mission and vission';
        acc.Founding_Year__c='0000';
        acc.Geographic_Coverage__c='coverage';
        acc.Registered_Entity__c='entity';
        acc.Necessary_Documents__c='necessary';
        acc.Target_Clients_or_Beneficiaries__c = 'targetBeneficiaries';
        acc.Sector_Activities__c = 'partnerActivities';
        acc.BillingCity = 'town';
        acc.BillingCountry = 'country';
        acc.BillingPostalCode = 'postCode';
        acc.BillingState = 'state';
        acc.BillingStreet = 'street';
        insert acc;
        
        account acc1=new account() ;
        acc1.Name='1Test orgName';
        insert acc1;
        
       CreateAppGrantReq();
       
    }
    
    //Duplicate project data
    @isTest
    public static void TestMethod15(){
        account acc=new account() ;
        acc.Name='Test orgName';
        acc.Mission_and_Vision_Statement__c='mission and vission';
        acc.Founding_Year__c='0000';
        acc.Geographic_Coverage__c='coverage';
        acc.Registered_Entity__c='entity';
        acc.Necessary_Documents__c='necessary';
        acc.Target_Clients_or_Beneficiaries__c = 'targetBeneficiaries';
        acc.Sector_Activities__c = 'partnerActivities';
        acc.BillingCity = 'town';
        acc.BillingCountry = 'country';
        acc.BillingPostalCode = 'postCode';
        acc.BillingState = 'state';
        acc.BillingStreet = 'street';
        insert acc;
        
        Projects__c proj = new Projects__c();
        proj.Name = 'Test Proj Title';
        insert proj;
        Projects__c proj1 = new Projects__c();
        proj1.Name = 'Test Proj Title';
        insert proj1;
        
       CreateAppGrantReq();
       
    }
    
    //Duplicate contact data
    @isTest
    public static void TestMethod16(){
        account acc=new account() ;
        acc.Name='Test orgName';
        acc.Mission_and_Vision_Statement__c='mission and vission';
        acc.Founding_Year__c='0000';
        acc.Geographic_Coverage__c='coverage';
        acc.Registered_Entity__c='entity';
        acc.Necessary_Documents__c='necessary';
        acc.Target_Clients_or_Beneficiaries__c = 'targetBeneficiaries';
        acc.Sector_Activities__c = 'partnerActivities';
        acc.BillingCity = 'town';
        acc.BillingCountry = 'country';
        acc.BillingPostalCode = 'postCode';
        acc.BillingState = 'state';
        acc.BillingStreet = 'street';
        insert acc;
        
        Projects__c proj = new Projects__c();
        proj.Name = 'Test Proj Title';
        insert proj;
        
        Contact con = new contact();
        con.FirstName = 'Test first name';
        con.LastName = 'Test last name';
        con.Email = 'Test3@test.com';
        con.AccountId = acc.Id;
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'Test first name';
        con1.LastName = 'Test last name111';
        con1.Email = 'Test13@test.com';
        con1.AccountId = acc.Id;
        insert con1;
       CreateAppGrantReq();
       
    }
    
    //Duplicate team data
    @isTest
    public static void TestMethod17(){
        account acc=new account() ;
        acc.Name='Test orgName';
        acc.Mission_and_Vision_Statement__c='mission and vission';
        acc.Founding_Year__c='0000';
        acc.Geographic_Coverage__c='coverage';
        acc.Registered_Entity__c='entity';
        acc.Necessary_Documents__c='necessary';
        acc.Target_Clients_or_Beneficiaries__c = 'targetBeneficiaries';
        acc.Sector_Activities__c = 'partnerActivities';
        acc.BillingCity = 'town';
        acc.BillingCountry = 'country';
        acc.BillingPostalCode = 'postCode';
        acc.BillingState = 'state';
        acc.BillingStreet = 'street';
        insert acc;
        
        Projects__c proj = new Projects__c();
        proj.Name = 'Test Proj Title';
        insert proj;
        
        Contact con = new contact();
        con.FirstName = 'Test first name';
        con.LastName = 'Test last name';
        con.Email = 'Test@test.com';
        con.AccountId = acc.Id;
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'Test capName';
        con1.LastName = 'Test CapLast';
        con1.Email = 'Test12@test.com';
        con1.AccountId = acc.Id;
        insert con1;
        
        Contact con2 = new contact();
        con2.FirstName = 'Test capName';
        con2.LastName = 'Test CapLast111';
        con2.Email = 'Test13@test.com';
        con2.AccountId = acc.Id;
        insert con2;
       CreateAppGrantReq();
       
    }
    
    
    //All data found
    @isTest
    public static void TestMethod18(){
        account acc=new account() ;
        acc.Name='Test orgName';
        acc.Mission_and_Vision_Statement__c='mission and vission';
        acc.Founding_Year__c='0000';
        acc.Geographic_Coverage__c='coverage';
        acc.Registered_Entity__c='entity';
        acc.Necessary_Documents__c='necessary';
        acc.Target_Clients_or_Beneficiaries__c = 'targetBeneficiaries';
        acc.Sector_Activities__c = 'partnerActivities';
        acc.BillingCity = 'town';
        acc.BillingCountry = 'country';
        acc.BillingPostalCode = 'postCode';
        acc.BillingState = 'state';
        acc.BillingStreet = 'street';
        insert acc;
        
        Projects__c proj = new Projects__c();
        proj.Name = 'Test Proj Title';
        insert proj;
        
        Contact con = new contact();
        con.FirstName = 'Test first name';
        con.LastName = 'Test last name';
        con.Email = 'Test@test.com';
        con.AccountId = acc.Id;
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'Test capName';
        con1.LastName = 'Test CapLast';
        con1.Email = 'Test1@test.com';
        con1.AccountId = acc.Id;
        insert con1;
        
        Grant_Request__c grantReqObj = new Grant_Request__c(Grant_Request_Name__c= 'Test orgName-Test Proj Title',Organization__c = acc.Id,Project__c=proj.Id);
        insert grantReqObj;
        Grant_Request__c grantReqObj1 = new Grant_Request__c(Grant_Request_Name__c = 'Test orgName-Test Proj Title11',Organization__c = acc.Id,Project__c=proj.Id);
        insert grantReqObj1;
       CreateAppGrantReq();
       
    }
    
    
    public static void CreateAppGrantReq()
    {
        Application_Grant_Request_Form__c appGrantReq=new Application_Grant_Request_Form__c();
        
        appGrantReq.Does_your_org_have_a_founding_document__c='Test founding document';
        appGrantReq.Does_your_org_have_a_bank_account__c='Test Bank account';
        appGrantReq.A_letter_from_SARS_confirming_PBO_status__c='Test letter from SARS';
        appGrantReq.Management_Accounts_for_the_current_FY__c='Test Management';
        appGrantReq.Is_your_project_supported_by_the_AFGB__c='Test project support';
        appGrantReq.Attachment_File_URL__c='Test attachment file';
        appGrantReq.Proof_of_company_org_registration__c='Test org registration';
        appGrantReq.Proof_of_bank_account__c='Test Bank Account';
        appGrantReq.Up_to_date_Management_Accounts__c='Test management account';
        appGrantReq.Proof_of_Address_not_older_than_3_months__c='Test address';
        appGrantReq.EMIS_registration_number_for_schools__c='test EMIS';
        appGrantReq.Letterhead_for_schools__c='Test LetterHead';
        appGrantReq.Signed_copy_of_Founding_document__c='Test Signed copy';
        appGrantReq.List_of_the_organisation_s_board_members__c='Test board members';
        appGrantReq.Certified_copy_of_each_board_member_s_ID__c='Test certified';
        appGrantReq.Proof_of_residence_for_each_board_membe__c='Test residence';
        appGrantReq.POC_First_Name__c='Test first name';
        appGrantReq.POC_Last_Name__c='Test last name';
        appGrantReq.POC_Job_Title_Role__c='Test JOb title';
        appGrantReq.POC_Email_Address__c='Test@test.com';
        appGrantReq.POC_Primary_Phone_Number__c='0000000000';
        appGrantReq.Team_Captain_First_Name__c='Test capName';
        appGrantReq.Team_Captain_Last_Name__c='Test CapLast';
        appGrantReq.Team_Captain_Email_Address__c='Test1@test.com';
        appGrantReq.Team_Captain_Primary_Phone_Number__c='0000000000';
        appGrantReq.Team_Captain_Company_Affiliation__c='Test company';
        appGrantReq.Organisation_Name__c='Test orgName';
        appGrantReq.Registration_Number__c='0000000';
        appGrantReq.Founding_Year__c='test 2020';
        appGrantReq.Website__c='Test2@test.com';
        appGrantReq.Company_Registration__c='Test Registration';
        appGrantReq.Primary_focus_of_your_organisation__c='Test Primary focus';
        appGrantReq.Registered_Address_Street__c='test registered address';
        appGrantReq.Town_City__c='Test city';
        appGrantReq.Country__c='Test country';
        appGrantReq.Postal_Code__c='Test Postal';
        appGrantReq.Office_Phone_Number__c='0000000000';
        appGrantReq.Total_Income_for_the_last_FY__c='22';
        //appGrantReq.Date_of_your_last_FY_End__c=Date.today();
        appGrantReq.Org_a_recipient_of_funding_from_the_AFGP__c='Test AFGP';
        appGrantReq.Project_Title__c='Test Proj Title';
        appGrantReq.Project_Background_and_Grant_Narrative__c='Test Project Background';
        appGrantReq.Anticipated_Project_Start_Date__c=Date.newInstance(2021, 8, 8);
        appGrantReq.Anticipated_Project_End_Date__c=Date.newInstance(2021, 9, 9);
        appGrantReq.Geo_Location_of_Project_Implementation__c='Test Geo ';
        appGrantReq.Project_Cost_ZAR__c='1';
        appGrantReq.Grant_Amount_Requested_ZAR__c='2000';
        appGrantReq.Budget_Item_1__c='1';
        appGrantReq.Budget_Item_1_and_Cost1__c='100';
        appGrantReq.Budget_Item_2__c='Test Item 2';
        appGrantReq.Budget_Item_2_and_Cost_2__c='200';
        appGrantReq.Budget_Item_3__c='Test Item 3';
        appGrantReq.Budget_Item_3_and_Cost_3__c='300';
        appGrantReq.Budget_Item_4__c='Test Item 4';
        appGrantReq.Budget_Item_4_and_Cost_4__c='400';
        appGrantReq.Budget_Item_5__c='Test Item 5';
        appGrantReq.Budget_Item_5_and_Cost_5__c='500';
        appGrantReq.Budget_Item_6__c='Test Item 6';
        appGrantReq.Budget_Item_6_and_Cost_6__c='600';
        appGrantReq.Budget_Item_7__c='Test Item 7';
        appGrantReq.Budget_Item_7_and_Cost_7__c='700';
        appGrantReq.Budget_Item_8__c='Test Item 8';
        appGrantReq.Budget_Item_8_and_Cost_8__c='800';
        appGrantReq.Budget_Item_9__c='Test Item 9';
        appGrantReq.Budget_Item_9_and_Cost_9__c='900';
        appGrantReq.Budget_Item_10__c='Test Item 10';
        appGrantReq.Budget_Item_10_and_Cost_10__c='10';
        appGrantReq.Budget_Total_Cost__c='1';
        appGrantReq.Proof_of_company_registration_File_Name__c = 'filename1.pdf';
        appGrantReq.Proof_of_company_org_registration__c = 'https://pyxera.iad1.qualtrics.com/WRQualtricsSurveyEngine/File.php?F=F_2dN0WlNFXERmNvW';
        appGrantReq.Proof_of_bank_account_File_Name__c = 'filename2.pdf';
        appGrantReq.Proof_of_bank_account__c = 'https://pyxera.iad1.qualtrics.com/WRQualtricsSurveyEngine/File.php?F=F_2dN0WlNFXERmNvW';
        appGrantReq.Up_to_date_Management_Accounts_File_Name__c = 'filename3.pdf';
        appGrantReq.Up_to_date_Management_Accounts__c = 'https://pyxera.iad1.qualtrics.com/WRQualtricsSurveyEngine/File.php?F=F_2dN0WlNFXERmNvW';
        appGrantReq.Proof_of_Add_not_old_than_3_File_Name__c = 'filename4.pdf';
        appGrantReq.Proof_of_Address_not_older_than_3_months__c = 'https://pyxera.iad1.qualtrics.com/WRQualtricsSurveyEngine/File.php?F=F_2dN0WlNFXERmNvW';
        appGrantReq.Signed_copy_of_Founding_doc_File_Name__c = 'filename5.pdf';
        appGrantReq.Signed_copy_of_Founding_document__c = 'https://pyxera.iad1.qualtrics.com/WRQualtricsSurveyEngine/File.php?F=F_2dN0WlNFXERmNvW';
        appGrantReq.List_of_the_org_board_members_File_Name__c = 'filename6.pdf';
        appGrantReq.List_of_the_organisation_s_board_members__c = 'https://pyxera.iad1.qualtrics.com/WRQualtricsSurveyEngine/File.php?F=F_2dN0WlNFXERmNvW';
        appGrantReq.Certified_board_member_s_ID_File_Name__c = 'filename7.pdf';
        appGrantReq.Certified_copy_of_each_board_member_s_ID__c = 'https://pyxera.iad1.qualtrics.com/WRQualtricsSurveyEngine/File.php?F=F_2dN0WlNFXERmNvW';
        appGrantReq.Proof_of_residence_board_member_FileName__c = 'filename8.pdf';
        appGrantReq.Proof_of_residence_for_each_board_membe__c = 'https://pyxera.iad1.qualtrics.com/WRQualtricsSurveyEngine/File.php?F=F_2dN0WlNFXERmNvW';
        appGrantReq.EMIS_registration_number_File_Name__c = 'filename9.pdf';
        appGrantReq.EMIS_registration_number_for_schools__c = 'https://pyxera.iad1.qualtrics.com/WRQualtricsSurveyEngine/File.php?F=F_2dN0WlNFXERmNvW';
        appGrantReq.Letterhead_for_schools_File_Name__c = 'filename10.pdf';
        appGrantReq.Letterhead_for_schools__c = 'https://pyxera.iad1.qualtrics.com/WRQualtricsSurveyEngine/File.php?F=F_2dN0WlNFXERmNvW';
        
        insert appGrantReq;
    }    
    
}