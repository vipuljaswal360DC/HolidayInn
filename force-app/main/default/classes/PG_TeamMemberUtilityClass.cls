/* Class Name: PG_TeamMemberUtilityClass
 * Usage: This class will create the team member records.
 * 
 */
public class PG_TeamMemberUtilityClass {
    
    /* Method Name: createTeamMember
     * Usage: This method will create the team member records.
     * Return Type: void
     * Parameters: contact reference, project refernce and isCaptain
     */
    public static TeamMemberInfoWrapper createTeamMember(Contact conObj, Projects__c projObj, boolean isCaptain){
        //Creating team member record
        
        Boolean createTeamMemberRecord = searchTeamMember(conObj, projObj);
        if(createTeamMemberRecord){
            Team_Member__c teamMember = new Team_Member__c(Name__c = conObj.Id,
                                                           Project__c = projObj.Id,
                                                           Team_Captain__c = isCaptain
                                                          );
            insert teamMember;
            TeamMemberInfoWrapper tmWrapper = new TeamMemberInfoWrapper(true,'Success',teamMember,'Team member created successfully');
            return tmWrapper;
        }else{
            TeamMemberInfoWrapper tmWrapper = new TeamMemberInfoWrapper(true,'Error',null,Label.Team_member_error+'-'+conObj.Name);
            return tmWrapper;
        }
        
    }

    
    
    /* Method Name: searchTeamMember
     * Usage: This method will search the team member records.
     * Return Type: void
     * Parameters: contact reference, project refernce and isCaptain
     */
    public static boolean searchTeamMember(Contact conObj, Projects__c projObj){
        List<Team_Member__c> teamMemberList = new List<Team_Member__c>([select id from Team_Member__c where Name__c =: conObj.Id AND Project__c =: projObj.Id]);
        
        if(teamMemberList != null && teamMemberList.size()>0){
            return false;
        }
        return true;
        
    }
    
    //Wrapper class for project logs
    public class TeamMemberInfoWrapper{
        public boolean isTeamMemberExist;
        public string status;
        public Team_Member__c teamMember;
        public string message;
        
        public TeamMemberInfoWrapper(boolean isTeamMemberExist, String status,Team_Member__c teamMember, String message){
            this.isTeamMemberExist = isTeamMemberExist;
            this.status = status;
            this.teamMember = teamMember;
            this.message = message;
        }
    }
}