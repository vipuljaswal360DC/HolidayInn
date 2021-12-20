global with sharing class SubmitApplicationController {
    
    //Accepts the record id and sends a boolean status about the updation
    @AuraEnabled @RemoteAction
    global static String SubmitApp(Id projectAppID){
        Set<String> lstValidationValues = new Set<String>();
        String ValidationValues = '';
        try{
            List<String> lstTeamMember1 = new List<String>{'Team Member 1 Job Title','Team Member 1 First Name','Team Member 1 Last Name','Team Member 1 Work Email','Team Member 1 Office City','Team Member 1 Home Office Country','Team Member 1 Company Affiliation','Team Member 1 Line Manager Full Name','Team Member 1 Line Manager Work Email','Team Member 1 BusUnitDebeers','Team Member 1 BusUnitAnglo'};
                List<String> lstTeamMember2 = new List<String>{'Team Member 2 Job Title','Team Member 2 First Name','Team Member 2 Last Name','Team Member 2 Work Email','Team Member 2 Office City','Team Member 2 Home Office Country','Team Member 2 Company Affiliation','Team Member 2 Line Manager Full Name','Team Member 2 Line Manager Work Email','Team Member 2 BusUnitDebeers','Team Member 2 BusUnitAnglo'};
                    List<String> lstTeamMember3 = new List<String>{'Team Member 3 Job Title','Team Member 3 First Name','Team Member 3 Last Name','Team Member 3 Work Email','Team Member 3 Office City','Team Member 3 Home Office Country','Team Member 3 Company Affiliation','Team Member 3 Line Manager Full Name','Team Member 3 Line Manager Work Email','Team Member 3 BusUnitDebeers','Team Member 3 BusUnitAnglo'};
                        List<String> lstTeamMember4 = new List<String>{'Team Member 4 Job Title','Team Member 4 First Name','Team Member 4 Last Name','Team Member 4 Work Email','Team Member 4 Office City','Team Member 4 Home Office Country','Team Member 4 Company Affiliation','Team Member 4 Line Manager Full Name','Team Member 4 Line Manager Work Email','Team Member 4 BusUnitDebeers','Team Member 4 BusUnitAnglo'};
                            
                            Map<String,String> mapProjApp = new map<String,String>();
            
            Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
            Schema.SObjectType leadSchema = schemaMap.get('Application_Survey_Form__c');
            Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();
            
            /* Retrieve fields of Project application from the page layout */
            String apiFieldNames = '';
            Map<String,List<String>> mapSectionFieldlst = new Map<String,List<String>>();
            List<Metadata.Metadata> layouts = 
                Metadata.Operations.retrieve(Metadata.MetadataType.Layout, 
                                             new List<String> {'Application_Survey_Form__c-Project Application New'});
            Metadata.Layout layoutMd = (Metadata.Layout) layouts.get(0);
            
            for (Metadata.LayoutSection section : layoutMd.layoutSections) {
                for (Metadata.LayoutColumn column : section.layoutColumns) {
                    if (column.layoutItems != null) {
                        for (Metadata.LayoutItem item : column.layoutItems) {
                            System.debug('section-'+section.label);
                            if(!mapSectionFieldlst.containsKey(section.label)){
                                List<String> tempList = new List<String>();
                                tempList.add(fieldMap.get(item.field).getDescribe().getLabel());
                                mapSectionFieldlst.put(section.label,tempList);
                            }else{
                                List<String> tempList = new List<String>();
                                tempList = mapSectionFieldlst.get(section.label);
                                tempList.add(fieldMap.get(item.field).getDescribe().getLabel());
                                mapSectionFieldlst.put(section.label, tempList);
                            }
                            apiFieldNames = apiFieldNames+item.field+',';
                        }
                    }
                }
            }
            apiFieldNames = apiFieldNames.removeEnd(',');
            List<String> lstFields = apiFieldNames.split(',');
            System.debug('lstFields-'+lstFields);
            System.debug('mapSectionFieldlst-'+mapSectionFieldlst);
            
            String qry = 'Select id,'+apiFieldNames+' FROM Application_Survey_Form__c where Id=:projectAppID LIMIT 1';
            System.debug('qry-'+qry);
            
            Application_Survey_Form__c pa = Database.query(qry);
            System.debug('pa - '+pa);
            
            for(String fieldName:lstFields){
                String fieldValue = String.valueOf(pa.get(fieldName));
                mapProjApp.put(fieldName,fieldValue);
            }
            Integer numberOfTeamMembers = 0;
            if ( mapProjApp.get('Number_Of_Team_Members__c') != NULL && mapProjApp.get('Number_Of_Team_Members__c') != '' ){
                numberOfTeamMembers = Integer.valueOf(mapProjApp.get('Number_Of_Team_Members__c'));
            }
            String companyAffiliation = '';
            if ( mapProjApp.get('Team_Captain_Company_Affiliation__c') != NULL && mapProjApp.get('Team_Captain_Company_Affiliation__c') != '' ){
                companyAffiliation = String.valueOf(mapProjApp.get('Team_Captain_Company_Affiliation__c'));
            }
            String teamMember1CompanyAffiliation = '';
            if ( mapProjApp.get('Team_Member_1_Company_Affiliation__c') != NULL && mapProjApp.get('Team_Member_1_Company_Affiliation__c') != '' ){
                teamMember1CompanyAffiliation = String.valueOf(mapProjApp.get('Team_Member_1_Company_Affiliation__c'));
            }
            String teamMember2CompanyAffiliation = '';
            if ( mapProjApp.get('Team_Member_2_Company_Affiliation__c') != NULL && mapProjApp.get('Team_Member_2_Company_Affiliation__c') != '' ){
                teamMember2CompanyAffiliation = String.valueOf(mapProjApp.get('Team_Member_2_Company_Affiliation__c'));
            }
            String teamMember3CompanyAffiliation = '';
            if ( mapProjApp.get('Team_Member_3_Company_Affiliation__c') != NULL && mapProjApp.get('Team_Member_3_Company_Affiliation__c') != '' ){
                teamMember3CompanyAffiliation = String.valueOf(mapProjApp.get('Team_Member_3_Company_Affiliation__c'));
            }
            String teamMember4CompanyAffiliation = '';
            if ( mapProjApp.get('Team_Member_4_Company_Affiliation__c') != NULL && mapProjApp.get('Team_Member_4_Company_Affiliation__c') != '' ){
                teamMember4CompanyAffiliation = String.valueOf(mapProjApp.get('Team_Member_4_Company_Affiliation__c'));
            }
            String grantUse = '';
            if ( mapProjApp.get('Grant_Use__c') != NULL && mapProjApp.get('Grant_Use__c') != '' ){
                grantUse = String.valueOf(mapProjApp.get('Grant_Use__c'));
            }
            System.debug('mapProjApp - '+mapProjApp);
            for(String fieldname : mapProjApp.keySet()){
                if(mapProjApp.get(fieldname)==NULL){
                    lstValidationValues.add( fieldMap.get(fieldname).getDescribe().getLabel() );
                }
            }
            
            if(numberOfTeamMembers==3){
                lstValidationValues.removeAll(lstTeamMember4);
            }else if(numberOfTeamMembers==2){
                lstValidationValues.removeAll(lstTeamMember3);
                lstValidationValues.removeAll(lstTeamMember4);
            }else if(numberOfTeamMembers==1){
                lstValidationValues.removeAll(lstTeamMember2);
                lstValidationValues.removeAll(lstTeamMember3);
                lstValidationValues.removeAll(lstTeamMember4);
            }
            else if(numberOfTeamMembers==0){
                lstValidationValues.removeAll(lstTeamMember1);
                lstValidationValues.removeAll(lstTeamMember2);
                lstValidationValues.removeAll(lstTeamMember3);
                lstValidationValues.removeAll(lstTeamMember4);
            }
            if(companyAffiliation == 'Anglo American'){
                lstValidationValues.remove('Team Captain BusUnitDebeers');
                System.debug('lstValidationValues Anglo American-->'+lstValidationValues);
            }else if(companyAffiliation == 'De Beers Group'){
                lstValidationValues.remove('Team Captain BusUnitAnglo'); 
                System.debug('lstValidationValues De Beers Group-->'+lstValidationValues);
            }
            if(teamMember1CompanyAffiliation == 'Anglo American'){
                lstValidationValues.remove('Team Member 1 BusUnitDebeers');
            }else if(teamMember1CompanyAffiliation == 'De Beers Group'){
                lstValidationValues.remove('Team Member 1 BusUnitAnglo'); 
            }
            if(teamMember2CompanyAffiliation == 'Anglo American'){
                lstValidationValues.remove('Team Member 2 BusUnitDebeers');
            }else if(teamMember2CompanyAffiliation == 'De Beers Group'){
                lstValidationValues.remove('Team Member 2 BusUnitAnglo'); 
            }
            if(teamMember3CompanyAffiliation == 'Anglo American'){
                lstValidationValues.remove('Team Member 3 BusUnitDebeers');
            }else if(teamMember3CompanyAffiliation == 'De Beers Group'){
                lstValidationValues.remove('Team Member 3 BusUnitAnglo'); 
            }
            if(teamMember4CompanyAffiliation == 'Anglo American'){
                lstValidationValues.remove('Team Member 4 BusUnitDebeers');
            }else if(teamMember4CompanyAffiliation == 'De Beers Group'){
                lstValidationValues.remove('Team Member 4 BusUnitAnglo'); 
            }
            
            if(grantUse == 'No'){
                lstValidationValues.remove('Grant Amount');
            }
            
            System.debug('lstValidationValues-->'+lstValidationValues);
            if(lstValidationValues != null && !lstValidationValues.isEmpty()){
                ValidationValues = new List<String> ( lstValidationValues )[0];
                System.debug('ValidationValues-'+ValidationValues);
            }
            for(String sectionName : mapSectionFieldlst.keySet()){
                for(String fieldName : mapSectionFieldlst.get(sectionName)){
                    if(ValidationValues == fieldName){
                        ValidationValues = ValidationValues+','+sectionName;
                    }
                }
            }
            System.debug('ValidationValues Final-'+ValidationValues);
            /*for(String fieldNames : lstValidationValues){
ValidationValues = ValidationValues+fieldNames+',';
}
ValidationValues = ValidationValues.removeEnd(',');
*/
            if(pa.Id != NULL){
                if(ValidationValues==''){
                    pa.Stop_Resync__c = true;
                    pa.Resubmission_Flag__c = 'No';
                    system.debug('pa before update '+pa);
                    update pa;
                    system.debug('pa '+pa);
                    return 'success';
                }else{
                    return ValidationValues;
                }
            }else{
                return 'notInSubmission';
            }
        }
        catch(Exception e){
            System.debug('Exception occured at line-'+e.getLineNumber());
            System.debug('Exception occured Message-'+e.getMessage());
            return 'exception';
        }
    }
}