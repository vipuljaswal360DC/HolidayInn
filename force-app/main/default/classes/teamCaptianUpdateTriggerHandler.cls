public class teamCaptianUpdateTriggerHandler {
    public static void captainUpdateMethod(set<id> projectIDset,map<id,Team_Member__c> oldmap){
        List<Projects__c> teamProjectList = new list<Projects__c>();
        List<Projects__c> updateProjectList = new list<Projects__c>();
        List<Team_Member__c> teamMemList = new list<Team_Member__c>();
        map<id,id> validationMap=new map<id,id>();
        teamProjectList=[select id,(select id,Team_Captain__c,Project__c,Name__c from Team_Members__r order by lastModifiedDate) from projects__c where id in :projectIDset];
        if(!teamProjectList.isEmpty()){
            for(Projects__c tmpPrjRec : teamProjectList){
                if(!tmpPrjRec.Team_Members__r.isEmpty()){
                    for(Team_Member__c tmpMemRec : tmpPrjRec.Team_Members__r){
                        teamMemList.add(tmpMemRec);
                    }
                }
            }
        }
        if(!teamMemList.isEmpty()){
            for(Team_Member__c tmpRecObj: teamMemList){
                if(tmpRecObj.Team_Captain__c){
                    if(validationMap.containsKey(tmpRecObj.Project__c)){
                        if(oldmap.containskey(tmpRecObj.Id)){
                            Team_Member__c tmpRec=oldmap.get(tmpRecObj.id);
                            tmpRec.addError(string.valueof(system.label.Team_Captain_Validation_Message));
                        }
                        
                    }
                    else{
                        validationMap.put(tmpRecObj.Project__c,tmpRecObj.Project__c);
                        Projects__c tmpProject=new Projects__c();
                        tmpProject.Id=tmpRecObj.Project__c;
                        tmpProject.Team_Captain__c=tmpRecObj.Name__c;
                        updateProjectList.add(tmpProject);
                    }
                }
            }
        }
        if(!updateProjectList.isEmpty()){
            try{
            	database.update(updateProjectList,false);
            }catch(exception e){
                system.debug('----Error Message ----'+e.getMessage());
                system.debug('----Error Line No ----'+e.getLineNumber());
            }
        }
    }

}