/* Class Name: PG_AccountUtilityClass
* Usage: This utility class will return the account data if any exist with name.
* 
*/
public class PG_AccountUtilityClass {
    
    public static boolean insertingAccount = false;
    
    /* Method Name: validateAccount
     * Usage: This method will search account by name and will return the AccountInfoWrapper if it exist or not.
     * Return Type: AccountInfoWrapper Class
     * Parameters: Name of account (String)
     */
    public static AccountInfoWrapper validateAccount(String accountName){
        System.debug('----Validating Account Data----'+accountName); 
        if(accountName != null && accountName != ''){
            
            //Map to find duplicate and to return data
            Map<String,List<Account>> namevsAccountMap = searchAccountByName(new List<String>{'%'+accountName.trim().replaceAll('[ ]{2,}', ' ')+'%'});
            
            //Checking the returned value if the account exist
            if(namevsAccountMap != null && namevsAccountMap.size()==1){
                
                List <String> keyList = new List<String>(namevsAccountMap.keySet());
                String firstMapValue = keyList[0];
                //Return log if single account found
                if(namevsAccountMap.get(firstMapValue).size()==1){
                    Account accObj = namevsAccountMap.get(firstMapValue.trim())[0];
                    //Account fields which we have to update
                    AccountInfoWrapper accWrapper = new AccountInfoWrapper(true,'Success',accObj,'Account with name '+accObj.Name+' Updated');
                    return accWrapper;
                    
                //Return log if multiple account found
                }else if(namevsAccountMap.get(firstMapValue).size()>1){
                    AccountInfoWrapper accWrapper = new AccountInfoWrapper(false,'Error',null,'Possible Duplicate Account exists with Name '+accountName);
                    return accWrapper;
                }
             
            //Return log for duplicate data
            }else if(namevsAccountMap != null && namevsAccountMap.size()>1){
                AccountInfoWrapper accWrapper = new AccountInfoWrapper(false,'Error',null,'Possible Duplicate Account exists with Name '+accountName);
                return accWrapper;
            //Return log if no data found for passed values
            }else{
               AccountInfoWrapper accWrapper = new AccountInfoWrapper(false,'Success',null,'No Account Found with Name '+accountName);
               return accWrapper; 
            }
            
        }
        return null;
    }
    
    /* Method Name: searchAccountByName
     * Usage: This method will search account by name and will return the map of name vs account list.
     * Return Type: Map of name(String) vs account list
     * Parameters: List of Name(String)
     */
    public static Map<String,List<Account>> searchAccountByName(List<String> nameList){
        System.debug('----Search Account Data----'+nameList);
        if(nameList != null && nameList.size()>0){
            
            //Query All Fields of Account
            DescribeSObjectResult describeResult = Account.getSObjectType().getDescribe();  
            List<String> fieldNames = new List<String>( describeResult.fields.getMap().keySet() );  
            
            //SOQL to query the account with the given name
            String query = 'SELECT '+String.join( fieldNames, ',') +' FROM ' +describeResult.getName() +' where Name Like :nameList';
            List<Account> accountList = Database.query( query );
            
            System.debug('---accountList---'+accountList);
            System.debug('---accountListSize---'+accountList.size());
            
            
            //adding data to name vs account list map to find duplicate and to return data
            if(accountList != null && accountList.size()>0){
                
                //Map to find duplicate and to return data
                Map<String,List<Account>> namevsAccountMap= new Map<String,List<Account>>();
                for(Account accObj: accountList){
                    if(namevsAccountMap != null && namevsAccountMap.containsKey(accObj.Name)){
                        List<Account> tempList = new List<Account>(namevsAccountMap.get(accObj.Name));
                        tempList.add(accObj);
                        namevsAccountMap.put(accObj.Name, tempList);
                    }else{
                        List<Account> tempList = new List<Account>();
                        tempList.add(accObj);
                        namevsAccountMap.put(accObj.Name, tempList);
                    }
                }
                
                System.debug('---accountList---'+namevsAccountMap);
                System.debug('---accountListSize---'+namevsAccountMap.size());
                System.debug('---accountListSize---'+namevsAccountMap.values());
                
                //retuning data
                if(namevsAccountMap != null && namevsAccountMap.size() > 0){
                    return namevsAccountMap;
                }
            }
        }
        return null;
    }
   
    
    /* Method Name: createAccount
     * Usage: This method will create the account record,
     * Return Type: Created account reference
     * Parameters: All the details of account.
     */
    public static Account createAccount(String name,String fullName, String missionAndVision, String website, String partnerCommunication, 
                                        String partnerParticipatedBefore, String partnerRegisteredEntity, String partnerActivities, String town, 
                                        String country, String geoCoverage, String postCode, String state, String street, String targetBeneficiaries){
        System.debug('----In Account Creation----');   
        //Creating account record  
        Account accObj = new Account(Name = name.trim().replaceAll('[ ]{2,}', ' '),
                                     Mission_and_Vision_Statement__c = missionAndVision,
                                     Website = website,
                                     Registered_Entity__c = partnerRegisteredEntity,
                                     Geographic_Coverage__c = geoCoverage,
                                     Target_Clients_or_Beneficiaries__c = targetBeneficiaries,
                                     Sector_Activities__c = partnerActivities,
                                     BillingCity = town,
                                     BillingCountry = country,
                                     BillingPostalCode = postCode,
                                     BillingState = state,
                                     BillingStreet = street
                                     );
                                            
        insertingAccount = true;                                    
        insert accObj;
        return accObj;
    }
    
    
    /* Method Name: updateAccount
     * Usage: This method will update the account record,
     * Return Type: update account reference
     * Parameters: All the details of account.
     */
    public static Account updateAccount(Account accObj, String name,String fullName, String missionAndVision, String website, String partnerCommunication, 
                                        String partnerParticipatedBefore, String partnerRegisteredEntity, String partnerActivities, String town, 
                                        String country, String geoCoverage, String postCode, String state, String street, String targetBeneficiaries,
                                        String registrationNumber, String Phone){
        System.debug('----In Account Updation----');   
        //updating account record  
        //accObj.Name = name;
        accObj.Mission_and_Vision_Statement__c = missionAndVision;
        accObj.Website = website;
        accObj.Registered_Entity__c = partnerRegisteredEntity;
        accObj.Geographic_Coverage__c = geoCoverage;
        accObj.Target_Clients_or_Beneficiaries__c = targetBeneficiaries;
        accObj.Sector_Activities__c = partnerActivities;                                    
        accObj.BillingCity = town;
        accObj.BillingCountry = country;
        accObj.BillingPostalCode = postCode;
        accObj.BillingState = state;
        accObj.BillingStreet = street;
        accObj.Registration_Number__c = registrationNumber;
        accObj.Phone = Phone;                               
                                            
        update accObj;
        return accObj;
    }
    
    
    //Wrapper class for account logs
    public class AccountInfoWrapper{
        public boolean isAccountExist;
        public string status;
        public Account acc;
        public string message;
        
        public AccountInfoWrapper(boolean isAccountExist, String status,Account acc, String message){
            this.isAccountExist = isAccountExist;
            this.status = status;
            this.acc = acc;
            this.message = message;
        }
    }
}