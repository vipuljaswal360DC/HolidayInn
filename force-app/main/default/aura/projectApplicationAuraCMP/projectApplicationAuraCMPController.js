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
                                    var createRecordEvent = $A.get("e.force:createRecord");
                                    createRecordEvent.setParams({
                                        "entityApiName": "Application_Survey_Form__c"
                                    });
                                    createRecordEvent.fire();
                                }
                            });
        $A.enqueueAction(action1);
    }
})