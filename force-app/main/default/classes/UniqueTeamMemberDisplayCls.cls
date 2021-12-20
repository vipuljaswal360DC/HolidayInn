/* Class Name: UniqueTeamMemberDisplayCls
* Usage: This utility class will return the Unique team member data along with #Total Participants .
* 
*/

public class UniqueTeamMemberDisplayCls {
    
    //@AuraEnabled public list<wrapperClass> returnwrapperClassList{ get; set;}
    @AuraEnabled(cacheable=true)
    public static List<wrapperClass> initMethod(){
        // create a wrapper class object and set the wrapper class @AuraEnabled properties and return it to the lightning component.
        
        
        // team Memnber List
        List<Team_Member__c> tempTM  = new List<Team_Member__c> ();
        Set<String> uniqueTeamMembers = new Set<String> ();// for storing unique Person id.
        Set<String> UniqueProjectIdsSet = new Set<String> ();//storing unique Project ids
        tempTM = [select id,Name__c,Project__c,Project__r.Total_Team_Members__c,Application_Cycle__c from Team_Member__C  order by Name__c,Application_Cycle__c];     
        for (team_Member__c tm: tempTM) {
            
            if (tm.Name__c != null){
                 uniqueTeamMembers.add(tm.Name__c);// filling Unique People Id in a set
            }
            if (tm.Project__c != null){
                 UniqueProjectIdsSet.add(tm.Project__c);// filling Unique project Id in a set
            }
            
        }
        list<wrapperClass> returnwrapperClassList= new list<wrapperClass>();// for storing all objecte data in a wrapper list
        
        list<Contact> conList=new list<Contact>([select id, name,(select id,Name__c,Project__c,Project__r.Total_Team_Members__c,Application_Cycle__c from Project_Membership__r where Project__c =:UniqueProjectIdsSet),(select id,Name,Counter__c,Person__c,Project_ID__c,Team_Member_ID__c,Participation_Year__c from PriorParticipations__r order by Participation_Year__c), AccountID,Account.BillingCountry,Home_Office__c,Account_Name__c,Company_Affiliation__c from contact where Id in :uniqueTeamMembers]);
        
        
        if(conList.size() > 0){
            For(Contact con :conList){
                
                Map<String,Integer> tmAppCyclegetMap=new Map<String,Integer>();
                
                String JSONInfoForAPP;
                if(con.Project_Membership__r.size() >0){
                    
                    for(Team_Member__C tm: con.Project_Membership__r){
                        
                        if(tmAppCyclegetMap.containsKey(tm.Application_Cycle__c)){
                            Integer countAppYr=tmAppCyclegetMap.get(tm.Application_Cycle__c);
                            countAppYr++;
                            tmAppCyclegetMap.put(tm.Application_Cycle__c,countAppYr);
                            
                            JSONInfoForAPP =String.ValueOf(tmAppCyclegetMap);
                        }else{
                            list<Team_Member__C>tmList= new list<Team_Member__C>();
                            tmList.add(tm);
                            tmAppCyclegetMap.put(tm.Application_Cycle__c,tmList.size());
                            
                            JSONInfoForAPP =String.ValueOf(tmAppCyclegetMap);
                        }
                    }
                }
                
                JSONInfoForAPP=JSONInfoForAPP.replace('}', ']');
                JSONInfoForAPP=JSONInfoForAPP.replace('{', '[');
                
                if(con.PriorParticipations__r.size() > 0){
                    returnwrapperClassList.add( new wrapperClass(Con,con.PriorParticipations__r,con.Project_Membership__r.size(),con.PriorParticipations__r.size(),conList.size(),con.Project_Membership__r,JSONInfoForAPP));    
                }
            }
        }
        
        
        return returnwrapperClassList;    
    }
    
    // Method to search People by application Year
    @AuraEnabled(cacheable=true)
    public static List<wrapperClass> searchByApplicationYear(String searchKeyWord){
        // create a wrapper class object and set the wrapper class @AuraEnabled properties and return it to the lightning component.
      List<Team_Member__c> tempTM  = new List<Team_Member__c> ();
      Set<String> uniqueTeamMembers = new Set<String> ();// for storing unique Person id.
      Set<String> UniqueProjectIdsSet = new Set<String> ();//storing unique Project ids
      String searchKey; 
      list<wrapperClass> returnwrapperClassList= new list<wrapperClass>();
      
      list<Contact> conList;
        if(searchKeyWord.contains(','))
         {
             List<String> searchKeyCode = searchKeyWord.split(',') ;
             tempTM = [select id,Name__c,Project__c,Project__r.Total_Team_Members__c,Application_Cycle__c from Team_Member__C where Application_Cycle__c!= '' AND Application_Cycle__c in: searchKeyCode order by Name__c,Application_Cycle__c limit 50000]; 
             if(tempTM.size() > 0){
        
            for (team_Member__c tm: tempTM) {
                
                if (tm.Name__c != null){
                     uniqueTeamMembers.add(tm.Name__c);// filling Unique People Id in a set
                }
                if (tm.Project__c != null){
                     UniqueProjectIdsSet.add(tm.Project__c);// filling Unique project Id in a set
                }
            }
        }
        
            conList=new list<Contact>([select id, name,(select id,Name__c,Project__c,Project__r.Total_Team_Members__c,Application_Cycle__c from Project_Membership__r where Project__c =:UniqueProjectIdsSet),(select id,Name,Counter__c,Person__c,Project_ID__c,Team_Member_ID__c,Participation_Year__c from PriorParticipations__r), AccountID,Account_Name__c,Home_Office__c,Account.BillingCountry,Company_Affiliation__c from contact where Id in :uniqueTeamMembers]);    
         }
         else
         {
         
             searchKey = searchKeyWord + '%';
             tempTM = [select id,Name__c,Project__c,Project__r.Total_Team_Members__c,Application_Cycle__c from Team_Member__C where Application_Cycle__c != '' AND Application_Cycle__c LIKE: searchKey order by Name__c,Application_Cycle__c limit 50000];
             if(tempTM.size() > 0){
        
            for (team_Member__c tm: tempTM) {
                
                if (tm.Name__c != null){
                     uniqueTeamMembers.add(tm.Name__c);// filling Unique People Id in a set
                }
                if (tm.Project__c != null){
                     UniqueProjectIdsSet.add(tm.Project__c);// filling Unique project Id in a set
                }
            }
        }
        
           conList=new list<Contact>([select id, name,(select id,Name__c,Project__c,Project__r.Total_Team_Members__c,Application_Cycle__c from Project_Membership__r where Project__c =:UniqueProjectIdsSet ),(select id,Name,Counter__c,Person__c,Project_ID__c,Team_Member_ID__c,Participation_Year__c from PriorParticipations__r order by Participation_Year__c ), AccountID,Home_Office__c,Account.BillingCountry,Account_Name__c,Company_Affiliation__c from contact where Id in :uniqueTeamMembers]);         
          }
            
        
        if(conList.size() > 0){
            For(Contact con :conList){
                
                Map<String,Integer> tmAppCyclegetMap=new Map<String,Integer>();
                
                String JSONInfoForAPP;
                if(con.Project_Membership__r.size() >0){
                
                    for(Team_Member__C tm: con.Project_Membership__r){
                        if(tmAppCyclegetMap.containsKey(tm.Application_Cycle__c)){
                            Integer countAppYr=tmAppCyclegetMap.get(tm.Application_Cycle__c);
                            countAppYr++;
                            tmAppCyclegetMap.put(tm.Application_Cycle__c,countAppYr);
                            JSONInfoForAPP =String.ValueOf(tmAppCyclegetMap);
                
                        }else{
                            list<Team_Member__C>tmList= new list<Team_Member__C>();
                            tmList.add(tm);
                            tmAppCyclegetMap.put(tm.Application_Cycle__c,tmList.size());
                            JSONInfoForAPP =String.ValueOf(tmAppCyclegetMap);
                        }
                    }
                }
                
                JSONInfoForAPP=JSONInfoForAPP.replace('}', ']');
                JSONInfoForAPP=JSONInfoForAPP.replace('{', '[');
                
                if(con.PriorParticipations__r.size() > 0){
                    returnwrapperClassList.add( new wrapperClass(Con,con.PriorParticipations__r,con.Project_Membership__r.size(),con.PriorParticipations__r.size(),conList.size(),con.Project_Membership__r,JSONInfoForAPP));    
                }
            }
        }
        
        
        return returnwrapperClassList;    
    }
    
    // Method to search People by Comapany Affiliation
    @AuraEnabled(cacheable=true)
    public static List<wrapperClass> searchByCA(String searchKeyWord){
        // create a wrapper class object and set the wrapper class @AuraEnabled properties and return it to the lightning component.
      List<Team_Member__c> tempTM  = new List<Team_Member__c> ();
      Set<String> uniqueTeamMembers = new Set<String> ();// for storing unique Person id.
      Set<String> UniqueProjectIdsSet = new Set<String> ();//storing unique Project ids
      String searchKey; 
      list<wrapperClass> returnwrapperClassList= new list<wrapperClass>();
      //Map<String,Integer> countTotalAPP=new map<String,Integer>();
      list<Contact> conList;
        if(searchKeyWord.contains(','))
         {
             List<String> searchKeyCode = searchKeyWord.split(',') ;
             tempTM = [select id,Name__c,Project__c,Company_Affiliation__c,Application_Cycle__c from Team_Member__C where Company_Affiliation__c in: searchKeyCode order by Name__c,Application_Cycle__c limit 50000]; 
             if(tempTM.size() > 0){
        
            for (team_Member__c tm: tempTM) {
                
                if (tm.Name__c != null){
                     uniqueTeamMembers.add(tm.Name__c);// filling Unique People Id in a set
                }
                if (tm.Project__c != null){
                     UniqueProjectIdsSet.add(tm.Project__c);// filling Unique project Id in a set
                }
            }
        }
        
            conList=new list<Contact>([select id, name,(select id,Name__c,Project__c,Company_Affiliation__c,Application_Cycle__c from Project_Membership__r where Project__c =:UniqueProjectIdsSet AND Company_Affiliation__c in: searchKeyCode),(select id,Name,Counter__c,Person__c,Project_ID__c,Team_Member_ID__c,Participation_Year__c from PriorParticipations__r where Person__r.Company_Affiliation__c!= '' AND Person__r.Company_Affiliation__c in: searchKeyCode), AccountID,Account.BillingCountry,Home_Office__c,Account_Name__c,Company_Affiliation__c from contact where Id in :uniqueTeamMembers AND Company_Affiliation__c != '' AND Company_Affiliation__c in: searchKeyCode]);    
         }
         else
         {
         
             searchKey = searchKeyWord + '%';
             tempTM = [select id,Name__c,Project__c,Project__r.Total_Team_Members__c,Application_Cycle__c from Team_Member__C where Company_Affiliation__c != '' AND Company_Affiliation__c LIKE: searchKey order by Name__c,Application_Cycle__c limit 50000];
             if(tempTM.size() > 0){
        
            for (team_Member__c tm: tempTM) {
                
                if (tm.Name__c != null){
                     uniqueTeamMembers.add(tm.Name__c);// filling Unique People Id in a set
                }
                if (tm.Project__c != null){
                     UniqueProjectIdsSet.add(tm.Project__c);// filling Unique project Id in a set
                }
            }
        }
        
           conList=new list<Contact>([select id, name,(select id,Name__c,Project__c,Project__r.Total_Team_Members__c,Application_Cycle__c from Project_Membership__r where Project__c =:UniqueProjectIdsSet ),(select id,Name,Counter__c,Person__c,Project_ID__c,Team_Member_ID__c,Participation_Year__c from PriorParticipations__r  order by Participation_Year__c ), AccountID,Account.BillingCountry,Account_Name__c,Home_Office__c,Company_Affiliation__c from contact where Id in :uniqueTeamMembers AND Company_Affiliation__c != '' AND Company_Affiliation__c LIKE: searchKey]);         
          }
            
        
        if(conList.size() > 0){
            For(Contact con :conList){
                
                Map<String,Integer> tmAppCyclegetMap=new Map<String,Integer>();
                
                String JSONInfoForAPP;
                if(con.Project_Membership__r.size() >0){
                
                    for(Team_Member__C tm: con.Project_Membership__r){
                        if(tmAppCyclegetMap.containsKey(tm.Application_Cycle__c)){
                            Integer countAppYr=tmAppCyclegetMap.get(tm.Application_Cycle__c);
                            countAppYr++;
                            tmAppCyclegetMap.put(tm.Application_Cycle__c,countAppYr);
                            JSONInfoForAPP =String.ValueOf(tmAppCyclegetMap);
                
                        }else{
                            list<Team_Member__C>tmList= new list<Team_Member__C>();
                            tmList.add(tm);
                            tmAppCyclegetMap.put(tm.Application_Cycle__c,tmList.size());
                            JSONInfoForAPP =String.ValueOf(tmAppCyclegetMap);
                        }
                    }
                }
                
                JSONInfoForAPP=JSONInfoForAPP.replace('}', ']');
                JSONInfoForAPP=JSONInfoForAPP.replace('{', '[');
                
                if(con.PriorParticipations__r.size() > 0){
                    returnwrapperClassList.add( new wrapperClass(Con,con.PriorParticipations__r,con.Project_Membership__r.size(),con.PriorParticipations__r.size(),conList.size(),con.Project_Membership__r,JSONInfoForAPP));    
                }
            }
        }
        
        
        return returnwrapperClassList;    
    }
    
    // Method to search People by application Year&&CA
    @AuraEnabled(cacheable=true)
    public static List<wrapperClass> searchByAppYearAndCA(String searchKeyWord,String searchKeywordCA){
        // create a wrapper class object and set the wrapper class @AuraEnabled properties and return it to the lightning component.
      List<Team_Member__c> tempTM  = new List<Team_Member__c> ();
      Set<String> uniqueTeamMembers = new Set<String> ();// for storing unique Person id.
      Set<String> UniqueProjectIdsSet = new Set<String> ();//storing unique Project ids
      String searchKey;
      String searchKeyCA;   
      list<wrapperClass> returnwrapperClassList= new list<wrapperClass>();
      
      list<Contact> conList;
        if(searchKeyWord.contains(',') || searchKeywordCA.contains(','))
         {
             List<String> searchKeyCode;
             List<String> searchKeyCodeCA;
             if(searchKeyWord.contains(',')){
                 searchKeyCode = searchKeyWord.split(',') ;
             }else if(searchKeywordCA.contains(',')){
                searchKeyCodeCA = searchKeyWord.split(',') ;
             }
             tempTM = [select id,Name__c,Project__c,Project__r.Total_Team_Members__c,Application_Cycle__c,Company_Affiliation__c from Team_Member__C where (Application_Cycle__c != '' AND Application_Cycle__c in: searchKeyCode) AND (Company_Affiliation__c != '' AND Company_Affiliation__c in: searchKeyCodeCA) order by Name__c,Application_Cycle__c limit 50000]; 
             if(tempTM.size() > 0){
        
            for (team_Member__c tm: tempTM) {
                
                if (tm.Name__c != null){
                     uniqueTeamMembers.add(tm.Name__c);// filling Unique People Id in a set
                }
                if (tm.Project__c != null){
                     UniqueProjectIdsSet.add(tm.Project__c);// filling Unique project Id in a set
                }
            }
        }
        
            conList=new list<Contact>([select id, name,(select id,Name__c,Project__c,Project__r.Total_Team_Members__c,Application_Cycle__c from Project_Membership__r where Project__c =:UniqueProjectIdsSet),(select id,Name,Counter__c,Person__c,Project_ID__c,Team_Member_ID__c,Participation_Year__c from PriorParticipations__r), AccountID,Account_Name__c,Home_Office__c,Account.BillingCountry,Company_Affiliation__c from contact where Id in :uniqueTeamMembers]);    
         }
         else
         {
         
             searchKey = searchKeyWord + '%';
             searchKeyCA =searchKeywordCA +'%';
             tempTM = [select id,Name__c,Project__c,Project__r.Total_Team_Members__c,Application_Cycle__c,Company_Affiliation__c from Team_Member__C where (Application_Cycle__c != '' AND Application_Cycle__c LIKE: searchKey) AND (Company_Affiliation__c != '' AND Company_Affiliation__c LIKE: searchKeyCA) order by Name__c,Application_Cycle__c limit 50000];
             if(tempTM.size() > 0){
        
            for (team_Member__c tm: tempTM) {
                
                if (tm.Name__c != null){
                     uniqueTeamMembers.add(tm.Name__c);// filling Unique People Id in a set
                }
                if (tm.Project__c != null){
                     UniqueProjectIdsSet.add(tm.Project__c);// filling Unique project Id in a set
                }
            }
        }
        
           conList=new list<Contact>([select id, name,(select id,Name__c,Project__c,Project__r.Total_Team_Members__c,Application_Cycle__c from Project_Membership__r where Project__c =:UniqueProjectIdsSet ),(select id,Name,Counter__c,Person__c,Project_ID__c,Team_Member_ID__c,Participation_Year__c from PriorParticipations__r order by Participation_Year__c ), AccountID,Home_Office__c,Account.BillingCountry,Account_Name__c,Company_Affiliation__c from contact where Id in :uniqueTeamMembers]);         
          }
            
        
        if(conList.size() > 0){
            For(Contact con :conList){
                
                Map<String,Integer> tmAppCyclegetMap=new Map<String,Integer>();
                
                String JSONInfoForAPP;
                if(con.Project_Membership__r.size() >0){
                
                    for(Team_Member__C tm: con.Project_Membership__r){
                        if(tmAppCyclegetMap.containsKey(tm.Application_Cycle__c)){
                            Integer countAppYr=tmAppCyclegetMap.get(tm.Application_Cycle__c);
                            countAppYr++;
                            tmAppCyclegetMap.put(tm.Application_Cycle__c,countAppYr);
                            JSONInfoForAPP =String.ValueOf(tmAppCyclegetMap);
                
                        }else{
                            list<Team_Member__C>tmList= new list<Team_Member__C>();
                            tmList.add(tm);
                            tmAppCyclegetMap.put(tm.Application_Cycle__c,tmList.size());
                            JSONInfoForAPP =String.ValueOf(tmAppCyclegetMap);
                        }
                    }
                }
                
                JSONInfoForAPP=JSONInfoForAPP.replace('}', ']');
                JSONInfoForAPP=JSONInfoForAPP.replace('{', '[');
                
                if(con.PriorParticipations__r.size() > 0){
                    returnwrapperClassList.add( new wrapperClass(Con,con.PriorParticipations__r,con.Project_Membership__r.size(),con.PriorParticipations__r.size(),conList.size(),con.Project_Membership__r,JSONInfoForAPP));    
                }
            }
        }
        
        
        return returnwrapperClassList;    
    }
    
    // Method to Sort by Contact Name
    @AuraEnabled(cacheable=true)
    public static List<wrapperClass> sortByCname(String sortField, boolean isAsc){
        // create a wrapper class object and set the wrapper class @AuraEnabled properties and return it to the lightning component.
      // if isAsc is equal tp ture then set 'asc' order otherwise set 'desc' order.
      String SearchOrder;
      String sortingFieldName;
       if (sortField != '') {
         sortingFieldName= ' order by ' + sortField;

             if (isAsc) {
                SearchOrder= ' asc';
             } else {
                SearchOrder= ' desc';
             }
         }
      List<Team_Member__c> tempTM  = new List<Team_Member__c> ();
      Set<String> uniqueTeamMembers = new Set<String> ();// for storing unique Person id.
      Set<String> UniqueProjectIdsSet = new Set<String> ();//storing unique Project ids
      String searchKey; 
      list<wrapperClass> returnwrapperClassList= new list<wrapperClass>();
      //Map<String,Integer> countTotalAPP=new map<String,Integer>();
      list<Contact> conList;
        
             tempTM = [select id,Name__c,Project__c,Company_Affiliation__c,Application_Cycle__c from Team_Member__C  order by Name__c,Application_Cycle__c limit 50000]; 
             if(tempTM.size() > 0){
        
            for (team_Member__c tm: tempTM) {
                
                if (tm.Name__c != null){
                     uniqueTeamMembers.add(tm.Name__c);// filling Unique People Id in a set
                }
                if (tm.Project__c != null){
                     UniqueProjectIdsSet.add(tm.Project__c);// filling Unique project Id in a set
                }
            }
        }
        
            String ContactQuery='select id, name,(select id,Name__c,Project__c,Company_Affiliation__c,Application_Cycle__c from Project_Membership__r where Project__c =:UniqueProjectIdsSet ),(select id,Name,Counter__c,Person__c,Project_ID__c,Team_Member_ID__c,Participation_Year__c from PriorParticipations__r ), AccountID,Account_Name__c,Home_Office__c,Company_Affiliation__c from contact where Id in :'+uniqueTeamMembers;
            ContactQuery+= sortingFieldName;
            ContactQuery+= SearchOrder;
            ContactQuery+= ' Limit 50000';
            list<Contact> conList1=Database.query(ContactQuery);
            conList= new list<Contact>();
             if(conList1.size() >0){
                 conList.addAll(conList1);
             }
            
        
        if(conList.size() > 0){
            For(Contact con :conList){
                
                Map<String,Integer> tmAppCyclegetMap=new Map<String,Integer>();
                
                String JSONInfoForAPP;
                if(con.Project_Membership__r.size() >0){
                
                    for(Team_Member__C tm: con.Project_Membership__r){
                        if(tmAppCyclegetMap.containsKey(tm.Application_Cycle__c)){
                            Integer countAppYr=tmAppCyclegetMap.get(tm.Application_Cycle__c);
                            countAppYr++;
                            tmAppCyclegetMap.put(tm.Application_Cycle__c,countAppYr);
                            JSONInfoForAPP =String.ValueOf(tmAppCyclegetMap);
                
                        }else{
                            list<Team_Member__C>tmList= new list<Team_Member__C>();
                            tmList.add(tm);
                            tmAppCyclegetMap.put(tm.Application_Cycle__c,tmList.size());
                            JSONInfoForAPP =String.ValueOf(tmAppCyclegetMap);
                        }
                    }
                }
                
                JSONInfoForAPP=JSONInfoForAPP.replace('}', ']');
                JSONInfoForAPP=JSONInfoForAPP.replace('{', '[');
                
                if(con.PriorParticipations__r.size() > 0){
                    returnwrapperClassList.add( new wrapperClass(Con,con.PriorParticipations__r,con.Project_Membership__r.size(),con.PriorParticipations__r.size(),conList.size(),con.Project_Membership__r,JSONInfoForAPP));    
                }
            }
        }
        
        
        return returnwrapperClassList;    
    }
    
    @AuraEnabled
    public static List<Participation__c> getAnnualParRecords(string ConId) {
        return new List<Participation__c> ([select id,Name,Counter__c,Person__c,Project_ID__c,Team_Member_ID__c,Participation_Year__c from Participation__c where Person__c=:ConId]);
    }
    
    @AuraEnabled
    public static ContactDataTableWrapper getContactData(Integer pageNumber, Integer pageSize) {
         
        List<Team_Member__c> tempTM  = new List<Team_Member__c> ();
        Set<String> uniqueTeamMembers = new Set<String> ();// for storing unique Person id.
        tempTM = [select id,Name__c,Project__c,Project__r.Total_Team_Members__c,Application_Cycle__c from Team_Member__C  order by Name__c,Application_Cycle__c limit 50000];     
        for (team_Member__c tm: tempTM) {
            
            if (tm.Name__c != null){
                 uniqueTeamMembers.add(tm.Name__c);// filling Unique People Id in a set
            }
            
        }
        //Offset for SOQL
        Integer offset = (pageNumber - 1) * pageSize;
         
        //Total Records
        Integer totalRecords = [SELECT COUNT() FROM Contact where ID IN:uniqueTeamMembers];
        Integer recordEnd = pageSize * pageNumber;
 
        //Instance of Contact DataTable Wrapper Class
        ContactDataTableWrapper objDT =  new ContactDataTableWrapper();  
        objDT.pageSize = pageSize;
        objDT.pageNumber = pageNumber;
        objDT.recordStart = offset + 1;
        objDT.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
        objDT.totalRecords = totalRecords;
        objDT.contactList = [SELECT Id, Name, Phone, Email FROM Contact where ID IN:uniqueTeamMembers ORDER BY Name LIMIT :pageSize OFFSET :offset];
        return objDT;
    }
    
    // wrapper or Inner class with @AuraEnabled {get;set;} properties*    
    public class wrapperClass{
        @AuraEnabled public List<contact> lstContact{get;set;}
        @AuraEnabled public List<Participation__c> AnnualParticipationList{get;set;}
        @AuraEnabled public Integer contactCount{get;set;}
        @AuraEnabled public String headerMsg {get;set;}
        @AuraEnabled public Contact Con{get;set;}
        @AuraEnabled public Integer ProjCount{get;set;}
        @AuraEnabled public Integer APCount{get;set;}
        @AuraEnabled public List<Team_Member__c> lstApplications{get;set;}
        @AuraEnabled public String JSONInfoForAPP{get;set;}
        
        
        public wrapperClass(Contact Con,List<Participation__c> AnnualParticipationList,Integer ProjCount,Integer APCount,Integer contactCount,List<Team_Member__c> lstApplications,String JSONInfoForAPP){
            this.con=con;
            this.AnnualParticipationList=AnnualParticipationList;
            this.ProjCount=ProjCount;
            this.APCount=APCount;
            this.contactCount=contactCount;
            this.lstApplications=lstApplications;
            this.JSONInfoForAPP=JSONInfoForAPP;
            
        }
        
    }
    
    //Wrapper Class For Contact DataTable  
    public class ContactDataTableWrapper {
        @AuraEnabled
        public Integer pageSize {get;set;}
        @AuraEnabled
        public Integer pageNumber {get;set;}
        @AuraEnabled
        public Integer totalRecords {get;set;}
        @AuraEnabled
        public Integer recordStart {get;set;}
        @AuraEnabled
        public Integer recordEnd {get;set;}
        @AuraEnabled
        public List<Contact> contactList {get;set;}
    }
}