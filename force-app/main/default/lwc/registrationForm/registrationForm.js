import {
    LightningElement,
    track,
    wire
} from 'lwc';
import {
    ShowToastEvent
} from 'lightning/platformShowToastEvent';
import {
    NavigationMixin,
    CurrentPageReference
} from 'lightning/navigation';
import createUserAndContact from '@salesforce/apex/registrationFormLWCController.createUserAndContact';
import checkWorkEmail from '@salesforce/apex/registrationFormLWCController.checkWorkEmail';
import fetchContact from '@salesforce/apex/registrationFormLWCController.fetchContact';
import updateContactAndCreateUser from '@salesforce/apex/registrationFormLWCController.updateContactAndCreateUser';
import findUser from '@salesforce/apex/registrationFormLWCController.findUser';
import checkUserName from '@salesforce/apex/registrationFormLWCController.checkUserName';

export default class RegistrationForm extends NavigationMixin(LightningElement) {
    @track email = null;
    @track isShowWorkEmail = true;
    @track isShowContactInfo = false;
    @track Name = null;
    @track jobtitle = null;
    @track recordId = null;
    @track error;
    @track noContactExists = false;
    @track FirstName = null;
    @track SurName = null;
    @track WorkEmail = null;
    @track JobTitle = null;
    @track MaillingCity = null;
    @track isUserCreated = false;
    @track login = null;
    //@track AlternativeEmail = null;
    @track UserName = null;
    @track Password = null;
    @track HomeOfficeCountry = null;
    @track isAngloAmerican = true;
    @track isDeBeers = false;
    @track isAngloAmericanCF = true;
    @track isDeBeersCF = false;
    @track otherBusinessUnit = null;
    @track otherSelected = false;
    @track otherSelectedCF = false;
    @track confirmPassword = null;
    @track FirstNameCF;
    @track SurNameCF;
    @track JobTitleCF;
    @track WorkEmailCF;
    @track MaillingCityCF;
    //@track AlternativeEmailCF;
    @track HomeOfficeCountryCF;
    @track CompanyAffiliationCF;
    @track BusinessUnitAACF;
    @track BusinessUnitDBCF;
    @track otherBusinessUnitCF;
    @track WorkEmailCF;
    @track PasswordCF = null;
    @track UserNameCF = null;
    @track confirmPasswordCF = null;
    @track preferredLanguage = null;
    @track preferredLanguageCF = null;
    //@track companyNameCF;
    //@track companyName = null;
    ContactId;
    @track PP = {};
    get preferredLanguageOptions() {
        return [{
                label: 'English(UK)',
                value: 'en_GB'
            },
            {
                label: 'Spanish',
                value: 'es'
            },
            {
                label: 'Portuguese (Brazil) (BR)',
                value: 'pt_BR'
            },
        ];

    }
    get options() {
        return [{
                label: 'Australia',
                value: 'Australia'
            },
            {
                label: 'Botswana',
                value: 'Botswana'
            },
            {
                label: 'Brazil',
                value: 'Brazil'
            },
            {
                label: 'Canada',
                value: 'Canada'
            },
            {
                label: 'Chile',
                value: 'Chile'
            },
            {
                label: 'Germany',
                value: 'Germany'
            },
            {
                label: 'Ireland',
                value: 'Ireland'
            },
            {
                label: 'Namibia',
                value: 'Namibia'
            },
            {
                label: 'Peru',
                value: 'Peru'
            },
            {
                label: 'Singapore',
                value: 'Singapore'
            },
            {
                label: 'South Africa',
                value: 'South Africa'
            },
            {
                label: 'United Kingdom',
                value: 'United Kingdom'
            },
        ];
    }
    get CAOptions() {
        return [{
                label: 'Anglo American',
                value: 'Anglo American'
            },
            {
                label: 'De Beers Group',
                value: 'De Beers Group'
            },
        ];
    }
    get BUAAOptions() {
        return [{
                label: 'Kumba Iron Ore',
                value: 'Kumba Iron Ore'
            },
            {
                label: 'Iron Ore & Nickel Brazil',
                value: 'Iron Ore & Nickel Brazil'
            },
            {
                label: 'Coal SA',
                value: 'Coal SA'
            },
            {
                label: 'Platinum',
                value: 'Platinum'
            },
            {
                label: 'Copper',
                value: 'Copper'
            },
            {
                label: 'Crop Nutrients',
                value: 'Crop Nutrients'
            },
            {
                label: 'Other',
                value: 'Other'
            },
        ];
    }
    get BUDBOptions() {
        return [{
                label: 'Group Corporate',
                value: 'Group Corporate'
            },
            {
                label: 'Element Six',
                value: 'Element Six'
            },
            {
                label: 'Other',
                value: 'Other'
            },
        ];
    }
    @track CompanyAffiliation = null;
    @track BusinessUnitAA = null;
    @track BusinessUnitDB = null;


    currentPageReference;
    @track urlLang;
    @track usrLangCF;

    @wire(CurrentPageReference)
    setCurrentPageReference(currentPageReference) {
        this.currentPageReference = currentPageReference;
        this.urlLang = this.currentPageReference.state.language;
        console.log('<--urlLang-->', this.urlLang);
        if (this.urlLang == 'en_GB') {
            this.preferredLanguage = 'en_GB';
        } else if (this.urlLang == 'es') {
            this.preferredLanguage = 'es';
        } else if (this.urlLang == 'pt_BR') {
            this.preferredLanguage = 'pt_BR';
        }
    }
    contactInfo = [];

    handleFieldChanges(event) {
        if (event.target.name == "email") {
            this.email = event.target.value;
            console.log('<--email-->', this.email);
        } else if (event.target.name == "firstname") {
            this.FirstName = event.target.value;
            console.log('<--FirstName-->', this.FirstName);
        } else if (event.target.name == "surname") {
            this.SurName = event.target.value;
            console.log('<--SurName-->', this.SurName);
        } else if (event.target.name == "workemail") {
            this.WorkEmail = event.target.value;
            console.log('<--WorkEmail-->', this.WorkEmail);
        } else if (event.target.name == "jobTitle") {
            this.JobTitle = event.target.value;
            console.log('<--JobTitle-->', this.JobTitle);
        } else if (event.target.name == "homeofficecity") {
            this.MaillingCity = event.target.value;
            console.log('<--MaillingCity-->', this.MaillingCity);
            /*} else if (event.target.name == "alternativeEmail") {
                this.AlternativeEmail = event.target.value;
                console.log('<--AlternativeEmail-->', this.AlternativeEmail);*/
        } else if (event.target.name == "username") {
            this.UserName = event.target.value;
            console.log('<--UserName-->', this.UserName);
        } else if (event.target.name == "password") {
            this.Password = event.target.value;
            console.log('<--Password-->', this.Password);
        } else if (event.target.name == "confirmpassword") {
            this.confirmPassword = event.target.value;
            console.log('<--confirmPassword-->', this.confirmPassword);
        } else if (event.target.name == "homeOfficeCountry") {
            this.HomeOfficeCountry = event.target.value;
            console.log('<--HomeOfficeCountry-->', this.HomeOfficeCountry);
        } else if (event.target.name == "CompanyAffiliation") {
            this.CompanyAffiliation = event.target.value;
            console.log('<--CompanyAffiliation-->', this.CompanyAffiliation);
            if (this.CompanyAffiliation == 'De Beers Group') {
                this.isAngloAmerican = false;
                this.isDeBeers = true;
                this.otherSelected = false;
            } else if (this.CompanyAffiliation == 'Anglo American') {
                this.isAngloAmerican = true;
                this.isDeBeers = false;
                this.otherSelected = false;
            }
        } else if (event.target.name == "BusinessUnitAA") {
            this.BusinessUnitAA = event.target.value;
            if (this.BusinessUnitAA != null) {
                this.BusinessUnitDB = null;
                console.log('<--BusinessUnitDB-->', this.BusinessUnitDB);
            }
            console.log('<--BusinessUnitAA-->', this.BusinessUnitAA);
            if (this.BusinessUnitAA == 'Other') {
                this.otherSelected = true;
            } else {
                this.otherSelected = false;
            }
        } else if (event.target.name == "BusinessUnitDB") {
            this.BusinessUnitDB = event.target.value;
            if (this.BusinessUnitDB != null) {
                this.BusinessUnitAA = null;
                console.log('<--BusinessUnitAA-->', this.BusinessUnitAA);
            }
            console.log('<--BusinessUnitDB-->', this.BusinessUnitDB);
            if (this.BusinessUnitDB == 'Other') {
                this.otherSelected = true;
            } else {
                this.otherSelected = false;
            }
        } else if (event.target.name == "firstnamecf") {
            this.FirstNameCF = event.target.value;
            console.log('<--FirstNameCF-->', this.FirstNameCF);
        } else if (event.target.name == "surnamecf") {
            this.SurNameCF = event.target.value;
            console.log('<--SurNameCF-->', this.SurNameCF);
        } else if (event.target.name == "workemailcf") {
            this.WorkEmailCF = event.target.value;
            console.log('<--WorkEmailCF-->', this.WorkEmailCF);
        } else if (event.target.name == "jobTitlecf") {
            this.JobTitleCF = event.target.value;
            console.log('<--JobTitleCF-->', this.JobTitleCF);
        } else if (event.target.name == "homeofficecitycf") {
            this.MaillingCityCF = event.target.value;
            console.log('<--MaillingCityCF-->', this.MaillingCityCF);
            /*} else if (event.target.name == "alternativeEmailcf") {
                this.AlternativeEmailCF = event.target.value;
                console.log('<--AlternativeEmailCF-->', this.AlternativeEmailCF);*/
        } else if (event.target.name == "usernamecf") {
            this.UserNameCF = event.target.value;
            console.log('<--UserNameCF-->', this.UserNameCF);
        } else if (event.target.name == "passwordcf") {
            this.PasswordCF = event.target.value;
            console.log('<--PasswordCF-->', this.PasswordCF);
        } else if (event.target.name == "confirmpasswordcf") {
            this.confirmPasswordCF = event.target.value;
            console.log('<--confirmPasswordCF-->', this.confirmPasswordCF);
            if (this.PasswordCF != this.confirmPasswordCF) {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Invalid Confirm Password',
                        message: 'Password did not match. Please Make sure both the passwords match.',
                        variant: 'error',
                    }),
                );
                event.preventDefault();
                return;
            }
        } else if (event.target.name == "homeOfficeCountrycf") {
            this.HomeOfficeCountryCF = event.target.value;
            console.log('<--HomeOfficeCountryCF-->', this.HomeOfficeCountryCF);
        } else if (event.target.name == "CompanyAffiliationcf") {
            this.CompanyAffiliationCF = event.target.value;
            console.log('<--CompanyAffiliationCF-->', this.CompanyAffiliationCF);
            if (this.CompanyAffiliationCF == 'De Beers Group') {
                this.isAngloAmericanCF = false;
                this.isDeBeersCF = true;
                this.otherSelectedCF = false;
            } else if (this.CompanyAffiliationCF == 'Anglo American') {
                this.isAngloAmericanCF = true;
                this.isDeBeersCF = false;
                this.otherSelectedCF = false;
            }
        } else if (event.target.name == "BusinessUnitAAcf") {
            this.BusinessUnitAACF = event.target.value;
            if (this.BusinessUnitAACF != null) {
                this.BusinessUnitDBCF = null;
            }
            console.log('<--BusinessUnitAACF-->', this.BusinessUnitAACF);
            if (this.BusinessUnitAACF == 'Other') {
                this.otherSelectedCF = true;
            } else {
                this.otherSelectedCF = false;
            }
        } else if (event.target.name == "BusinessUnitDBcf") {
            this.BusinessUnitDBCF = event.target.value;
            if (this.BusinessUnitDBCF != null) {
                this.BusinessUnitAACF = null;
            }
            console.log('<--BusinessUnitDBCF-->', this.BusinessUnitDBCF);
            if (this.BusinessUnitDBCF == 'Other') {
                this.otherSelectedCF = true;
            } else {
                this.otherSelectedCF = false;
            }
            /*} else if (event.target.name == "companyname") {
                this.companyName = event.target.value;
                console.log('<--companyName-->', this.companyName);
            } else if (event.target.name == "companynamecf") {
                this.companyNameCF = event.target.value;
                console.log('<--companyNameCF-->', this.companyNameCF);*/
        } else if (event.target.name == "otherBusinessUnit") {
            this.otherBusinessUnit = event.target.value;
            console.log('<--otherBusinessUnit-->', this.otherBusinessUnit);
        } else if (event.target.name == "otherBusinessUnitcf") {
            this.otherBusinessUnitCF = event.target.value;
            console.log('<--otherBusinessUnitCF-->', this.otherBusinessUnitCF);
        } else if (event.target.name == "preferredLanguage") {
            this.preferredLanguage = event.target.value;
            console.log('<--preferredLanguage-->', this.preferredLanguage);
        } else if (event.target.name == "preferredLanguageCF") {
            this.preferredLanguageCF = event.target.value;
            console.log('<--preferredLanguageCF-->', this.preferredLanguageCF);
        }
    }

    //Checking Work Primary Email
    checkEmail() {
        const isInputsCorrect = [...this.template.querySelectorAll('input')]
            .reduce((validSoFar, inputField) => {
                inputField.reportValidity();
                return validSoFar && inputField.checkValidity();
            }, true);
        if (isInputsCorrect) {
            //Imperative call to checkWorkEmail Apex Method
            checkWorkEmail({
                    email: this.email
                })
                .then((result) => {
                    this.isShowWorkEmail = false;
                    if (result != 'No Contact Exists') {
                        this.isShowContactInfo = true;
                        if (this.isShowContactInfo == true) {
                            console.log('this.isShowContactInfo', this.isShowContactInfo);
                            fetchContact({
                                    email: this.email
                                })
                                .then((result) => {
                                    console.log('<--result Fetch Contact-->', result);
                                    this.PP = [...result];
                                    console.log('<--this.PP-->', this.PP);
                                    //this.activities.forEach((activity) => {
                                    result.forEach((info) => {
                                        if (info.FirstName == null || info.FirstName == 'undefined') {
                                            this.FirstNameCF = null;
                                        } else {
                                            this.FirstNameCF = info.FirstName;
                                        }
                                        if (info.LastName == null || info.LastName == 'undefined') {
                                            this.SurNameCF = null;
                                        } else {
                                            this.SurNameCF = info.LastName;
                                        }
                                        if (info.Title == null || info.Title == 'undefined') {
                                            this.JobTitleCF = null;
                                        } else {
                                            this.JobTitleCF = info.Title;
                                        }
                                        if (info.Company_Affiliation__c == null || info.Company_Affiliation__c == 'undefined') {
                                            this.CompanyAffiliationCF = null;
                                        } else {
                                            this.CompanyAffiliationCF = info.Company_Affiliation__c;
                                            if (this.CompanyAffiliationCF  == 'Anglo American') {
                                                if (info.Department == null || info.Department == 'undefined') {
                                                    this.BusinessUnitAACF = null;
                                                } else {
                                                    this.BusinessUnitAACF = info.Department;
                                                }
                                            } else {
                                                if (info.Department == null || info.Department == 'undefined') {
                                                    this.BusinessUnitDBCF = null;
                                                } else {
                                                    this.isAngloAmericanCF = false;
                                                    this.isDeBeersCF = true;
                                                    this.BusinessUnitDBCF = info.Department;
                                                }
                                            }
                                        }
                                        if (info.MailingCountry == null || info.MailingCountry == 'undefined') {
                                            this.HomeOfficeCountryCF = null;
                                        } else {
                                            this.HomeOfficeCountryCF = info.MailingCountry;
                                        }
                                        /*if(info.Account.Name == null || info.Account.Name == 'undefined'){
                                            this.companyNameCF = null;
                                        }else{
                                            this.companyNameCF = info.Account.Name; 
                                        }
                                        if(info.Alternative_Email__c == null || info.Alternative_Email__c == 'undefined'){
                                            console.log('info.Alternative_Email__c ',info.Alternative_Email__c);
                                            this.AlternativeEmailCF = null; 
                                        }else{
                                            this.AlternativeEmailCF = info.Alternative_Email__c;
                                        }*/
                                        if (info.Email == null || info.Email == 'undefined') {
                                            this.WorkEmailCF = null;
                                        } else {
                                            this.WorkEmailCF = info.Email;
                                        }
                                        if (info.MailingCity == null || info.MailingCity == 'undefined') {
                                            this.MaillingCityCF = null;
                                        } else {
                                            this.MaillingCityCF = info.MailingCity;
                                        }
                                        if (info.Id == null || info.Id == 'undefined') {
                                            this.ContactId = null;
                                        } else {
                                            this.ContactId = info.Id;
                                        }
                                        if (info.Id != null) {
                                            findUser({
                                                ContactId: this.ContactId
                                            }).then((result) => {
                                                console.log('<--result Fetch User-->', result);
                                                result.forEach((info) => {
                                                    this.usrLangCF = info.LocaleSidKey;
                                                    console.log('<--this.usrLangCF-->', this.usrLangCF);
                                                    if (this.usrLangCF == 'en_GB') {
                                                        this.preferredLanguageCF = 'en_GB';
                                                    } else if (this.usrLangCF == 'es') {
                                                        this.preferredLanguageCF = 'es';
                                                    } else if (this.usrLangCF == 'pt_BR') {
                                                        this.preferredLanguageCF = 'pt_BR';
                                                    }
                                                })
                                            }).catch((error) => {
                                                console.log('<--error-->', error);
                                                this.error = error;
                                                this.dispatchEvent(
                                                    new ShowToastEvent({
                                                        title: 'User Not found',
                                                        message: 'Some Error Occured!',
                                                        variant: 'error',
                                                    }),
                                                );
                                            });
                                        }
                                        //this.SurNameCF = info.LastName;
                                        //this.JobTitleCF = info.Title;
                                        //this.BusinessUnitAACF = info.Department;
                                        //this.CompanyAffiliationCF = info.Company_Affiliation__c;
                                        //this.HomeOfficeCountryCF = info.MailingCountry;
                                        //this.companyNameCF = info.Account.Name;
                                        //this.AlternativeEmailCF = info.Alternative_Email__c;
                                        //this.WorkEmailCF = info.Email;
                                        //this.MaillingCityCF = info.MailingCity;
                                        //this.ContactId = info.Id;
                                    });
                                    //this.companyNameCF = 'Test Company';

                                })
                                .catch((error) => {
                                    console.log('<--error-->', error);
                                    this.error = error;
                                    this.dispatchEvent(
                                        new ShowToastEvent({
                                            title: 'Error Fetching Records',
                                            message: 'Some Error Occured',
                                            variant: 'error',
                                        }),
                                    );
                                });
                        }
                    }
                    this.recordId = result;
                    if (result == 'No Contact Exists') {
                        this.noContactExists = true;
                        console.log('this.noContactExists', this.noContactExists);
                    }
                    console.log('<--result-->', result);
                    console.log('<--recordId-->', this.recordId);

                })
                .catch((error) => {
                    console.log('<--error-->', error);
                    this.error = error;
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error Fetching Records',
                            message: 'Some Error Occured',
                            variant: 'error',
                        }),
                    );
                });
        }
    }
    saveRecords() {
        const isInputsCorrect = [...this.template.querySelectorAll('input')]
            .reduce((validSoFar, inputField) => {
                inputField.reportValidity();
                return validSoFar && inputField.checkValidity();
            }, true);
        if (isInputsCorrect) {
            checkUserName({
                    UserName: this.UserName
                })
                .then((result) => {
                    console.log('result - ', result.length);
                    if (result.length > 0) {
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Username Already Exists!',
                                message: 'A user with same Username already exists choose a different Username.',
                                variant: 'error',
                            }),
                        );
                    } else if (result.length == 0) {
                        if (this.Password != this.confirmPassword) {
                            this.dispatchEvent(
                                new ShowToastEvent({
                                    title: 'Invalid Confirm Password',
                                    message: 'Password did not match. Please Make sure both the passwords match.',
                                    variant: 'error',
                                }),
                            );
                        } else {
                            createUserAndContact({
                                    FirstName: this.FirstName,
                                    SurName: this.SurName,
                                    WorkEmail: this.WorkEmail,
                                    JobTitle: this.JobTitle,
                                    MaillingCity: this.MaillingCity,
                                    UserName: this.UserName,
                                    Password: this.Password,
                                    HomeOfficeCountry: this.HomeOfficeCountry,
                                    otherBusinessUnit: this.otherBusinessUnit,
                                    CompanyAffiliation: this.CompanyAffiliation,
                                    BusinessUnitAA: this.BusinessUnitAA,
                                    BusinessUnitDB: this.BusinessUnitDB,
                                    preferredLanguage: this.preferredLanguage,
                                })
                                .then((result) => {
                                    //window.location.href = result;
                                    this.login = result;
                                    this.message = result;
                                    this.error = undefined;
                                    if (this.message === 'login') {
                                        this.isUserCreated = true;
                                    }
                                })
                                .catch((error) => {
                                    console.log('<--error-->', error);
                                    this.error = error;
                                    this.dispatchEvent(
                                        new ShowToastEvent({
                                            title: 'Error occurred in Registration!',
                                            message: 'Some Error Occured',
                                            variant: 'error',
                                        }),
                                    );
                                });

                        }
                    }
                })
                .catch((error) => {
                    console.log('<--error-->', error);
                    this.error = error;
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error occurred in Registration!',
                            message: 'Some Error Occured',
                            variant: 'error',
                        }),
                    );
                });
        }

    }
    saveCFRecords() {
        const isInputsCorrect = [...this.template.querySelectorAll('input')]
            .reduce((validSoFar, inputField) => {
                inputField.reportValidity();
                return validSoFar && inputField.checkValidity();
            }, true);
        if (isInputsCorrect) {
            checkUserName({
                    UserName: this.UserNameCF
                })
                .then((result) => {
                    console.log('result - ', result.length);
                    if (result.length > 0) {
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Username Already Exists!',
                                message: 'A user with same Username already exists choose a different Username.',
                                variant: 'error',
                            }),
                        );
                    } else if (result.length == 0) {
                        if (this.PasswordCF != this.confirmPasswordCF) {
                            this.dispatchEvent(
                                new ShowToastEvent({
                                    title: 'Invalid Confirm Password',
                                    message: 'Password did not match. Please Make sure both the passwords match.',
                                    variant: 'error',
                                }),
                            );
                        } else {
                            updateContactAndCreateUser({
                                    FirstName: this.FirstNameCF,
                                    SurName: this.SurNameCF,
                                    WorkEmail: this.WorkEmailCF,
                                    JobTitle: this.JobTitleCF,
                                    MaillingCity: this.MaillingCityCF,
                                    UserName: this.UserNameCF,
                                    Password: this.PasswordCF,
                                    HomeOfficeCountry: this.HomeOfficeCountryCF,
                                    otherBusinessUnit: this.otherBusinessUnitCF,
                                    CompanyAffiliation: this.CompanyAffiliationCF,
                                    BusinessUnitAA: this.BusinessUnitAACF,
                                    BusinessUnitDB: this.BusinessUnitDBCF,
                                    preferredLanguageCF: this.preferredLanguageCF,
                                    conId: this.ContactId
                                })
                                .then((result) => {
                                    this.login = result;
                                    //this.message = result;
                                    this.error = undefined;
                                    if (result === 'login') {
                                        this.isUserCreated = true;
                                    }
                                })
                                .catch((error) => {
                                    console.log('<--error-->', error);
                                    this.error = error;
                                    this.dispatchEvent(
                                        new ShowToastEvent({
                                            title: 'Error occurred in Registration!',
                                            message: 'Some Error Occured',
                                            variant: 'error',
                                        }),
                                    );
                                });

                        }
                    }
                })
                .catch((error) => {
                    console.log('<--error-->', error);
                    this.error = error;
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error occurred in Registration!',
                            message: 'Some Error Occured',
                            variant: 'error',
                        }),
                    );
                });
        }
    }
    handleOK() {
        window.location.href = this.login;
    }
    handleCancel() {
        this.isUserCreated = false;
    }
    handleSubmit() {
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Details Saved Successfully',
                variant: 'success',
            }),
        );
        const login = 'login';
        this[NavigationMixin.GenerateUrl]({
            type: 'standard__webPage',
            attributes: {
                url: ''
            }
        }).then(url => {
            window.open(window.location.href = login);
        });
    }
    handleError() {
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error Saveing Records',
                message: 'Some Error Occured',
                variant: 'error',
            }),
        );
    }
}