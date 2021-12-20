({
    //Method to get folder list from salesforce
    getFoldersHelper : function(c,e,h) {
        try {
            var folderType = c.get("v.folderType");
            if(folderType != null && folderType != undefined && folderType.trim() != ''){
                var action = c.get("c.getFoldersApex");
                action.setParams({ 
                    folderType : folderType
                });	
                action.setCallback(this, function(response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        var result = response.getReturnValue();
                        console.log('result>>>>'+JSON.stringify(result));
                        
                        c.set("v.folderList",result);
                        
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
    //Method to get Sub Folder list from salesforce
    getSubFolderHelper : function(c,e,h,folderId) {
        try {
            //var folderType = c.get("v.folderType");
            if(folderId != null && folderId != undefined && folderId.trim() != ''){
                var action = c.get("c.getSubFolderApex");
                action.setParams({ 
                    folderId : folderId
                });	
                action.setCallback(this, function(response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        var result = response.getReturnValue();
                        console.log('result>>File>>'+JSON.stringify(result));
                        
                        c.set("v.subFolderList",result);
                        //c.set("v.parentFolderId",result[0].Parent_Folder__r.Parent_Folder__c);
                        //c.set('v.selectedFolderId',result[0].Parent_Folder__c);
                        
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
    //Method to get Sub Folder list from salesforce
    getSubFolderBackHelper : function(c,e,h,folderId) {
        try {
            //var folderType = c.get("v.folderType");
            if(folderId != null && folderId != undefined && folderId.trim() != ''){
                var action = c.get("c.getSubFolderBackApex");
                action.setParams({ 
                    folderId : folderId
                });	
                action.setCallback(this, function(response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        var result = response.getReturnValue();
                        console.log('result>>sub back>>'+JSON.stringify(result));
                        
                        //c.set("v.subFolderList",result);
                        if(result != null){
                            console.log('>>>'+result[0].Parent_Folder__c);
                            if(result[0].Parent_Folder__c != null){
                                c.set("v.parentFolderId",result[0].Parent_Folder__c);
                                c.set("v.selectedFolderId",result[0].Parent_Folder__c);
                                c.set('v.selectedFolder',result[0].Parent_Folder__r.Name);
                                h.getSubFolderHelper(c,e,h,result[0].Parent_Folder__c);
                                h.getFilesHelper(c,e,h,result[0].Parent_Folder__c);
                                h.getLinksHelper(c,e,h,result[0].Parent_Folder__c);
                            }
                            //c.set("v.parentFolderId",result[0].Parent_Folder__r.Parent_Folder__c);
                            //c.set('v.selectedFolder',result[0].Parent_Folder__r.Name);
                        }else{
                            c.set('v.selectedFolderId','');
                            c.set('v.folderSection',true);
                            h.getFoldersHelper(c,e,h);
                        }
                        
                        
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
    //Method to get file list from salesforce
    getFilesHelper : function(c,e,h,folderId) {
        try {
            //var folderType = c.get("v.folderType");
            if(folderId != null && folderId != undefined && folderId.trim() != ''){
                var action = c.get("c.getFilesApex");
                action.setParams({ 
                    folderId : folderId
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
    //method to get community links list from the salesforce
    getLinksHelper : function(c,e,h,folderId) {
        try {
            //var folderType = c.get("v.folderType");
            if(folderId != null && folderId != undefined && folderId.trim() != ''){
                var action = c.get("c.getLinksApex");
                action.setParams({ 
                    folderId : folderId
                });	
                action.setCallback(this, function(response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        var result = response.getReturnValue();
                        console.log('result>>Link>>'+JSON.stringify(result));
                        
                        c.set("v.linksList",result);
                        
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
                        h.getFilesHelper(c,e,h,c.get('v.selectedFolderId'));
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
    //Method to delete selected Community link record from salesforce
    deletelinkRecordHelper : function(c,e,h,recId) {
        try {
            //var folderType = c.get("v.folderType");
            if(recId != null && recId != undefined && recId.trim() != ''){
                var action = c.get("c.deleteLinkRecordApex");
                action.setParams({ 
                    recId : recId
                });	
                action.setCallback(this, function(response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        var result = response.getReturnValue();
                        console.log('result>>>>'+JSON.stringify(result));
                        h.getLinksHelper(c,e,h,c.get('v.selectedFolderId'));
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
    //Method to save new link record to salesforce
    saveLinkHelper : function(c,e,h) {
        try {
            var folderId = c.get("v.selectedFolderId");
            var newLinkRec = c.get("v.createLinkObj");
            console.log('newLinkRec>>>>'+JSON.stringify(newLinkRec));
            
            if(folderId != null && folderId != undefined && folderId.trim() != '' && newLinkRec != null && newLinkRec != undefined){
                var action = c.get("c.saveLinkApex");
                action.setParams({ 
                    folderId : folderId,
                    newLinkRec : newLinkRec
                });	
                action.setCallback(this, function(response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        var result = response.getReturnValue();
                        console.log('result>>>>'+JSON.stringify(result));
                        c.set("v.showLinkSection", false);
                        h.refreshLinkObj(c,e,h);
                        h.getLinksHelper(c,e,h,c.get('v.selectedFolderId'));
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
    //Method to save new Sub Folder record to salesforce
    saveSubFolderHelper : function(c,e,h) {
        try {
            var folderId = c.get("v.selectedFolderId");
            var newSubFolderRec = c.get("v.createSubFolderObj");
            var folderType = c.get("v.folderType");
            console.log('newSubFolderRec>>>>'+JSON.stringify(newSubFolderRec));
            
            if(folderId != null && folderId != undefined && folderId.trim() != '' && newSubFolderRec != null && newSubFolderRec != undefined && folderType != null && folderType != undefined){
                var action = c.get("c.saveSubFolderApex");
                action.setParams({ 
                    folderId : folderId,
                    newSubFolderRec : newSubFolderRec,
                    folderType : folderType
                });	
                action.setCallback(this, function(response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        var result = response.getReturnValue();
                        console.log('result>>>>'+JSON.stringify(result));
                        c.set("v.showSubFolderSection", false);
                        h.refreshSubFolderObj(c,e,h);
                        h.getSubFolderHelper(c,e,h,c.get('v.selectedFolderId'));
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
            console.log('>>>Error>>saveSubFolderHelper>'+ex);
            
        }
    },
    //Method to save new Sub Folder record to salesforce
    saveFolderHelper : function(c,e,h) {
        try {
            //var folderId = c.get("v.selectedFolderId");
            var newFolderRec = c.get("v.createFolderObj");
            var folderType = c.get("v.folderType");
            console.log('newFolderRec>>>>'+JSON.stringify(newFolderRec));
            
            if(newFolderRec != null && newFolderRec != undefined && folderType != null && folderType != undefined && folderType.trim() != ''){
                var action = c.get("c.saveFolderApex");
                action.setParams({ 
                    newFolderRec : newFolderRec,
                    folderType : folderType
                });	
                action.setCallback(this, function(response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        var result = response.getReturnValue();
                        console.log('result>>>>'+JSON.stringify(result));
                        c.set("v.showFolderSection", false);
                        h.refreshSubFolderObj(c,e,h);
                        h.getFoldersHelper(c,e,h);
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
            console.log('>>>Error>>saveFolderHelper>'+ex);
            
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
                        var profileNames = c.get("v.profileNames");
                        if(profileNames != undefined && profileNames != null && profileNames != ''){
                            var profileNameList = profileNames.split(',');
                            //for(var i=0; i<profileNameList.length; i++){
                            console.log('profileNameList>>>>'+profileNameList);
                            if(profileNameList.includes(result.Name)){
                                
                                c.set('v.uploadDelFunActive',true);
                                console.log('result>>>>'+c.get('v.uploadDelFunActive'));
                            }else{
                                c.set('v.uploadDelFunActive',false);
                            }
                            //}
                        }else{
                            if(result.Name == 'System Administrator'){
                                console.log('result>>>>'+result.Name);
                                c.set('v.uploadDelFunActive',true);
                                console.log('result>>>>'+c.get('v.uploadDelFunActive'));
                            }else{
                                c.set('v.uploadDelFunActive',false);
                            }
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
    //Method to initialise Link js object
    refreshLinkObj: function(c, e, h) {
        var obj = {};
        obj.sObjectType = 'Community_Link__c';
        obj.Title__c =  '';
        obj.Link__c = '';
        c.set("v.createLinkObj", obj);
    },
    //Method to initialise Sun folder js object
    refreshSubFolderObj: function(c, e, h) {
        var obj = {};
        obj.sObjectType = 'Community_Folder__c';
        obj.Name =  '';
        //obj.Link__c = '';
        c.set("v.createSubFolderObj", obj);
    },
    
    
    //Method to rename selected file record into salesforce
    renameFileRecordHelper : function(c,e,h,recId,newName) {
        try {
            //var recordId = c.get("v.recordId");
            if(recId != null && recId != undefined && recId.trim() != ''
               && newName != null && newName != undefined && newName != ''){
                var action = c.get("c.renameFileRecordApex");
                action.setParams({ 
                    recId : recId,
                    newName : newName
                });	
                action.setCallback(this, function(response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        var result = response.getReturnValue();
                        console.log('result>>>>'+JSON.stringify(result));
                        if(c.get('v.isHome')){
                            h.getFilesHelper(c,e,h,c.get('v.recordId'));
                        }else{
                            h.getFilesHelper(c,e,h,c.get('v.selectedFolderId'));
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
                
            }
        } catch (ex) {
            console.log('>>>Error>>getFoldersHelper>'+ex);
            
        }
    },
    
    //Method to rename selected folder record into salesforce
    renameFolderRecordHelper : function(c,e,h,recId,newName) {
        try {
            //var recordId = c.get("v.recordId");
            if(recId != null && recId != undefined && recId.trim() != ''
               && newName != null && newName != undefined && newName != ''){
                var action = c.get("c.renameFolderRecordApex");
                action.setParams({ 
                    recId : recId,
                    newName : newName
                });	
                action.setCallback(this, function(response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        var result = response.getReturnValue();
                        console.log('result>>>>'+JSON.stringify(result));
                        if(c.get('v.isHome')){
                            h.getFoldersHelper(c,e,h);
                        }else{
                            h.getSubFolderHelper(c,e,h,c.get('v.selectedFolderId'));
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
                
            }
        } catch (ex) {
            console.log('>>>Error>>getFoldersHelper>'+ex);
            
        }
    },
})