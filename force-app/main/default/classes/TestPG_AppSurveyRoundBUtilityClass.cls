@isTest
public class TestPG_AppSurveyRoundBUtilityClass {
    
    @testSetup static void  setupData() {
        // Create common test accounts
        account acct=new account() ;
        acct.Name='Ambassadors for Good';
        acct.Mission_and_Vision_Statement__c='mission and vission';
        acct.Founding_Year__c='0000';
        acct.Geographic_Coverage__c='coverage1';
        acct.Registered_Entity__c='entity1';
        acct.Necessary_Documents__c='necessary1';
        acct.Target_Clients_or_Beneficiaries__c = 'targetBeneficiaries1';
        acct.Sector_Activities__c = 'partnerActivities1';
        acct.BillingCity = 'town1';
        acct.BillingCountry = 'country1';
        acct.BillingPostalCode = 'postCode1';
        acct.BillingState = 'state1';
        acct.BillingStreet = 'street1';
        
        insert acct;
    } 
    
    //Normal Run
    @isTest
    public static  void TestMethod1(){
        createApplicationSurvey(false);
    }
    
    
    //Without 'Ambassadors for Good' account
    @isTest
    public static  void TestMethod7(){
        delete [select id from account where name = 'Ambassadors for Good'];
        createApplicationSurvey(false);
    }
    
    //With multiple 'Ambassadors for Good' account
    @isTest
    public static  void TestMethod10(){
        account acct=new account() ;
        acct.Name='111Ambassadors for Good211';
        insert acct;
        createApplicationSurvey(false);
    }
    
    //With multiple account data
    @isTest
    public static  void TestMethod5(){
        
        account acct=new account();
        acct.Name='Test Org';        
        insert acct;
        
        account acc=new account();
        acc.Name='Test Org11';        
        insert acc;
        
        createApplicationSurvey(false);
    }
    
    //With existing project data
    @isTest
    public static  void TestMethod4(){
        
        Projects__c proj = new Projects__c();
        proj.Name = 'projecttest';
        insert proj;
        
        createApplicationSurvey(false);
    }
    
    //With existing contact data
    @isTest
    public static  void TestMethod2(){
        account acct=new account();
        acct.Name='Test Org';        
        insert acct;
        
        Contact con = new contact();
        con.FirstName = 'conF';
        con.LastName = 'conL';
        con.Email = 'test11@test.com';
        con.notActive__c = true;
        insert con;
        
        createApplicationSurvey(false);
        
    }
    
    //With same email but different name
    @isTest
    public static  void TestMethod3(){
        
        account acct=new account();
        acct.Name='Test Org';        
        insert acct;
        
        Contact con = new contact();
        con.FirstName = 'conF';
        con.LastName = 'con';
        con.Email = 'test11@test.com';
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'conF1';
        con1.LastName = 'conL1';
        con1.Email = 'test11@test.com';
        insert con1;
        
        createApplicationSurvey(false);
    } 
    
    //With same name but different email
    @isTest
    public static  void TestMethod11(){
        
        account acct=new account();
        acct.Name='Test Org';        
        insert acct;
        
        Contact con = new contact();
        con.FirstName = 'conF';
        con.LastName = 'conL';
        con.Email = 'test1@test.com';
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'conF3';
        con1.LastName = 'conL';
        con1.Email = 'test2@test.com';
        insert con1;
        
        createApplicationSurvey(true);
    } 
    
    @isTest
    public static  void TestMethod33(){
        
        account acct=new account();
        acct.Name='Test Org';        
        insert acct;
        
        Contact con = new contact();
        con.FirstName = 'conF';
        con.LastName = 'conL';
        con.Email = 'test1@test.com';
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'conF';
        con1.LastName = 'conL';
        con1.Email = 'test2@test.com';
        insert con1;
        
        createApplicationSurvey(false);
    } 
    
    @isTest
    public static  void TestMethod39(){
        
        account acct=new account();
        acct.Name='Test Org';        
        insert acct;
        
        Contact con = new contact();
        con.FirstName = 'conF';
        con.LastName = 'conL';
        con.Email = 'test1@test.com';
        con.High_Risk__c = true;
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'conF3';
        con1.LastName = 'conL';
        con1.Email = 'test2@test.com';
        con.High_Risk__c = true;
        insert con1;
        
        createApplicationSurvey(true);
    } 
    
    //With different contact name
    @isTest
    public static  void TestMethod6(){
        
        Contact con = new contact();
        con.FirstName = 'first';
        con.LastName = 'last';
        con.Email = 'test11@test.com';
        insert con;
        
        createApplicationSurvey(false);
    }
    
    
    //With existing team captain data
    @isTest
    public static  void TestMethod12(){
        account acct=new account();
        acct.Name='Test Org';        
        insert acct;
        
        Contact con = new contact();
        con.FirstName = 'tcfname';
        con.LastName = 'tcLastname';
        con.Email = 'testcap@test.com';
        con.notActive__c = true;
        insert con;
        
        createApplicationSurvey(false);
        
    }
    
    //With same email but different name
    @isTest
    public static  void TestMethod13(){
        
        account acct=new account();
        acct.Name='Test Org';        
        insert acct;
        
        Contact con = new contact();
        con.FirstName = 'tcfname1';
        con.LastName = 'tcLastn1';
        con.Email = 'testcap@test.com';
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'tcfname';
        con1.LastName = 'tcLname11';
        con1.Email = 'testcap@test.com';
        insert con1;
        
        createApplicationSurvey(false);
    } 
    
    //With same name but different email
    @isTest
    public static  void TestMethod14(){
        
        account acct=new account();
        acct.Name='Test Org';        
        insert acct;
        
        Contact con = new contact();
        con.FirstName = 'tcfname';
        con.LastName = 'tcLastname';
        con.Email = 'testcap1@test.com';
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'tcfname2';
        con1.LastName = 'tcLastname';
        con1.Email = 'testcap2@test.com';
        insert con1;
        
        createApplicationSurvey(true);
    } 
    
    @isTest
    public static  void TestMethod34(){
        
        account acct=new account();
        acct.Name='Test Org';        
        insert acct;
        
        Contact con = new contact();
        con.FirstName = 'tcfname';
        con.LastName = 'tcLastname';
        con.Email = 'testcap1@test.com';
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'tcfname';
        con1.LastName = 'tcLastname';
        con1.Email = 'testcap2@test.com';
        insert con1;
        
        createApplicationSurvey(false);
    } 
    
    @isTest
    public static  void TestMethod40(){
        
        account acct=new account();
        acct.Name='Test Org';        
        insert acct;
        
        Contact con = new contact();
        con.FirstName = 'tcfname';
        con.LastName = 'tcLastname';
        con.Email = 'testcap1@test.com';
        con.High_Risk__c = true;
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'tcfname2';
        con1.LastName = 'tcLastname';
        con1.Email = 'testcap2@test.com';
        con.High_Risk__c = true;
        insert con1;
        
        createApplicationSurvey(true);
    } 
    
    //With different team captain name
    @isTest
    public static  void TestMethod15(){
        
        Contact con = new contact();
        con.FirstName = 'first';
        con.LastName = 'last';
        con.Email = 'testcap@test.com';
        insert con;
        
        createApplicationSurvey(false);
    }
    
    
    //With existing team member 1 data
    @isTest
    public static  void TestMethod16(){
        account acct=new account();
        acct.Name='Test Org';        
        insert acct;
        
        Contact con = new contact();
        con.FirstName = 'tmirstname1';
        con.LastName = 'tmLastname1';
        con.Email = 'test1@test.com';
        con.notActive__c = true;
        insert con;
        
        createApplicationSurvey(false);
        
    }
    
    //With same email but different name
    @isTest
    public static  void TestMethod17(){
        
        account acct=new account();
        acct.Name='Test Org';        
        insert acct;
        
        Contact con = new contact();
        con.FirstName = 'tmirstname1';
        con.LastName = 'tmLastn';
        con.Email = 'test1@test.com';
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'tmirstname1';
        con1.LastName = 'tmLastname1111';
        con1.Email = 'test1@test.com';
        insert con1;
        
        createApplicationSurvey(false);
    } 
    
    //With same name but different email
    @isTest
    public static  void TestMethod18(){
        
        account acct=new account();
        acct.Name='Test Org';        
        insert acct;
        
        Contact con = new contact();
        con.FirstName = 'tmirstname1';
        con.LastName = 'tmLastname1';
        con.Email = 'test12@test.com';
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'tmirstname';
        con1.LastName = 'tmLastname1';
        con1.Email = 'test13@test.com';
        insert con1;
        
        createApplicationSurvey(true);
    } 
    
    @isTest
    public static  void TestMethod35(){
        
        account acct=new account();
        acct.Name='Test Org';        
        insert acct;
        
        Contact con = new contact();
        con.FirstName = 'tmirstname1';
        con.LastName = 'tmLastname1';
        con.Email = 'test12@test.com';
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'tmirstname1';
        con1.LastName = 'tmLastname1';
        con1.Email = 'test13@test.com';
        insert con1;
        
        createApplicationSurvey(false);
    } 
    
    @isTest
    public static  void TestMethod41(){
        
        account acct=new account();
        acct.Name='Test Org';        
        insert acct;
        
        Contact con = new contact();
        con.FirstName = 'tmirstname1';
        con.LastName = 'tmLastname1';
        con.Email = 'test12@test.com';
        con.High_Risk__c = true;
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'tmirstname';
        con1.LastName = 'tmLastname1';
        con1.Email = 'test13@test.com';
        con.High_Risk__c = true;
        insert con1;
        
        createApplicationSurvey(true);
    } 
    
    //With different team member1 name
    @isTest
    public static  void TestMethod19(){
        
        Contact con = new contact();
        con.FirstName = 'first';
        con.LastName = 'last';
        con.Email = 'test1@test.com';
        insert con;
        
        createApplicationSurvey(false);
    }
    
    
    
    
    //With existing team member 2 data
    @isTest
    public static  void TestMethod20(){
        account acct=new account();
        acct.Name='Test Org';        
        insert acct;
        
        Contact con = new contact();
        con.FirstName = 'tmirstname2';
        con.LastName = 'tmLastname2';
        con.Email = 'test2@test.com';
        con.notActive__c = true;
        insert con;
        
        createApplicationSurvey(false);
        
    }
    
    //With same email but different name
    @isTest
    public static  void TestMethod21(){
        
        account acct=new account();
        acct.Name='Test Org';        
        insert acct;
        
        Contact con = new contact();
        con.FirstName = 'tmirstname2';
        con.LastName = 'tmLastn';
        con.Email = 'test2@test.com';
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'first name1';
        con1.LastName = 'tmLastname1121';
        con1.Email = 'test2@test.com';
        insert con1;
        
        createApplicationSurvey(false);
    } 
    
    //With same name but different email
    @isTest
    public static  void TestMethod22(){
        
        account acct=new account();
        acct.Name='Test Org';        
        insert acct;
        
        Contact con = new contact();
        con.FirstName = 'tmirstname2';
        con.LastName = 'tmLastname2';
        con.Email = 'test211@test.com';
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'tmirstname1';
        con1.LastName = 'tmLastname2';
        con1.Email = 'test211@test.com';
        insert con1;
        
        createApplicationSurvey(true);
    } 
    
    @isTest
    public static  void TestMethod36(){
        
        account acct=new account();
        acct.Name='Test Org';        
        insert acct;
        
        Contact con = new contact();
        con.FirstName = 'tmirstname2';
        con.LastName = 'tmLastname2';
        con.Email = 'test211@test.com';
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'tmirstname1';
        con1.LastName = 'tmLastname2';
        con1.Email = 'test211@test.com';
        insert con1;
        
        createApplicationSurvey(false);
    } 
    
    @isTest
    public static  void TestMethod42(){
        
        account acct=new account();
        acct.Name='Test Org';        
        insert acct;
        
        Contact con = new contact();
        con.FirstName = 'tmirstname2';
        con.LastName = 'tmLastname2';
        con.Email = 'test211@test.com';
        con.High_Risk__c = true;
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'tmirstname1';
        con1.LastName = 'tmLastname2';
        con1.Email = 'test211@test.com';
        con.High_Risk__c = true;
        insert con1;
        
        createApplicationSurvey(true);
    } 
    
    //With different team member2 name
    @isTest
    public static  void TestMethod23(){
        
        Contact con = new contact();
        con.FirstName = 'first';
        con.LastName = 'last';
        con.Email = 'test1@test.com';
        insert con;
        
        createApplicationSurvey(false);
    }
    
    
    //With existing team member 3 data
    @isTest
    public static  void TestMethod24(){
        account acct=new account();
        acct.Name='Test Org';        
        insert acct;
        
        Contact con = new contact();
        con.FirstName = 'tmirstname3';
        con.LastName = 'tmLastname3';
        con.Email = 'test3@test.com';
        con.notActive__c = true;
        insert con;
        
        createApplicationSurvey(false);
        
    }
    
    //With same email but different name
    @isTest
    public static  void TestMethod25(){
        
        account acct=new account();
        acct.Name='Test Org';        
        insert acct;
        
        Contact con = new contact();
        con.FirstName = 'tmirstname3';
        con.LastName = 'tmLastn';
        con.Email = 'test3@test.com';
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'tmirstname3';
        con1.LastName = 'tmLastname31212';
        con1.Email = 'test3@test.com';
        insert con1;
        
        createApplicationSurvey(false);
    } 
    
    //With same name but different email
    @isTest
    public static  void TestMethod26(){
        
        account acct=new account();
        acct.Name='Test Org';        
        insert acct;
        
        Contact con = new contact();
        con.FirstName = 'tmirstname3';
        con.LastName = 'tmLastname3';
        con.Email = 'test311@test.com';
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'tmirstname2';
        con1.LastName = 'tmLastname3';
        con1.Email = 'test322@test.com';
        insert con1;
        
        createApplicationSurvey(true);
    } 
    
    @isTest
    public static  void TestMethod37(){
        
        account acct=new account();
        acct.Name='Test Org';        
        insert acct;
        
        Contact con = new contact();
        con.FirstName = 'tmirstname3';
        con.LastName = 'tmLastname3';
        con.Email = 'test311@test.com';
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'tmirstname3';
        con1.LastName = 'tmLastname3';
        con1.Email = 'test322@test.com';
        insert con1;
        
        createApplicationSurvey(false);
    } 
    
    @isTest
    public static  void TestMethod43(){
        
        account acct=new account();
        acct.Name='Test Org';        
        insert acct;
        
        Contact con = new contact();
        con.FirstName = 'tmirstname3';
        con.LastName = 'tmLastname3';
        con.Email = 'test311@test.com';
        con.High_Risk__c = true;
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'tmirstname2';
        con1.LastName = 'tmLastname3';
        con1.Email = 'test322@test.com';
        con.High_Risk__c = true;
        insert con1;
        
        createApplicationSurvey(true);
    } 
    
    //With different team member3 name
    @isTest
    public static  void TestMethod27(){
        
        Contact con = new contact();
        con.FirstName = 'first';
        con.LastName = 'last';
        con.Email = 'test1@test.com';
        insert con;
        
        createApplicationSurvey(false);
    }
    
    
    //With existing team member 4 data
    @isTest
    public static  void TestMethod28(){
        account acct=new account();
        acct.Name='Test Org';        
        insert acct;
        
        Contact con = new contact();
        con.FirstName = 'tmirstname4';
        con.LastName = 'tmLastname4';
        con.Email = 'test4@test.com';
        con.notActive__c = true;
        insert con;
        
        
        createApplicationSurvey(false);
        
    }
    
    //With same email but different name
    @isTest
    public static  void TestMethod29(){
        
        account acct=new account();
        acct.Name='Test Org';        
        insert acct;
        
        Contact con = new contact();
        con.FirstName = 'tmirstname4';
        con.LastName = 'tmLastn';
        con.Email = 'test4@test.com';
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'tmirstname4';
        con1.LastName = 'tmLastname41212';
        con1.Email = 'test4@test.com';
        insert con1;
        
        createApplicationSurvey(false);
    } 
    
    //With same name but different email
    @isTest
    public static  void TestMethod30(){
        
        account acct=new account();
        acct.Name='Test Org';        
        insert acct;
        
        Contact con = new contact();
        con.FirstName = 'tmirstname4';
        con.LastName = 'tmLastname4';
        con.Email = 'test411@test.com';
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'tmirstname2';
        con1.LastName = 'tmLastname4';
        con1.Email = 'test422@test.com';
        insert con1;
        
        createApplicationSurvey(true);
    } 
    
    @isTest
    public static  void TestMethod38(){
        
        account acct=new account();
        acct.Name='Test Org';        
        insert acct;
        
        Contact con = new contact();
        con.FirstName = 'tmirstname4';
        con.LastName = 'tmLastname4';
        con.Email = 'test411@test.com';
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'tmirstname4';
        con1.LastName = 'tmLastname4';
        con1.Email = 'test422@test.com';
        insert con1;
        
        createApplicationSurvey(false);
    } 
    
    @isTest
    public static  void TestMethod44(){
        
        account acct=new account();
        acct.Name='Test Org';        
        insert acct;
        
        Contact con = new contact();
        con.FirstName = 'tmirstname4';
        con.LastName = 'tmLastname4';
        con.Email = 'test411@test.com';
        con.High_Risk__c = true;
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'tmirstname2';
        con1.LastName = 'tmLastname4';
        con1.Email = 'test422@test.com';
        con.High_Risk__c = true;
        insert con1;
        
        createApplicationSurvey(true);
    } 
    
    //With different team member4 name
    @isTest
    public static  void TestMethod31(){
        
        Contact con = new contact();
        con.FirstName = 'first';
        con.LastName = 'last';
        con.Email = 'test1@test.com';
        insert con;
        
        createApplicationSurvey(false);
    }
    
    //Team captain and members with same details
    @isTest
    public static  void TestMethod32(){
        createApplicationSurveyWithSameTeamMemberDetails('1');
        createApplicationSurveyWithSameTeamMemberDetails('2');
        createApplicationSurveyWithSameTeamMemberDetails('3');
        createApplicationSurveyWithSameTeamMemberDetails('4');
    }
    
    
    
    
    
    public static void createApplicationSurvey(Boolean isTestClassRunning){
	createDataForRoundB();
        Application_Survey_Form__c appsurvey=new Application_Survey_Form__c();
        
        appsurvey.Contact_Title__c='Test Title';
        appsurvey.Contact_First_Name__c='conF';
        appsurvey.Contact_Last_Name__c='conL';
        appsurvey.Contact_City__c='test city';
        appsurvey.Home_Office_Country__c='test home office';
        appsurvey.Contact_BusUnitAnglo__c='test busUnit';
        appsurvey.Company_Affiliation__c='test company';
        appsurvey.Contact_Phone_Number__c='0000000000';
        appsurvey.Contact_Work_Email__c='test11@test.com';
        appsurvey.Line_Manager_Name__c='Test Line Manager';
        appsurvey.Line_Manager_Work_Email__c='Test@test.com';
        appsurvey.Contact_BusUnitDebeers__c='Test contact busUnit';
        appsurvey.Organization_Name__c='Test Org';
        appsurvey.Organization_Street__c='test street';
        appsurvey.Organisation_Mission_and_Vision__c='test mission';
        appsurvey.Organization_City_Town__c='Test city';
        appsurvey.Organisation_Website__c='www.test.com';
        appsurvey.Organization_State_Province_Country__c='test state';
        appsurvey.Partner_Organisation_Communication__c='test partner';
        appsurvey.Organization_Country__c='test org country';
        appsurvey.Partner_organisation_Participated_before__c='test participant';
        appsurvey.Organization_Post_Code__c='test post';
        appsurvey.Partner_Organisation_registered_entity__c='test registered';
        appsurvey.Partner_Organisation_Sector_Activities__c='Agriculture';
        appsurvey.Organization_Geographic_Coverage__c='test geog';
        appsurvey.Target_Beneficiaries__c='Individuals';
        appsurvey.Project_Name__c='projecttest';
        appsurvey.Level_of_Effort__c='test effort';
        appsurvey.Project_Objective__c='test objective';
        appsurvey.Grant_Use__c='Yes';
        appsurvey.Project_Timeline__c='test Timeline';
        appsurvey.Grant_Narrative__c='test native';
        appsurvey.Project_Type__c='test prject';
        appsurvey.Team_Skills__c='test skill';
        appsurvey.Project_Background__c='test background';
        appsurvey.Team_Diversity__c='test diversity';
        appsurvey.Project_Beneficiaries__c='test beneficiaries';
        appsurvey.Activities_to_Obtain_Objective__c='test activity';
        appsurvey.Level_of_Commitment__c='test level';
        appsurvey.Sustainability_Alignment__c='test sustanibility';
        appsurvey.Application_Cycle__c='test cycle';
        appsurvey.Grant_Request_Status__c='test request';
        appsurvey.Application_Round__c='test round';
        appsurvey.Grant_Request_Submitted__c=Date.newInstance(2021, 8, 8);
        appsurvey.Grant_Amount__c='100';
        appsurvey.Team_captain_Job_Title__c='test captain1';
        appsurvey.Team_captain_First_Name__c='tcfname';
        appsurvey.Team_captain_Last_Name__c='tcLastname';
        appsurvey.Team_captain_Work_Email__c='testcap@test.com';
        appsurvey.Team_captain_Home_Office_City__c='test city captain';
        appsurvey.Team_Captain_Home_Office_Country__c='test country';
        appsurvey.Team_Captain_Company_Affiliation__c='test affl';
        appsurvey.Team_Captain_Line_Manager_Full_Name__c='test Name';
        appsurvey.Team_Captain_Line_Manager_Work_Email__c='test@test.com';
        appsurvey.Team_Captain_BusUnitDebeers__c='testdebeers';
        appsurvey.Team_Captain_BusUnitAnglo__c='test busunit';
        appsurvey.Team_Member_1_Job_Title__c='test job1';
        appsurvey.Team_Member_1_First_Name__c='tmirstname1';
        appsurvey.Team_Member_1_Last_Name__c='tmLastname1';
        appsurvey.Team_Member_1_Work_Email__c='test1@test.com';
        appsurvey.Team_Member_1_Office_City__c='test city member1';
        appsurvey.Team_Member_1_Home_Office_Country__c='test country1';
        appsurvey.Team_Member_1_Company_Affiliation__c='test affl1';
        appsurvey.Team_Member_1_Line_Manager_Full_Name__c='test Name1';
        appsurvey.Team_Member_1_Line_Manager_Work_Email__c='tes11t@test.com';
        appsurvey.Team_Member_1_BusUnitDebeers__c='testdebeers1';
        appsurvey.Team_Member_1_BusUnitAnglo__c='test busunit1';
        appsurvey.Team_Member_2_Job_Title__c='test job2';
        appsurvey.Team_Member_2_First_Name__c='tmirstname2';
        appsurvey.Team_Member_2_Last_Name__c='tmLastname2';
        appsurvey.Team_Member_2_Work_Email__c='test2@test.com';
        appsurvey.Team_Member_2_Office_City__c='test city member2';
        appsurvey.Team_Member_2_Home_Office_Country__c='test country2';
        appsurvey.Team_Member_2_Company_Affiliation__c='test affl2';
        appsurvey.Team_Member_2_Line_Manager_Full_Name__c='test Name2';
        appsurvey.Team_Member_2_Line_Manager_Work_Email__c='test2@test.com';
        appsurvey.Team_Member_2_BusUnitDebeers__c='testdebeers2';
        appsurvey.Team_Member_2_BusUnitAnglo__c='test busunit2';
        appsurvey.Team_Member_3_Job_Title__c='test job3';
        appsurvey.Team_Member_3_First_Name__c='tmirstname3';
        appsurvey.Team_Member_3_Last_Name__c='tmLastname3';
        appsurvey.Team_Member_3_Work_Email__c='test3@test.com';
        appsurvey.Team_Member_3_Office_City__c='test city member3';
        appsurvey.Team_Member_3_Home_Office_Country__c='test country3';
        appsurvey.Team_Member_3_Company_Affiliation__c='test affl3';
        appsurvey.Team_Member_3_Line_Manager_Full_Name__c='test Name3';
        appsurvey.Team_Member_3_Line_Manager_Work_Email__c='test3@test.com';
        appsurvey.Team_Member_3_BusUnitDebeers__c='testdebeers3';
        appsurvey.Team_Member_3_BusUnitAnglo__c='test busunit3';
        appsurvey.Team_Member_4_Job_Title__c='test job4';
        appsurvey.Team_Member_4_First_Name__c='tmirstname4';
        appsurvey.Team_Member_4_Last_Name__c='tmLastname4';
        appsurvey.Team_Member_4_Work_Email__c='test4@test.com';
        appsurvey.Team_Member_4_Office_City__c='test city member4';
        appsurvey.Team_Member_4_Home_Office_Country__c='test country4';
        appsurvey.Team_Member_4_Company_Affiliation__c='test affl4';
        appsurvey.Team_Member_4_Line_Manager_Full_Name__c='test Name4';
        appsurvey.Team_Member_4_Line_Manager_Work_Email__c='test4@test.com';
        appsurvey.Team_Member_4_BusUnitDebeers__c='testdebeers4';
        appsurvey.Team_Member_4_BusUnitAnglo__c='test busunit4';
        appsurvey.Resubmission_Flag__c = 'Yes';
        
        PG_ContactUtilityClass.isTestClassRunning = isTestClassRunning;
        insert appsurvey;
        
        appsurvey.Stop_Resync__c = true;
        update appsurvey;
        
    }
    
    
    public static void createApplicationSurveyWithSameTeamMemberDetails(String errorOnTeamMember){
	createDataForRoundB();
        Application_Survey_Form__c appsurvey=new Application_Survey_Form__c();
        
        appsurvey.Contact_Title__c='Test Title';
        appsurvey.Contact_First_Name__c='conF';
        appsurvey.Contact_Last_Name__c='conL';
        appsurvey.Contact_City__c='test city';
        appsurvey.Home_Office_Country__c='test home office';
        appsurvey.Contact_BusUnitAnglo__c='test busUnit';
        appsurvey.Company_Affiliation__c='test company';
        appsurvey.Contact_Phone_Number__c='0000000000';
        appsurvey.Contact_Work_Email__c='test11@test.com';
        appsurvey.Line_Manager_Name__c='Test Line Manager';
        appsurvey.Line_Manager_Work_Email__c='Test@test.com';
        appsurvey.Contact_BusUnitDebeers__c='Test contact busUnit';
        appsurvey.Organization_Name__c='Test Org';
        appsurvey.Organization_Street__c='test street';
        appsurvey.Organisation_Mission_and_Vision__c='test mission';
        appsurvey.Organization_City_Town__c='Test city';
        appsurvey.Organisation_Website__c='www.test.com';
        appsurvey.Organization_State_Province_Country__c='test state';
        appsurvey.Partner_Organisation_Communication__c='test partner';
        appsurvey.Organization_Country__c='test org country';
        appsurvey.Partner_organisation_Participated_before__c='test participant';
        appsurvey.Organization_Post_Code__c='test post';
        appsurvey.Partner_Organisation_registered_entity__c='test registered';
        appsurvey.Partner_Organisation_Sector_Activities__c='Agriculture';
        appsurvey.Organization_Geographic_Coverage__c='test geog';
        appsurvey.Target_Beneficiaries__c='Individuals';
        appsurvey.Project_Name__c='projecttest';
        appsurvey.Level_of_Effort__c='test effort';
        appsurvey.Project_Objective__c='test objective';
        appsurvey.Grant_Use__c='Yes';
        appsurvey.Project_Timeline__c='test Timeline';
        appsurvey.Grant_Narrative__c='test native';
        appsurvey.Project_Type__c='test prject';
        appsurvey.Team_Skills__c='test skill';
        appsurvey.Project_Background__c='test background';
        appsurvey.Team_Diversity__c='test diversity';
        appsurvey.Project_Beneficiaries__c='test beneficiaries';
        appsurvey.Activities_to_Obtain_Objective__c='test activity';
        appsurvey.Level_of_Commitment__c='test level';
        appsurvey.Sustainability_Alignment__c='test sustanibility';
        appsurvey.Application_Cycle__c='test cycle';
        appsurvey.Grant_Request_Status__c='test request';
        appsurvey.Application_Round__c='test round';
        appsurvey.Grant_Request_Submitted__c=Date.newInstance(2021, 8, 8);
        appsurvey.Grant_Amount__c='100';
        appsurvey.Team_captain_Job_Title__c='test captain1';
        appsurvey.Team_captain_First_Name__c='tmirstname1';
        appsurvey.Team_captain_Last_Name__c='tmLastname1';
        appsurvey.Team_captain_Work_Email__c='test1@test.com';
        appsurvey.Team_captain_Home_Office_City__c='test city captain';
        appsurvey.Team_Captain_Home_Office_Country__c='test country';
        appsurvey.Team_Captain_Company_Affiliation__c='test affl';
        appsurvey.Team_Captain_Line_Manager_Full_Name__c='test Name';
        appsurvey.Team_Captain_Line_Manager_Work_Email__c='test@test.com';
        appsurvey.Team_Captain_BusUnitDebeers__c='testdebeers';
        appsurvey.Team_Captain_BusUnitAnglo__c='test busunit';
        appsurvey.Resubmission_Flag__c = 'Yes';
        if(errorOnTeamMember == '1'){
            appsurvey.Team_Member_1_Job_Title__c='test job1';
            appsurvey.Team_Member_1_First_Name__c='tmirstname1';
            appsurvey.Team_Member_1_Last_Name__c='tmLastname1';
            appsurvey.Team_Member_1_Work_Email__c='test1@test.com';
            appsurvey.Team_Member_1_Office_City__c='test city member1';
            appsurvey.Team_Member_1_Home_Office_Country__c='test country1';
            appsurvey.Team_Member_1_Company_Affiliation__c='test affl1';
            appsurvey.Team_Member_1_Line_Manager_Full_Name__c='test Name1';
            appsurvey.Team_Member_1_Line_Manager_Work_Email__c='tes11t@test.com';
            appsurvey.Team_Member_1_BusUnitDebeers__c='testdebeers1';
            appsurvey.Team_Member_1_BusUnitAnglo__c='test busunit1';
        }
        if(errorOnTeamMember == '2'){
            appsurvey.Team_Member_2_Job_Title__c='test job2';
            appsurvey.Team_Member_2_First_Name__c='tmirstname1';
            appsurvey.Team_Member_2_Last_Name__c='tmLastname1';
            appsurvey.Team_Member_2_Work_Email__c='test1@test.com';
            appsurvey.Team_Member_2_Office_City__c='test city member2';
            appsurvey.Team_Member_2_Home_Office_Country__c='test country2';
            appsurvey.Team_Member_2_Company_Affiliation__c='test affl2';
            appsurvey.Team_Member_2_Line_Manager_Full_Name__c='test Name2';
            appsurvey.Team_Member_2_Line_Manager_Work_Email__c='test2@test.com';
            appsurvey.Team_Member_2_BusUnitDebeers__c='testdebeers2';
            appsurvey.Team_Member_2_BusUnitAnglo__c='test busunit2';
        }
        if(errorOnTeamMember == '3'){
            appsurvey.Team_Member_3_Job_Title__c='test job3';
            appsurvey.Team_Member_3_First_Name__c='tmirstname1';
            appsurvey.Team_Member_3_Last_Name__c='tmLastname1';
            appsurvey.Team_Member_3_Work_Email__c='test1@test.com';
            appsurvey.Team_Member_3_Office_City__c='test city member3';
            appsurvey.Team_Member_3_Home_Office_Country__c='test country3';
            appsurvey.Team_Member_3_Company_Affiliation__c='test affl3';
            appsurvey.Team_Member_3_Line_Manager_Full_Name__c='test Name3';
            appsurvey.Team_Member_3_Line_Manager_Work_Email__c='test3@test.com';
            appsurvey.Team_Member_3_BusUnitDebeers__c='testdebeers3';
            appsurvey.Team_Member_3_BusUnitAnglo__c='test busunit3';
        }
        
        if(errorOnTeamMember == '4'){
            appsurvey.Team_Member_4_Job_Title__c='test job4';
            appsurvey.Team_Member_4_First_Name__c='tmirstname1';
            appsurvey.Team_Member_4_Last_Name__c='tmLastname1';
            appsurvey.Team_Member_4_Work_Email__c='test1@test.com';
            appsurvey.Team_Member_4_Office_City__c='test city member4';
            appsurvey.Team_Member_4_Home_Office_Country__c='test country4';
            appsurvey.Team_Member_4_Company_Affiliation__c='test affl4';
            appsurvey.Team_Member_4_Line_Manager_Full_Name__c='test Name4';
            appsurvey.Team_Member_4_Line_Manager_Work_Email__c='test4@test.com';
            appsurvey.Team_Member_4_BusUnitDebeers__c='testdebeers4';
            appsurvey.Team_Member_4_BusUnitAnglo__c='test busunit4';
        }
        
        PG_ContactUtilityClass.isTestClassRunning = true;
        
        insert appsurvey;
        
        appsurvey.Stop_Resync__c = true;
        update appsurvey;
       
    }
    
    public static void createDataForRoundB(){
        List<Account> accList = new List<Account>([select id from account where name = 'Test Org']);
        if(accList == null || accList.size() == 0){
            account acct=new account();
            acct.Name='Test Org';        
            insert acct;
            Projects__c proj = new Projects__c();
            proj.Host_Organization__c = acct.Id;
            proj.Name = 'projecttest';
            insert proj;
            /*Projects__c proj1 = new Projects__c();
            proj1.Host_Organization__c = acct.Id;
            proj1.Name = 'projecttest';
            insert proj1;*/
        }else{
            Projects__c proj = new Projects__c();
            proj.Host_Organization__c = accList[0].Id;
            proj.Name = 'projecttest';
            insert proj;
            
        }
        
        
    }
	
    
}