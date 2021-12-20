/*Class Name - GroupMemberControllerTestClass
* Usage - Test Class for GroupMemberController */

@isTest
public class GroupMemberControllerTestClass {
    
    @isTest
    public static void testMethod1(){
        Group grp = new Group();
        grp.Name = 'Test Group';
        grp.Type = 'Regular'; 
        insert grp;
        GroupMemberController.getGroupMember(grp.Id);
        GroupMemberController.getGroupMember('');
        GroupMemberController.getCurrentUserId();
    }
    
}