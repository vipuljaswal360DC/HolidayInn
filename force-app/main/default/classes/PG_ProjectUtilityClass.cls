/* Class Name: PG_ProjectUtilityClass
* Usage: This utility class will return the project data if any exist with name.
* 
*/
public class PG_ProjectUtilityClass {
    
     /* Method Name: validateProject
     * Usage: This method will search projects by name and will return the ProjectInfoWrapper.
   * Return Type: ProjectInfoWrapper Class
   * Parameters: Project name (String)
   */
    public static ProjectInfoWrapper validateProject(String projectName){
        System.debug('----Validating Project Data----'); 
        if(projectName != null && projectName != ''){
            
            //Map to find duplicate and to return data
            Map<String,List<Projects__c>> namevsProjectMap = searchProjectByName(new List<String>{projectName.trim().replaceAll('[ ]{2,}', ' ')});
            
            //Checking the returned value if the account exist
            if(namevsProjectMap != null && namevsProjectMap.size()>0){
                ProjectInfoWrapper projWrapper = new ProjectInfoWrapper(false,'Error',null,'Duplicate project exists with Name '+projectName.trim().replaceAll('[ ]{2,}', ' '));
                return projWrapper;
                
                
                //Return log if no data found for passed values
            }else{
                ProjectInfoWrapper projWrapper = new ProjectInfoWrapper(false,'Success',null,'No Project Found with Name '+projectName.trim().replaceAll('[ ]{2,}', ' '));
                return projWrapper;
            }
            
        }
        return null;
    }
    
    
    
    /* Method Name: validateProjectForGrantReq
     * Usage: This method will search projects by name and will return the ProjectInfoWrapper.
   * Return Type: ProjectInfoWrapper Class
   * Parameters: Project name (String)
   */
    public static ProjectInfoWrapper validateProjectForGrantReq(String projectName){
        System.debug('----Validating Project Data----'); 
        if(projectName != null && projectName != ''){
            
            //Map to find duplicate and to return data
            Map<String,List<Projects__c>> namevsProjectMap = searchProjectByName(new List<String>{projectName.trim().replaceAll('[ ]{2,}', ' ')});
            
            //Checking the returned value if the account exist
            if(namevsProjectMap != null && namevsProjectMap.size()>0){
                List <String> keyList = new List<String>(namevsProjectMap.keySet());
                String firstMapValue = keyList[0];
                if(namevsProjectMap.get(firstMapValue.trim()).size() == 1){
                    Projects__c projObj = namevsProjectMap.get(firstMapValue.trim())[0];
                    ProjectInfoWrapper projWrapper = new ProjectInfoWrapper(true,'Success',projObj,'Project exists with Name '+projectName.trim().replaceAll('[ ]{2,}', ' '));
                    return projWrapper;
                }else if(namevsProjectMap.get(firstMapValue.trim()).size() > 1){
                    Projects__c projObj = namevsProjectMap.get(firstMapValue.trim())[0];
                    ProjectInfoWrapper projWrapper = new ProjectInfoWrapper(true,'Error',null,'Duplicate project exists with Name '+projectName.trim().replaceAll('[ ]{2,}', ' '));
                    return projWrapper;
                }
                                
                //Return log if no data found for passed values
            }else{
                ProjectInfoWrapper projWrapper = new ProjectInfoWrapper(false,'Success',null,'No Project Found with Name '+projectName);
                return projWrapper;
            }
            
        }
        return null;
    }
    
    /* Method Name: validateProjectForRoundBApplication
     * Usage: This method will search projects by name and will return the ProjectInfoWrapper.
   * Return Type: ProjectInfoWrapper Class
   * Parameters: Project name (String)
   */
    public static ProjectInfoWrapper validateProjectForRoundBApplication(String projectName){
        System.debug('----Validating Round B-Project Data----'+projectName); 
        if(projectName != null && projectName != ''){
            
            //Map to find duplicate and to return data
            Map<String,List<Projects__c>> namevsProjectMap = searchProjectByName(new List<String>{projectName.trim().replaceAll('[ ]{2,}', ' ')});
            
            //Checking the returned value if the account exist
            if(namevsProjectMap != null && namevsProjectMap.size()>0){
                List <String> keyList = new List<String>(namevsProjectMap.keySet());
                String firstMapValue = keyList[0];
                if(namevsProjectMap.get(firstMapValue.trim()).size() == 1){
                    Projects__c projObj = namevsProjectMap.get(firstMapValue.trim())[0];
                    ProjectInfoWrapper projWrapper = new ProjectInfoWrapper(true,'Success',projObj,'Project exists with Name '+projectName.trim().replaceAll('[ ]{2,}', ' '));
                    return projWrapper;
                }else if(namevsProjectMap.get(firstMapValue.trim()).size() > 1){
                    Projects__c projObj = namevsProjectMap.get(firstMapValue.trim())[0];
                    ProjectInfoWrapper projWrapper = new ProjectInfoWrapper(true,'Error',null,'Duplicate project exists with Name '+projectName.trim().replaceAll('[ ]{2,}', ' '));
                    return projWrapper;
                }
                                
                //Return log if no data found for passed values
            }else{
                ProjectInfoWrapper projWrapper = new ProjectInfoWrapper(false,'Success',null,'No Project Found with Name '+projectName);
                return projWrapper;
            }
            
        }
        return null;
    }
    
    /* Method Name: searchProjectByName
     * Usage: This method will search projects by name and will return the map of name vs project list.
   * Return Type: Map of name(String) vs project list
   * Parameters: List of Name(String)
   */
    public static Map<String,List<Projects__c>> searchProjectByName(List<String> nameList){
        if(nameList != null && nameList.size()>0){
            
            //Query All Fields of Projects
            DescribeSObjectResult describeResult = Projects__c.getSObjectType().getDescribe();  
            List<String> fieldNames = new List<String>( describeResult.fields.getMap().keySet() );  
            
            //SOQL to query the projects with the given name
            String query = 'SELECT '+String.join( fieldNames, ',') +' FROM ' +describeResult.getName() +' where Name IN :nameList';
            List<Projects__c> projectList = Database.query( query );
            
            System.debug('---projectList---'+projectList);
            System.debug('---projectListSize---'+projectList.size());
            
            
            //adding data to name vs project list map to find duplicate and to return data
            if(projectList != null && projectList.size()>0){
                
                //Map to find duplicate and to return data
                Map<String,List<Projects__c>> namevsProjectMap= new Map<String,List<Projects__c>>();
                for(Projects__c projectObj: projectList){
                    if(namevsProjectMap != null && namevsProjectMap.containsKey(projectObj.Name)){
                        List<Projects__c> tempList = new List<Projects__c>(namevsProjectMap.get(projectObj.Name));
                        tempList.add(projectObj);
                        namevsProjectMap.put(projectObj.Name, tempList);
                    }else{
                        List<Projects__c> tempList = new List<Projects__c>();
                        tempList.add(projectObj);
                        namevsProjectMap.put(projectObj.Name, tempList);
                    }
                }
                
                System.debug('---namevsProjectMap---'+namevsProjectMap);
                System.debug('---namevsProjectMapSize---'+namevsProjectMap.size());
                System.debug('---namevsProjectMapValues---'+namevsProjectMap.values());
                
                //retuning data
                if(namevsProjectMap != null && namevsProjectMap.size() > 0){
                    return namevsProjectMap;
                }
            }
        }
        return null;
    }
    
    
    /* Method Name: createProject
     * Usage: This method will create the project record,
     * Return Type: Created project reference
     * Parameters: All the details of project.
     */
    public static Projects__c createProject(Account accObj,Contact conObj,Application_Survey_Form__c appObj, String name, String timeline, String projectType,String corpSocialInvestment,String grantAmount, 
                                            String sustainabilityAlignment, String objective, String background, String benficiaries, 
                                            String commitmentLevel, String effortLevel, String grantUse, 
                                            String teamSkills, String diversity, String activities,String ApplicationCycle,String ApplicationRound,String GrantNarrative){
        System.debug('----In Project Creation----');   
        //Creating Project record                                         
        Projects__c projectObj = new Projects__c(Name = name.trim().replaceAll('[ ]{2,}', ' '),
                                                 Project_Objective__c = objective,
                                                 Project_Background__c = background,
                                                 Corporate_Social_Investment__c = corpSocialInvestment,
                                                 Project_Beneficiaries__c = benficiaries,
                                                 Level_of_Commitment__c = commitmentLevel,
                                                 Project_Timing_and_Implementation__c = timeline,
                                                 Sustainability_Focus_Area__c = sustainabilityAlignment,
                                                 Level_of_Effort__c = effortLevel,
                                                 Grant_Use__c = grantUse,
                                                 Team_Skills__c = teamSkills,
                                                 Team_Diversity__c = diversity,
                                                 Activities_to_Obtain_Objectives__c = activities,
                                                 Application_Cycle__c = ApplicationCycle,
                                                 Host_Organization__c = accObj.Id,
                                                 Host_Org_Project_Contact__c = conObj.Id,
                                                 Application_Round__c =ApplicationRound
                                                 
                                                );
        if(grantAmount != null && grantAmount != ''){
             projectObj.Grant_Amount__c = Integer.valueOf(grantAmount);                                     
        }
        if(projectType != null && projectType != ''){
             projectObj.Project_Activities__c = String.join(projectType.split(','),';');                                       
        }
        if(grantUse.ContainsIgnoreCase('NO')){
            projectObj.Grant_Request_Status__c ='Not Requested';
        }else if(grantUse.ContainsIgnoreCase('Yes')){
            projectObj.Grant_Request_Status__c ='Requested';
            if(GrantNarrative != null && GrantNarrative != ''){
                projectObj.Grant_Use__c =GrantNarrative;
            }
        }
        
        if(appObj.Partner_Organisation_Communication__c != null && appObj.Partner_Organisation_Communication__c != ''){
            projectObj.Project_discussed_with_POC__c =appObj.Partner_Organisation_Communication__c;
        }
        //projectObj.Grant_Request_Submitted__c = Date.today();
        insert projectObj;
        return projectObj;
    }
    
    /* Method Name: createProjectRoundB
     * Usage: This method will create the project record,
     * Return Type: Created project reference
     * Parameters: All the details of project.
     */
    public static Projects__c createProjectRoundB(Projects__c projObj,Account accObj,Contact conObj,Application_Survey_Form__c appObj, String name, String timeline, String projectType,String grantAmount, 
                                            String sustainabilityAlignment, String objective, String background, String benficiaries, 
                                            String commitmentLevel, String effortLevel, String grantUse, 
                                            String teamSkills, String diversity, String activities,String ApplicationCycle,String ApplicationRound,String GrantNarrative){
        System.debug('----In Project Creation----');   
        //Creating Project record                                         
        Projects__c projectObj = new Projects__c(Name = name.trim().replaceAll('[ ]{2,}', ' '),
                                                 Project_Objective__c = objective,
                                                 Project_Background__c = background,
                                                 Project_Beneficiaries__c = benficiaries,
                                                 Level_of_Commitment__c = commitmentLevel,
                                                 Project_Timing_and_Implementation__c = timeline,
                                                 Sustainability_Focus_Area__c = sustainabilityAlignment,
                                                 Level_of_Effort__c = effortLevel,
                                                 Grant_Use__c = grantUse,
                                                 Team_Skills__c = teamSkills,
                                                 Team_Diversity__c = diversity,
                                                 Activities_to_Obtain_Objectives__c = activities,
                                                 Application_Cycle__c = ApplicationCycle,
                                                 Host_Organization__c = accObj.Id,
                                                 Host_Org_Project_Contact__c = conObj.Id,
                                                 Application_Round__c =ApplicationRound
                                                 
                                                );
        if(grantAmount != null && grantAmount != ''){
             projectObj.Grant_Amount__c = Integer.valueOf(grantAmount);                                     
        }
        if(projectType != null && projectType != ''){
             projectObj.Project_Activities__c = String.join(projectType.split(','),';');                                       
        }
        
        if(appObj.Resubmission_Flag__c != null && appObj.Resubmission_Flag__c != ''){
            if(appObj.Resubmission_Flag__c.ContainsIgnoreCase('NO')){
                   projectObj.Resubmission_flag__c=false; 
                
                }else if(appObj.Resubmission_Flag__c.ContainsIgnoreCase('Yes')){
                    projectObj.Resubmission_flag__c=true; 
                }
                                                    
        }
        
        if(appObj.Partner_Organisation_Communication__c != null && appObj.Partner_Organisation_Communication__c != ''){
            projectObj.Project_discussed_with_POC__c =appObj.Partner_Organisation_Communication__c;
        }
        
        if(grantUse.ContainsIgnoreCase('NO')){
            projectObj.Grant_Request_Status__c ='Not Requested';
        }else if(grantUse.ContainsIgnoreCase('Yes')){
            projectObj.Grant_Request_Status__c ='Requested';
            if(GrantNarrative != null && GrantNarrative != ''){
                projectObj.Grant_Use__c =GrantNarrative;
            }
        }
        
        //projectObj.Grant_Request_Submitted__c = Date.today();
        if(projObj != null){
            projectObj.Round_B_Project_Name__c=projObj.id+'-'+projObj.Name.trim().replaceAll('[ ]{2,}', ' ');
        }
        insert projectObj;
        if(projectObj == null ) return projectObj;
        system.debug('--projectObj --'+projectObj );
        Projects__c projectObjUpdate;
        if(projObj != null)
        projectObjUpdate= [select id,name from Projects__c where ID =: projObj.id limit 1];
        system.debug('--projectObjUpdate--'+projectObjUpdate );
        projectObjUpdate.Round_B_Project_Name__c=projectObj.id+'-'+projectObj.Name.trim().replaceAll('[ ]{2,}', ' ');
        update projectObjUpdate;
        return projectObj;
    }
    /* Method Name: updateProject
     * Usage: This method will update the project record,
     * Return Type: Updated project reference
     * Parameters: All the details of project.
     */
    public static Projects__c updateProject(Projects__c projObj, String status, Date submittedDate){
        projObj.Grant_Request_Status__c = status;
        projObj.Grant_Request_Submitted__c = submittedDate;
        
        update projObj;
        return projObj;
    }
    
    //Wrapper class for project logs
    public class ProjectInfoWrapper{
        public boolean isProjectExist;
        public string status;
        public Projects__c proj;
        public string message;
        
        public ProjectInfoWrapper(boolean isProjectExist, String status,Projects__c proj, String message){
            this.isProjectExist = isProjectExist;
            this.status = status;
            this.proj = proj;
            this.message = message;
        }
    }
}