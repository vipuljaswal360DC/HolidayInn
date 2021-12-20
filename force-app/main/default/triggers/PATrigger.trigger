trigger PATrigger on Project_Application__c (before insert) {
    if(trigger.isUpdate){
        List<Project_Application__c> lstLockEOI = new List<Project_Application__c>();
        List<Project_Application__c> lstUnlockEOI = new List<Project_Application__c>();
        
        for(Project_Application__c objeoi : Trigger.new){
            if(Trigger.old!=NULL && Trigger.oldMap!=NULL && Trigger.oldMAp.get(objeoi.id).status__c=='In Submission' && objeoi.status__c == 'Submitted' ){
                lstLockEOI.add(objeoi);
            }else if(Trigger.old!=NULL && Trigger.oldMap!=NULL && Trigger.oldMap.get(objeoi.Id).status__c!=objeoi.status__c && objeoi.status__c == 'In Submission' ){
                if(approval.islocked(objeoi.id)){
                    lstUnlockEOI.add(objeoi);
                }
            }
        }
               
        if(!lstUnlockEOI.isEmpty()){
            List<Approval.unLockResult> lrList = Approval.unlock(lstUnlockEOI, false);
        }else if(!lstLockEOI.isEmpty()){
            PATriggerhandler.lockEOIRecord(lstLockEOI);
        }
         
        //EOITriggerhandler.unLockEOIRecord(lstUnlockEOI);
    }
}