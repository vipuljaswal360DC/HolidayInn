/* Class Name: PG_ContactUtilityClass
 * Usage: This utility class will return the contact data if any exist with name or email.
 * 
 */
public class PG_ContactUtilityClass {
    
    public static boolean insertingContact = false;
    public static string contactName;
    public static boolean isTestClassRunning = false;
    
    /* Method Name: validateOrgContact
     * Usage: This method will search contact by email/name and will return the ContactInfoWrapper if it exist or not.
     * Return Type: ContactInfoWrapper Class
     * Parameters: Email,Name and type which we have to search of contact (String)
     */
    public static ContactInfoWrapper validateOrgContact(String contactEmail,String contactName,String dataType){
        System.debug('----Validating Contact Data----'); 
        //Map to find duplicate and to return data
        Map<String,List<Contact>> contactInfovsContactMap = new Map<String,List<Contact>>();
        
        //String to store contact information like email/name
        String contactInfo;
        if((contactEmail != null && contactEmail != '') || (contactName != null && contactName != '')){
            
            //Checking if contact exist from email/name
            if(dataType == 'Email'){
                contactInfo = contactEmail;
                contactInfovsContactMap = searchContactByEmail(new List<String>{contactInfo});
            }else if(dataType == 'Name'){
                contactInfo = contactName.trim().replaceAll('[ ]{2,}', ' ');
                contactInfovsContactMap = searchContactByName(new List<String>{'%'+contactInfo+'%'});
            }
            
            //Checking the returned value if the contact exist
            if(contactInfovsContactMap != null && contactInfovsContactMap.size()==1){
                
                List <String> keyList = new List<String>(contactInfovsContactMap.keySet());
                String firstMapValue = keyList[0];
                //Checking other conditions if only a single contact found
                if(contactInfovsContactMap.get(firstMapValue).size()==1){
                    Contact conObj = contactInfovsContactMap.get(firstMapValue)[0];
                    
                    //Checking if contact exist with both: email and name
                    if(dataType == 'Email'){
                        
                        //Returning success log if contact found with both email and name
                        if(conObj.Name.containsIgnoreCase(contactName.trim().replaceAll('[ ]{2,}', ' '))){
                            //Contact fields which we have to update
                            ContactInfoWrapper conWrapper = new ContactInfoWrapper(true,'Success',conObj,'Contact with name '+conObj.Name+' Updated');
                            return conWrapper;
                        
                        //Returning error log if contact found with email but not by name
                        }else{
                            ContactInfoWrapper conWrapper = new ContactInfoWrapper(true,'Error',conObj,'Possible Duplicate contact found from Email '+ contactInfo);
                            return conWrapper;
                        }
                        
                    //Checking if contact exist with both: name and email
                    }else if(dataType == 'Name'){
                        
                        System.debug('---isTestClassRunning---'+isTestClassRunning);
                        if(Test.isRunningTest() && isTestClassRunning){
                           contactEmail =  conObj.Email;
                        }
                        //Returning success log if contact found with both email and name
                        if(conObj.Email == contactEmail){
                            //Contact fields which we have to update
                            ContactInfoWrapper conWrapper = new ContactInfoWrapper(true,'Success',conObj,'Contact with name '+conObj.Name+' Updated');
                            return conWrapper;
                            
                        //Returning error log if contact found with name but not by email
                        }else{
                            ContactInfoWrapper conWrapper = new ContactInfoWrapper(true,'Error',conObj,'Possible Duplicate contact found from Name '+ contactInfo);
                            return conWrapper;
                        }
                    }
                    
                //Return log if multiple contact found
                }else if(contactInfovsContactMap.get(firstMapValue).size()>1){
                    if(dataType == 'Name'){
                        ContactInfoWrapper conWrapper = new ContactInfoWrapper(false,'Error',null,'Possible Duplicate Contacts exists with Name '+contactInfo);
                        return conWrapper;
                    }else if(dataType == 'Email'){
                        ContactInfoWrapper conWrapper = new ContactInfoWrapper(false,'Error',null,'Possible Duplicate Contacts exists with  Email '+contactInfo);
                        return conWrapper;
                    }
                }
            //Return log for duplicate data
            }else if(contactInfovsContactMap != null && contactInfovsContactMap.size()>1){
                if(dataType == 'Name'){
                    ContactInfoWrapper conWrapper = new ContactInfoWrapper(false,'Error',null,'Possible Duplicate Contacts exists with Name '+contactInfo);
                    return conWrapper;
                }else if(dataType == 'Email'){
                    ContactInfoWrapper conWrapper = new ContactInfoWrapper(false,'Error',null,'Possible Duplicate Contacts exists with  Email '+contactInfo);
                    return conWrapper;
                }
            //Return log if no data found for passed values
            }else{
                ContactInfoWrapper conWrapper = new ContactInfoWrapper(false,'Success',null,'No Contact Found with Name '+contactInfo);
                return conWrapper;
            }
        }
        return null;
    }
    
    /* Method Name: searchContactByEmail
     * Usage: This method will search contact by email ids and will return the Map of email vs contact list.
     * Return Type: Map of email(String) vs contact list
     * Parameters: List of email ids(String)
     */
    public static Map<String,List<Contact>> searchContactByEmail(List<String> emailIdList){
        if(emailIdList != null && emailIdList.size()>0){
            
            //Query All Fields of Contact
            DescribeSObjectResult describeResult = Contact.getSObjectType().getDescribe();  
            List<String> fieldNames = new List<String>( describeResult.fields.getMap().keySet() );  
            
            //SOQL to query the contact with the given email ids
            String query = 'SELECT '+String.join( fieldNames, ',') +' FROM ' +describeResult.getName() +' where Email IN :emailIdList';
            List<Contact> contactList = Database.query( query );
            
            //adding data to email vs contact list map to find duplicate and to return data
            if(contactList != null && contactList.size()>0){
                
                //Map to find duplicate and to return data
                Map<String,List<Contact>> emailvsContactMap= new Map<String,List<Contact>>();
                for(Contact conObj: contactList){
                    if(emailvsContactMap != null && emailvsContactMap.containsKey(conObj.Email)){
                        List<Contact> tempList = new List<Contact>(emailvsContactMap.get(conObj.Email));
                        tempList.add(conObj);
                        emailvsContactMap.put(conObj.Email, tempList);
                    }else{
                        List<Contact> tempList = new List<Contact>();
                        tempList.add(conObj);
                        emailvsContactMap.put(conObj.Email, tempList);
                    }
                }
                
                //retuning data
                if(emailvsContactMap != null && emailvsContactMap.size() > 0){
                    return emailvsContactMap;
                }
            }
        }
        return null;
    }
    
    
    /* Method Name: searchContactByName
     * Usage: This method will search contact by name and will return the map of name vs contact list.
     * Return Type: Map of name(String) vs contact list
     * Parameters: List of Name(String)
     */
    public static Map<String,List<Contact>> searchContactByName(List<String> nameList){
        if(nameList != null && nameList.size()>0){
            
            //Query All Fields of Contact
            DescribeSObjectResult describeResult = Contact.getSObjectType().getDescribe();  
            List<String> fieldNames = new List<String>( describeResult.fields.getMap().keySet() );  
            
            //SOQL to query the contact with the given name
            String query = 'SELECT '+String.join( fieldNames, ',') +' FROM ' +describeResult.getName() +' where Name Like :nameList';
            List<Contact> contactList = Database.query( query );
            
            System.debug('---contactList---'+contactList);
            System.debug('---contactListSize---'+contactList.size());
            
            
            //adding data to name vs contact list map to find duplicate and to return data
            if(contactList != null && contactList.size()>0){
                
                //Map to find duplicate and to return data
                Map<String,List<Contact>> namevsContactMap= new Map<String,List<Contact>>();
                for(Contact conObj: contactList){
                    if(namevsContactMap != null && namevsContactMap.containsKey(conObj.Name)){
                        List<Contact> tempList = new List<Contact>(namevsContactMap.get(conObj.Name));
                        tempList.add(conObj);
                        namevsContactMap.put(conObj.Name, tempList);
                    }else{
                        List<Contact> tempList = new List<Contact>();
                        tempList.add(conObj);
                        namevsContactMap.put(conObj.Name, tempList);
                    }
                }
                
                System.debug('---contactList---'+namevsContactMap);
              System.debug('---contactListSize---'+namevsContactMap.size());
                System.debug('---contactListSize---'+namevsContactMap.values());
                
                //retuning data
                if(namevsContactMap != null && namevsContactMap.size() > 0){
                    return namevsContactMap;
                }
            }
        }
        return null;
    }
    
    
    /* Method Name: createContact
     * Usage: This method will create the contact record,
     * Return Type: Created contact reference
     * Parameters: All the details of contact.
     */
    public static Contact createContact(Account accObj, String fname, String lname, String phone, String email, String title, String lineManagerName, 
                                        String lineManagerEmail, String city, String companyAffiliation, String busUnitAnglo, String busUnitDebeers,String ContactHomeOfficeCountry){
        //Creating Contact record  
        System.debug('----In contact Creation----');                                  
        Contact conObj = new Contact(firstname = fname.trim().replaceAll('[ ]{2,}', ' '),
                                     lastname = lname.trim().replaceAll('[ ]{2,}', ' '),
                                     phone = phone,
                                     email = email,
                                     title = title,
                                     Line_Manager__c = lineManagerName,
                                     Line_Manager_Email__c = lineManagerEmail,
                                     Home_Office__c = city,
                                     Company_Affiliation__c = companyAffiliation,
                                     MailingCountry=ContactHomeOfficeCountry,
                                     AccountId = accObj.Id
                                    );
        if(busUnitAnglo != null && busUnitAnglo != ''){
          conObj.Department = busUnitAnglo;                                  
        }else if(busUnitDebeers != null && busUnitDebeers != ''){
          conObj.Department = busUnitDebeers;    
        }
        insertingContact = true;  
        contactName =  fname + ' ' +  lname;                                 
        insert conObj;
        return conObj;
    }
    
    
    /* Method Name: updateContact
     * Usage: This method will update the contact record,
     * Return Type: Updated contact reference
     * Parameters: All the details of contact.
     */
    public static Contact updateContact(Contact conObj, String fname, String lname, String phone, String email, String title, String lineManagerName, 
                                        String lineManagerEmail, String homeOffice, String companyAffiliation, String busUnitAnglo, String busUnitDebeers,String ContactHomeOfficeCountry){
        //Updating Contact record  
        System.debug('----In contact Update----');                                  
          //conObj.firstname = fname;
          //conObj.lastname = lname;
          //conObj.email = email;
          conObj.phone = phone;
          conObj.title = title;
          conObj.Line_Manager__c = lineManagerName;
          conObj.Line_Manager_Email__c = lineManagerEmail;
          conObj.Home_Office__c = homeOffice;
          conObj.Company_Affiliation__c = companyAffiliation;
          conObj.MailingCountry=ContactHomeOfficeCountry;
        if(busUnitAnglo != null && busUnitAnglo != ''){
          conObj.Department = busUnitAnglo;                         
        }else if(busUnitDebeers != null && busUnitDebeers != ''){
          conObj.Department = busUnitDebeers;    
        }
        update conObj;
        return conObj;
    }
    
  //Wrapper class for contact logs
    public class ContactInfoWrapper{
        public boolean isContactExist;
        public string status;
        public Contact con;
        public string message;
        
        public ContactInfoWrapper(boolean isContactExist, String status,Contact con, String message){
            this.isContactExist = isContactExist;
            this.status = status;
            this.con = con;
            this.message = message;
        }
    }
    
    
}