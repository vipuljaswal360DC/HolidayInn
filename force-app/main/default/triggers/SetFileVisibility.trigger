/*Trigger Name : SetFileVisibility
 *Functionality : This trigger set the visibility of inserted ContentDocumentLink to All Users. */

trigger SetFileVisibility on ContentDocumentLink(before insert) {
     for (ContentDocumentLink cdl : Trigger.new) {
          //if (cdl.LinkedEntityId.getSObjectType().getDescribe().getName() == 'Community_Folder__c') {
               cdl.visibility = 'AllUsers';
          //}
     }
}