({
    getMembers : function(component, event, helper) {
        try{
            var groupId = component.get('v.recordId');
            var userId = component.get('v.userId');
            var userProfile = component.get('v.userProfile');
            console.log('groupId>>>>'+groupId);
            console.log('userId>>>>'+userId);
            var action = component.get("c.getGroupMember");
            action.setParams({ 
                groupId : groupId
            });	
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    var result = response.getReturnValue();
                    //console.log('result>>>>'+JSON.stringify(result));
                    if(result != undefined && result != null){
                        component.set("v.groupMemberList",result);
                        component.set("v.groupMemberSize",result.length);
                        
                        let memberIdSet = new Set();
                        for(var i=0;i<result.length;i++){
                            //console.log('memberId>>>>'+result[i].MemberId);
                            memberIdSet.add(result[i].MemberId);
                        }
                        //console.log('memberIdSet>>>>'+memberIdSet);
                        if(userProfile == 'System Administrator'){
                            component.set("v.showComponent",true);                            
                        }else{
                            if(userId != null && userId != '' && 
                               memberIdSet != undefined && memberIdSet != null && memberIdSet.size >0){
                                //console.log('Im Here>>>>');
                                if(memberIdSet.has(userId)){
                                    //console.log('Im Here 1>>>>');
                                    component.set("v.showComponent",true);
                                }else{
                                    //console.log('Im Here 2>>>>');
                                    component.set("v.showComponent",false);
                                }
                                //console.log('showComponent>>>>'+component.get("v.showComponent"));
                            }
                        }
                        
                    }
                }else if (state === "INCOMPLETE") {
                    // do something
                }else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " + 
                                        errors[0].message);
                        }
                    } else {
                        console.log("Unknown error");
                    }
                }
            });
            $A.enqueueAction(action);
        }catch (ex) {
            console.log('>>>Error>>getGroupMemberHelper>'+ex);
            
        }
    },
    
    getCurrentUser : function(c,e,h){
        try {
            var action = c.get("c.getCurrentUserId");
            action.setParams({ });	
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    var result = response.getReturnValue();
                    //console.log('User Id>>>>'+result);
                    if(result != null){
                        c.set('v.userId',result.split('--')[0]);
                        c.set('v.userProfile',result.split('--')[1]);
                        this.getMembers(c, e, h);
                    }else{
                        c.set('v.userId',null);
                        c.set('v.userProfile',null);
                    }
                }else if (state === "INCOMPLETE") {
                    // do something
                }else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " + 
                                        errors[0].message);
                        }
                    } else {
                        console.log("Unknown error");
                    }
                }
            });
            $A.enqueueAction(action);            
        } catch (ex) {
            console.log('>>>Error>>getFoldersHelper>'+ex);
        }
    },
})