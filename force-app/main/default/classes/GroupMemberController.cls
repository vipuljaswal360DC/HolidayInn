/*Class Name - GroupMemberController
 * Usage - Used to get the list of group member in Lightning Component Named - GroupMemberComponent */
public class GroupMemberController {

    /*Method Name - getGroupMember
     * Return - List of group members
     * Arguement - Group Id */
    @AuraEnabled
    public static List<CollaborationGroupMember> getGroupMember(String groupId){
        if(groupId != null && groupId != ''){
           List<CollaborationGroupMember> listGroupMember = new List<CollaborationGroupMember>([select id,memberId, member.name,member.title, member.email,member.SmallPhotoUrl from CollaborationGroupMember where CollaborationGroupId =:groupId order by member.name]);
            if(listGroupMember != null && listGroupMember.size()>0){
                return listGroupMember;
            }else{
                return null;
            }
        }
        return null;
    }
    
    
    /* Method name:  getCurrentUserId
     * Input: None 
     * returns: return user Id and Profile */
    @AuraEnabled
    public static String getCurrentUserId(){
        String userId =  userinfo.getuserID();
        Id profileId=userinfo.getProfileId();
        if(profileId != null){
            Profile profile = [Select Id,Name from Profile where Id =: profileId];
            return userId+'--'+profile.Name;
        }        
        return null;
    }
}