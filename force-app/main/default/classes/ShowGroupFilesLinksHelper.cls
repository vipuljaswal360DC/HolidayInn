/* Class Name: ShowGroupFilesLinksHelper */
/* Description: this classes retrieves list of files, links for a specific Group */

public with sharing class ShowGroupFilesLinksHelper {
    /* Method name:  getCurrentUserProfileApex */
    /* Input: None */
    /* returns: returns Profile Object */
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

    /* Method name:  deleteFileRecordApex */
    /* Input: record Id of the Files */
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

    /* Method name:  getFilesApex */
    /* Input: group Id */
    /* returns: list of FileRecordWrapper class */
    @AuraEnabled
    public static List<FileRecordWrapper> getFilesApex(String groupId){
        //System.debug('recordId>>>>'+recordId);
        //System.debug('docType>>>>'+docType);
        if(groupId != null){
            List<ContentDocumentLink> cdlList = new List<ContentDocumentLink>();
            cdlList = [SELECT Id,ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId =: groupId];
            if(cdlList.size() > 0){
                Set<String> contentDocSet = new Set<String>();
                for(ContentDocumentLink cdl : cdlList){
                    contentDocSet.add(cdl.ContentDocumentId);
                }
                if(contentDocSet.size() > 0){
                    List<ContentVersion> contentversionList = new List<ContentVersion>();
                    contentversionList = [SELECT Id,Title,ContentDocumentId,ContentSize,CreatedDate,OwnerId,Owner.Name FROM ContentVersion WHERE ContentDocumentId IN: contentDocSet];
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