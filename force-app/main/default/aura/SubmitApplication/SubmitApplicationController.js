({
	submitApp : function(component, event, helper) {
		var action = component.get("c.SubmitApp");
        action.setParams({"projectAppID": component.get("v.recordId")});
        action.setCallback(component,
        function(response) {
            var state = response.getReturnValue();
            if(state.includes(',')){
                console.log(state);
                $A.get('e.force:refreshView').fire();
                component.set("v.validationError", true);
                component.set("v.validationFields", state);
            }
            if (state === 'success'){
                $A.get('e.force:refreshView').fire();
                component.set("v.smsg", true);
            } else if(state === 'notInSubmission'){
                $A.get('e.force:refreshView').fire();
                component.set("v.NISubmissionMsg", true);
            } else {
                 $A.get('e.force:refreshView').fire();
                 component.set("v.emsg", true);
            }
        });
        $A.enqueueAction(action);
	}
})