trigger teamCaptianUpdateTrigger on Team_Member__c (after insert,after update ) {
    set<id> projectIdSet = new set<id>();
    if(trigger.isInsert && trigger.isAfter){
        for(Team_Member__c tmpRecObj : trigger.new){
            if(tmpRecObj.Team_Captain__c && tmpRecObj.Project__c != null){
                projectIdSet.add(tmpRecObj.Project__c);
            }
        }
        if(projectIdSet.size()>0){
            teamCaptianUpdateTriggerHandler.captainUpdateMethod(projectIdSet,trigger.newmap);
        }
    }
    else if(trigger.isupdate && trigger.isAfter){
        for(Team_Member__c tmpRecObj : trigger.new){
            projectIdSet.add(tmpRecObj.Project__c);
        }
        if(projectIdSet.size()>0){
            teamCaptianUpdateTriggerHandler.captainUpdateMethod(projectIdSet,trigger.newmap);
        }
    }
}