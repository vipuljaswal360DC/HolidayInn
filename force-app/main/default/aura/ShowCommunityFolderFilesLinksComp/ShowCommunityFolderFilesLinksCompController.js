({
    doInit : function(c, e, h) {
        h.getFoldersHelper(c,e,h);
        h.getCurrentUserProfileHelper(c,e,h);
    },
    openSelectedFolder : function(c, e, h) {
        c.set('v.folderSection',false);
        c.set('v.selectedTab','one');
        var folderId = e.currentTarget.getAttribute("data-Id");
        var folderName = e.currentTarget.getAttribute("title");
        c.set('v.selectedFolder',folderName);
        if(folderId != undefined && folderId != null){
            c.set("v.parentFolderId",folderId);
            c.set('v.selectedFolderId',folderId);
            h.getSubFolderHelper(c,e,h,folderId);
            h.getFilesHelper(c,e,h,folderId);
            h.getLinksHelper(c,e,h,folderId);
        }
        
    },
    goBackToFolders: function(c, e, h) {
        /*var parentFolderId = c.get("v.parentFolderId");
        console.log('parentFolderId>>>'+parentFolderId);
        if(parentFolderId != undefined && parentFolderId != null && parentFolderId != ''){
            c.set('v.selectedFolderId',parentFolderId);
            h.getSubFolderHelper(c,e,h,parentFolderId);
            h.getFilesHelper(c,e,h,parentFolderId);
            h.getLinksHelper(c,e,h,parentFolderId);
        }else{
            c.set('v.selectedFolderId','');
            c.set('v.folderSection',true);
            h.getFoldersHelper(c,e,h);
        }*/
        c.set("v.showFolderSection", false);
        c.set("v.showSubFolderSection", false);
        c.set("v.showLinkSection", false);
        console.log('>>parent id>>'+c.get("v.parentFolderId"));
        h.getSubFolderBackHelper(c,e,h,c.get("v.parentFolderId"));

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
    openSelectedLink: function(c, e, h) {
        var link = e.currentTarget.getAttribute("data-Id");
        if(link != undefined && link != null){
            window.open(link);
        }

    },
    handleUploadFinished: function(c, e, h) {
        var selectedFolderId = c.get('v.selectedFolderId');
        if(selectedFolderId != null && selectedFolderId != undefined){
            h.getFilesHelper(c,e,h,selectedFolderId);
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
    deleteLink: function(c, e, h) {
        console.log('deleteFile>>');
        var linkId = e.getSource().get("v.name")
        console.log('linkId>>'+linkId);
        
        if(linkId != undefined && linkId != null){
            c.set('v.showConfirmDialog', true);
            c.set('v.recIdToDel', linkId);
            c.set('v.recIdToDelobjType', 'link');
            
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
            h.deletelinkRecordHelper(c,e,h,c.get('v.recIdToDel'));
        }
        c.set('v.recIdToDel', '');
        c.set('v.recIdToDelobjType', '');
    },
    handleConfirmDialogNo : function(c, e, h) {
        console.log('No');
        c.set('v.showConfirmDialog', false);
    },
    showCreateLinkSection : function(c, e, h) {
        try{
            c.set('v.selectedTab','three');
            console.log('showCreateLinkSection>>>>'+c.get('v.showLinkSection'));
            c.set("v.showLinkSection", true);
            h.refreshLinkObj(c,e,h);
        } catch (ex) {
            console.log('>>>Error>>showCreateLinkSection>'+ex);
            
        }
    },
    showCreateSubFolderSection : function(c, e, h) {
        try{
            c.set('v.selectedTab','one');
            console.log('showSubFolderSection>>>>'+c.get('v.showSubFolderSection'));
            c.set("v.showSubFolderSection", true);
            h.refreshSubFolderObj(c,e,h);
        } catch (ex) {
            console.log('>>>Error>>showCreateSubFolderSection>'+ex);
            
        }
    },
    closeSubFolder: function(c, e, h) {
        try{
            console.log('showSubFolderSection>>>>'+c.get('v.showSubFolderSection'));
            c.set("v.showSubFolderSection", false);
            h.refreshSubFolderObj(c,e,h);
        } catch (ex) {
            console.log('>>>Error>>closeSubFolder>'+ex);
            
        }
    },
    saveSubFolder:function(c,e,h){
        h.saveSubFolderHelper(c,e,h);
    },
    closeLink: function(c, e, h) {
        try{
            console.log('showCreateLinkSection>>>>'+c.get('v.showLinkSection'));
            c.set("v.showLinkSection", false);
            h.refreshLinkObj(c,e,h);
        } catch (ex) {
            console.log('>>>Error>>showCreateLinkSection>'+ex);
            
        }
    },
    saveLink:function(c,e,h){
        h.saveLinkHelper(c,e,h);
    },
    handleSelect: function (c, e, h){
        if(c.get("v.selectedTab") == 'one'){
            c.set("v.showLinkSection", false);
        }
        if(c.get("v.selectedTab") == 'three'){
            c.set("v.showSubFolderSection", false);
        }
    },
    showCreateFolderSection : function(c, e, h) {
        try{
            c.set('v.selectedTab','one');
            console.log('showSubFolderSection>>>>'+c.get('v.showSubFolderSection'));
            c.set("v.showFolderSection", true);
            h.refreshSubFolderObj(c,e,h);
        } catch (ex) {
            console.log('>>>Error>>showCreateSubFolderSection>'+ex);
            
        }
    },
    closeFolder: function(c, e, h) {
        try{
            console.log('showFolderSection>>>>'+c.get('v.showFolderSection'));
            c.set("v.showFolderSection", false);
            h.refreshSubFolderObj(c,e,h);
        } catch (ex) {
            console.log('>>>Error>>closeFolder>'+ex);
            
        }
    },
    saveFolder:function(c,e,h){
        h.saveFolderHelper(c,e,h);
    },
    
    renameFileHome: function(c,e,h){
        console.log('RenameFile>>');
        var fileId = e.getSource().get("v.name")
        console.log('fileId>>'+fileId);
        
        if(fileId != undefined && fileId != null){
            c.set('v.showRenameDialog', true);
            c.set('v.recIdToRename', fileId);
            c.set('v.recIdToRenameobjType', 'file');
            c.set('v.isHome', true);
        }
    },
    
    renameFolderHome: function(c,e,h){
        console.log('RenameFile>>');
        var fileId = e.getSource().get("v.name")
        console.log('fileId>>'+fileId);
        
        if(fileId != undefined && fileId != null){
            c.set('v.showRenameDialog', true);
            c.set('v.recIdToRename', fileId);
            c.set('v.recIdToRenameobjType', 'folder');
            c.set('v.isHome', true);
        } 
    },
    
    renameFile: function(c,e,h){
        console.log('RenameFile>>');
        var fileId = e.getSource().get("v.name")
        console.log('fileId>>'+fileId);
        
        if(fileId != undefined && fileId != null){
            c.set('v.showRenameDialog', true);
            c.set('v.recIdToRename', fileId);
            c.set('v.recIdToRenameobjType', 'file');
            c.set('v.isHome', false);
        }
    },
    
    renameFolder: function(c,e,h){
        console.log('RenameFile>>');
        var fileId = e.getSource().get("v.name")
        console.log('fileId>>'+fileId);
        
        if(fileId != undefined && fileId != null){
            c.set('v.showRenameDialog', true);
            c.set('v.recIdToRename', fileId);
            c.set('v.recIdToRenameobjType', 'folder');
            c.set('v.isHome', false);
        } 
    },
    
    handleRenameDialogNo : function(c, e, h) {
        console.log('No');
        c.set('v.showRenameDialog', false);
    },
    
    handleRenameDialogYes : function(c, e, h) {
        console.log('Yes');
        c.set('v.showRenameDialog', false);
        var objType = c.get('v.recIdToRenameobjType');
        if(objType == 'file'){
            h.renameFileRecordHelper(c,e,h,c.get('v.recIdToRename'),c.get('v.newName'));
        }
        if(objType == 'folder'){
            h.renameFolderRecordHelper(c,e,h,c.get('v.recIdToRename'),c.get('v.newName'));
        }
        c.set('v.recIdToRename', '');
        c.set('v.recIdToRenameobjType', '');
        c.set('v.newName','');
    },
})