({  
    doInit:function(component,event,helper){  
    },      
    
    UploadFinished : function(component, event, helper) {  
        var uploadedFiles = event.getParam("files");  
        component.find('notifLib').showNotice({
            "variant": "info",
            "header": "Success",
            "message": "File Uploaded successfully!!",
            closeCallback: function() {}
        });
    }
 })