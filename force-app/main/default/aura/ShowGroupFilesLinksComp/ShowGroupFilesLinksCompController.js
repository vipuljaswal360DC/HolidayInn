({
    doInit : function(c, e, h) {
        console.log('>>doInit>>'+c.get('v.recordId'));
        //c.set('v.recordId',c.get('v.recordId'));
        h.getFilesHelper(c,e,h,c.get('v.recordId'));
        h.getCurrentUserProfileHelper(c,e,h);
    },
    handleUploadFinished: function(c, e, h) {
        var GroupId = c.get('v.recordId');
        if(GroupId != null && GroupId != undefined){
            h.getFilesHelper(c,e,h,GroupId);
        }
    },
    deleteFile: function(c, e, h) {
        console.log('deleteFile>>');
        var fileId = e.getSource().get("v.name")
        console.log('fileId>>'+fileId);
        
        if(fileId != undefined && fileId != null){
            c.set('v.showConfirmDialog', true);
            c.set('v.recIdToDel', fileId);
            c.set('v.recIdToDelobjType', 'file');
            
        }

    },
    handleConfirmDialogYes : function(c, e, h) {
        console.log('Yes');
        c.set('v.showConfirmDialog', false);
        var objType = c.get('v.recIdToDelobjType');
        if(objType == 'file'){
            h.deleteFileRecordHelper(c,e,h,c.get('v.recIdToDel'));
        }
        if(objType == 'link'){
            //h.deletelinkRecordHelper(c,e,h,c.get('v.recIdToDel'));
        }
        c.set('v.recIdToDel', '');
        c.set('v.recIdToDelobjType', '');
    },
    handleConfirmDialogNo : function(c, e, h) {
        console.log('No');
        c.set('v.showConfirmDialog', false);
    },
    openSelectedFile: function(c, e, h) {
        try {
            var fileId = e.currentTarget.getAttribute("data-Id");
            if(fileId != undefined && fileId != null){
                $A.get('e.lightning:openFiles').fire({
                    recordIds: [fileId]
                });
            }
        } catch (ex) {
            console.log('>>>Error>>openSelectedFile>'+ex);
            
        }
    },
})