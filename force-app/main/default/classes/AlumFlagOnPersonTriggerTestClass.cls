@isTest
public class AlumFlagOnPersonTriggerTestClass {
    public static testmethod void method1(){
        Test.startTest();        
    	Contact con = new Contact();
        con.FirstName = 'Fname';
        con.LastName = 'Lname';
        insert con;
        Participation__c par = new Participation__c();
        par.Person__c = con.Id;
        insert par;
        update par;
        
        Participation__c par1 = new Participation__c();
        par1.Person__c = con.Id;
        insert par1;
        
        Test.stopTest();
    }
}