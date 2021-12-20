({
    handleSubmission : function(component, event, helper) {
    	//component.set("v.emsg", true);
        var action = component.get("c.SubmitApp");
        action.setParams({"projectAppID": component.get("v.recordId")});
        action.setCallback(component, function(response) {
            var state = response.getReturnValue();
            if(state.includes(',')){
                console.log('Validation Fields -'+state);
                $A.get('e.force:refreshView').fire();
                
                component.set("v.emsg", false);
                component.set("v.validationError", true);
                let fieldAndSectionNames = state.split(',');
                component.set("v.validationFields", fieldAndSectionNames[0]);
                let SectionName = fieldAndSectionNames[1];
                if(SectionName == 'Team Captain Information'){
                    component.set("v.SectionName", "Team Captain");
                }else if(SectionName == 'Team Member 1 Information'){
                    component.set("v.SectionName", "Team Member 1 Details");
                }else if(SectionName == 'Team Member 2 Information'){
                    component.set("v.SectionName", "Team Member 2 Details");
                }else if(SectionName == 'Team Member 3 Information'){
                    component.set("v.SectionName", "Team Member 3 Details");
                }else if(SectionName == 'Team Member 4 Information'){
                    component.set("v.SectionName", "Team Member 4 Details");
                }else if(SectionName == 'Organization Information'){
                    component.set("v.SectionName", "Organisational Overview and Point of Contact");
                }else if(SectionName == 'Project Information'){
                    component.set("v.SectionName", "Proposed Project Information");
                }else if(SectionName == 'Contact Information'){
                    component.set("v.SectionName", "Partner Organisation Point of Contact Information");
                }else{
                    component.set("v.SectionName", SectionName);
                }
                
            } else if (state === 'success'){
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "You Project Application is submitted successfully!."
                });
                toastEvent.fire();
                $A.get('e.force:refreshView').fire();
                $A.get("e.force:closeQuickAction").fire(); 
            }
        });
        $A.enqueueAction(action);
    },
    handleCancel : function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
        $A.get('e.force:refreshView').fire();
        
    },
    editLWC : function(component, event, helper) {
        component.set("v.validationError", false);
        component.set("v.openEditLWC", true);
        
    }
})