/* Class Name: ShowGroupFolderController */
/* Description: this classes retrieves list of folders, files, links for a specific community */
/* */
public without sharing class ShowGroupFolderController {
    
    /* Method name:  getFoldersApex */
    /* Input: name of the community of the folders */
    /* returns: list of folders that have the input community name */
    @AuraEnabled
    public static List<Community_Folder__c> getFoldersApex(String folderType, String recordId){
        //System.debug('recordId>>>>'+recordId);
        //System.debug('docType>>>>'+docType);
        if(folderType != null && recordId != null){
            List<Community_Folder__c> CommFolderList = new List<Community_Folder__c>();
            CommFolderList = [SELECT Id,Name,Folder_Type__c,Group_Id__c FROM Community_Folder__c WHERE Folder_Type__c =: folderType AND Sub_Folder__c = FALSE AND Group_Id__c =:recordId ORDER BY Name];
            if(CommFolderList.size() > 0){
                return CommFolderList;
            }
        }
        return null;
    }

    
    /* Method name:  getCurrentUserProfileApex */
    /* Input: None */
    /* returns: return profile data */
    @AuraEnabled
    public static Profile getCurrentUserProfileApex(){
        //System.debug('recordId>>>>'+recordId);
        //System.debug('docType>>>>'+docType);
        Id profileId=userinfo.getProfileId();
        if(profileId != null){
            Profile profile = [Select Id,Name from Profile where Id =: profileId];
            return profile;
        }
        
        
        return null;
    }

    
    /* Method name:  getSubFolderBackApex */
    /* Input: Take the Folder Id */
    /* returns: list of folders that have the input community name */
    @AuraEnabled
    public static List<Community_Folder__c> getSubFolderBackApex(String folderId){
        //System.debug('recordId>>>>'+recordId);
        //System.debug('docType>>>>'+docType);
        if(folderId != null){
            List<Community_Folder__c> CommFolderList = new List<Community_Folder__c>();
            CommFolderList = [SELECT Id,Name,Folder_Type__c,Parent_Folder__c,Parent_Folder__r.Name,Parent_Folder__r.Parent_Folder__c FROM Community_Folder__c WHERE Id =: folderId AND Sub_Folder__c = TRUE ORDER BY Name];
            if(CommFolderList.size() > 0){
                return CommFolderList;
            }
        }
        return null;
    }

    /* Method name:  getSubFolderApex */
    /* Input: Take the Folder Id */
    /* returns: list of folders that have the input community name */
    @AuraEnabled
    public static List<Community_Folder__c> getSubFolderApex(String folderId){
        //System.debug('recordId>>>>'+recordId);
        //System.debug('docType>>>>'+docType);
        if(folderId != null){
            List<Community_Folder__c> CommFolderList = new List<Community_Folder__c>();
            CommFolderList = [SELECT Id,Name,Folder_Type__c,Parent_Folder__c,Parent_Folder__r.Name,Parent_Folder__r.Parent_Folder__c FROM Community_Folder__c WHERE Parent_Folder__c =: folderId AND Sub_Folder__c = TRUE ORDER BY Name];
            if(CommFolderList.size() > 0){
                return CommFolderList;
            }
        }
        return null;
    }
    
    /* Method name:  getLinksApex */
    /* Input: Take the Folder Id */
    /* returns: list of Link that have the input community name */
    @AuraEnabled
    public static List<Community_Link__c> getLinksApex(String folderId){
        //System.debug('recordId>>>>'+recordId);
        //System.debug('docType>>>>'+docType);
        if(folderId != null){
            List<Community_Link__c> CommLinkList = new List<Community_Link__c>();
            CommLinkList = [SELECT Id,Name,Community_Folder__c,Link__c,Title__c FROM Community_Link__c WHERE Community_Folder__c =: folderId ORDER BY Title__c];
            if(CommLinkList.size() > 0){
                return CommLinkList;
            }
        }
        return null;
    }

    /* Method name:  deleteFileRecordApex */
    /* Input: Take the File Id */
    /* returns: None */
    @AuraEnabled
    public static void deleteFileRecordApex(String recId){
        //System.debug('recordId>>>>'+recordId);
        //System.debug('docType>>>>'+docType);
        if(recId != null){
            List<ContentDocument> documentList = new List<ContentDocument>();
            documentList = [SELECT Id FROM ContentDocument WHERE Id =: recId];
            if(documentList.size() > 0){
                delete documentList;
            }
        }
        
    }

    /* Method name:  deleteLinkRecordApex */
    /* Input: Take the Link Id */
    /* returns: None */
    @AuraEnabled
    public static void deleteLinkRecordApex(String recId){
        //System.debug('recordId>>>>'+recordId);
        //System.debug('docType>>>>'+docType);
        if(recId != null){
            List<Community_Link__c> commLinkList = new List<Community_Link__c>();
            commLinkList = [SELECT Id FROM Community_Link__c WHERE Id =: recId];
            if(commLinkList.size() > 0){
                delete commLinkList;
            }
        }
        
    }

    /* Method name:  saveLinkApex */
    /* Input: Take the Folder Id and New Link Obj*/
    /* returns: None */
    @AuraEnabled
    public static void saveLinkApex(String folderId,Community_Link__c newLinkRec){
        //System.debug('recordId>>>>'+recordId);
        //System.debug('docType>>>>'+docType);
        if(folderId != null && newLinkRec != null){
            Community_Link__c commLinkObj = new Community_Link__c();
            commLinkObj.Community_Folder__c = folderId;
            commLinkObj.Link__c = newLinkRec.Link__c;
            commLinkObj.Title__c = newLinkRec.Title__c;
            if(commLinkObj != null){
                insert commLinkObj;
            }
        }
        
    }

    /* Method name:  saveSubFolderApex */
    /* Input: Take the Folder Id and New Folder Obj and Folder Type*/
    /* returns: None */
    @AuraEnabled
    public static void saveSubFolderApex(String folderId, Community_Folder__c newSubFolderRec, String folderType){
        //System.debug('recordId>>>>'+recordId);
        //System.debug('docType>>>>'+docType);
        if(folderId != null && newSubFolderRec != null && folderType != null){
            Community_Folder__c commFolderObj = new Community_Folder__c();
            commFolderObj.Parent_Folder__c = folderId;
            commFolderObj.Name = newSubFolderRec.Name;
            commFolderObj.Folder_Type__c = folderType;
            commFolderObj.Sub_Folder__c = true;
            //commLinkObj.Title__c = newLinkRec.Title__c;
            if(commFolderObj != null){
                insert commFolderObj;
            }
        }
        
    }

    /* Method name:  saveFolderApex */
    /* Input: Take the New Folder Obj and Folder Type*/
    /* returns: None */
    @AuraEnabled
    public static void saveFolderApex(Community_Folder__c newFolderRec, String folderType, String recordId){
        //System.debug('recordId>>>>'+recordId);
        //System.debug('docType>>>>'+docType);
        if(newFolderRec != null && folderType != null){
            Community_Folder__c commFolderObj = new Community_Folder__c();
            //commFolderObj.Parent_Folder__c = folderId;
            commFolderObj.Name = newFolderRec.Name;
            commFolderObj.Folder_Type__c = folderType;
            commFolderObj.Group_Id__c = recordId;
            //commFolderObj.Sub_Folder__c = true;
            //commLinkObj.Title__c = newLinkRec.Title__c;
            if(commFolderObj != null){
                insert commFolderObj;
            }
        }
        
    }

    /* Method name:  getFilesApex */
    /* Input: Take the Folder Id */
    /* returns: list of FileRecordWrapper class */
    @AuraEnabled
    public static List<FileRecordWrapper> getFilesApex(String folderId){
        //System.debug('recordId>>>>'+recordId);
        //System.debug('docType>>>>'+docType);
        if(folderId != null){
            List<ContentDocumentLink> cdlList = new List<ContentDocumentLink>();
            cdlList = [SELECT Id,ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId =: folderId];
            if(cdlList.size() > 0){
                Set<String> contentDocSet = new Set<String>();
                for(ContentDocumentLink cdl : cdlList){
                    contentDocSet.add(cdl.ContentDocumentId);
                }
                if(contentDocSet.size() > 0){
                    List<ContentVersion> contentversionList = new List<ContentVersion>();
                    contentversionList = [SELECT Id,Title,ContentDocumentId,ContentSize,CreatedDate,OwnerId,Owner.Name FROM ContentVersion WHERE ContentDocumentId IN: contentDocSet ORDER BY Title];
                    if(contentversionList.size() > 0){
                        List<FileRecordWrapper> FileRecList = new List<FileRecordWrapper>();
                        for (ContentVersion cv : contentversionList) {
                            FileRecordWrapper FileRecObj = new FileRecordWrapper();
                            FileRecObj.DocId = cv.ContentDocumentId;
                            FileRecObj.Title = cv.Title;
                            FileRecObj.Size = String.valueOf((cv.ContentSize / 1024).format()) + ' KB';
                            FileRecObj.Owner = cv.Owner.Name;
                            FileRecObj.OwnerId = cv.OwnerId;
                            FileRecObj.CreatedDate = cv.CreatedDate.Date();
                            FileRecList.add(FileRecObj);
                        }
                        if(FileRecList.size() > 0){
                            return FileRecList;
                        }
                    }
                }
            }
        }
        return null;
    }
    
    /*Method Name - getGroupMember
     * Return - List of group members
     * Arguement - Group Id */
    @AuraEnabled
    public static List<CollaborationGroupMember> getGroupMember(String groupId){
        if(groupId != null && groupId != ''){
           List<CollaborationGroupMember> listGroupMember = new List<CollaborationGroupMember>([select id,memberId, member.name,member.title, member.email,member.SmallPhotoUrl from CollaborationGroupMember where CollaborationGroupId =:groupId order by member.name]);
            if(listGroupMember != null && listGroupMember.size()>0){
                return listGroupMember;
            }else{
                return null;
            }
        }
        return null;
    }
    
    
    /* Method name:  getCurrentUserId
     * Input: None 
     * returns: return user Id and Profile */
    @AuraEnabled
    public static String getCurrentUserId(){
        String userId =  userinfo.getuserID();
        Id profileId=userinfo.getProfileId();
        if(profileId != null){
            Profile profile = [Select Id,Name from Profile where Id =: profileId];
            return userId+'--'+profile.Name;
        }        
        return null;
    }
    
    /* Method name:  renameFolderRecordApex
     * Input: Folder Id and new Name for the folder 
     * returns: none
     * usage: used to rename the folder*/
    @AuraEnabled
    public static void renameFolderRecordApex(String recId, String newName){
        if(recId != null && recId != ''){
            List<Community_Folder__c> CommFolderList = new List<Community_Folder__c>();
            CommFolderList = [SELECT Id,Name FROM Community_Folder__c WHERE Id =: recId limit 1];
            if(CommFolderList.size() > 0 && newName != null && newName != ''){
                CommFolderList[0].Name = newName;
                update CommFolderList;
            }
        }
    }
    
    /* Method name:  renameFolderRecordApex
     * Input: File Id and new Name for the file 
     * returns: none
     * usage: used to rename the file*/
    @AuraEnabled
    public static void renameFileRecordApex(String recId, String newName){
        if(recId != null && recId != ''){
            List<ContentDocument> documentList = new List<ContentDocument>();
            documentList = [SELECT Id,Title FROM ContentDocument WHERE Id =: recId Limit 1];
            if(documentList.size() > 0 && newName != null && newName != ''){
                documentList[0].Title = newName;
                update documentList;
            }
        }
        
    }
    
    /* Class name:  FileRecordWrapper */
    /* Type: Wrapper class to store File data*/
    public class FileRecordWrapper{
        @AuraEnabled public String DocId {get;set;}
        @AuraEnabled public String Title {get;set;}
        @AuraEnabled public String Owner {get;set;}
        @AuraEnabled public String OwnerId {get;set;}
        @AuraEnabled public String Size {get;set;}
        @AuraEnabled public Date CreatedDate {get;set;}
    }
    
}