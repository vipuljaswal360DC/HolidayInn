({
    doInit : function(component, event, helper) {
        var recordId = component.get('v.recordId');
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
                                    /*var editRecordEvent = $A.get("e.force:editRecord");
                                    editRecordEvent.setParams({
                                        "recordId": recordId
                                    });
                                    editRecordEvent.fire();*/
                                }
                            });
        $A.enqueueAction(action1);
    },
    save : function(component, event, helper) {
        component.find("edit").get("e.recordSave").fire();
        var recordId = component.get('v.recordId');
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": recordId
        });
        navEvt.fire();
       	setTimeout(function(){ 
            $A.get('e.force:refreshView').fire();
        }, 1);
        var toastEvent = $A.get("e.force:showToast");
                                   toastEvent.setParams({
                                       "title": "Success!",
                                       "type" : "success",
                                       "message": "Project Application is updated successfully!."
                                   });
                                   toastEvent.fire();
        
    },
    close : function(component, event, helper) {
        $A.get('e.force:closeQuickAction').fire();
        var recordId = component.get('v.recordId');
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": recordId
        });
        navEvt.fire();
        
    },
    handleSaveSuccess : function(cmp, event) {
        // Display the save status
         console.log('Success Status-->');
        cmp.set("v.saveState", true);
    }
})