@isTest
public class AnnualParticipationUpdateTriggerTest 
{
    @isTest
    public static void unitTest1()
    {
        Account objAcc = new Account();
        objAcc.Name = 'Test';
		insert objAcc;
            
        Contact objCon = new Contact();
        objCon.AccountId = objAcc.Id;
        objCon.LastName = 'Test';
        insert objCon;
        
        Projects__c objProj = new Projects__c();
        objProj.Host_Organization__c = objAcc.Id;
        objProj.Team_Captain__c = objCon.Id;
        objProj.Status__c = 'Accepted';
        objProj.Application_Cycle__c = '2020';
        insert objProj;
        
        Projects__c objProj1 = new Projects__c();
        objProj1.Host_Organization__c = objAcc.Id;
        objProj1.Team_Captain__c = objCon.Id;
        objProj1.Status__c = 'Accepted';
        objProj1.Application_Cycle__c = '2019';
        insert objProj1;
        
        Team_Member__c objTM = new Team_Member__c();
        objTM.Name__c = objCon.Id;
        objTM.Project__c = objProj.id;
        insert objTM;
        
        Team_Member__c objTM1 = new Team_Member__c();
        objTM1.Name__c = objCon.Id;
        objTM1.Project__c = objProj1.id;
        insert objTM1;
        
        objProj1.Status__c = 'Approved in Principle';
        update objProj1;
        
        objProj.Status__c = 'Approved in Principle';
        update objProj;
        
        objProj1.Status__c = 'Submitted';
        update objProj1;
        
        objProj.Status__c = 'Submitted';
        update objProj;
    }
    @isTest
    public static void unitTest2()
    {
        Account objAcc = new Account();
        objAcc.Name = 'Test';
		insert objAcc;
            
        Contact objCon = new Contact();
        objCon.AccountId = objAcc.Id;
        objCon.LastName = 'Test';
        insert objCon;
        
        Projects__c objProj = new Projects__c();
        objProj.Host_Organization__c = objAcc.Id;
        objProj.Team_Captain__c = objCon.Id;
        objProj.Status__c = 'Submitted';
        objProj.Application_Cycle__c = '2020';
        insert objProj;
        
        Projects__c objProj1 = new Projects__c();
        objProj1.Host_Organization__c = objAcc.Id;
        objProj1.Team_Captain__c = objCon.Id;
        objProj1.Status__c = 'Submitted';
        objProj1.Application_Cycle__c = '2019';
        insert objProj1;
        
        Team_Member__c objTM = new Team_Member__c();
        objTM.Name__c = objCon.Id;
        objTM.Project__c = objProj.id;
        insert objTM;
        
        Team_Member__c objTM1 = new Team_Member__c();
        objTM1.Name__c = objCon.Id;
        objTM1.Project__c = objProj1.id;
        insert objTM1;
        
        objProj1.Status__c = 'Accepted';
        update objProj1;
        
        objProj.Status__c = 'Approved in Principle';
        update objProj;
    }
}