public class PATriggerhandler {
    public static void lockEOIRecord(List<Project_Application__c> lstEOI){
        List<Project_Application__c> listEOI = new List<Project_Application__c>();
        Map<ID,USer> mapUser = new Map<Id,USer>([select id,name,contactId from user where contactID!=NULL AND 
                                                 Profile.name = 'Custom Customer Community Plus Login User']);
        for(Project_Application__c objeoi : lstEOI){
            if(mapUser.containsKey(objeoi.LastModifiedById)){
                listEOI.add(objeoi);
            }
        }
        system.debug('listEOI-'+listEOI);
        if(listEOI.size()>0){
            List<Approval.LockResult> lrList = Approval.lock(listEOI, false);
        }
    }
}