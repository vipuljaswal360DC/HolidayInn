/* Class Name: ShowGroupFolderControllerTestClass */
/* Description: This is the test class for the class : ShowGroupFolderController */

@isTest
public class ShowGroupFolderControllerTestClass {

    /* Method name:  testMethod1 */
    /* Input: none */
    /* returns: none */
    @isTest
    public static void testMethod1(){
        //Creating Folder Record
        Community_Folder__c commFolderObj = new Community_Folder__c();
        commFolderObj.Name = 'Test Folder 1';
        commFolderObj.Folder_Type__c = 'Group';
        commFolderObj.Sub_Folder__c = false;
        if(commFolderObj != null){
            insert commFolderObj;
        }
        
        //Creating Sub-Folder Record
        Community_Folder__c commSubFolderObj = new Community_Folder__c();
        commSubFolderObj.Parent_Folder__c = commFolderObj.Id;
        commSubFolderObj.Name = 'Test SubFolder 1';
        commSubFolderObj.Folder_Type__c = 'Group';
        commSubFolderObj.Sub_Folder__c = true;
        if(commSubFolderObj != null){
            insert commSubFolderObj;
        }
        
        //Creating Link Record
        Community_Link__c commLinkObj = new Community_Link__c();
        commLinkObj.Community_Folder__c = commSubFolderObj.Id;
        commLinkObj.Link__c = 'www.test.com';
        commLinkObj.Title__c = 'Test Link';
        if(commLinkObj != null){
            insert commLinkObj;
        }
        
        ContentVersion contentVersion = new ContentVersion(
            Title = 'Penguins',
            PathOnClient = 'Penguins.jpg',
            VersionData = Blob.valueOf('Test Content'),
            IsMajorVersion = true
        );
        insert contentVersion;    
        List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
        
        //create ContentDocumentLink  record 
        ContentDocumentLink ContDocumentLink = New ContentDocumentLink();
        ContDocumentLink.LinkedEntityId = commFolderObj.Id;
        ContDocumentLink.ContentDocumentId = documents[0].Id;
        ContDocumentLink.shareType = 'V';
        insert ContDocumentLink;
        
        test.startTest();
        ShowGroupFolderController.renameFolderRecordApex(commFolderObj.Id,'New Name');
        ShowGroupFolderController.renameFileRecordApex(documents[0].Id,'New Name');
        ShowGroupFolderController.getCurrentUserProfileApex();
        ShowGroupFolderController.getSubFolderBackApex(commSubFolderObj.Id);
        ShowGroupFolderController.getSubFolderApex(commSubFolderObj.Id);
        ShowGroupFolderController.getLinksApex(commSubFolderObj.Id);
        ShowGroupFolderController.saveLinkApex(commSubFolderObj.Id, commLinkObj);
        ShowGroupFolderController.deleteLinkRecordApex(commLinkObj.Id);
        ShowGroupFolderController.saveSubFolderApex(commFolderObj.Id,commSubFolderObj,'Group');
        ShowGroupFolderController.getFilesApex(commFolderObj.Id);
        ShowGroupFolderController.deleteFileRecordApex(documents[0].Id);
        test.stopTest();
    }
    
    @isTest
    public static void testMethod2(){
        ShowGroupFilesLinksHelper.getCurrentUserProfileApex();
        
        Community_Folder__c commFolderObj = new Community_Folder__c();
        commFolderObj.Name = 'Test Folder 1';
        commFolderObj.Folder_Type__c = 'Group';
        commFolderObj.Sub_Folder__c = false;
        if(commFolderObj != null){
            insert commFolderObj;
        }
        
        //Create Group
        Group grp = new Group();
        grp.Name = 'Test Group';
        grp.Type = 'Regular'; 
        insert grp;
        
        ContentVersion contentVersion = new ContentVersion(
            Title = 'Penguins',
            PathOnClient = 'Penguins.jpg',
            VersionData = Blob.valueOf('Test Content'),
            IsMajorVersion = true
        );
        insert contentVersion;    
        List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
        //create ContentDocumentLink  record 
        ContentDocumentLink ContDocumentLink = New ContentDocumentLink();
        ContDocumentLink.LinkedEntityId = commFolderObj.Id;
        ContDocumentLink.ContentDocumentId = documents[0].Id;
        ContDocumentLink.shareType = 'V';
        ContDocumentLink.Visibility = 'AllUsers';
        insert ContDocumentLink;
        
        ShowGroupFolderController.getFilesApex(commFolderObj.Id);
        ShowGroupFolderController.deleteFileRecordApex(documents[0].Id);
        ShowGroupFolderController.getFoldersApex('Group',grp.Id);
        
    }
    
     @isTest
    public static void testMethod3(){
        Group grp = new Group();
        grp.Name = 'Test Group';
        grp.Type = 'Regular'; 
        insert grp;
        ShowGroupFolderController.getGroupMember(grp.Id);
        ShowGroupFolderController.getGroupMember('');
        ShowGroupFolderController.getCurrentUserId();
    }
}