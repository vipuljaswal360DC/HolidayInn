/*
Test Class Name=PG_WaiverPreProgrammeSurveyBatchClass_Testcls
Description:This test Class will cover PG waiver app trigger and batch class

*/

@isTest
public class PG_WaiverPreProgrammeSurveyBatch_TestCls {
    public static testmethod void method1(){
        Test.startTest();
        Waiver_Pre_programme_Survey_Form__c wp= new Waiver_Pre_programme_Survey_Form__c();
        wp.Application_Cycle__c='2018';
        wp.Application_Round__c='A';
        wp.Company_Affiliation__c='Anglo american';
        wp.Contact_BusUnitAnglo__c='Anglo';
        wp.Contact_BusUnitDebeers__c='Debeers';
        wp.Contact_City__c='new york';
        wp.Contact_First_Name__c='Kumar';
        wp.Contact_Last_Name__c='Madhurendra';
        wp.Contact_Phone_Number__c='9711260567';
        wp.Contact_Title__c='Developer';
        wp.Contact_Work_Email__c='kumar@kumar.com';
        wp.Home_Office_Country__c='USA';
        wp.Immediate_Impact_URL__c=false;
        wp.Line_Manager_Approval_PDF__c=false;
        wp.Line_Manager_Name__c='Kumar';
        wp.Line_Manager_Work_Email__c='Kumar12@kumar.com';
        wp.SingleResponseReportLink__c='https://ambassadors.com';
        wp.Status__c='failed';
        wp.SurveyURL__c='https://ambassadors.com';
        wp.Synced__c=false;
        wp.Waiver_Pre_programme_Survey_PDF__c=false;
        
        insert wp;
        
               
      Contact con = new Contact();
        con.FirstName = 'Kumar';
        con.LastName = 'Madhurendra';
        con.Email='kumar@kumar.com';
        con.department='Anglo';
        con.High_Risk__c=false;
        con.Company_Affiliation__c='Anglo american';
        con.notActive__c=true;
        con.Home_Office__c='USA';
        insert con;
        
        Contact conUp=[select id,name,Email,High_Risk__c from contact where id=:con.id];
        
        Participation__c par = new Participation__c();
        par.Person__c = con.Id;
        par.Counter__c=1;
        par.Application_Round__c='A';
        par.LineManager_Approval_PDF__c=false;
        par.Participation_Year__c='2018';
        par.WaiverPre_programme_Survey_PDF__c=false;
        par.Name=con.FirstName+' '+con.LastName+'-'+wp.Application_Cycle__c+'-'+wp.Application_Round__c;
        insert par;
        //update par;
        
        Participation__c par1 = new Participation__c();
        par1.Person__c = conUp.Id;
        par1.LineManager_Approval_PDF__c=true;
        insert par1;
        
        Test.stopTest();
    }
    public static testmethod void method2(){
        Test.startTest();
        Waiver_Pre_programme_Survey_Form__c wp= new Waiver_Pre_programme_Survey_Form__c();
        wp.Application_Cycle__c='2018';
        wp.Application_Round__c='A';
        wp.Company_Affiliation__c='Anglo american';
        wp.Contact_BusUnitAnglo__c='Anglo';
        wp.Contact_BusUnitDebeers__c='Debeers';
        wp.Contact_City__c='new york';
        wp.Contact_First_Name__c='Kumar';
        wp.Contact_Last_Name__c='Madhurendra';
        wp.Contact_Phone_Number__c='9711260567';
        wp.Contact_Title__c='Developer';
        wp.Contact_Work_Email__c='kumar@kumar.com';
        wp.Home_Office_Country__c='USA';
        wp.Immediate_Impact_URL__c=false;
        wp.Line_Manager_Approval_PDF__c=false;
        wp.Line_Manager_Name__c='Kumar';
        wp.Line_Manager_Work_Email__c='Kumar12@kumar.com';
        wp.SingleResponseReportLink__c='https://ambassadors.com';
        wp.Status__c='failed';
        wp.SurveyURL__c='https://ambassadors.com';
        wp.Synced__c=false;
        wp.Waiver_Pre_programme_Survey_PDF__c=false;
        
        insert wp;
        
               
      Contact con = new Contact();
        con.FirstName = 'Kumar';
        con.LastName = 'Madhurendra';
        con.Email='kumar@kumar.com';
        con.department='Anglo';
        con.High_Risk__c=false;
        con.Company_Affiliation__c='Anglo american';
        con.notActive__c=true;
        con.Home_Office__c='USA';
        //insert con;
        
        //Contact conUp=[select id,name,Email,High_Risk__c from contact where id=:con.id];
        
        Participation__c par = new Participation__c();
        par.Person__c = con.Id;
        par.Counter__c=1;
        par.Application_Round__c='A';
        par.LineManager_Approval_PDF__c=false;
        par.Participation_Year__c='2018';
        par.WaiverPre_programme_Survey_PDF__c=false;
        par.Name=con.FirstName+' '+con.LastName+'-'+wp.Application_Cycle__c+'-'+wp.Application_Round__c;
        insert par;
        //update par;
        
        Participation__c par1 = new Participation__c();
        par1.Person__c = con.Id;
        par1.LineManager_Approval_PDF__c=true;
        insert par1;
        
        Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c(Waiver_Pre_programme_Survey_Form__c = wp.Id,
                                                                                    Status__c = 'failed',
                                                                                    Error_Description__c = 'failed');
        insert logObj;
        
        Test.stopTest();
    }
    public static testmethod void method3(){
        Test.startTest();
        Waiver_Pre_programme_Survey_Form__c wp= new Waiver_Pre_programme_Survey_Form__c();
        wp.Application_Cycle__c='2018';
        wp.Application_Round__c='A';
        wp.Company_Affiliation__c='Anglo american';
        wp.Contact_BusUnitAnglo__c='Anglo';
        wp.Contact_BusUnitDebeers__c='Debeers';
        wp.Contact_City__c='new york';
        wp.Contact_First_Name__c='Kumar';
        wp.Contact_Last_Name__c='Madhurendra';
        wp.Contact_Phone_Number__c='9711260567';
        wp.Contact_Title__c='Developer';
        wp.Contact_Work_Email__c='kumar@kumar.com';
        wp.Home_Office_Country__c='USA';
        wp.Immediate_Impact_URL__c=false;
        wp.Line_Manager_Approval_PDF__c=false;
        wp.Line_Manager_Name__c='Kumar';
        wp.Line_Manager_Work_Email__c='Kumar12@kumar.com';
        wp.SingleResponseReportLink__c='https://ambassadors.com';
        wp.Status__c='failed';
        wp.SurveyURL__c='https://ambassadors.com';
        wp.Synced__c=false;
        wp.Waiver_Pre_programme_Survey_PDF__c=false;
        
        insert wp;
        
               
      Contact con = new Contact();
        con.FirstName = 'Kumar';
        con.LastName = 'Madhurendra';
        con.Email='kumar@kumar.com';
        //con.department='Anglo';
        con.High_Risk__c=true;
        //con.Company_Affiliation__c='Anglo american';
        //con.notActive__c=true;
        //con.Home_Office__c='USA';
        insert con;
        
        String conName=wp.Contact_First_Name__c+' '+wp.Contact_Last_Name__c;
        list<Contact> conUp=new list<Contact>([select id,name,Email,High_Risk__c from contact where name=:conName limit 1]);
        
        Participation__c par = new Participation__c();
        par.Person__c = con.Id;
        par.Counter__c=1;
        par.Application_Round__c='A';
        par.LineManager_Approval_PDF__c=false;
        par.Participation_Year__c='2018';
        par.WaiverPre_programme_Survey_PDF__c=false;
        par.Name=con.FirstName+' '+con.LastName+'-'+wp.Application_Cycle__c+'-'+wp.Application_Round__c;
        insert par;
        //update par;
        
        Participation__c par1 = new Participation__c();
        if(conUp.size() >0){
            par1.Person__c = conUp[0].Id;
        }
        par1.LineManager_Approval_PDF__c=true;
        insert par1;
        
        Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c(Waiver_Pre_programme_Survey_Form__c = wp.Id,
                                                                                                Status__c = 'failed',
                                                                                    Error_Description__c = 'failed');
        insert logObj;
        
        Test.stopTest();
    }
    public static testmethod void method4(){
        Test.startTest();
        Waiver_Pre_programme_Survey_Form__c wp= new Waiver_Pre_programme_Survey_Form__c();
        wp.Application_Cycle__c='2018';
        wp.Application_Round__c='A';
        wp.Company_Affiliation__c='Anglo american';
        wp.Contact_BusUnitAnglo__c='Anglo';
        wp.Contact_BusUnitDebeers__c='Debeers';
        wp.Contact_City__c='new york';
        wp.Contact_First_Name__c='Kumar';
        wp.Contact_Last_Name__c='Madhurendra';
        wp.Contact_Phone_Number__c='9711260567';
        wp.Contact_Title__c='Developer';
        wp.Contact_Work_Email__c='kumar@kumar.com';
        wp.Home_Office_Country__c='USA';
        wp.Immediate_Impact_URL__c=false;
        wp.Line_Manager_Approval_PDF__c=false;
        wp.Line_Manager_Name__c='Kumar';
        wp.Line_Manager_Work_Email__c='Kumar12@kumar.com';
        wp.SingleResponseReportLink__c='https://ambassadors.com';
        wp.Status__c='failed';
        wp.SurveyURL__c='https://ambassadors.com';
        wp.Synced__c=false;
        wp.Waiver_Pre_programme_Survey_PDF__c=false;
        
        insert wp;
        
               
      Contact con = new Contact();
        con.FirstName = 'Kumar';
        con.LastName = 'Madhurendra';
        con.Email='kumar@kumar.com';
        con.department='Anglo';
        //con.High_Risk__c=true;
        //con.Company_Affiliation__c='Anglo american';
        //con.notActive__c=true;
        //con.Home_Office__c='USA';
        insert con;
        
        String conName=wp.Contact_First_Name__c+' '+wp.Contact_Last_Name__c;
        list<Contact> conUp=new list<Contact>([select id,name,Email,High_Risk__c from contact where name=:conName limit 1]);
        
        Participation__c par = new Participation__c();
        par.Person__c = con.Id;
        par.Counter__c=1;
        par.Application_Round__c='A';
        par.LineManager_Approval_PDF__c=false;
        par.Participation_Year__c='2018';
        par.WaiverPre_programme_Survey_PDF__c=false;
        par.Name=con.FirstName+' '+con.LastName+'-'+wp.Application_Cycle__c+'-'+wp.Application_Round__c;
        insert par;
        //update par;
        
        Participation__c par1 = new Participation__c();
        if(conUp.size() >0){
            par1.Person__c = conUp[0].Id;
        }
        par1.LineManager_Approval_PDF__c=true;
        insert par1;
        
        Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c(Waiver_Pre_programme_Survey_Form__c = wp.Id,
                                                                                                Status__c = 'failed',
                                                                                    Error_Description__c = 'failed');
        insert logObj;
        
        Test.stopTest();
    }
    public static testmethod void method5(){
        Test.startTest();
        Waiver_Pre_programme_Survey_Form__c wp= new Waiver_Pre_programme_Survey_Form__c();
        wp.Application_Cycle__c='2018';
        wp.Application_Round__c='A';
        wp.Company_Affiliation__c='Anglo american';
        wp.Contact_BusUnitAnglo__c='Anglo';
        wp.Contact_BusUnitDebeers__c='Debeers';
        wp.Contact_City__c='new york';
        wp.Contact_First_Name__c='Kumar';
        wp.Contact_Last_Name__c='Madhurendra';
        wp.Contact_Phone_Number__c='9711260567';
        wp.Contact_Title__c='Developer';
        wp.Contact_Work_Email__c='kumar@kumar.com';
        wp.Home_Office_Country__c='USA';
        wp.Immediate_Impact_URL__c=false;
        wp.Line_Manager_Approval_PDF__c=false;
        wp.Line_Manager_Name__c='Kumar';
        wp.Line_Manager_Work_Email__c='Kumar12@kumar.com';
        wp.SingleResponseReportLink__c='https://ambassadors.com';
        wp.Status__c='failed';
        wp.SurveyURL__c='https://ambassadors.com';
        wp.Synced__c=false;
        wp.Waiver_Pre_programme_Survey_PDF__c=false;
        
        insert wp;
        
               
      Contact con = new Contact();
        con.FirstName = 'Kumar';
        con.LastName = 'Madhurendra';
        con.Email='kumar@kumar.com';
        //con.department='Anglo';
        //con.High_Risk__c=true;
        con.Company_Affiliation__c='Anglo american';
        //con.notActive__c=true;
        //con.Home_Office__c='USA';
        insert con;
        
        String conName=wp.Contact_First_Name__c+' '+wp.Contact_Last_Name__c;
        list<Contact> conUp=new list<Contact>([select id,name,Email,High_Risk__c from contact where name=:conName limit 1]);
        
        Participation__c par = new Participation__c();
        par.Person__c = con.Id;
        par.Counter__c=1;
        par.Application_Round__c='A';
        par.LineManager_Approval_PDF__c=false;
        par.Participation_Year__c='2018';
        par.WaiverPre_programme_Survey_PDF__c=false;
        par.Name=con.FirstName+' '+con.LastName+'-'+wp.Application_Cycle__c+'-'+wp.Application_Round__c;
        insert par;
        //update par;
        
        Participation__c par1 = new Participation__c();
        if(conUp.size() >0){
            par1.Person__c = conUp[0].Id;
        }
        par1.LineManager_Approval_PDF__c=true;
        insert par1;
        
        Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c(Waiver_Pre_programme_Survey_Form__c = wp.Id,
                                                                                                Status__c = 'failed',
                                                                                    Error_Description__c = 'failed');
        insert logObj;
        
        Test.stopTest();
    }
    public static testmethod void method6(){
        Test.startTest();
        Waiver_Pre_programme_Survey_Form__c wp= new Waiver_Pre_programme_Survey_Form__c();
        wp.Application_Cycle__c='2018';
        wp.Application_Round__c='A';
        wp.Company_Affiliation__c='Anglo american';
        wp.Contact_BusUnitAnglo__c='Anglo';
        wp.Contact_BusUnitDebeers__c='Debeers';
        wp.Contact_City__c='new york';
        wp.Contact_First_Name__c='Kumar';
        wp.Contact_Last_Name__c='Madhurendra';
        wp.Contact_Phone_Number__c='9711260567';
        wp.Contact_Title__c='Developer';
        wp.Contact_Work_Email__c='kumar@kumar.com';
        wp.Home_Office_Country__c='USA';
        wp.Immediate_Impact_URL__c=false;
        wp.Line_Manager_Approval_PDF__c=false;
        wp.Line_Manager_Name__c='Kumar';
        wp.Line_Manager_Work_Email__c='Kumar12@kumar.com';
        wp.SingleResponseReportLink__c='https://ambassadors.com';
        wp.Status__c='failed';
        wp.SurveyURL__c='https://ambassadors.com';
        wp.Synced__c=false;
        wp.Waiver_Pre_programme_Survey_PDF__c=false;
        
        insert wp;
        
               
      Contact con = new Contact();
        con.FirstName = 'Kumar';
        con.LastName = 'Madhurendra';
        con.Email='kumar@kumar.com';
        //con.department='Anglo';
        //con.High_Risk__c=true;
        //con.Company_Affiliation__c='Anglo american';
        con.notActive__c=true;
        //con.Home_Office__c='USA';
        insert con;
        
        String conName=wp.Contact_First_Name__c+' '+wp.Contact_Last_Name__c;
        list<Contact> conUp=new list<Contact>([select id,name,Email,High_Risk__c from contact where name=:conName limit 1]);
        
        Participation__c par = new Participation__c();
        par.Person__c = con.Id;
        par.Counter__c=1;
        par.Application_Round__c='A';
        par.LineManager_Approval_PDF__c=false;
        par.Participation_Year__c='2018';
        par.WaiverPre_programme_Survey_PDF__c=false;
        par.Name=con.FirstName+' '+con.LastName+'-'+wp.Application_Cycle__c+'-'+wp.Application_Round__c;
        insert par;
        //update par;
        
        Participation__c par1 = new Participation__c();
        if(conUp.size() >0){
            par1.Person__c = conUp[0].Id;
        }
        par1.LineManager_Approval_PDF__c=true;
        insert par1;
        
        Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c(Waiver_Pre_programme_Survey_Form__c = wp.Id,
                                                                                                Status__c = 'failed',
                                                                                    Error_Description__c = 'failed');
        insert logObj;
        
        Test.stopTest();
    }
    public static testmethod void method7(){
        Test.startTest();
        Waiver_Pre_programme_Survey_Form__c wp= new Waiver_Pre_programme_Survey_Form__c();
        wp.Application_Cycle__c='2018';
        wp.Application_Round__c='A';
        wp.Company_Affiliation__c='Anglo american';
        wp.Contact_BusUnitAnglo__c='Anglo';
        wp.Contact_BusUnitDebeers__c='Debeers';
        wp.Contact_City__c='new york';
        wp.Contact_First_Name__c='Kumar';
        wp.Contact_Last_Name__c='Madhurendra';
        wp.Contact_Phone_Number__c='9711260567';
        wp.Contact_Title__c='Developer';
        wp.Contact_Work_Email__c='kumar@kumar.com';
        wp.Home_Office_Country__c='USA';
        wp.Immediate_Impact_URL__c=false;
        wp.Line_Manager_Approval_PDF__c=false;
        wp.Line_Manager_Name__c='Kumar';
        wp.Line_Manager_Work_Email__c='Kumar12@kumar.com';
        wp.SingleResponseReportLink__c='https://ambassadors.com';
        wp.Status__c='failed';
        wp.SurveyURL__c='https://ambassadors.com';
        wp.Synced__c=false;
        wp.Waiver_Pre_programme_Survey_PDF__c=false;
        
        insert wp;
        
               
      Contact con = new Contact();
        con.FirstName = 'Kumar';
        con.LastName = 'Madhurendra';
        con.Email='kumar@kumar.com';
        //con.department='Anglo';
        //con.High_Risk__c=true;
        //con.Company_Affiliation__c='Anglo american';
        //con.notActive__c=true;
        con.Home_Office__c='USA';
        insert con;
        
        String conName=wp.Contact_First_Name__c+' '+wp.Contact_Last_Name__c;
        list<Contact> conUp=new list<Contact>([select id,name,Email,High_Risk__c from contact where name=:conName limit 1]);
        
        Participation__c par = new Participation__c();
        par.Person__c = con.Id;
        par.Counter__c=1;
        par.Application_Round__c='A';
        par.LineManager_Approval_PDF__c=false;
        par.Participation_Year__c='2018';
        par.WaiverPre_programme_Survey_PDF__c=false;
        par.Name=con.FirstName+' '+con.LastName+'-'+wp.Application_Cycle__c+'-'+wp.Application_Round__c;
        insert par;
        //update par;
        
        Participation__c par1 = new Participation__c();
        if(conUp.size() >0){
            par1.Person__c = conUp[0].Id;
        }
        par1.LineManager_Approval_PDF__c=true;
        insert par1;
        
        Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c(Waiver_Pre_programme_Survey_Form__c = wp.Id,
                                                                                                Status__c = 'failed',
                                                                                    Error_Description__c = 'failed');
        insert logObj;
        
        Test.stopTest();
    }
    public static testmethod void method8(){
        Test.startTest();
        Waiver_Pre_programme_Survey_Form__c wp= new Waiver_Pre_programme_Survey_Form__c();
        wp.Application_Cycle__c='2018';
        wp.Application_Round__c='A';
        wp.Company_Affiliation__c='Anglo american';
        wp.Contact_BusUnitAnglo__c='Anglo';
        wp.Contact_BusUnitDebeers__c='Debeers';
        wp.Contact_City__c='new york';
        wp.Contact_First_Name__c='Kumar';
        wp.Contact_Last_Name__c='Madhurendra';
        wp.Contact_Phone_Number__c='9711260567';
        wp.Contact_Title__c='Developer';
        wp.Contact_Work_Email__c='kumar@kumar.com';
        wp.Home_Office_Country__c='USA';
        wp.Immediate_Impact_URL__c=false;
        wp.Line_Manager_Approval_PDF__c=false;
        wp.Line_Manager_Name__c='Kumar';
        wp.Line_Manager_Work_Email__c='Kumar12@kumar.com';
        wp.SingleResponseReportLink__c='https://ambassadors.com';
        wp.Status__c='failed';
        wp.SurveyURL__c='https://ambassadors.com';
        wp.Synced__c=false;
        wp.Waiver_Pre_programme_Survey_PDF__c=false;
        
        insert wp;
        
               
      Contact con = new Contact();
        con.FirstName = 'Kumar';
        con.LastName = 'Madhurendra';
        con.Email='kumar12@kumar.com';
        //con.department='Anglo';
        //con.High_Risk__c=true;
        //con.Company_Affiliation__c='Anglo american';
        //con.notActive__c=true;
        con.Home_Office__c='USA';
        insert con;
        
        String conName=wp.Contact_First_Name__c+' '+wp.Contact_Last_Name__c;
        list<Contact> conUp=new list<Contact>([select id,name,Email,High_Risk__c from contact where name=:conName limit 1]);
        
        Participation__c par = new Participation__c();
        par.Person__c = con.Id;
        par.Counter__c=1;
        par.Application_Round__c='A';
        par.LineManager_Approval_PDF__c=false;
        par.Participation_Year__c='2018';
        par.WaiverPre_programme_Survey_PDF__c=false;
        par.Name=con.FirstName+' '+con.LastName+'-'+wp.Application_Cycle__c+'-'+wp.Application_Round__c;
        insert par;
        //update par;
        
        Participation__c par1 = new Participation__c();
        if(conUp.size() >0){
            par1.Person__c = conUp[0].Id;
        }
        par1.LineManager_Approval_PDF__c=true;
        insert par1;
        
        Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c(Waiver_Pre_programme_Survey_Form__c = wp.Id,
                                                                                                Status__c = 'failed',
                                                                                    Error_Description__c = 'failed');
        insert logObj;
        
        Test.stopTest();
    }
    public static testmethod void method9(){
        Test.startTest();
        Waiver_Pre_programme_Survey_Form__c wp= new Waiver_Pre_programme_Survey_Form__c();
        wp.Application_Cycle__c='2018';
        wp.Application_Round__c='A';
        wp.Company_Affiliation__c='Anglo american';
        wp.Contact_BusUnitAnglo__c='Anglo';
        wp.Contact_BusUnitDebeers__c='Debeers';
        wp.Contact_City__c='new york';
        wp.Contact_First_Name__c='Kumar';
        wp.Contact_Last_Name__c='Madhurendra';
        wp.Contact_Phone_Number__c='9711260567';
        wp.Contact_Title__c='Developer';
        wp.Contact_Work_Email__c='kumar@kumar.com';
        wp.Home_Office_Country__c='USA';
        wp.Immediate_Impact_URL__c=false;
        wp.Line_Manager_Approval_PDF__c=false;
        wp.Line_Manager_Name__c='Kumar';
        wp.Line_Manager_Work_Email__c='Kumar12@kumar.com';
        wp.SingleResponseReportLink__c='https://ambassadors.com';
        wp.Status__c='failed';
        wp.SurveyURL__c='https://ambassadors.com';
        wp.Synced__c=false;
        wp.Waiver_Pre_programme_Survey_PDF__c=false;
        
        insert wp;
        
               
      Contact con = new Contact();
        con.FirstName = 'Kumar';
        con.LastName = 'Madhurendra';
        con.Email='kumar@kumar.com';
        //con.department='Anglo1';
        //con.High_Risk__c=true;
        con.Company_Affiliation__c='Anglo Indian american';
        //con.notActive__c=true;
        //con.Home_Office__c='USA';
        insert con;
        
        
        
        Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c(Waiver_Pre_programme_Survey_Form__c = wp.Id,
                                                                                                Status__c = 'failed',
                                                                                    Error_Description__c = 'failed');
        insert logObj;
        
        Test.stopTest();
    }
    
    public static testmethod void method10(){
        Test.startTest();
        Waiver_Pre_programme_Survey_Form__c wp= new Waiver_Pre_programme_Survey_Form__c();
        wp.Application_Cycle__c='2018';
        wp.Application_Round__c='A';
        wp.Company_Affiliation__c='Anglo american';
        wp.Contact_BusUnitAnglo__c='Anglo';
        //wp.Contact_BusUnitDebeers__c='Debeers';
        wp.Contact_City__c='new york';
        wp.Contact_First_Name__c='Kumar';
        wp.Contact_Last_Name__c='Madhurendra';
        wp.Contact_Phone_Number__c='9711260567';
        wp.Contact_Title__c='Developer';
        wp.Contact_Work_Email__c='kumar@kumar.com';
        wp.Home_Office_Country__c='USA';
        wp.Immediate_Impact_URL__c=false;
        wp.Line_Manager_Approval_PDF__c=false;
        wp.Line_Manager_Name__c='Kumar';
        wp.Line_Manager_Work_Email__c='Kumar12@kumar.com';
        wp.SingleResponseReportLink__c='https://ambassadors.com';
        wp.Status__c='failed';
        wp.SurveyURL__c='https://ambassadors.com';
        wp.Synced__c=false;
        wp.Waiver_Pre_programme_Survey_PDF__c=false;
        
        insert wp;
        
               
      Contact con = new Contact();
        con.FirstName = 'Kumar';
        con.LastName = 'Madhurendra';
        con.Email='kumar@kumar.com';
        con.department='Anglo1';
        //con.High_Risk__c=true;
        //con.Company_Affiliation__c='Anglo Indian american';
        //con.notActive__c=true;
        //con.Home_Office__c='USA';
        insert con;
        
        
        
        Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c(Waiver_Pre_programme_Survey_Form__c = wp.Id,
                                                                                                Status__c = 'failed',
                                                                                    Error_Description__c = 'failed');
        insert logObj;
        
        Test.stopTest();
    }
    public static testmethod void method11(){
        Test.startTest();
        Waiver_Pre_programme_Survey_Form__c wp= new Waiver_Pre_programme_Survey_Form__c();
        wp.Application_Cycle__c='2018';
        wp.Application_Round__c='A';
        wp.Company_Affiliation__c='Anglo american';
        wp.Contact_BusUnitAnglo__c='Anglo';
        //wp.Contact_BusUnitDebeers__c='Debeers';
        wp.Contact_City__c='new york';
        wp.Contact_First_Name__c='Kumar';
        wp.Contact_Last_Name__c='Madhurendra';
        wp.Contact_Phone_Number__c='9711260567';
        wp.Contact_Title__c='Developer';
        wp.Contact_Work_Email__c='kumar@kumar.com';
        wp.Home_Office_Country__c='USA';
        wp.Immediate_Impact_URL__c=false;
        wp.Line_Manager_Approval_PDF__c=false;
        wp.Line_Manager_Name__c='Kumar';
        wp.Line_Manager_Work_Email__c='Kumar12@kumar.com';
        wp.SingleResponseReportLink__c='https://ambassadors.com';
        wp.Status__c='failed';
        wp.SurveyURL__c='https://ambassadors.com';
        wp.Synced__c=false;
        wp.Waiver_Pre_programme_Survey_PDF__c=false;
        
        insert wp;
        
               
      Contact con = new Contact();
        con.FirstName = 'Kumar';
        con.LastName = 'Madhurendra';
        con.Email='kumar@kumar.com';
        con.department='kumartest';
        //con.High_Risk__c=true;
        //con.Company_Affiliation__c='Anglo Indian american';
        //con.notActive__c=true;
        //con.Home_Office__c='USA';
        insert con;
        
        
        
        Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c(Waiver_Pre_programme_Survey_Form__c = wp.Id,
                                                                                                Status__c = 'failed',
                                                                                    Error_Description__c = 'failed');
        insert logObj;
        
        Test.stopTest();
    }
    public static testmethod void method12(){
        Test.startTest();
        Waiver_Pre_programme_Survey_Form__c wp= new Waiver_Pre_programme_Survey_Form__c();
        wp.Application_Cycle__c='2018';
        wp.Application_Round__c='A';
        wp.Company_Affiliation__c='Anglo american';
        wp.Contact_BusUnitAnglo__c='Anglo';
        //wp.Contact_BusUnitDebeers__c='Debeers';
        wp.Contact_City__c='new york';
        wp.Contact_First_Name__c='Kumar';
        wp.Contact_Last_Name__c='Madhurendra';
        wp.Contact_Phone_Number__c='9711260567';
        wp.Contact_Title__c='Developer';
        wp.Contact_Work_Email__c='kumar12@kumar.com';
        wp.Home_Office_Country__c='USA';
        wp.Immediate_Impact_URL__c=false;
        wp.Line_Manager_Approval_PDF__c=false;
        wp.Line_Manager_Name__c='Kumar';
        wp.Line_Manager_Work_Email__c='Kumar12@kumar.com';
        wp.SingleResponseReportLink__c='https://ambassadors.com';
        wp.Status__c='failed';
        wp.SurveyURL__c='https://ambassadors.com';
        wp.Synced__c=false;
        wp.Waiver_Pre_programme_Survey_PDF__c=false;
        
        insert wp;
        
               
      Contact con = new Contact();
        con.FirstName = 'Kumar';
        con.LastName = 'Madhurendra';
        con.Email='44kumar13@kumar.com';
        //con.department='kumartest';
        //con.High_Risk__c=true;
        //con.Company_Affiliation__c='Anglo Indian american';
        //con.notActive__c=true;
        //con.Home_Office__c='USA';
        insert con;
        
        
        
        Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c(Waiver_Pre_programme_Survey_Form__c = wp.Id,
                                                                                                Status__c = 'failed',
                                                                                    Error_Description__c = 'failed');
        insert logObj;
        
        Test.stopTest();
    }
    
    public static testmethod void method13(){
        Test.startTest();
        Waiver_Pre_programme_Survey_Form__c wp= new Waiver_Pre_programme_Survey_Form__c();
        wp.Application_Cycle__c='2018';
        wp.Application_Round__c='A';
        wp.Company_Affiliation__c='Anglo american';
        wp.Contact_BusUnitAnglo__c='Anglo';
        //wp.Contact_BusUnitDebeers__c='Debeers';
        wp.Contact_City__c='new york';
        wp.Contact_First_Name__c='Kumar11';
        wp.Contact_Last_Name__c='Madhurendra33';
        wp.Contact_Phone_Number__c='9711260567';
        wp.Contact_Title__c='Developer';
        //wp.Contact_Work_Email__c='kumar12432@kumar.com';
        wp.Home_Office_Country__c='USA';
        wp.Immediate_Impact_URL__c=false;
        wp.Line_Manager_Approval_PDF__c=false;
        wp.Line_Manager_Name__c='Kumar';
        wp.Line_Manager_Work_Email__c='Kumar12@kumar.com';
        wp.SingleResponseReportLink__c='https://ambassadors.com';
        wp.Status__c='failed';
        wp.SurveyURL__c='https://ambassadors.com';
        wp.Synced__c=false;
        wp.Waiver_Pre_programme_Survey_PDF__c=false;
        
        insert wp;
        
               
      Contact con = new Contact();
        con.FirstName = 'Kumar11';
        con.LastName = 'Madhurendra33';
        con.Email='kumar12432@kumar.com';
        //con.department='kumartest';
        //con.High_Risk__c=true;
        //con.Company_Affiliation__c='Anglo Indian american';
        con.notActive__c=false;
        //con.Home_Office__c='USA';
        insert con;
        
        String conName=wp.Contact_First_Name__c+' '+wp.Contact_Last_Name__c;
        list<Contact> conUp=new list<Contact>([select id,name,Email,High_Risk__c from contact where name=:conName limit 1]);
        if(conUp.size()>0){
        //conUp[0].email='kumar12432@kumar.com';
        //update conUp;
        }
        Participation__c par = new Participation__c();
        par.Person__c = con.Id;
        par.Counter__c=1;
        par.Application_Round__c='A';
        par.LineManager_Approval_PDF__c=false;
        par.Participation_Year__c='2018';
        par.WaiverPre_programme_Survey_PDF__c=false;
        par.Name=con.FirstName+' '+con.LastName+'-'+wp.Application_Cycle__c+'-'+wp.Application_Round__c;
        insert par;
        //update par;
        
        Participation__c par1 = new Participation__c();
        if(conUp.size() >0){
            par1.Person__c = conUp[0].Id;
        }
        par1.LineManager_Approval_PDF__c=true;
        insert par1;
        
        Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c(Waiver_Pre_programme_Survey_Form__c = wp.Id,
                                                                                                Status__c = 'failed',
                                                                                    Error_Description__c = 'failed');
        insert logObj;
        
        Test.stopTest();
    }
    public static testmethod void method14(){
        Test.startTest();
        Waiver_Pre_programme_Survey_Form__c wp= new Waiver_Pre_programme_Survey_Form__c();
        wp.Application_Cycle__c='2018';
        wp.Application_Round__c='A';
        wp.Company_Affiliation__c='Anglo american';
        wp.Contact_BusUnitAnglo__c='Anglo';
        wp.Contact_BusUnitDebeers__c='Debeers';
        wp.Contact_City__c='new york';
        wp.Contact_First_Name__c='Kumar11';
        wp.Contact_Last_Name__c='Madhurendra33';
        wp.Contact_Phone_Number__c='9711260567';
        wp.Contact_Title__c='Developer';
        //wp.Contact_Work_Email__c='kumar12432@kumar.com';
        wp.Home_Office_Country__c='USA';
        wp.Immediate_Impact_URL__c=false;
        wp.Line_Manager_Approval_PDF__c=false;
        wp.Line_Manager_Name__c='Kumar';
        wp.Line_Manager_Work_Email__c='Kumar12@kumar.com';
        wp.SingleResponseReportLink__c='https://ambassadors.com';
        wp.Status__c='failed';
        wp.SurveyURL__c='https://ambassadors.com';
        wp.Synced__c=false;
        wp.Waiver_Pre_programme_Survey_PDF__c=false;
        
        insert wp;
        
        //list<Waiver_Pre_programme_Survey_Form__c> wp1= new list<Waiver_Pre_programme_Survey_Form__c>([select id,Contact_Work_Email__c,Contact_First_Name__c,Contact_Last_Name__c,Status__c,Synced__c from Waiver_Pre_programme_Survey_Form__c where id=:wp.id limit 1]);
        
        /*if(wp1.size()>0){
            //wp1[0].Contact_Work_Email__c='kumar12432@kumar.com';
            //wp1[0].Contact_First_Name__c='Kumar11';
            //wp1[0].Contact_Last_Name__c='Madhurendra33';
            wp1[0].Status__c='success';
            wp1[0].Synced__c=true;
            update wp1;
        }*/
               
      Contact con = new Contact();
        con.FirstName = 'Kumar11';
        con.LastName = 'Madhurendra33';
        con.Email='kumar12432@kumar.com';
        //con.department='kumartest';
        con.High_Risk__c=true;
        //con.Company_Affiliation__c='Anglo american';
        //con.notActive__c=false;
        //con.Home_Office__c='USA';
        //insert con;
        
        String conName=wp.Contact_First_Name__c+' '+wp.Contact_Last_Name__c;
        
        list<Contact> conUp=new list<Contact>([select id,name,Email,High_Risk__c from contact where name=:conName limit 1]);
        
        
        Application_Survey_Form_Logs__c logObj = new Application_Survey_Form_Logs__c(Waiver_Pre_programme_Survey_Form__c = wp.Id,
                                                                                                Status__c = 'failed',
                                                                                    Error_Description__c = 'failed');
        insert logObj;
        
        Test.stopTest();
    }
}