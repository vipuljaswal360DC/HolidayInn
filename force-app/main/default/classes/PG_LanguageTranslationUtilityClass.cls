public class PG_LanguageTranslationUtilityClass {
    @AuraEnabled
    public static list<sObject> fetchMessageText(String Language){
        String messageData = '';
        if(Language!=null && Language!=''){
            try{
                if(Language == 'en_US'){
                    list<Messages_EN__c> enUS = [select MessageNum__c,MessageText__c from Messages_EN__c order by MessageNum__c ASC];/* where MessageNum__c=:MessageNum limit 1];
                    if(enUS!=null){
                    	messageData = (enUS.MessageText__c!='' && enUS.MessageText__c!=null) ? enUS.MessageText__c : '';
                    }*/
                    list<sObject> retObj = enUS;
                    return retObj;
                }
                else if(Language == 'en_GB'){
                    list<Messages_EN_GB__c> enGB = [select MessageNum__c,MessageText__c from Messages_EN_GB__c order by MessageNum__c ASC];/* where MessageNum__c=:MessageNum limit 1];
                    if(enGB!=null){
                        messageData = (enGB.MessageText__c!='' && enGB.MessageText__c!=null) ? enGB.MessageText__c : '';
                    }*/
                    list<sObject> retObj = enGB;
                    return retObj;
                }
                else if(Language == 'es'){
                    list<Messages_ES__c> ES = [select MessageNum__c,MessageText__c from Messages_ES__c order by MessageNum__c ASC];/* where MessageNum__c=:MessageNum limit 1];
                    if(ES!=null){
                        messageData = (ES.MessageText__c!='' && ES.MessageText__c!=null) ? ES.MessageText__c : '';
                    }*/
                    list<sObject> retObj = ES;
                    return retObj;
                }
                else if(Language == 'pt_BR'){
                    list<Messages_PT_BR__c> ptBR = [select MessageNum__c,MessageText__c from Messages_PT_BR__c order by MessageNum__c ASC];/* where MessageNum__c=:MessageNum limit 1];
                    if(ptBR!=null){
                        messageData = (ptBR.MessageText__c!='' && ptBR.MessageText__c!=null) ? ptBR.MessageText__c : '';
                    }*/
                    list<sObject> retObj = ptBR;
                    return retObj;
                }
                else
                    return new list<sObject>{new Messages_EN__c(MessageNum__c=-1,MessageText__c='error')};
            }
            catch(Exception e){
                return new list<sObject>{new Messages_EN__c(MessageNum__c=-1,MessageText__c='error')};
			}
        }
        return new list<sObject>{new Messages_EN__c(MessageNum__c=-1,MessageText__c='error')};
	}
}