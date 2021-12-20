/*This is the handler class used in the triggers. Trigger Names:-
 * 1. AlumFlagOnPerson
 * 2. AnnualParticipationUpdateTrigger
 * 3. ParticipationInsertOrUpdateTrigger
*/

public class AnnualParticipationHandlerClass {
    
    /*This method will set the alum flag on the person records by check the participation record count.*/
    Public static void setAlumFlag(List<Participation__c> newTriggerList,List<Participation__c> oldTriggerList){
        
        /* contIds - This set is used to store the person Id related to the inserted participation records.*/
        Set<Id> contIds = New Set<Id>();
        if(newTriggerList!=Null){            
            for(Participation__c objPart:newTriggerList){
                if(objPart.Person__c!=null){
                    contIds.add(objPart.Person__c);
                }
            }
        }
        if(oldTriggerList!=Null){
            for(Participation__c objPart:oldTriggerList){
                if(objPart.Person__c!=null){
                    contIds.add(objPart.Person__c);
                }
            }
        } 
        /* contToUpdate - This list is used to store the contact record to perform the update operation after set the flag on the contact*/
        list<Contact> contToUpdate = new list<Contact>();
        
        /* lstCont - this list contains the contact record with there participation to check the number of particiaption records */
        List<Contact> lstCont = [Select id,Alum_Flag__c, (Select id, Person__c from PriorParticipations__r ) from Contact where id IN : contIds];
      
        for(Contact cont : lstCont){
            if(cont.PriorParticipations__r.size()>0 && !cont.Alum_Flag__c){             
                cont.Alum_Flag__c  = True;    
                contToUpdate.add(cont);            
            }else if(cont.PriorParticipations__r.size()==0){
                cont.Alum_Flag__c  = false;  
                contToUpdate.add(cont);     
            }
            
        }
        if(!contToUpdate.isEmpty()){
            //updating the contacts after set the flag value.
            update contToUpdate;   
        }
    }
    
    
    /* This method is used when there is an update on the project records.
     * This method used to create new annual participation record if no on exist for that cycle
     * as well as used to update the counter on annual participation record if record is exist for that application cycle. 
    */
    public static void createOrUpdateParticipationFromProject(List<Projects__c> lstProjectTriggerList, Map<Id,Projects__c> oldMap){
        
        /* mapProject - Map to store the project id vs project record of the updated project. 
         * mapProjectvsPerson - Map to store the list of the person related to the updated project id.
         * mapConPart - Map that has the person id and application cycle vs the particpation record of that cycle.
         * mapPersonName - Map that has the person id vs its full name.
         * setPerson - Set of all the person id related to the updated project record.
         * setTM - Set of all the team member id related to the updated project record. 
        */
        Map<Id,Projects__c> mapProject = new Map<Id,Projects__c>();                 
        Map<Id,List<String>> mapProjectvsPerson = new Map<Id,List<String>>();             
        Map<String,Participation__c> mapConPart = new Map<String,Participation__c>();    
        Map<Id,String> mapPersonName = new Map<Id,String>();                             
        Set<Id> setPerson = new Set<Id>();            
        Set<Id> setTM = new Set<Id>(); 
        
        try{
            /* lstUpdateParticipation - List of annual participation that has to be update after the increment in the counter for the existing record of that cycle.
             * lstInsertParticipation - List of annual particiaption that has to be insert.
             * ParticipationToinsert - Map of person id and application cycle vs the counter of the annual participation which has to be insert.
             * ParticipationToupdate - Map of person id and application cycle vs the counter of the annual participation which has to be update.
            */
            List<Participation__c> lstUpdateParticipation = new List<Participation__c>();             
            List<Participation__c> lstInsertParticipation = new List<Participation__c>();     
            Map<String,Decimal> ParticipationToinsert = new Map<String,Decimal>();             
            Map<String,Decimal> ParticipationToupdate = new Map<String,Decimal>();            
            
            //Filling the map of id vs project of the updated projects.
            for(Projects__c objProject : lstProjectTriggerList){
                mapProject.put(objProject.id, objProject);
            }
            System.debug('mapProject+++++ '+mapProject.keySet());
            
            //Query for Team Member which are related to the updated project records and fill the map of project vs person, set of person and set of Team Member. 
            for(Team_Member__c objTM : [Select Id, Application_Cycle__c, Name__c, Project__c,Application_Round__c, Proect_Status__c, Name From Team_Member__c where Project__c IN : mapProject.keySet()]){
                String uniq = objTM.Name__c +'-'+objTM.Application_Cycle__c+'-'+objTM.Application_Round__c;
                if(mapProjectvsPerson.containsKey(objTM.Project__c)){
                    List<String> tempPersonId = new List<String>(mapProjectvsPerson.get(objTM.Project__c));
                    tempPersonId.add(uniq);
                    mapProjectvsPerson.put(objTM.Project__c, tempPersonId);
                }else{
                    List<String> tempPersonId = new List<String>();
                    tempPersonId.add(uniq);
                    mapProjectvsPerson.put(objTM.Project__c, tempPersonId);
                }
                setPerson.add(objTM.Name__c);
                setTM.add(objTM.id);
            }
            System.debug('mapProjectvsPerson++++++setPerson++++++ '+mapProjectvsPerson+' ==+++++++ '+setPerson);
            
            //Query for person and their participation to fill the map of person and map of Contact vs participation.
            if(setPerson != null && setPerson.size()>0){
                for(Contact objcon: [Select id, FirstName, LastName From Contact where Id IN : setPerson]){
                    mapPersonName.put(objcon.id,objcon.FirstName + ' '+ objcon.LastName);
                }
                for(Participation__c objPart : [Select id, Counter__c,Participation_Year__c,Application_Round__c, Person__c From Participation__c where Person__c IN : setPerson]){
                    String uniq = objPart.Person__c +'-'+objPart.Participation_Year__c+'-'+objPart.Application_Round__c;
                    mapConPart.put(uniq, objPart);
                }
            }
            System.debug('++++=+mapConPart++++ '+mapConPart);
            
            //Loop over the updated project records.
            for(Projects__c objProject : lstProjectTriggerList){
                //Check if status is null or not and changed or not
                if(objProject.Status__c != null && oldMap.get(objProject.id).Status__c != objProject.Status__c){
                    //Check current project status
                    if(((objProject.Status__c == 'Accepted' && oldMap.get(objProject.id).Status__c != 'Approved in Principle') 
                        || (objProject.Status__c == 'Approved in Principle' && oldMap.get(objProject.id).Status__c != 'Accepted'))){
                        //Check if any Team Member of same person has same project coming from trigger.
                        if(mapProjectvsPerson.containsKey(objProject.Id)){
                            //Loop over the related person of the project.
                            for(String personId : mapProjectvsPerson.get(objProject.Id)){
                                System.debug('++++=+personId++++ '+personId);
                                System.debug('++++=+mapConPart.containsKey(personId)++++ '+mapConPart.containsKey(personId));
                                
                                //Calculate the counter value for each application cycle and fill the same in maps to insert or update the annual particaption records.
                                if(mapConPart != null && mapConPart.size()>0 && mapConPart.containsKey(personId)){
                                    Participation__c partObj = mapConPart.get(personId);
                                    if(ParticipationToupdate != null && ParticipationToupdate.containsKey(partObj.Id)){
                                        Decimal counter = ParticipationToupdate.get(partObj.Id);
                                        if(counter == null){
                                            counter = 1;
                                        }else{
                                            counter +=1; 
                                        }
                                        ParticipationToupdate.put(partObj.Id, counter);
                                    }else{
                                        Decimal counter = partObj.Counter__c;
                                        if(counter == null){
                                            counter = 1;
                                        }else{
                                            counter +=1; 
                                        }
                                        ParticipationToupdate.put(partObj.Id, counter);
                                    }
                                }else{    //Fill Map of ParticipationToinsert
                                    if(ParticipationToinsert != null && ParticipationToinsert.containsKey(personId)){
                                        Decimal counter = ParticipationToinsert.get(personId);
                                        counter++;
                                        ParticipationToinsert.put(personId, counter);
                                    }else{
                                        ParticipationToinsert.put(personId, 1);
                                    }
                                }
                            }
                        }
                    }
                    //Check if status is approved in prinicple or accepted and change to declined or submitted or Withdrawn
                    else if((oldMap.get(objProject.id).Status__c == 'Accepted' || oldMap.get(objProject.id).Status__c == 'Approved in Principle') && (objProject.Status__c == 'Declined' || objProject.Status__c == 'Submitted' || objProject.Status__c == 'Withdrawn')){
                        //Check if any Team Member of same person has same project coming from trigger.
                        if(mapProjectvsPerson.containsKey(objProject.Id)){
                            for(String personId : mapProjectvsPerson.get(objProject.Id)){
                                System.debug('++++=+personId++++ '+personId);
                                System.debug('++++=+mapConPart.containsKey(personId)++++ '+mapConPart.containsKey(personId));
                                if(mapConPart != null && mapConPart.size()>0 && mapConPart.containsKey(personId)){
                                    Participation__c partObj = mapConPart.get(personId);
                                    if(ParticipationToupdate != null && ParticipationToupdate.containsKey(partObj.Id)){
                                        Decimal counter = ParticipationToupdate.get(partObj.Id);
                                        if(counter >0){
                                            counter--;
                                        }
                                        ParticipationToupdate.put(partObj.Id, counter);
                                    }else{
                                        Decimal counter = partObj.Counter__c;
                                        if(counter >0){
                                            counter--;
                                        }
                                        ParticipationToupdate.put(partObj.Id, counter);
                                    }
                                }
                            }
                        }   
                    }
                }
            }
            System.debug('++++=+ParticipationToinsert++++ '+ParticipationToinsert);
            //Check if Map of Project Vs Contact is null or not
            if(ParticipationToinsert != null && ParticipationToinsert.size()>0){
                //Loop over the person to insert the new participation records with their counter.
                for(String person : ParticipationToinsert.keySet()){
                    Id personId = person.split('-')[0]; 
                    Participation__c objPart = new Participation__c();
                    objPart.Name = mapPersonName.get(personId)+'-'+person.split('-')[1]+'-'+person.split('-')[2];
                    objPart.Counter__c = ParticipationToinsert.get(person);
                    objPart.Participation_Year__c = person.split('-')[1];
                    objPart.Application_Round__c = person.split('-')[2];
                    objPart.Person__c = personId;
                    lstInsertParticipation.add(objPart);
                }
            }   
            //Loop over the person to update the participation records with the updated counter value.
            if(ParticipationToupdate != null && ParticipationToupdate.size()>0){
                for(String parti : ParticipationToupdate.keySet()){
                    Participation__c objPart = new Participation__c(Id=parti);
                    objPart.Counter__c = ParticipationToupdate.get(parti);
                    lstUpdateParticipation.add(objPart);
                }
            }   
            System.debug('++++lstUpdateParticipation+++'+lstUpdateParticipation);
            //Insert the List of participation
            if(lstInsertParticipation.size()>0){
                insert lstInsertParticipation;
            }
            //Update the list of Participation
            if(lstUpdateParticipation.size()>0){
                update lstUpdateParticipation;
            }
        }catch(Exception e){
            System.debug('-----Error---'+e.getMessage()+'----Line NUmber----'+e.getLineNumber());
        }
    }
    
    
    /* This method is used when a new team member record is created.
     * This method used to create new annual participation record if no on exist for that cycle
     * as well as used to update the counter on annual participation record if record is exist for that application cycle. 
    */
    public static void createOrUpdateParticipationFromTeamMem(List<Team_Member__c> lstTMTriggerList){
        try{
            /* mapPersonName - Map that has the person id vs its full name.
             * mapTM - Map to store the team member id vs team member record of the inserted team member records.
             * mapConPart - Map that has the person id vs the particpation record of that cycle.
             * setprojId - Set of Project to contain Project id related to the inserted team member records.
             * setPerson - Set of Person to contain Person Id related to the inserted team member records.
             * lstProj - List of all the project records related to the inserted team member records.
             * lstUpdateParticipation - List of annual participation that has to be update after the increment in the counter for the existing record of that cycle.
             * lstInsertParticipation - List of annual particiaption that has to be insert.
            */
            Map<Id,String> mapPersonName = new Map<Id,String>();                               
            Map<Id,Team_Member__c> mapTM = new Map<Id,Team_Member__c>();                
            Map<String,Participation__c> mapConPart = new Map<String,Participation__c>();       
            Set<Id> setprojId = new Set<Id>();                                         
            Set<Id> setPerson = new Set<Id>();                                         
            List<Projects__c> lstProj = new List<Projects__c>();                       
            List<Participation__c> lstUpdateParticipation = new List<Participation__c>();       
            List<Participation__c> lstInsertParticipation = new List<Participation__c>();   
            
            //Loop over the inserted Team Member and fill the map of team Member, set of person and set of Project.
            for(Team_Member__c objTM : lstTMTriggerList){
                mapTM.put(objTM.Project__c, objTM);
                setPerson.add(objTM.Name__c);
                setprojId.add(objTM.Project__c);
            }
            
            //Fill the Map of Project in which coming Team Member are the childs.
            Map<Id, Projects__c> m = new Map<Id, Projects__c>([Select Id, Name, Status__c,Application_Cycle__c,Application_Round__c From Projects__c where Id in: mapTM.keyset()]);
            System.debug('++++m++++ '+m);
            
            //Add all the values to the list of project from map of project.
            lstProj.addall(m.values());
            System.debug('++++lstProj++++ '+lstProj);
            
            //Check if person is exist in the team member or not and query for each participation and fill the map of person vs participation.
            if(setPerson.size()>0){
                for(Contact objcon: [Select id, FirstName, LastName From Contact where Id IN : setPerson]){
                    mapPersonName.put(objcon.id,objcon.FirstName + ' '+ objcon.LastName);
                }
                for(Participation__c objPart : [Select id, Counter__c, Participation_Year__c , Person__c,Application_Round__c From Participation__c where Person__c in : setPerson]){
                    String uniq = objPart.Person__c +'-'+objPart.Participation_Year__c+'-'+objPart.Application_Round__c;
                    mapConPart.put(uniq, objPart);
                }
            }
            
            //Loop over project records related to inserted team member
            for(Projects__c objProj : lstProj){
                //Check the status of project
                if(objProj.Status__c != null && (objProj.Status__c == 'Accepted' || objProj.Status__c == 'Approved in Principle')){
                    //Check if team member contains project.
                    if(mapTM.containskey(objProj.id)){
                        //Check if Participation person has same person as Team Member and increment in NO of Participation and fill the list to update.
                        String key = mapTM.get(objProj.Id).Name__c+'-'+objProj.Application_Cycle__c+'-'+objProj.Application_Round__c;
                        if(mapConPart.containsKey(key)){
                            if(mapConPart.get(key).Participation_Year__c != null && mapConPart.get(key).Application_Round__c != null && mapConPart.get(key).Participation_Year__c == mapTM.get(objProj.Id).Application_Cycle__c && mapConPart.get(key).Application_Round__c == mapTM.get(objProj.Id).Application_Round__c){
                                mapConPart.get(key).Counter__c++;
                            }
                            lstUpdateParticipation.add(mapConPart.get(key));
                        }
                        //Create New Participation under same team member and same project.
                        else{
                            Participation__c objPart = new Participation__c();
                            objPart.Name = mapPersonName.get(mapTM.get(objProj.Id).Name__c)+'-'+ mapTM.get(objProj.Id).Application_Cycle__c+'-'+mapTM.get(objProj.Id).Application_Round__c;
                            objPart.Counter__c = 1;
                            objPart.Person__c = mapTM.get(objProj.Id).Name__c;
                            objPart.Participation_Year__c = mapTM.get(objProj.Id).Application_Cycle__c;
                            objPart.Application_Round__c = mapTM.get(objProj.Id).Application_Round__c;
                            lstInsertParticipation.add(objPart);
                            
                            System.debug('++++New Part+++ '+objPart);
                        }
                    }
                }
            }
            //update the Participation.
            if(lstUpdateParticipation.size()>0){
                update lstUpdateParticipation;
            }
            //insert the Participation.
            if(lstInsertParticipation.size()>0){
                insert lstInsertParticipation;
            }
            // Calling UpdatePeopleAppFromTM Method to Update People Record Team Member Count Update
            UpdatePeopleAppFromTM(lstTMTriggerList);
        }catch(Exception e){
            System.debug('-----Error---'+e.getMessage()+'----Line NUmber----'+e.getLineNumber());
        }
    }
    
    /*
     Created this method on June 15 2021
     This Method UpdatePeopleAppFromTM is to update total no of Applications and is Team Member checkbox when TM is inserted or updated or deleted.
    */
    public static void UpdatePeopleAppFromTM(List<Team_Member__c> lstTMTriggerList){
        try{
            
            System.debug('--lstTMTriggerList---'+lstTMTriggerList.size());
            //Map of PersonVsTeammember for counting total App to the corresponding Projects
            Map<String,Integer> personVsCountAppMap= new Map<String,Integer>();
            list<Contact> conList= new list<Contact>();// contactList corresponding to TM;
            set<String> PersonIdset=new set<string>();
            list<Contact> conListToUpdate= new list<Contact>();// contactList to update;
            // storing setOfPersonId from List of TM
            for(Team_Member__c tm:lstTMTriggerList){
                if(tm.Name__c != null){
                    PersonIdset.add(tm.Name__c);
                }
            }
            if(PersonIdset.size() >0){
                conList= [select id,Name,Is_Team_Member__c,Total_Number_of_Applications__c,(select id,Name__c from Project_Membership__r) from Contact where ID IN:PersonIdset];
            }
            System.debug('--conList---'+conList.size());
            if(conList.size() >0){
                for(Contact con:conList){
                    if(con.Project_Membership__r != null){
                        System.debug('--con.Project_Membership__r---'+con.Project_Membership__r.size());
                        for(Team_Member__c tm : con.Project_Membership__r){
                            if(personVsCountAppMap.containsKey(tm.Name__c)){
                                Integer countApp=personVsCountAppMap.get(tm.Name__c);
                                countApp++;
                                personVsCountAppMap.put(tm.Name__c,countApp);
                                
                    
                            }else{
                                list<Team_Member__C>tmList= new list<Team_Member__C>();
                                tmList.add(tm);
                                personVsCountAppMap.put(tm.Name__c,tmList.size());
                                
                            }
                        }
                    }
                }
                    
                    
                for(contact con :conList){
                    if(personVsCountAppMap.containsKey(con.id)){
                        con.Total_Number_of_Applications__c=personVsCountAppMap.get(con.id);
                        con.Is_Team_Member__c=true;
                    }else{
                        con.Total_Number_of_Applications__c=0;
                        con.Is_Team_Member__c=false;
                    }
                    
                    conListToUpdate.add(con);
                }
                    


            }
            if(conListToUpdate.size() > 0){
                update conListToUpdate;
            }
            
            
        }catch(Exception e){
            System.debug('-----Error in people updateInsertTM---'+e.getMessage()+'----Line NUmber----'+e.getLineNumber());
        }
        
    }
    
    /*
     Created this method on June 17 2021
     This Method UpdatePeopleAppFromTM is to update total no of Applications and List Of Years Field when AP is inserted or updated or deleted.
    */
    public static void UpdatePeopleFromAP(List<Participation__c> lstAPTriggerList){
        try{
            
            System.debug('--lstAPTriggerList---'+lstAPTriggerList.size());
            //Map of PersonVsAPMap for counting total AP to the corresponding Projects
            Map<String,Integer> PersonVsAPMap= new Map<String,Integer>();
            Map<String,String> PersonVsAPListYrsMap= new Map<String,String>();
            list<Contact> conList= new list<Contact>();// contactList corresponding to AP;
            set<String> PersonIdset=new set<string>();
            list<Contact> conListToUpdate= new list<Contact>();
            set<String> ApIdset=new set<string>();// for storing Zero counter AP in order to delete
            // contactList to update;
            // storing setOfPersonId from List of TM
            for(Participation__c tm:lstAPTriggerList){
                if(tm.Person__c != null){
                    PersonIdset.add(tm.Person__c);
                }
                if(tm.Counter__c == 0){
                    ApIdset.add(tm.id);
                }
            }
            //processing Zero counter AP to delete
            if(ApIdset.size() >0){
                list<Participation__c> APDeleteList= new list<Participation__c>([select id from Participation__c where ID IN: ApIdset]);
                
                if(APDeleteList.size() >0){
                    delete APDeleteList;
                }
            }
            
            if(PersonIdset.size() >0){
                conList= [select id,Name,List_of_years__c,Total_Number_Of_Participations__c,(select id,Name,Person__c,Counter__c,Participation_Year__c from PriorParticipations__r) from Contact where ID IN:PersonIdset];
            }
            System.debug('--conList---'+conList.size());
            
            if(conList.size() >0){
                for(Contact con:conList){
                    
                    set<String> ListAPYrs=new Set<String>();
                    Integer Counter=0;
                    if(con.PriorParticipations__r != null){
                        System.debug('--con.PriorParticipations__r---'+con.PriorParticipations__r.size());
                        
                        for(Participation__c tm : con.PriorParticipations__r){
                            if(tm.Counter__c != null){
                                Counter +=integer.valueof(tm.Counter__c);
                            }
                            PersonVsAPMap.put(tm.Person__c,Counter);
                            if(tm.Participation_Year__c != ''){
                                ListAPYrs.add(tm.Participation_Year__c);
                                PersonVsAPListYrsMap.put(tm.Person__c,string.valueOf(ListAPYrs));
                            }
                        }
                        
                        
                    }
                    
                }
                
                For(Contact con: conList){
                    if(PersonVsAPMap.containsKey(con.id)){
                        con.Total_Number_Of_Participations__c=PersonVsAPMap.get(con.id);
                    }else{
                        con.Total_Number_Of_Participations__c=0;
                    }
                    if(PersonVsAPListYrsMap.containsKey(con.id)){
                        String paryrsList=PersonVsAPListYrsMap.get(con.id);
                        paryrsList=paryrsList.removeEnd('}');
                        paryrsList=paryrsList.removeStart('{');
                        con.List_of_years__c=paryrsList;
                    }else{
                        con.List_of_years__c='';
                    }
                    conListToUpdate.add(con);
                }
                    
                
            }
            if(conListToUpdate.size() > 0){
                update conListToUpdate;
            }
            
            
        }catch(Exception e){
            System.debug('-----Error in people updateInsertAP---'+e.getMessage()+'----Line NUmber----'+e.getLineNumber());
        }
        
    }
    
}