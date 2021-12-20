({
    doInit : function(component, event, helper) {
        var userId = $A.get("$SObjectType.CurrentUser.Id");
        console.log(userId);
        var action1 = component.get("c.isPortalUser");
        action1.setParams({"userId":userId});
        action1.setCallback(component,
                            function(response) {
                                var state = response.getReturnValue();
                                console.log('IsPortalUser - '+state);
                                if (state){
                                    component.set("v.IsPortalUser", true);
                                }else if(!state){
                                    component.set("v.IsPortalUser", false);
                                }
                            });
        $A.enqueueAction(action1);
        
        var action = component.get("c.fetchApplication");
        action.setParams({"projectAppID": component.get("v.recordId")});
        action.setCallback(component,
                           function(response) {
                               var state = response.getReturnValue();
                               console.log('state - '+state);
                               if (state === 'In progress'){
                                   component.set("v.InprogressStatus", true);
                               }else if(state === 'Submitted'){
                                   component.set("v.SubmittedStatus", true);
                               }
                           });
        $A.enqueueAction(action);
    },
    handleCancel : function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
        $A.get('e.force:refreshView').fire();
        
    },
    handleInProgressSubmission: function(cmp,eve,helper){
        var action = cmp.get("c.updateStatus");
        action.setParams({"projectAppID": cmp.get("v.recordId")});
        action.setCallback(cmp,
                           function(response) {
                               var state = response.getReturnValue();
                               if (state === 'success'){
                                   var toastEvent = $A.get("e.force:showToast");
                                   toastEvent.setParams({
                                       "title": "Success!",
                                       "type" : "success",
                                       "message": "You Project Application is deleted successfully!."
                                   });
                                   toastEvent.fire();
                                   $A.get('e.force:refreshView').fire();
                                   $A.get("e.force:closeQuickAction").fire(); 
                               }
                           });
        $A.enqueueAction(action);
    },
    deleteRecord: function(cmp,eve,helper){
        var action = cmp.get("c.deleteApplication");
        action.setParams({"projectAppID": cmp.get("v.recordId")});
        action.setCallback(cmp,
                           function(response) {
                               var state = response.getReturnValue();
                               if (state){
                                   var toastEvent = $A.get("e.force:showToast");
                                   toastEvent.setParams({
                                       "title": "Success!",
                                       "type" : "success",
                                       "message": "You Project Application is deleted successfully!."
                                   });
                                   toastEvent.fire();
                                   $A.get('e.force:refreshView').fire();
                                   $A.get("e.force:closeQuickAction").fire();
                                   var navEvent = $A.get("e.force:navigateToList");
                                   navEvent.setParams({
                                       "listViewName": "recent",
                                       "scope": "Application_Survey_Form__c"
                                   });
                                   navEvent.fire();
                               }else{
                                   var toastEvent = $A.get("e.force:showToast");
                                   toastEvent.setParams({
                                       "title": "Error!",
                                       "type" : "error",
                                       "message": "Error deleting the Project Application"
                                   });
                                   toastEvent.fire();
                                   $A.get('e.force:refreshView').fire();
                                   $A.get("e.force:closeQuickAction").fire(); 
                               }
                           });
        $A.enqueueAction(action);
    }
})