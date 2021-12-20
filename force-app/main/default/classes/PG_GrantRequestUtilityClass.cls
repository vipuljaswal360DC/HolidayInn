/* Class Name: PG_GrantRequestUtilityClass
* Usage: This utility class will create the Grant request data.
* 
*/
public class PG_GrantRequestUtilityClass {
    
    
    /* Method Name: validateGrantReq
     * Usage: This method will search grant request by name and will return the GrantReqInfoWrapper if it exist or not.
     * Return Type: GrantReqInfoWrapper Class
     * Parameters: Name of grant request (String)
     */
    public static GrantReqInfoWrapper validateGrantReq(String grantReqName){
     System.debug('----Validating grantReqName Data----'); 
        if(grantReqName != null && grantReqName != ''){
            
            //Map to find duplicate and to return data
            Map<String,List<Grant_Request__c>> namevsGrantReqMap = searchGrantReqByName(new List<String>{grantReqName.trim().replaceAll('[ ]{2,}', ' ')});
            
            //Checking the returned value if the account exist
            if(namevsGrantReqMap != null && namevsGrantReqMap.size()>0){
                List <String> keyList = new List<String>(namevsGrantReqMap.keySet());
                String firstMapValue = keyList[0];
                if(namevsGrantReqMap.get(firstMapValue.trim()).size() == 1){
                    Grant_Request__c grantObj = namevsGrantReqMap.get(firstMapValue.trim())[0];
                    GrantReqInfoWrapper grantWrapper = new GrantReqInfoWrapper(true,'Success',grantObj,'Grant Request exists with Name '+grantReqName);
                    return grantWrapper;
                }else if(namevsGrantReqMap.get(firstMapValue.trim()).size() == 1){
                    Grant_Request__c grantObj = namevsGrantReqMap.get(firstMapValue.trim())[0];
                    GrantReqInfoWrapper grantWrapper = new GrantReqInfoWrapper(true,'Error',null,'Duplicate Grant Request exists with Name '+grantReqName);
                    return grantWrapper;
                }
                                
                //Return log if no data found for passed values
            }else{
                GrantReqInfoWrapper grantWrapper = new GrantReqInfoWrapper(false,'Success',null,'No Grant Request Found with Name '+grantReqName);
                return grantWrapper;
            }
            
        }
        return null;
    }
    
    /* Method Name: searchGrantReqByName
     * Usage: This method will search GrantReq by name and will return the map of name vs GrantReq list.
   * Return Type: Map of name(String) vs GrantReq list
   * Parameters: List of Name(String)
   */
    public static Map<String,List<Grant_Request__c>> searchGrantReqByName(List<String> nameList){
        if(nameList != null && nameList.size()>0){
            
            //Query All Fields of Projects
            DescribeSObjectResult describeResult = Grant_Request__c.getSObjectType().getDescribe();  
            List<String> fieldNames = new List<String>( describeResult.fields.getMap().keySet() );  
            
            //SOQL to query the projects with the given name
            String query = 'SELECT '+String.join( fieldNames, ',') +' FROM ' +describeResult.getName() +' where Grant_Request_Name__c IN :nameList';
            List<Grant_Request__c> grantReqList = Database.query( query );
            
            System.debug('---grantReqList---'+grantReqList);
            System.debug('---grantReqListSize---'+grantReqList.size());
            
            
            //adding data to name vs project list map to find duplicate and to return data
            if(grantReqList != null && grantReqList.size()>0){
                
                //Map to find duplicate and to return data
                Map<String,List<Grant_Request__c>> namevsGrantReqMap= new Map<String,List<Grant_Request__c>>();
                for(Grant_Request__c grantObj: grantReqList){
                    if(namevsGrantReqMap != null && namevsGrantReqMap.containsKey(grantObj.Grant_Request_Name__c)){
                        List<Grant_Request__c> tempList = new List<Grant_Request__c>(namevsGrantReqMap.get(grantObj.Grant_Request_Name__c));
                        tempList.add(grantObj);
                        namevsGrantReqMap.put(grantObj.Grant_Request_Name__c, tempList);
                    }else{
                        List<Grant_Request__c> tempList = new List<Grant_Request__c>();
                        tempList.add(grantObj);
                        namevsGrantReqMap.put(grantObj.Grant_Request_Name__c, tempList);
                    }
                }
                
                System.debug('---namevsGrantReqMap---'+namevsGrantReqMap);
                System.debug('---namevsGrantReqMapSize---'+namevsGrantReqMap.size());
                System.debug('---namevsGrantReqMapValues---'+namevsGrantReqMap.values());
                
                //retuning data
                if(namevsGrantReqMap != null && namevsGrantReqMap.size() > 0){
                    return namevsGrantReqMap;
                }
            }
        }
        return null;
    }
    
    /* Method Name: createGrantReq
     * Usage: This method will create the grant request record,
     * Return Type: Created grant request reference
     * Parameters: Name and Application_Grant_Request_Form reference.
     */
    public static Grant_Request__c createGrantReq(String name, Account accObj, Projects__c projObj, Contact conObj, Application_Grant_Request_Form__c appObj){
        
        Grant_Request__c grantReqObj = new Grant_Request__c(Grant_Request_Name__c = name.trim().replaceAll('[ ]{2,}', ' '),
                                                            Organization__c = accObj.Id,
                                                            Organization_POC__c = conObj.Id,
                                                            Project__c = projObj.Id,
                                                            Anticipated_Project_Start_Date__c = Date.valueOf(appObj.Anticipated_Project_Start_Date__c),
                                                            Anticipated_Project_End_Date__c = Date.valueOf(appObj.Anticipated_Project_End_Date__c),
                                                            Proof_of_Address_not_older_than_3_months__c = appObj.Proof_of_Address_not_older_than_3_months__c,
                                                            Proof_of_bank_account__c = appObj.Proof_of_bank_account__c,
                                                            Proof_of_company_org_registration__c = appObj.Proof_of_company_org_registration__c,
                                                            Proof_of_residence_for_each_board_membe__c = appObj.Proof_of_residence_for_each_board_membe__c,
                                                            Signed_copy_of_Founding_document__c = appObj.Signed_copy_of_Founding_document__c,
                                                            Certified_copy_of_each_board_member_s_ID__c = appObj.Certified_copy_of_each_board_member_s_ID__c,
                                                            EMIS_registration_number_for_schools__c = appObj.EMIS_registration_number_for_schools__c,
                                                            Letterhead_for_schools__c = appObj.Letterhead_for_schools__c,
                                                            List_of_the_organisation_s_board_members__c = appObj.List_of_the_organisation_s_board_members__c,
                                                            Founding_Document__c = appObj.Does_your_org_have_a_founding_document__c,
                                                            Bank_Account__c = appObj.Does_your_org_have_a_bank_account__c,
                                                            Confirmed_PBO_status_and_or_NPO_Cert__c = appObj.A_letter_from_SARS_confirming_PBO_status__c,
                                                            Up_to_Date_Management_Accounts__c = appObj.Up_to_date_Management_Accounts__c,
                                                            Primary_Focus_of_Organisation__c = appObj.Primary_focus_of_your_organisation__c,
                                                            Project_Background_and_Grant_Narrative__c = appObj.Project_Background_and_Grant_Narrative__c,
                                                            Geographical_Location__c = appObj.Geo_Location_of_Project_Implementation__c,
                                                            Proof_of_Add_not_old_than_3_File_Name__c = appObj.Proof_of_Add_not_old_than_3_File_Name__c,
                                                            EMIS_registration_number_File_Name__c = appObj.EMIS_registration_number_File_Name__c,
                                                            Letterhead_for_schools_File_Name__c = appObj.Letterhead_for_schools_File_Name__c,
                                                            List_of_the_org_board_members_File_Name__c = appObj.List_of_the_org_board_members_File_Name__c,
                                                            Certified_board_member_s_ID_File_Name__c = appObj.Certified_board_member_s_ID_File_Name__c,
                                                            Proof_of_company_registration_File_Name__c = appObj.Proof_of_company_registration_File_Name__c,
                                                            Proof_of_bank_account_File_Name__c = appObj.Proof_of_bank_account_File_Name__c,
                                                            Up_to_date_Management_Accounts_File_Name__c = appObj.Up_to_date_Management_Accounts_File_Name__c,
                                                            Signed_copy_of_Founding_doc_File_Name__c = appObj.Signed_copy_of_Founding_doc_File_Name__c,
                                                            Proof_of_residence_board_member_FileName__c = appObj.Proof_of_residence_board_member_FileName__c,
                                                            End_of_Last_FY__c = null,
                                                            Budget_Item_1__c = appObj.Budget_Item_1__c,
                                                            Budget_Item_2__c = appObj.Budget_Item_2__c,
                                                            Budget_Item_3__c = appObj.Budget_Item_3__c,
                                                            Budget_Item_4__c = appObj.Budget_Item_4__c,
                                                            Budget_Item_5__c = appObj.Budget_Item_5__c,
                                                            Budget_Item_6__c = appObj.Budget_Item_6__c,
                                                            Budget_Item_7__c = appObj.Budget_Item_7__c,
                                                            Budget_Item_8__c = appObj.Budget_Item_8__c,
                                                            Budget_Item_9__c = appObj.Budget_Item_9__c,
                                                            Budget_Item_10__c = appObj.Budget_Item_10__c,
                                                            Management_Accounts_for_the_current_FY__c= appObj.Management_Accounts_for_the_current_FY__c,
                                                            Survey_ID__c = appObj.SurveyPlatform__c + '-' + appObj.ResponseID__c
                                                           );
        if(appObj.Budget_Total_Cost__c != null && appObj.Budget_Total_Cost__c != ''){
            grantReqObj.Project_Cost__c = integer.valueOf(appObj.Budget_Total_Cost__c);
        }
        if(appObj.Total_Income_for_the_last_FY__c != null && appObj.Total_Income_for_the_last_FY__c != ''){
            grantReqObj.Total_income_last_FY_R__c = integer.valueOf(appObj.Total_Income_for_the_last_FY__c);
        }
        if(appObj.Budget_Item_1_and_Cost1__c != null && appObj.Budget_Item_1_and_Cost1__c != ''){
            grantReqObj.Cost_1__c = integer.valueOf(appObj.Budget_Item_1_and_Cost1__c);
        }
        if(appObj.Budget_Item_2_and_Cost_2__c != null && appObj.Budget_Item_2_and_Cost_2__c != ''){
            grantReqObj.Cost_2__c = integer.valueOf(appObj.Budget_Item_2_and_Cost_2__c);
        }
        if(appObj.Budget_Item_3_and_Cost_3__c != null && appObj.Budget_Item_3_and_Cost_3__c != ''){
            grantReqObj.Cost_3__c = integer.valueOf(appObj.Budget_Item_3_and_Cost_3__c); 
        }
        if(appObj.Budget_Item_4_and_Cost_4__c != null && appObj.Budget_Item_4_and_Cost_4__c != ''){
            grantReqObj.Cost_4__c = integer.valueOf(appObj.Budget_Item_4_and_Cost_4__c);
        }
        if(appObj.Budget_Item_5_and_Cost_5__c != null && appObj.Budget_Item_5_and_Cost_5__c != ''){
            grantReqObj.Cost_5__c = integer.valueOf(appObj.Budget_Item_5_and_Cost_5__c);
        }
        if(appObj.Budget_Item_6_and_Cost_6__c != null && appObj.Budget_Item_6_and_Cost_6__c != ''){
            grantReqObj.Cost_6__c = integer.valueOf(appObj.Budget_Item_6_and_Cost_6__c);
        }
        if(appObj.Budget_Item_7_and_Cost_7__c != null && appObj.Budget_Item_7_and_Cost_7__c != ''){
            grantReqObj.Cost_7__c = integer.valueOf(appObj.Budget_Item_7_and_Cost_7__c);
        }
        if(appObj.Budget_Item_8_and_Cost_8__c != null && appObj.Budget_Item_8_and_Cost_8__c != ''){
            grantReqObj.Cost_8__c = integer.valueOf(appObj.Budget_Item_8_and_Cost_8__c);
        }
        if(appObj.Budget_Item_9_and_Cost_9__c != null && appObj.Budget_Item_9_and_Cost_9__c != ''){
            grantReqObj.Cost_9__c = integer.valueOf(appObj.Budget_Item_9_and_Cost_9__c);
        }
        if(appObj.Budget_Item_10_and_Cost_10__c != null && appObj.Budget_Item_10_and_Cost_10__c != ''){
            grantReqObj.Cost_10__c = integer.valueOf(appObj.Budget_Item_10_and_Cost_10__c);
        }
       
        //downloadAttachment(grantReqObj.Id,'test','pdf',appObj.Proof_of_company_org_registration__c);
        
        insert grantReqObj;                                         
        return grantReqObj;   
    }
    
    
    /* Method Name: downloadAttachment
     * Parameters: Parent record id, file name, file type (pdf, png, txt, etc.) and url
     */
    public static Attachment downloadAttachment(Id recordId, String fileName, String contentType, String url){
        // Instantiate a new http object
        Http h = new Http();
        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setTimeout(120000);//sets maximum timeout
        req.setMethod('GET');
        
        // Send the request, and return a response
        Blob body;
        if(!test.isRunningTest()){
            HttpResponse res = h.send(req);
            body = res.getBodyAsBlob();
            system.debug('---test--'+res);
        }else{
            body = Blob.valueOf('Test');
        }
        
        //then you can attach this body wherever you want
        Attachment att = new Attachment(Name = fileName, Body = body, ContentType = ContentType(contentType), ParentId = recordId);
        return att;
    }
    
    public static string ContentType(string fileType)
    {
        switch on fileType.toLowerCase()
        {
            when 'txt'
            {
                return 'text/plain';
            }
            when 'xls'
            {
                return 'application/vnd.ms-excel';
            }
            when 'xlsx'
            {
                return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
            }
            when 'zip'
            {
                return 'application/zip';
            }
            when 'docx'
            {
                return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
            }
            when 'csv'
            {
                return 'application/vnd.ms-excel';
            }
            when 'wav'
            {
                return 'audio/wav';
            }
            when 'wmv'
            {
                return 'video/x-ms-wmv';
            }
            when 'mp3'
            {
                return 'audio/mpeg';
            }
            when 'mp4'
            {
                return 'video/mp4';
            }
            when 'png'
            {
                return 'image/png';
                
            }
            when 'pdf'
            {
                return 'application/pdf';
                
            }
            when else {
                return 'image/jpeg';
            }
        }
    }
    
    
    //Wrapper class
    public class GrantReqInfoWrapper{
        public boolean isGrantReqExist;
        public string status;
        public Grant_Request__c grantReqObj;
        public string message;
        
        public GrantReqInfoWrapper(boolean isGrantReqExist, String status,Grant_Request__c grantReqObj, String message){
            this.isGrantReqExist = isGrantReqExist;
            this.status = status;
            this.grantReqObj = grantReqObj;
            this.message = message;
        }
    }
}