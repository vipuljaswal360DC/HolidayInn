/* Class Name: PG_DownloadAttachmentBatchClass
 * Usage: This batch class will download the attachments from the links
 * 
 */
public class PG_DownloadAttachmentBatchClass implements Database.Batchable<Grant_Request__c>,Database.Stateful,Database.AllowsCallouts {
    public list<Grant_Request__c> successGrantReqDataList; // list to store inserted grant request
    public list<Attachment> AttachmentList = new list<Attachment>(); //list to store attachment id
    //public map<Grant_Request__c,Application_Grant_Request_Form__c> grantReqvsApplicationFormMap;
    
    public PG_DownloadAttachmentBatchClass(List<Grant_Request__c> successGrantReqDataList){
        this.successGrantReqDataList = successGrantReqDataList;
        //this.grantReqvsApplicationFormMap = grantReqvsApplicationFormMap;                               
    }
    
    /* Method Name: start
     * Type: Standard Method
     */
    public List<Grant_Request__c> start(Database.BatchableContext BC){
        System.debug('-----successGrantReqDataList-----'+successGrantReqDataList);
        return successGrantReqDataList;
    }
    
    /* Method Name: execute
     * Type: Standard Method
     */
    public void execute(Database.BatchableContext BC, List<Grant_Request__c> successGrantReqDataList){
        System.debug('-----successGrantReqDataList-----'+successGrantReqDataList);
        
        //Checking if list is not blank
        if(successGrantReqDataList != null && successGrantReqDataList.size()>0){
            Grant_Request__c grantObj = successGrantReqDataList[0]; //Grant req reference variable
            //Savepoint sp = Database.setSavepoint();  
            try{
                if(grantObj.Proof_of_company_registration_File_Name__c != null && grantObj.Proof_of_company_registration_File_Name__c != '' 
                   && grantObj.Proof_of_company_org_registration__c != null && grantObj.Proof_of_company_org_registration__c != ''){
                       String fileName = grantObj.Proof_of_company_registration_File_Name__c;
                       String contentType = fileName.substringAfterLast('.');
                       String url = grantObj.Proof_of_company_org_registration__c;
                       //Calling method to download attachment
                       Attachment att = PG_GrantRequestUtilityClass.downloadAttachment(grantObj.Id, fileName, contentType, url);
                       AttachmentList.add(att);
                   }
                
                if(grantObj.Proof_of_bank_account_File_Name__c != null && grantObj.Proof_of_bank_account_File_Name__c != '' 
                   && grantObj.Proof_of_bank_account__c != null && grantObj.Proof_of_bank_account__c != ''){
                       String fileName = grantObj.Proof_of_bank_account_File_Name__c;
                       String contentType = fileName.substringAfterLast('.');
                       String url = grantObj.Proof_of_bank_account__c;
                       //Calling method to download attachment
                       Attachment att = PG_GrantRequestUtilityClass.downloadAttachment(grantObj.Id, fileName, contentType, url);
                       AttachmentList.add(att);
                   }
                
                if(grantObj.Up_to_date_Management_Accounts_File_Name__c != null && grantObj.Up_to_date_Management_Accounts_File_Name__c != '' 
                   && grantObj.Up_to_date_Management_Accounts__c != null && grantObj.Up_to_date_Management_Accounts__c != ''){
                       String fileName = grantObj.Up_to_date_Management_Accounts_File_Name__c;
                       String contentType = fileName.substringAfterLast('.');
                       String url = grantObj.Up_to_date_Management_Accounts__c;
                       //Calling method to download attachment
                       Attachment att = PG_GrantRequestUtilityClass.downloadAttachment(grantObj.Id, fileName, contentType, url);
                       AttachmentList.add(att);
                   }
                
                if(grantObj.Proof_of_Add_not_old_than_3_File_Name__c != null && grantObj.Proof_of_Add_not_old_than_3_File_Name__c != '' 
                   && grantObj.Proof_of_Address_not_older_than_3_months__c != null && grantObj.Proof_of_Address_not_older_than_3_months__c != ''){
                       String fileName = grantObj.Proof_of_Add_not_old_than_3_File_Name__c;
                       String contentType = fileName.substringAfterLast('.');
                       String url = grantObj.Proof_of_Address_not_older_than_3_months__c;
                       //Calling method to download attachment
                       Attachment att = PG_GrantRequestUtilityClass.downloadAttachment(grantObj.Id, fileName, contentType, url);
                       AttachmentList.add(att);
                   }
                
                if(grantObj.Signed_copy_of_Founding_doc_File_Name__c != null && grantObj.Signed_copy_of_Founding_doc_File_Name__c != '' 
                   && grantObj.Signed_copy_of_Founding_document__c != null && grantObj.Signed_copy_of_Founding_document__c != ''){
                       String fileName = grantObj.Signed_copy_of_Founding_doc_File_Name__c;
                       String contentType = fileName.substringAfterLast('.');
                       String url = grantObj.Signed_copy_of_Founding_document__c;
                       //Calling method to download attachment
                       Attachment att = PG_GrantRequestUtilityClass.downloadAttachment(grantObj.Id, fileName, contentType, url);
                       AttachmentList.add(att);
                   }
                
                if(grantObj.List_of_the_org_board_members_File_Name__c != null && grantObj.List_of_the_org_board_members_File_Name__c != '' 
                   && grantObj.List_of_the_organisation_s_board_members__c != null && grantObj.List_of_the_organisation_s_board_members__c != ''){
                       String fileName = grantObj.List_of_the_org_board_members_File_Name__c;
                       String contentType = fileName.substringAfterLast('.');
                       String url = grantObj.List_of_the_organisation_s_board_members__c;
                       //Calling method to download attachment
                       Attachment att = PG_GrantRequestUtilityClass.downloadAttachment(grantObj.Id, fileName, contentType, url);
                       AttachmentList.add(att);
                   }
                
                if(grantObj.Certified_board_member_s_ID_File_Name__c != null && grantObj.Certified_board_member_s_ID_File_Name__c != '' 
                   && grantObj.Certified_copy_of_each_board_member_s_ID__c != null && grantObj.Certified_copy_of_each_board_member_s_ID__c != ''){
                       String fileName = grantObj.Certified_board_member_s_ID_File_Name__c;
                       String contentType = fileName.substringAfterLast('.');
                       String url = grantObj.Certified_copy_of_each_board_member_s_ID__c;
                       //Calling method to download attachment
                       Attachment att = PG_GrantRequestUtilityClass.downloadAttachment(grantObj.Id, fileName, contentType, url);
                       AttachmentList.add(att);
                   }
                
                if(grantObj.Proof_of_residence_board_member_FileName__c != null && grantObj.Proof_of_residence_board_member_FileName__c != '' 
                   && grantObj.Proof_of_residence_for_each_board_membe__c != null && grantObj.Proof_of_residence_for_each_board_membe__c != ''){
                       String fileName = grantObj.Proof_of_residence_board_member_FileName__c;
                       String contentType = fileName.substringAfterLast('.');
                       String url = grantObj.Proof_of_residence_for_each_board_membe__c;
                       //Calling method to download attachment
                       Attachment att = PG_GrantRequestUtilityClass.downloadAttachment(grantObj.Id, fileName, contentType, url);
                       AttachmentList.add(att);
                   }
                
                if(grantObj.EMIS_registration_number_File_Name__c != null && grantObj.EMIS_registration_number_File_Name__c != '' 
                   && grantObj.EMIS_registration_number_for_schools__c != null && grantObj.EMIS_registration_number_for_schools__c != ''){
                       String fileName = grantObj.EMIS_registration_number_File_Name__c;
                       String contentType = fileName.substringAfterLast('.');
                       String url = grantObj.EMIS_registration_number_for_schools__c;
                       //Calling method to download attachment
                       Attachment att = PG_GrantRequestUtilityClass.downloadAttachment(grantObj.Id, fileName, contentType, url);
                       AttachmentList.add(att);
                   }
                
                if(grantObj.Letterhead_for_schools_File_Name__c != null && grantObj.Letterhead_for_schools_File_Name__c != '' 
                   && grantObj.Letterhead_for_schools__c != null && grantObj.Letterhead_for_schools__c != ''){
                       String fileName = grantObj.Letterhead_for_schools_File_Name__c;
                       String contentType = fileName.substringAfterLast('.');
                       String url = grantObj.Letterhead_for_schools__c;
                       //Calling method to download attachment
                       Attachment att = PG_GrantRequestUtilityClass.downloadAttachment(grantObj.Id, fileName, contentType, url);
                       AttachmentList.add(att);
                   }
                
            }catch(Exception e){
                System.debug('-----Exception-----'+e.getMessage()+'----Line number----'+e.getLineNumber());
                //Database.rollback(sp);
                //PG_ApplicationSurveyLogUtilityClass.createGrantReqLog(grantReqvsApplicationFormMap.get(grantObj), 'Error', e.getMessage());
                //return;
            }
            
        }
    }
    
    /* Method Name: finish
     * Type: Standard Method
     */
    public void finish(Database.BatchableContext BC){
        //Savepoint sp = Database.setSavepoint();
        try{
            insert AttachmentList;
        }catch(Exception e){
            System.debug('-----Exception-----'+e.getMessage()+'----Line number----'+e.getLineNumber());
            //Database.rollback(sp);
            //PG_ApplicationSurveyLogUtilityClass.createGrantReqLog(grantReqvsApplicationFormMap.get(grantObj), 'Error', e.getMessage());
            //return;
        }
        
    }
}