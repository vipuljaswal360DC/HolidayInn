({
    //Method to get file list from salesforce
    getFilesHelper : function(c,e,h,folderId) {
        try {
            //var folderType = c.get("v.folderType");
            if(folderId != null && folderId != undefined && folderId.trim() != ''){
                var action = c.get("c.getFilesApex");
                action.setParams({ 
                    groupId : folderId
                });	
                action.setCallback(this, function(response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        var result = response.getReturnValue();
                        console.log('result>>File>>'+JSON.stringify(result));
                        
                        c.set("v.filesList",result);
                    
                        //alert('Form is updated Successfully.')
                        
                    }
                    else if (state === "INCOMPLETE") {
                        // do something
                    }
                    else if (state === "ERROR") {
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
            }
        } catch (ex) {
            console.log('>>>Error>>getFoldersHelper>'+ex);
            
        }
    },
    //Method to get current user profile record from salesforce
    getCurrentUserProfileHelper : function(c,e,h) {
        try {
            
                var action = c.get("c.getCurrentUserProfileApex");
                action.setParams({ 
                    
                });	
                action.setCallback(this, function(response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        var result = response.getReturnValue();
                        console.log('result>>>>'+JSON.stringify(result));
                        if(result != null){
                            console.log('result>>>>'+result.Name);
                            if(result.Name == 'System Administrator'){
                                console.log('result>>>>'+result.Name);
                                c.set('v.uploadDelFunActive',true);
                                console.log('result>>>>'+c.get('v.uploadDelFunActive'));
                            }else{
                                c.set('v.uploadDelFunActive',false);
                            }
                        }else{
                            c.set('v.uploadDelFunActive',false);
                        }
                        
                        //c.set("v.folderList",result);
                    
                        //alert('Form is updated Successfully.')
                        
                    }
                    else if (state === "INCOMPLETE") {
                        // do something
                    }
                    else if (state === "ERROR") {
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
    //Method to delete selected file record from salesforce
    deleteFileRecordHelper : function(c,e,h,recId) {
        try {
            //var folderType = c.get("v.folderType");
            if(recId != null && recId != undefined && recId.trim() != ''){
                var action = c.get("c.deleteFileRecordApex");
                action.setParams({ 
                    recId : recId
                });	
                action.setCallback(this, function(response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        var result = response.getReturnValue();
                        console.log('result>>>>'+JSON.stringify(result));
                        h.getFilesHelper(c,e,h,c.get('v.recordId'));
                        //c.set("v.folderList",result);
                    
                        //alert('Form is updated Successfully.')
                        
                    }
                    else if (state === "INCOMPLETE") {
                        // do something
                    }
                    else if (state === "ERROR") {
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
                
            }
        } catch (ex) {
            console.log('>>>Error>>getFoldersHelper>'+ex);
            
        }
    },
})