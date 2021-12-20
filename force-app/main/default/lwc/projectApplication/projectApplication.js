import {
    LightningElement,
    track,
    wire,
    api
} from 'lwc';
import {
    CloseActionScreenEvent
} from 'lightning/actions';
import {
    ShowToastEvent
} from 'lightning/platformShowToastEvent';
import {
    NavigationMixin,
    CurrentPageReference
} from 'lightning/navigation';
import Id from '@salesforce/user/Id';
import fetchProject from '@salesforce/apex/projectApplicationController.fetchProject';
import fetchOrganizations from '@salesforce/apex/projectApplicationController.fetchOrganizations';
import createProjectApplication from '@salesforce/apex/projectApplicationController.createProjectApplication';
import fetchUserRelatedContactInfo from '@salesforce/apex/projectApplicationController.fetchUserRelatedContactInfo';
import updateLineManagerInfo from '@salesforce/apex/projectApplicationController.updateLineManagerInfo';
import updateTeamMember1Info from '@salesforce/apex/projectApplicationController.updateTeamMember1Info';
import updateTeamMember2Info from '@salesforce/apex/projectApplicationController.updateTeamMember2Info';
import updateTeamMember3Info from '@salesforce/apex/projectApplicationController.updateTeamMember3Info';
import updateTeamMember4Info from '@salesforce/apex/projectApplicationController.updateTeamMember4Info';
import updateOrganizationAddress from '@salesforce/apex/projectApplicationController.updateOrganizationAddress';
import updateProjectInformation from '@salesforce/apex/projectApplicationController.updateProjectInformation';
import updateProjectApp from '@salesforce/apex/projectApplicationController.updateProjectApp';
import updateGrantInfo from '@salesforce/apex/projectApplicationController.updateGrantInfo';


export default class ProjectApplication extends NavigationMixin(LightningElement) {
    @api userId = Id;
    @track disabled = false;
    @track projectName = null;
    @track teamCaptain = null;
    @track firstName = null;
    @track surname = null;
    @track jobTitle = null;
    @track workEmail = null;
    @track HomeOfficeCountry = null;
    @track homeOfficeCity = null;
    @track CompanyAffiliation = null;
    @track BusinessUnitAA = null;
    @track BusinessUnitDB = null;
    @track otherBusinessUnitAA = null;
    @track otherBusinessUnitDB = null;

    @track fullName = null;
    @track workEmailLM = null;
    @track noOfTeamMember = null;
    @track fullOrgName = null;
    @track websiteURL = null;
    @track isRegisteredEntity = null;
    @track participatedBefore = null;
    @track street = null;
    @track cityTown = null;
    @track stateProvCountry = null;
    @track postCode = null;
    @track country = null;
    @track firstNamePOC = null;
    @track surnamePOC = null;
    @track titlePOC = null;
    @track workEmailPOC = null;
    @track missionAndVision = null;
    @track phoneNumberPOC = null;
    sectorActivites = [];
    @track otherSectorAC = null;
    @track geographicCoverage = null;
    targetBeneficiaries = [];
    @track otherTargetBenef = null;
    partnerOrgComm = [];
    @track levelOfCommitment = null;
    @track projectObjective = null;
    @track projectBackground = null;
    @track activitesToObtain = null;
    @track projectTimeline = null;
    @track teamSkills = null;
    @track levelOfEffort = null;
    @track projectBeneficiaries = null;
    @track susAlignment = null;
    @track grantUse = null;
    @track projectType = [];
    @track projectTypeString = null;
    @track otherProjectType = null;
    projectValues = null;
    @track otherHomeOfficeCountry = null;
    @track otherCountry = null;
    @track corpSocialInvst = null;
    @track otherSocialInvest = null;
    @track projectSustainability = null;
    @track alignMiningPlan = null;
    @track howMuchFunding = null;
    @track grantNarrative = null;

    //Conditional Rendering Variables
    @track isAngloAmerican = true;
    @track isDeBeers = false;
    @track otherSelected = false;
    @track showNext = false;
    @track showFirst = false;
    @track showNext1 = false;
    @track otherSectorActivities = false;
    @track isOtherTargetBenef = false;
    @track showNext2 = false;
    @track showNext3 = false;
    @track isOtherProjectType = false;
    @track isOtherCountrySelected = false;
    @track isotherCountry = false;
    @track isOtherSocialInvest = false;
    @track hasGrant = false;
    @track otherSelectedAA = false;
    @track otherSelectedDB = false;
    @track showProjectApplicationInfo = true;
    @track showTeamInfo = false;


    //Team Member 1 Variables
    @track tm1FirstName = null;
    @track tm1Surname = null;
    @track tm1JobTitle = null;
    @track tm1WorkEmail = null;
    @track tm1HomeOfficeCity = null;
    @track tm1HomeOfficeCountry = null;
    @track tm1OtherHomeOfficeCountry = null;
    @track tm1CompanyAffiliation = null;
    @track tm1BusinessUnitAA = null;
    @track tm1BusinessUnitDB = null;
    @track tm1OtherBusinessUnitAA = null;
    @track tm1OtherBusinessUnitBB = null;
    @track tm1MfullName = null;
    @track tm1MworkEmailLM = null;

    //Team Member 2 Variables
    @track tm2FirstName = null;
    @track tm2Surname = null;
    @track tm2JobTitle = null;
    @track tm2WorkEmail = null;
    @track tm2HomeOfficeCity = null;
    @track tm2HomeOfficeCountry = null;
    @track tm2OtherHomeOfficeCountry = null;
    @track tm2CompanyAffiliation = null;
    @track tm2BusinessUnitAA = null;
    @track tm2OtherBusinessUnitAA = null;
    @track tm2BusinessUnitDB = null;
    @track tm2OtherBusinessUnitDB = null;
    @track tm2MfullName = null;
    @track tm2MworkEmailLM = null;

    //Team Member 3 Variables
    @track tm3FirstName = null;
    @track tm3Surname = null;
    @track tm3JobTitle = null;
    @track tm3WorkEmail = null;
    @track tm3HomeOfficeCity = null;
    @track tm3HomeOfficeCountry = null;
    @track tm3OtherHomeOfficeCountry = null;
    @track tm3CompanyAffiliation = null;
    @track tm3BusinessUnitAA = null;
    @track tm3BusinessUnitDB = null;
    @track tm3OtherBusinessUnit = null;
    @track tm3MfullName = null;
    @track tm3MworkEmailLM = null;

    //Team Member 4 Variables
    @track tm4FirstName = null;
    @track tm4Surname = null;
    @track tm4JobTitle = null;
    @track tm4WorkEmail = null;
    @track tm4HomeOfficeCity = null;
    @track tm4HomeOfficeCountry = null;
    @track tm4OtherHomeOfficeCountry = null;
    @track tm4CompanyAffiliation = null;
    @track tm4BusinessUnitAA = null;
    @track tm4BusinessUnitDB = null;
    @track tm4OtherBusinessUnit = null;
    @track tm4MfullName = null;
    @track tm4MworkEmailLM = null;

    //TM 1
    @track hasTeamMember = false;
    @track is1TMOtherCountrySelected = false;
    @track is1AngloAmerican = false;
    @track is1DeBeers = false;
    @track is1otherSelectedAA = false;
    @track is1otherSelectedBB = false;
    //TM 2
    @track has2TeamMember = false;
    @track is2TMOtherCountrySelected = false;
    @track is2AngloAmerican = false;
    @track is2DeBeers = false;
    @track is2otherSelectedAA = false;
    @track is2otherSelectedDB = false;
    //TM 3
    @track has3TeamMember = false;
    @track is3TMOtherCountrySelected = false;
    @track is3AngloAmerican = false;
    @track is3DeBeers = false;
    @track is3otherSelectedAA = false;
    @track is3otherSelectedDB = false;
    //TM 4
    @track has4TeamMember = false;
    @track is4TMOtherCountrySelected = false;
    @track is4AngloAmerican = false;
    @track is4DeBeers = false;
    @track is4otherSelectedAA = false;
    @track is4otherSelectedDB = false;

    @track contactList = [];

    @track projectApplicationId = null;


    currentPageReference;
    //listViewID;
    //PageURL;

    @wire(CurrentPageReference)
    setCurrentPageReference(currentPageReference) {
        this.currentPageReference = currentPageReference;
        console.log('this.currentPageReference--> ', this.currentPageReference.state.Id);
        console.log('data => ', window.location.href);
        console.log('userId - ', this.userId);
    }

    connectedCallback() {
        fetchUserRelatedContactInfo({
                userId: this.userId
            })
            .then((result) => {
                console.log('result ', result);
                console.log('result.FirstName  - ', result.FirstName);
                if (result.FirstName == null || result.FirstName == 'undefined') {
                    this.firstName = null;
                } else {
                    this.firstName = result.FirstName;
                }
                if (result.LastName == null || result.LastName == 'undefined') {
                    this.surname = null;
                } else {
                    this.surname = result.LastName;
                }
                if (result.Title == null || result.Title == 'undefined') {
                    this.jobTitle = null;
                } else {
                    this.jobTitle = result.Title;
                }
                if (result.Email == null || result.Email == 'undefined') {
                    this.workEmail = null;
                } else {
                    this.workEmail = result.Email;
                }
                if (result.MailingCity == null || result.MailingCity == 'undefined') {
                    this.homeOfficeCity = null;
                } else {
                    this.homeOfficeCity = result.MailingCity;
                }
                if (result.MailingCountry == null || result.MailingCountry == 'undefined') {
                    this.HomeOfficeCountry = null;
                } else {
                    this.HomeOfficeCountry = result.MailingCountry;
                    if(result.MailingCountry == 'Australia' || result.MailingCountry == 'Botswana' || result.MailingCountry == 'Brazil' || result.MailingCountry == 'Canada' || result.MailingCountry == 'Chile' || result.MailingCountry == 'China' || result.MailingCountry == 'Germany' || result.MailingCountry == 'Ireland' || result.MailingCountry == 'Namibia' || result.MailingCountry == 'Peru' || result.MailingCountry == 'Singapore' || result.MailingCountry == 'South Africa' || result.MailingCountry == 'United Kingdom' || result.MailingCountry == 'Zimbabwe'){
                        this.HomeOfficeCountry = result.MailingCountry;
                    }else{
                        this.HomeOfficeCountry = 'Other';
                        this.isOtherCountrySelected = true;
                        this.otherHomeOfficeCountry = result.MailingCountry;
                    }
                }
                if (result.Company_Affiliation__c == null || result.Company_Affiliation__c == 'undefined') {
                    this.CompanyAffiliation = null;
                } else {
                    this.CompanyAffiliation = result.Company_Affiliation__c;
                    if (this.CompanyAffiliation  == 'Anglo American') {
                        if (result.Department == null || result.Department == 'undefined') {
                            this.BusinessUnitAA = null;
                        } else {
                            this.isAngloAmerican = true;
                            this.isDeBeers = false;
                            this.otherSelectedAA = false;
                            this.BusinessUnitAA  = result.Department;
                        }
                    } else if (this.CompanyAffiliation  == 'De Beers Group'){
                        if (result.Department == null || result.Department == 'undefined') {
                            this.BusinessUnitDB = null;
                        } else {
                            this.isAngloAmerican = false;
                            this.isDeBeers = true;
                            this.BusinessUnitDB = result.Department;
                        }
                    }else{
                        this.otherSelectedAA = true;
                        this.otherBusinessUnitAA = result.Department;
                    }
                }
                /*if (result.Department == null || result.Department == 'undefined') {
                    this.BusinessUnitAA = null;
                } else {
                    this.BusinessUnitAA = result.Department;
                }*/
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
                label: 'China',
                value: 'China'
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
            {
                label: 'Zimbabwe',
                value: 'Zimbabwe'
            },
            {
                label: 'Other',
                value: 'Other'
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
                label: 'Group Corporate',
                value: 'Group Corporate'
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
                label: 'Group Corporate ',
                value: 'Group Corporate'
            },
            {
                label: 'Element Six ',
                value: 'Element Six '
            },
            {
                label: 'Other',
                value: 'Other'
            },
        ];
    }
    get regEntityOptions() {
        return [{
                label: 'Yes',
                value: 'Yes'
            },
            {
                label: 'No',
                value: 'No'
            },
        ];
    }
    get participatedBeforeOptions() {
        return [{
                label: 'Yes',
                value: 'Yes'
            },
            {
                label: 'No',
                value: 'No'
            },
            {
                label: 'Unsure',
                value: 'Unsure'
            },
        ];
    }
    get sectorActivitesOptions() {
        return [{
                label: 'Agriculture',
                value: 'Agriculture'
            },
            {
                label: 'Artisan/Handicraft',
                value: 'Artisan/Handicraft'
            },
            {
                label: 'Culture',
                value: 'Culture'
            },
            {
                label: 'Education',
                value: 'Education'
            },
            {
                label: 'Employment Services',
                value: 'Employment Services'
            },
            {
                label: 'Energy',
                value: 'Energy'
            },
            {
                label: 'Environment',
                value: 'Environment'
            },
            {
                label: 'Financial Services',
                value: 'Financial Services'
            },
            {
                label: 'Health',
                value: 'Health'
            },
            {
                label: 'Housing Development',
                value: 'Housing Development'
            },
            {
                label: 'Information and Communications Technology',
                value: 'Information and Communications Technology'
            },
            {
                label: 'Infrastructure/Facilities Development',
                value: 'Infrastructure/Facilities Development'
            },
            {
                label: 'Supply Chain Services',
                value: 'Supply Chain Services'
            },
            {
                label: 'Technical Assistance',
                value: 'Technical Assistance'
            },
            {
                label: 'Tourism',
                value: 'Tourism'
            },
            {
                label: 'Water',
                value: 'Water'
            },
            {
                label: 'Other',
                value: 'Other'
            },
        ];
    }
    get targetBeneOptions() {
        return [{
                label: 'Individuals',
                value: 'Individuals'
            },
            {
                label: 'Households',
                value: 'Households'
            },
            {
                label: 'Small to Medium Enterprises/Entrepreneurs',
                value: 'Small to Medium Enterprises/Entrepreneurs'
            },
            {
                label: 'Government Organisations',
                value: 'Government Organisations'
            },
            {
                label: 'Non-governmental Organisations',
                value: 'Non-governmental Organisations'
            },
            {
                label: 'Women and girls',
                value: 'Women and girls'
            },
            {
                label: 'Elderly (60+)',
                value: 'Elderly (60+)'
            },
            {
                label: 'Indigenous',
                value: 'Indigenous'
            },
            {
                label: 'Disadvantaged',
                value: 'Disadvantaged'
            },
            {
                label: 'Children (0-17 years old)',
                value: 'Children (0-17 years old)'
            },
            {
                label: 'Youth (18-35 years old)',
                value: 'Youth (18-35 years old)'
            },
            {
                label: 'People with Disabilities',
                value: 'People with Disabilities'
            },
            {
                label: 'Social Enterprises/Entrepreneurs',
                value: 'Social Enterprises/Entrepreneurs'
            },
            {
                label: 'Disaster/Conflict Affected',
                value: 'Disaster/Conflict Affected'
            },
            {
                label: 'Ill/Imunocompromised',
                value: 'Ill/Imunocompromised'
            },
            {
                label: 'LGBTQ + Community',
                value: 'LGBTQ + Community'
            },
            {
                label: 'Other',
                value: 'Other'
            },
        ];
    }
    get orgCommunOptions() {
        return [{
                label: 'Yes,we have conducted relevant discussions via email.',
                value: 'Yes,we have conducted relevant discussions via email.'
            },
            {
                label: 'Yes, we have conducted relevant discussions via video/phone calls.',
                value: 'Yes, we have conducted relevant discussions via video/phone calls.'
            },
            {
                label: 'Yes,have conducted relevant discussions in-person.',
                value: 'Yes,have conducted relevant discussions in-person.'
            },
            {
                label: 'No,we have not conducted any relevant discussions.',
                value: 'No,we have not conducted any relevant discussions.'
            },
        ];
    }
    get grantUseOptions() {
        return [{
                label: 'Yes',
                value: 'Yes'
            },
            {
                label: 'No',
                value: 'No'
            },
        ];
    }
    get projectTypeOptions() {
        return [{
                label: 'Event Planning: organising virtual or in person event(s) or campaign, such as fundraising, science fair, sports/outdoor activities, or awareness building',
                value: 'Event Planning: organising virtual or in person event(s) or campaign, such as fundraising, science fair, sports/outdoor activities, or awareness building'
            },
            {
                label: 'Training or Education: direct interaction and volunteering with beneficiaries through activities such as mentoring, coaching, teaching, or training',
                value: 'Training or Education: direct interaction and volunteering with beneficiaries through activities such as mentoring, coaching, teaching, or training'
            },
            {
                label: 'Organisational Capacity Building: building capacity of the partner organisation through project activities, such as technical assistance, business consulting, or administrative/office work',
                value: 'Organisational Capacity Building: building capacity of the partner organisation through project activities, such as technical assistance, business consulting, or administrative/office work'
            },
            {
                label: 'Built Environment or Material Improvements: supporting the construction or revitalization of a physical space, such as community space, gardening, or material improvements such as providing books for a library or computers for a computer lab',
                value: 'Built Environment or Material Improvements: supporting the construction or revitalization of a physical space, such as community space, gardening, or material improvements such as providing books for a library or computers for a computer lab'
            },
        ];
    }
    get corpSocialInvstOptions() {
        return [{
                label: 'Community Development',
                value: 'Community Development'
            },
            {
                label: 'Disaster and Emergency Relief',
                value: 'Disaster and Emergency Relief'
            },
            {
                label: 'Education and Training',
                value: 'Education and Training'
            },
            {
                label: 'Energy and Climate Change',
                value: 'Energy and Climate Change'
            },
            {
                label: 'Environment',
                value: 'Environment'
            },
            {
                label: 'Health and Welfare',
                value: 'Health and Welfare'
            },
            {
                label: 'Institutional Capacity Development',
                value: 'Institutional Capacity Development '
            },
            {
                label: 'Sports, art, culture and heritage',
                value: 'Sports, art, culture and heritage'
            },
            {
                label: 'Water and Sanitation',
                value: 'Water and Sanitation'
            },
            {
                label: 'Other',
                value: 'Other'
            },
        ];
    }

    handleCancel() {
        let PageURL = window.location.href;
        /*let listViewID = PageURL.substring(PageURL.indexOf('Application_Survey_Form__c/') + 27);
        console.log('listViewID => ', listViewID);
        this[NavigationMixin.GenerateUrl]({
            type: 'comm__namedPage',
            attributes: {
                url: ''
            }
        }).then(url => {
            window.open(window.location.href = listViewID);
        });*/
        this[NavigationMixin.Navigate]({
            "type": "standard__webPage",
            "attributes": {
                "url": PageURL
            }
        });
    }
    handleProjectInformation() {
        this.showProjectApplicationInfo = false;
        this.showTeamInfo = true;
    }
    handleTeamInfoNext() {
        this.showTeamInfo = false;
        this.showFirst = true;
    }
    handleTeamInfoBack() {
        this.showTeamInfo = false;
        this.showProjectApplicationInfo = true;
    }
    handleBackPN() {
        this.showTeamInfo = true;
        this.showFirst = false;
    }
    handleProjectNameChanges(event) {
        if (event.target.name == "projectName") {
            this.projectName = event.target.value;
            console.log('projectName-> ', this.projectName);
        }
    }
    handleOrgNameFieldChanges(event) {
        if (event.target.name == "fullOrgName") {
            this.fullOrgName = event.target.value;
            if (this.fullOrgName != null || this.fullOrgName != undefined) {
                fetchOrganizations({
                        fullOrgName: this.fullOrgName
                    })
                    .then((result) => {
                        result.forEach((info) => {
                            console.log('Organization Already Exist--> ', info.Name);
                            console.log('Organization Already Exist--> ', info);
                            this.dispatchEvent(
                                new ShowToastEvent({
                                    title: 'Organization Already Exists',
                                    message: 'An Organization with same name already exist',
                                    variant: 'error',
                                }),
                            );
                            if (info.Name == null || info.Name == 'undefined') {
                                this.fullOrgName = null;
                            } else {
                                this.fullOrgName = info.Name;
                            }
                            if (info.Website == null || info.Website == 'undefined') {
                                this.websiteURL = null;
                            } else {
                                this.websiteURL = info.Website;
                            }
                            if (info.Registered_Entity__c == null || info.Registered_Entity__c == 'undefined') {
                                this.isRegisteredEntity = null;
                            } else {
                                this.isRegisteredEntity = info.Registered_Entity__c;
                            }
                            if (info.BillingStreet == null || info.BillingStreet == 'undefined') {
                                this.street = null;
                            } else {
                                this.street = info.BillingStreet;
                            }
                            if (info.BillingCity == null || info.BillingCity == 'undefined') {
                                this.cityTown = null;
                            } else {
                                this.cityTown = info.BillingCity;
                            }
                            if (info.BillingState == null || info.BillingState == 'undefined') {
                                this.stateProvCountry = null;
                            } else {
                                this.stateProvCountry = info.BillingState;
                            }
                            if (info.BillingPostalCode == null || info.BillingPostalCode == 'undefined') {
                                this.postCode = null;
                            } else {
                                this.postCode = info.BillingPostalCode;
                            }
                            if (info.BillingCountry == null || info.BillingCountry == 'undefined') {
                                this.country = null;
                            } else {
                                this.country = info.BillingCountry;
                            }
                            if (info.Contacts[0].FirstName == null || info.Contacts[0].FirstName == 'undefined') {
                                this.firstNamePOC = null;
                            } else {
                                this.firstNamePOC = info.Contacts[0].FirstName;
                            }
                            if (info.Contacts[0].LastName == null || info.Contacts[0].LastName == 'undefined') {
                                this.surnamePOC = null;
                            } else {
                                this.surnamePOC = info.Contacts[0].LastName;
                            }
                            if (info.Contacts[0].Title == null || info.Contacts[0].Title == 'undefined') {
                                this.titlePOC = null;
                            } else {
                                this.titlePOC = info.Contacts[0].Title;
                            }
                            if (info.Contacts[0].Email == null || info.Contacts[0].Email == 'undefined') {
                                this.workEmailPOC = null;
                            } else {
                                this.workEmailPOC = info.Contacts[0].Email;
                            }
                            if (info.Contacts[0].Phone == null || info.Contacts[0].Phone == 'undefined') {
                                this.phoneNumberPOC = null;
                            } else {
                                this.phoneNumberPOC = info.Contacts[0].Phone;
                            }
                            if (info.Mission_and_Vision_Statement__c == null || info.Mission_and_Vision_Statement__c == 'undefined') {
                                this.missionAndVision = null;
                            } else {
                                this.missionAndVision = info.Mission_and_Vision_Statement__c;
                            }
                            if (info.Sector_Activities__c == null || info.Sector_Activities__c == 'undefined') {
                                this.sectorActivites = null;
                            } else {
                                info.Sector_Activities__c = info.Sector_Activities__c.split(";");
                                this.sectorActivites = [...info.Sector_Activities__c];
                            }
                            if (info.Geographic_Coverage__c == null || info.Geographic_Coverage__c == 'undefined') {
                                this.geographicCoverage = null;
                            } else {
                                this.geographicCoverage = info.Geographic_Coverage__c;
                            }
                            if (info.Target_Clients_or_Beneficiaries__c == null || info.Target_Clients_or_Beneficiaries__c == 'undefined') {
                                this.targetBeneficiaries = null;
                            } else {
                                info.Target_Clients_or_Beneficiaries__c = info.Target_Clients_or_Beneficiaries__c.split(";");
                                this.targetBeneficiaries = [...info.Target_Clients_or_Beneficiaries__c];
                            }
                            if (info.Level_of_Commitment__c == null || info.Level_of_Commitment__c == 'undefined') {
                                this.levelOfCommitment = null;
                            } else {
                                this.levelOfCommitment = info.Level_of_Commitment__c;
                            }
                        });
                    })
            }
        }
    }

    handleFieldChanges(event) {
        // Display field-level errors if last name field is empty.
        if (!event.target.value) {
            event.target.reportValidity();
            this.disabled = true;
        } else {
            this.disabled = false;
        }
        if (event.target.name == "teamCaptain") {
            this.teamCaptain = event.target.value;
        } else if (event.target.name == "surname") {
            this.surname = event.target.value;
        } else if (event.target.name == "firstName") {
            this.firstName = event.target.value;
        } else if (event.target.name == "jobTitle") {
            this.jobTitle = event.target.value;
        } else if (event.target.name == "workEmail") {
            this.workEmail = event.target.value;
        } else if (event.target.name == "homeOfficeCity") {
            this.homeOfficeCity = event.target.value;
        } else if (event.target.name == "homeOfficeCountry") {
            this.HomeOfficeCountry = event.target.value;
            if (this.HomeOfficeCountry == 'Other') {
                this.isOtherCountrySelected = true;
            } else {
                this.isOtherCountrySelected = false;
            }
        } else if (event.target.name == "otherHomeOfficeCountry") {
            this.otherHomeOfficeCountry = event.target.value;
        } else if (event.target.name == "CompanyAffiliation") {
            this.CompanyAffiliation = event.target.value;
            if (this.CompanyAffiliation == "De Beers Group") {
                this.isAngloAmerican = false;
                this.isDeBeers = true;
                this.otherSelectedDB = false;
                this.otherSelectedAA = false;
            } else if (this.CompanyAffiliation == "Anglo American") {
                this.isAngloAmerican = true;
                this.isDeBeers = false;
                this.otherSelectedAA = false;
                this.otherSelectedDB = false;
            }
        } else if (event.target.name == "BusinessUnitAA") {
            this.BusinessUnitAA = event.target.value;
            if (this.BusinessUnitAA == 'Other') {
                this.otherSelectedAA = true;
                this.otherSelectedDB = false;
            } else {
                this.otherSelectedAA = false;
                this.otherSelectedDB = false;
            }
        } else if (event.target.name == "BusinessUnitDB") {
            this.BusinessUnitDB = event.target.value;
            if (this.BusinessUnitDB == 'Other') {
                this.otherSelectedDB = true;
                this.otherSelectedAA = false;
            } else {
                this.otherSelectedDB = false;
                this.otherSelectedAA = false;
            }
        } else if (event.target.name == "otherBusinessUnitDB") {
            this.otherBusinessUnitDB = event.target.value;
        } else if (event.target.name == "otherBusinessUnitAA") {
            this.otherBusinessUnitAA = event.target.value;
        } else if (event.target.name == "fullName") {
            this.fullName = event.target.value;
        } else if (event.target.name == "noOfTeamMember") {
            this.noOfTeamMember = event.target.value;
        } else if (event.target.name == "websiteURL") {
            this.websiteURL = event.target.value;
        } else if (event.target.name == "isRegisteredEntity") {
            this.isRegisteredEntity = event.target.value;
            console.log('this.isRegisteredEntity ', this.isRegisteredEntity);

        } else if (event.target.name == "sectorActivites") {
            console.log('this.sectorActivites ', [...event.detail.value]);
            if (event.detail.value != null || event.detail.value != 'undefined') {
                this.sectorActivites = event.detail.value;
                console.log('this.sectorActivites Inside', this.sectorActivites);
            }
            console.log('this.sectorActivites After If', this.sectorActivites);
            for (let i = 0; i < this.sectorActivites.length; i++) {
                if (this.sectorActivites[i] == 'Other') {
                    this.otherSectorActivities = true;
                } else {
                    this.otherSectorActivities = false;
                }
            }
        } else if (event.target.name == "geographicCoverage") {
            this.geographicCoverage = event.target.value;
        } else if (event.target.name == "targetBeneficiaries") {
            console.log('this.targetBeneficiaries ', [...event.detail.value]);
            if (event.detail.value != null || event.detail.value != 'undefined') {
                this.targetBeneficiaries = event.detail.value;
            }
            console.log('this.targetBeneficiaries After If', this.targetBeneficiaries);
            for (let i = 0; i < this.targetBeneficiaries.length; i++) {
                if (this.targetBeneficiaries[i] == 'Other') {
                    this.isOtherTargetBenef = true;
                } else {
                    this.isOtherTargetBenef = false;
                }
            }
        } else if (event.target.name == "partnerOrgComm") {
            this.partnerOrgComm = event.detail.value;
            console.log('this.partnerOrgComm', partnerOrgComm);
        } else if (event.target.name == "projectType") {
            this.projectType = event.detail.value;
            this.projectType.forEach(obj => {
                if (this.projectType.length > 1) {
                    //alert('Please select only one option for the Project Type');
                }
                this.projectTypeString = obj;
                console.log('this.projectType', obj);
            });
        } else if (event.target.name == "country") {
            this.country = event.target.value;
            if (this.country == 'Other') {
                this.isotherCountry = true;
            } else {
                this.isotherCountry = false;
            }
        } else if (event.target.name == "otherCountry") {
            this.otherCountry = event.target.value;
        } else if (event.target.name == "tm1FirstName") {
            this.tm1FirstName = event.target.value;
        } else if (event.target.name == "corpSocialInvst") {
            this.corpSocialInvst = event.target.value;
            console.log('this.corpSocialInvst', this.corpSocialInvst);
            if (this.corpSocialInvst == 'Other') {
                this.isOtherSocialInvest = true;
            } else {
                this.isOtherSocialInvest = false;
            }
        } else if (event.target.name == "otherSocialInvest") {
            this.otherSocialInvest = event.target.value;
            console.log('this.otherSocialInvest', this.otherSocialInvest);
        } else if (event.target.name == "alignMiningPlan") {
            this.alignMiningPlan = event.target.value;
        } else if (event.target.name == "howMuchFunding") {
            this.howMuchFunding = event.target.value;
        } else if (event.target.name == "workEmailLM") {
            this.workEmailLM = event.target.value;
        } else if (event.target.name == "tm1Surname") {
            this.tm1Surname = event.target.value;
        } else if (event.target.name == "tm1JobTitle") {
            this.tm1JobTitle = event.target.value;
        } else if (event.target.name == "tm1WorkEmail") {
            this.tm1WorkEmail = event.target.value;
        } else if (event.target.name == "tm1HomeOfficeCity") {
            this.tm1HomeOfficeCity = event.target.value;
        } else if (event.target.name == "tm1HomeOfficeCountry") {
            this.tm1HomeOfficeCountry = event.target.value;
            if (this.tm1HomeOfficeCountry == 'Other') {
                this.is1TMOtherCountrySelected = true;
            } else {
                this.is1TMOtherCountrySelected = false;
            }
        } else if (event.target.name == "tm1OtherHomeOfficeCountry") {
            this.tm1OtherHomeOfficeCountry = event.target.value;
        } else if (event.target.name == "tm1CompanyAffiliation") {
            this.tm1CompanyAffiliation = event.target.value;
            if (this.tm1CompanyAffiliation == "De Beers Group") {
                this.is1AngloAmerican = false;
                this.is1DeBeers = true;
                this.is1otherSelectedBB = false;
                this.is1otherSelectedAA = false;
            } else if (this.tm1CompanyAffiliation == "Anglo American") {
                this.is1AngloAmerican = true;
                this.is1DeBeers = false;
                this.is1otherSelectedAA = false;
                this.is1otherSelectedBB = false;
            }
        } else if (event.target.name == "tm1BusinessUnitAA") {
            this.tm1BusinessUnitAA = event.target.value;
            if (this.tm1BusinessUnitAA == 'Other') {
                this.is1otherSelectedAA = true;
                this.is1otherSelectedBB = false;
            } else {
                this.is1otherSelectedAA = false;
                this.is1otherSelectedBB = false;
            }
        } else if (event.target.name == "tm1BusinessUnitDB") {
            this.tm1BusinessUnitDB = event.target.value;
            if (this.tm1BusinessUnitDB == 'Other') {
                this.is1otherSelectedBB = true;
                this.is1otherSelectedAA = false;
            } else {
                this.is1otherSelectedBB = false;
                this.is1otherSelectedAA = false;
            }
        } else if (event.target.name == "tm1OtherBusinessUnitAA") {
            this.tm1OtherBusinessUnitAA = event.target.value;
        } else if (event.target.name == "tm1OtherBusinessUnitBB") {
            this.tm1OtherBusinessUnitBB = event.target.value;
        } else if (event.target.name == "tm1MfullName") {
            this.tm1MfullName = event.target.value;
        } else if (event.target.name == "tm1MfullName") {
            this.tm1MfullName = event.target.value;
        } else if (event.target.name == "tm1MworkEmailLM") {
            this.tm1MworkEmailLM = event.target.value;
        } else if (event.target.name == "participatedBefore") {
            this.participatedBefore = event.target.value;
        } else if (event.target.name == "street") {
            this.street = event.target.value;
        } else if (event.target.name == "cityTown") {
            this.cityTown = event.target.value;
        } else if (event.target.name == "stateProvCountry") {
            this.stateProvCountry = event.target.value;
        } else if (event.target.name == "postCode") {
            this.postCode = event.target.value;
        } else if (event.target.name == "country") {
            this.country = event.target.value;
        } else if (event.target.name == "otherCountry") {
            this.otherCountry = event.target.value;
        } else if (event.target.name == "firstNamePOC") {
            this.firstNamePOC = event.target.value;
        } else if (event.target.name == "surnamePOC") {
            this.surnamePOC = event.target.value;
        } else if (event.target.name == "titlePOC") {
            this.titlePOC = event.target.value;
        } else if (event.target.name == "workEmailPOC") {
            this.workEmailPOC = event.target.value;
        } else if (event.target.name == "phoneNumberPOC") {
            this.phoneNumberPOC = event.target.value;
        } else if (event.target.name == "missionAndVision") {
            this.missionAndVision = event.target.value;
        } else if (event.target.name == "otherSectorAC") {
            this.otherSectorAC = event.target.value;
        } else if (event.target.name == "geographicCoverage") {
            this.geographicCoverage = event.target.value;
        } else if (event.target.name == "otherTargetBenef") {
            this.otherTargetBenef = event.target.value;
        } else if (event.target.name == "levelOfCommitment") {
            this.levelOfCommitment = event.target.value;
        } else if (event.target.name == "projectObjective") {
            this.projectObjective = event.target.value;
        } else if (event.target.name == "projectBackground") {
            this.projectBackground = event.target.value;
        } else if (event.target.name == "activitesToObtain") {
            this.activitesToObtain = event.target.value;
        } else if (event.target.name == "activitesToObtain") {
            this.activitesToObtain = event.target.value;
        } else if (event.target.name == "projectSustainability") {
            this.projectSustainability = event.target.value;
        } else if (event.target.name == "teamSkills") {
            this.teamSkills = event.target.value;
        } else if (event.target.name == "levelOfEffort") {
            this.levelOfEffort = event.target.value;
        } else if (event.target.name == "teamDiversity") {
            this.teamDiversity = event.target.value;
        } else if (event.target.name == "projectBeneficiaries") {
            this.projectBeneficiaries = event.target.value;
        } else if (event.target.name == "alignMiningPlan") {
            this.alignMiningPlan = event.target.value;
        } else if (event.target.name == "grantUse") {
            this.grantUse = event.target.value;
            if (this.grantUse == 'Yes') {
                this.hasGrant = true;
            } else {
                this.hasGrant = false;
            }
        } else if (event.target.name == "howMuchFunding") {
            this.howMuchFunding = event.target.value;
        } else if (event.target.name == "grantNarrative") {
            this.grantNarrative = event.target.value;

        } else if (event.target.name == "tm2FirstName") {
            this.tm2FirstName = event.target.value;
        } else if (event.target.name == "tm2Surname") {
            this.tm2Surname = event.target.value;
        } else if (event.target.name == "tm2JobTitle") {
            this.tm2JobTitle = event.target.value;
        } else if (event.target.name == "tm2WorkEmail") {
            this.tm2WorkEmail = event.target.value;
        } else if (event.target.name == "tm2HomeOfficeCity") {
            this.tm2HomeOfficeCity = event.target.value;
        } else if (event.target.name == "tm2HomeOfficeCountry") {
            this.tm2HomeOfficeCountry = event.target.value;
            if (this.tm2HomeOfficeCountry == 'Other') {
                this.is2TMOtherCountrySelected = true;
            } else {
                this.is2TMOtherCountrySelected = false;
            }
        } else if (event.target.name == "tm2OtherHomeOfficeCountry") {
            this.tm2OtherHomeOfficeCountry = event.target.value;
        } else if (event.target.name == "tm2CompanyAffiliation") {
            this.tm2CompanyAffiliation = event.target.value;
            if (this.tm2CompanyAffiliation == "De Beers Group") {
                this.is2AngloAmerican = false;
                this.is2DeBeers = true;
                this.tm2OtherBusinessUnitDB = false;
                this.tm2OtherBusinessUnitAA = false;
            } else if (this.tm2CompanyAffiliation == "Anglo American") {
                this.is2AngloAmerican = true;
                this.is2DeBeers = false;
                this.tm2OtherBusinessUnitAA = false;
                this.tm2OtherBusinessUnitDB = false;
            }
        } else if (event.target.name == "tm2BusinessUnitAA") {
            this.tm2BusinessUnitAA = event.target.value;
            if (this.tm2BusinessUnitAA == 'Other') {
                this.tm2OtherBusinessUnitAA = true;
                this.tm2OtherBusinessUnitDB = false;
            } else {
                this.tm2OtherBusinessUnitAA = false;
                this.tm2OtherBusinessUnitDB = false;
            }
        } else if (event.target.name == "tm2BusinessUnitDB") {
            this.tm2BusinessUnitDB = event.target.value;
            if (this.tm2BusinessUnitDB == 'Other') {
                this.tm2OtherBusinessUnitDB = true;
                this.tm2OtherBusinessUnitAA = false;
            } else {
                this.tm2OtherBusinessUnitDB = false;
                this.tm2OtherBusinessUnitAA = false;
            }
        } else if (event.target.name == "tm2OtherBusinessUnitAA") {
            this.tm2OtherBusinessUnitAA = event.target.value;
        } else if (event.target.name == "tm2OtherBusinessUnitDB") {
            this.tm2OtherBusinessUnitDB = event.target.value;
        } else if (event.target.name == "tm2MfullName") {
            this.tm2MfullName = event.target.value;
        } else if (event.target.name == "tm2MworkEmailLM") {
            this.tm2MworkEmailLM = event.target.value;

        } else if (event.target.name == "tm3FirstName") {
            this.tm3FirstName = event.target.value;
        } else if (event.target.name == "tm3Surname") {
            this.tm3Surname = event.target.value;
        } else if (event.target.name == "tm3JobTitle") {
            this.tm3JobTitle = event.target.value;
        } else if (event.target.name == "tm3WorkEmail") {
            this.tm3WorkEmail = event.target.value;
        } else if (event.target.name == "tm3HomeOfficeCity") {
            this.tm3HomeOfficeCity = event.target.value;
        } else if (event.target.name == "tm3HomeOfficeCountry") {
            this.tm3HomeOfficeCountry = event.target.value;
            if (this.tm3HomeOfficeCountry == 'Other') {
                this.is3TMOtherCountrySelected = true;
            } else {
                this.is3TMOtherCountrySelected = false;
            }
        } else if (event.target.name == "tm3OtherHomeOfficeCountry") {
            this.tm3OtherHomeOfficeCountry = event.target.value;
        } else if (event.target.name == "tm3CompanyAffiliation") {
            this.tm3CompanyAffiliation = event.target.value;
            if (this.tm3CompanyAffiliation == "De Beers Group") {
                this.is3AngloAmerican = false;
                this.is3DeBeers = true;
                this.is3otherSelectedDB = false;
                this.is3otherSelectedAA = false;
            } else if (this.tm3CompanyAffiliation == "Anglo American") {
                this.is3AngloAmerican = true;
                this.is3DeBeers = false;
                this.is3otherSelectedAA = false;
                this.is3otherSelectedDB = false;
            }
        } else if (event.target.name == "tm3BusinessUnitAA") {
            this.tm3BusinessUnitAA = event.target.value;
            if (this.tm3BusinessUnitAA == 'Other') {
                this.is3otherSelectedAA = true;
                this.is3otherSelectedDB = false;
            } else {
                this.is3otherSelectedAA = false;
                this.is3otherSelectedDB = false;
            }
        } else if (event.target.name == "tm3BusinessUnitDB") {
            this.tm3BusinessUnitDB = event.target.value;
            if (this.tm3BusinessUnitDB == 'Other') {
                this.is3otherSelectedDB = true;
                this.is3otherSelectedAA = false;
            } else {
                this.is3otherSelectedDB = false;
                this.is3otherSelectedAA = false;
            }
        } else if (event.target.name == "tm3OtherBusinessUnitAA") {
            this.tm3OtherBusinessUnitAA = event.target.value;
        } else if (event.target.name == "tm3OtherBusinessUnitDB") {
            this.tm3OtherBusinessUnitDB = event.target.value;
        } else if (event.target.name == "tm3MfullName") {
            this.tm3MfullName = event.target.value;
        } else if (event.target.name == "tm3MworkEmailLM") {
            this.tm3MworkEmailLM = event.target.value;
        } else if (event.target.name == "tm4FirstName") {
            this.tm4FirstName = event.target.value;
        } else if (event.target.name == "tm4Surname") {
            this.tm4Surname = event.target.value;
        } else if (event.target.name == "tm4JobTitle") {
            this.tm4JobTitle = event.target.value;
        } else if (event.target.name == "tm4WorkEmail") {
            this.tm4WorkEmail = event.target.value;
        } else if (event.target.name == "tm4HomeOfficeCity") {
            this.tm4HomeOfficeCity = event.target.value;
        } else if (event.target.name == "tm4HomeOfficeCountry") {
            this.tm4HomeOfficeCountry = event.target.value;
            if (this.tm4HomeOfficeCountry == 'Other') {
                this.is4TMOtherCountrySelected = true;
            } else {
                this.is4TMOtherCountrySelected = false;
            }
        } else if (event.target.name == "tm4OtherHomeOfficeCountry") {
            this.tm4OtherHomeOfficeCountry = event.target.value;
        } else if (event.target.name == "tm4CompanyAffiliation") {
            this.tm4CompanyAffiliation = event.target.value;
            if (this.tm4CompanyAffiliation == "De Beers Group") {
                this.is4AngloAmerican = false;
                this.is4DeBeers = true;
                this.is4otherSelectedAA = false;
                this.is4otherSelectedDB = false;
            } else if (this.tm4CompanyAffiliation == "Anglo American") {
                this.is4AngloAmerican = true;
                this.is4DeBeers = false;
                this.is4otherSelectedAA = false;
                this.is4otherSelectedDB = false;
            }
        } else if (event.target.name == "tm4BusinessUnitAA") {
            this.tm4BusinessUnitAA = event.target.value;
            if (this.tm4BusinessUnitAA == 'Other') {
                this.is4otherSelectedAA = true;
                this.is4otherSelectedDB = false;
            } else {
                this.is4otherSelectedAA = false;
                this.is4otherSelectedDB = false;
            }
        } else if (event.target.name == "tm4BusinessUnitDB") {
            this.tm4BusinessUnitDB = event.target.value;
            if (this.tm4BusinessUnitDB == 'Other') {
                this.is4otherSelectedAA = true;
                this.is4otherSelectedDB = false;
            } else {
                this.is4otherSelectedDB = false;
                this.is4otherSelectedAA = false;
            }
        } else if (event.target.name == "tm4OtherBusinessUnitAA") {
            this.tm4OtherBusinessUnitAA = event.target.value;
        } else if (event.target.name == "tm4OtherBusinessUnitDB") {
            this.tm4OtherBusinessUnitDB = event.target.value;
        } else if (event.target.name == "tm4MfullName") {
            this.tm4MfullName = event.target.value;
        } else if (event.target.name == "tm4MworkEmailLM") {
            this.tm4MworkEmailLM = event.target.value;
        }
    }
    handleBack() {
        this.showFirst = true;
        this.showNext = false;
    }
    handleBack1() {
        if (this.noOfTeamMember == "1") {
            this.hasTeamMember = true;
            this.showNext1 = false;
        } else if (this.noOfTeamMember == "2") {
            this.has2TeamMember = true;
            this.showNext1 = false;
        } else if (this.noOfTeamMember == "3") {
            this.has3TeamMember = true;
            this.showNext1 = false;
        } else if (this.noOfTeamMember == "4") {
            this.has4TeamMember = true;
            this.showNext1 = false;
        } else {
            this.showNext1 = false;
            this.showNext = true;
            //this.noOfTeamMember = null;
        }
    }
    handleBack2() {
        this.showNext1 = true;
        this.showNext2 = false;
    }
    handleBack3() {
        this.showNext2 = true;
        this.showNext3 = false;
    }
    handleBack4() {
        this.showNext3 = true;
        this.showNext4 = false;
    }
    handleTMBack() {
        this.hasTeamMember = false;
        this.showNext = true;
        //this.noOfTeamMember = null;
    }
    handleTM2Back() {
        this.has2TeamMember = false;
        this.hasTeamMember = true;
    }
    handleTM3Back() {
        this.has3TeamMember = false;
        this.has2TeamMember = true;
    }
    handleTM4Back() {
        this.has4TeamMember = false;
        this.has3TeamMember = true;
    }



    handleNext(event) {
        const isInputsCorrect = [...this.template.querySelectorAll('input')]
            .reduce((validSoFar, inputField) => {
                inputField.reportValidity();
                return validSoFar && inputField.checkValidity();
            }, true);
        if (isInputsCorrect) {
            if (this.projectName != null || this.projectName != undefined) {
                fetchProject({
                        projectName: this.projectName
                    })
                    .then((result) => {
                        if (result != 'No Project Exists' && result != undefined && result != null) {
                            this.dispatchEvent(
                                new ShowToastEvent({
                                    title: 'Project Already Exists',
                                    message: 'A Project with same name already exist',
                                    variant: 'error',
                                }),
                            );
                        } else {
                            this.showFirst = false;
                            this.showNext = true;
                        }
                    })
            }
        }
    }
    countVar = 0;
    handleSave1() {
        ++this.countVar;
        console.log('this.countVar - ',this.countVar);
        if (this.countVar == 1) {
            /*const isInputsCorrect = [...this.template.querySelectorAll('input')]
                .reduce((validSoFar, inputField) => {
                    inputField.reportValidity();
                    return validSoFar && inputField.checkValidity();
                }, true);
            if (isInputsCorrect) {*/
            if (this.projectName != null || this.projectName != undefined) {
                fetchProject({
                        projectName: this.projectName
                    })
                    .then((result) => {
                        if (result != 'No Project Exists' && result != undefined && result != null) {
                            this.dispatchEvent(
                                new ShowToastEvent({
                                    title: 'Project Already Exists',
                                    message: 'A Project with same name already exist',
                                    variant: 'error',
                                }),
                            );
                        } else {
                            this.showFirst = false;
                            this.showNext = true;
                            createProjectApplication({
                                    projectName: this.projectName,
                                    firstName: this.firstName,
                                    surname: this.surname,
                                    jobTitle: this.jobTitle,
                                    workEmail: this.workEmail,
                                    homeOfficeCity: this.homeOfficeCity,
                                    HomeOfficeCountry: this.HomeOfficeCountry,
                                    otherHomeOfficeCountry: this.otherHomeOfficeCountry,
                                    CompanyAffiliation: this.CompanyAffiliation,
                                    BusinessUnitAA: this.BusinessUnitAA,
                                    otherBusinessUnitAA: this.otherBusinessUnitAA,
                                    BusinessUnitDB: this.BusinessUnitDB,
                                    otherBusinessUnitDB: this.otherBusinessUnitDB
                                })
                                .then((result) => {
                                    console.log('result ', result);
                                    this.projectApplicationId = result;
                                    /*if (this.projectApplicationId != null || this.projectApplicationId != undefined) {
                                        this[NavigationMixin.Navigate]({
                                            "type": "standard__webPage",
                                            "attributes": {
                                                "url": '/s/detail/' + projectApplicationId
                                            }
                                        });
                                        this.dispatchEvent(
                                            new ShowToastEvent({
                                                title: 'Success',
                                                message: 'Congratulations! You have successfully submitted your 2021 Ambassadors for Good project application. If you have any inquiries about the next steps, please reach out to info@ambassadorsforgood.org. We wish you the best of luck with your application!',
                                                variant: 'success',
                                            }),
                                        );
                                    }*/
                                })
                                .catch((error) => {
                                    console.log('<--error-->', error);
                                    this.error = error;
                                    this.dispatchEvent(
                                        new ShowToastEvent({
                                            title: 'Error Submitting Project Application!',
                                            message: error.message,
                                            variant: 'error',
                                        }),
                                    );
                                });
                        }
                    })
            } else {
                createProjectApplication({
                        projectName: this.projectName,
                        firstName: this.firstName,
                        surname: this.surname,
                        jobTitle: this.jobTitle,
                        workEmail: this.workEmail,
                        homeOfficeCity: this.homeOfficeCity,
                        HomeOfficeCountry: this.HomeOfficeCountry,
                        otherHomeOfficeCountry: this.otherHomeOfficeCountry,
                        CompanyAffiliation: this.CompanyAffiliation,
                        BusinessUnitAA: this.BusinessUnitAA,
                        otherBusinessUnitAA: this.otherBusinessUnitAA,
                        BusinessUnitDB: this.BusinessUnitDB,
                        otherBusinessUnitDB: this.otherBusinessUnitDB
                    })
                    .then((result) => {
                        console.log('result ', result);
                        this.projectApplicationId = result;
                        this.showFirst = false;
                        this.showNext = true;
                    })
                    .catch((error) => {
                        console.log('<--error-->', error);
                        this.error = error;
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Error Submitting Project Application!',
                                message: error,
                                variant: 'error',
                            }),
                        );
                    });
            }
        } else if (this.countVar > 1) {
            console.log('this.countVar - ',this.countVar);
            if (this.projectName != null || this.projectName != undefined) {
                fetchProject({
                        projectName: this.projectName
                    })
                    .then((result) => {
                        if (result != 'No Project Exists' && result != undefined && result != null) {
                            this.dispatchEvent(
                                new ShowToastEvent({
                                    title: 'Project Already Exists',
                                    message: 'A Project with same name already exist',
                                    variant: 'error',
                                }),
                            );
                        } else {
                            this.showFirst = false;
                            this.showNext = true;
                            updateProjectApp({
                                    projectName: this.projectName,
                                    firstName: this.firstName,
                                    surname: this.surname,
                                    jobTitle: this.jobTitle,
                                    workEmail: this.workEmail,
                                    homeOfficeCity: this.homeOfficeCity,
                                    HomeOfficeCountry: this.HomeOfficeCountry,
                                    otherHomeOfficeCountry: this.otherHomeOfficeCountry,
                                    CompanyAffiliation: this.CompanyAffiliation,
                                    BusinessUnitAA: this.BusinessUnitAA,
                                    otherBusinessUnitAA: this.otherBusinessUnitAA,
                                    BusinessUnitDB: this.BusinessUnitDB,
                                    otherBusinessUnitDB: this.otherBusinessUnitDB,
                                    projectApplicationId: this.projectApplicationId
                                })
                                .then((result) => {
                                    console.log('result ', result);
                                    this.projectApplicationId = result;
                                    /*if (this.projectApplicationId != null || this.projectApplicationId != undefined) {
                                        this[NavigationMixin.Navigate]({
                                            "type": "standard__webPage",
                                            "attributes": {
                                                "url": '/s/detail/' + projectApplicationId
                                            }
                                        });
                                        this.dispatchEvent(
                                            new ShowToastEvent({
                                                title: 'Success',
                                                message: 'Congratulations! You have successfully submitted your 2021 Ambassadors for Good project application. If you have any inquiries about the next steps, please reach out to info@ambassadorsforgood.org. We wish you the best of luck with your application!',
                                                variant: 'success',
                                            }),
                                        );
                                    }*/
                                })
                                .catch((error) => {
                                    console.log('<--error-->', error);
                                    this.error = error;
                                    this.dispatchEvent(
                                        new ShowToastEvent({
                                            title: 'Error Submitting Project Application!',
                                            message: error.message,
                                            variant: 'error',
                                        }),
                                    );
                                });
                        }
                    })
            } else {
                updateProjectApp({
                        projectName: this.projectName,
                        firstName: this.firstName,
                        surname: this.surname,
                        jobTitle: this.jobTitle,
                        workEmail: this.workEmail,
                        homeOfficeCity: this.homeOfficeCity,
                        HomeOfficeCountry: this.HomeOfficeCountry,
                        otherHomeOfficeCountry: this.otherHomeOfficeCountry,
                        CompanyAffiliation: this.CompanyAffiliation,
                        BusinessUnitAA: this.BusinessUnitAA,
                        otherBusinessUnitAA: this.otherBusinessUnitAA,
                        BusinessUnitDB: this.BusinessUnitDB,
                        otherBusinessUnitDB: this.otherBusinessUnitDB,
                        projectApplicationId: this.projectApplicationId
                    })
                    .then((result) => {
                        console.log('result ', result);
                        this.projectApplicationId = result;
                        this.showFirst = false;
                        this.showNext = true;
                    })
                    .catch((error) => {
                        console.log('<--error-->', error);
                        this.error = error;
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Error Submitting Project Application!',
                                message: error,
                                variant: 'error',
                            }),
                        );
                    });
            }

        }
        //}
    }
    handleSaveAndContinue1() {
        if (this.projectName != null || this.projectName != undefined) {
            fetchProject({
                    projectName: this.projectName
                })
                .then((result) => {
                    if (result != 'No Project Exists' && result != undefined && result != null) {
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Project Already Exists',
                                message: 'A Project with same name already exist',
                                variant: 'error',
                            }),
                        );
                    } else {
                        createProjectApplication({
                                projectName: this.projectName,
                                firstName: this.firstName,
                                surname: this.surname,
                                jobTitle: this.jobTitle,
                                workEmail: this.workEmail,
                                homeOfficeCity: this.homeOfficeCity,
                                HomeOfficeCountry: this.HomeOfficeCountry,
                                otherHomeOfficeCountry: this.otherHomeOfficeCountry,
                                CompanyAffiliation: this.CompanyAffiliation,
                                BusinessUnitAA: this.BusinessUnitAA,
                                otherBusinessUnitAA: this.otherBusinessUnitAA,
                                BusinessUnitDB: this.BusinessUnitDB,
                                otherBusinessUnitDB: this.otherBusinessUnitDB
                            })
                            .then((result) => {
                                console.log('result ', result);
                                this.projectApplicationId = result;
                            })
                            .catch((error) => {
                                console.log('<--error-->', error);
                                this.error = error;
                                this.dispatchEvent(
                                    new ShowToastEvent({
                                        title: 'Error Submitting Project Application!',
                                        message: error,
                                        variant: 'error',
                                    }),
                                );
                            });

                    }
                });
        } else {
            createProjectApplication({
                    projectName: this.projectName,
                    firstName: this.firstName,
                    surname: this.surname,
                    jobTitle: this.jobTitle,
                    workEmail: this.workEmail,
                    homeOfficeCity: this.homeOfficeCity,
                    HomeOfficeCountry: this.HomeOfficeCountry,
                    otherHomeOfficeCountry: this.otherHomeOfficeCountry,
                    CompanyAffiliation: this.CompanyAffiliation,
                    BusinessUnitAA: this.BusinessUnitAA,
                    otherBusinessUnitAA: this.otherBusinessUnitAA,
                    BusinessUnitDB: this.BusinessUnitDB,
                    otherBusinessUnitDB: this.otherBusinessUnitDB
                })
                .then((result) => {
                    console.log('result ', result);
                    this.projectApplicationId = result;
                })
                .catch((error) => {
                    console.log('<--error-->', error);
                    this.error = error;
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error Submitting Project Application!',
                            message: error,
                            variant: 'error',
                        }),
                    );
                });
        }
    }
    handleSave2() {
        if (this.noOfTeamMember == null || this.noOfTeamMember == "0" ||this.noOfTeamMember == "1" || this.noOfTeamMember == "2" || this.noOfTeamMember == "3" || this.noOfTeamMember == "4") {
            updateLineManagerInfo({
                    fullName: this.fullName,
                    workEmailLM: this.workEmailLM,
                    noOfTeamMember: this.noOfTeamMember,
                    projectApplicationId: this.projectApplicationId
                })
                .then((result) => {
                    console.log('result ', result);
                    if(result === 'Error'){
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Error',
                                message: 'Something went wrong while saving the details. Please fill the details carefully!',
                                variant: 'error',
                            }),
                        );
                    }else if(result === 'Success'){
                        if (this.noOfTeamMember == "1") {
                            this.hasTeamMember = true;
                            this.showNext = false;
                        } else if (this.noOfTeamMember == "2" || this.noOfTeamMember == "3" || this.noOfTeamMember == "4") {
                            this.hasTeamMember = true;
                            this.showNext = false;
                        } else if (this.noOfTeamMember == null || this.noOfTeamMember == undefined) {
                            this.hasTeamMember = false;
                            this.showNext = false;
                            this.showNext1 = true;
                        } else if (this.noOfTeamMember != "1" || this.noOfTeamMember != "2" || this.noOfTeamMember != "3" || this.noOfTeamMember != "4") {
                            this.dispatchEvent(
                                new ShowToastEvent({
                                    title: 'Number of Teammates',
                                    message: 'There must be at least one additional team member or at most 4 team member',
                                    variant: 'error',
                                }),
                            );
                        }
                    }
                   
                })
                .catch((error) => {
                    console.log('<--error-->', error);
                    this.error = error;
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error Submitting Project Application!',
                            message: error.message,
                            variant: 'error',
                        }),
                    );
                });
        }
        //}
    }
    handleSaveAndContinue2() {
        updateLineManagerInfo({
                fullName: this.fullName,
                workEmailLM: this.workEmailLM,
                noOfTeamMember: this.noOfTeamMember,
                projectApplicationId: this.projectApplicationId
            })
            .then((result) => {
                console.log('result ', result);
                if(result === 'Error'){
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error',
                            message: 'Something went wrong while saving the details. Please fill the details carefully!',
                            variant: 'error',
                        }),
                    );
                }
            })
            .catch((error) => {
                console.log('<--error-->', error);
                this.error = error;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error Submitting Project Application!',
                        message: error.message,
                        variant: 'error',
                    }),
                );
            });

    }
    handleNext1() {
        const isInputsCorrect = [...this.template.querySelectorAll('input')]
            .reduce((validSoFar, inputField) => {
                inputField.reportValidity();
                return validSoFar && inputField.checkValidity();
            }, true);
        if (isInputsCorrect) {
            if (this.noOfTeamMember == "1") {
                this.hasTeamMember = true;
                this.showNext = false;
            } else if (this.noOfTeamMember == "2" || this.noOfTeamMember == "3" || this.noOfTeamMember == "4") {
                this.hasTeamMember = true;
                this.showNext = false;
            } else if (this.noOfTeamMember == null || this.noOfTeamMember == undefined) {
                this.hasTeamMember = false;
                this.showNext = false;
                this.showNext1 = true;
            } else if (this.noOfTeamMember != "1" || this.noOfTeamMember != "2" || this.noOfTeamMember != "3" || this.noOfTeamMember != "4") {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Number of Teammates',
                        message: 'You cannot have more than 4 teammates',
                        variant: 'error',
                    }),
                );
            }
        }
    }
    handleNext2() {
        this.showNext1 = false;
        this.showNext2 = true;
    }
    handleNext3() {
        this.showNext2 = false;
        this.showNext3 = true;
    }
    handleNext4() {
        this.showNext3 = false;
        this.showNext4 = true;
    }
    handleTMNext() {
        const isInputsCorrect = [...this.template.querySelectorAll('input')]
            .reduce((validSoFar, inputField) => {
                inputField.reportValidity();
                return validSoFar && inputField.checkValidity();
            }, true);
        if (isInputsCorrect) {
            if (this.noOfTeamMember == "1") {
                this.hasTeamMember = false;
                this.showNext1 = true;
            } else if (this.noOfTeamMember == "2" || this.noOfTeamMember == "3" || this.noOfTeamMember == "4") {
                this.has2TeamMember = true;
                this.hasTeamMember = false;
            }
        }
    }
    handleSave3() {
        updateTeamMember1Info({
                tm1FirstName: this.tm1FirstName,
                tm1Surname: this.tm1Surname,
                tm1JobTitle: this.tm1JobTitle,
                tm1WorkEmail: this.tm1WorkEmail,
                tm1HomeOfficeCity: this.tm1HomeOfficeCity,
                tm1HomeOfficeCountry: this.tm1HomeOfficeCountry,
                tm1OtherHomeOfficeCountry: this.tm1OtherHomeOfficeCountry,
                tm1CompanyAffiliation: this.tm1CompanyAffiliation,
                tm1BusinessUnitAA: this.tm1BusinessUnitAA,
                tm1OtherBusinessUnitAA: this.tm1OtherBusinessUnitAA,
                tm1BusinessUnitDB: this.tm1BusinessUnitDB,
                tm1OtherBusinessUnitBB: this.tm1OtherBusinessUnitBB,
                tm1OtherBusinessUnit: this.tm1OtherBusinessUnit,
                tm1MfullName: this.tm1MfullName,
                tm1MworkEmailLM: this.tm1MworkEmailLM,
                projectApplicationId: this.projectApplicationId
            })
            .then((result) => {
                console.log('result ', result);
                if(result === 'Error'){
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error',
                            message: 'Something went wrong while saving the details. Please fill the details carefully!',
                            variant: 'error',
                        }),
                    );
                }else if(result === 'Success'){
                    if (this.noOfTeamMember == "1") {
                        this.hasTeamMember = false;
                        this.showNext1 = true;
                    } else if (this.noOfTeamMember == "2" || this.noOfTeamMember == "3" || this.noOfTeamMember == "4") {
                        this.has2TeamMember = true;
                        this.hasTeamMember = false;
                    }
                }
            })
            .catch((error) => {
                console.log('<--error-->', error);
                this.error = error;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error Submitting Project Application!',
                        message: error.message,
                        variant: 'error',
                    }),
                );
            });
        //}
    }
    handleSaveAndContinue3() {
        updateTeamMember1Info({
                tm1FirstName: this.tm1FirstName,
                tm1Surname: this.tm1Surname,
                tm1JobTitle: this.tm1JobTitle,
                tm1WorkEmail: this.tm1WorkEmail,
                tm1HomeOfficeCity: this.tm1HomeOfficeCity,
                tm1HomeOfficeCountry: this.tm1HomeOfficeCountry,
                tm1OtherHomeOfficeCountry: this.tm1OtherHomeOfficeCountry,
                tm1CompanyAffiliation: this.tm1CompanyAffiliation,
                tm1BusinessUnitAA: this.tm1BusinessUnitAA,
                tm1OtherBusinessUnitAA: this.tm1OtherBusinessUnitAA,
                tm1BusinessUnitDB: this.tm1BusinessUnitDB,
                tm1OtherBusinessUnitBB: this.tm1OtherBusinessUnitBB,
                tm1MfullName: this.tm1MfullName,
                tm1MworkEmailLM: this.tm1MworkEmailLM,
                projectApplicationId: this.projectApplicationId,
                noOfTeamMember: this.noOfTeamMember
            })
            .then((result) => {
                console.log('result ', result);
                this.projectApplicationId = result;
                /*if (this.noOfTeamMember == "1") {
                    this.hasTeamMember = false;
                    this.showNext1 = true;
                } else if (this.noOfTeamMember == "2" || this.noOfTeamMember == "3" || this.noOfTeamMember == "4") {
                    this.has2TeamMember = true;
                    this.hasTeamMember = false;
                }*/
            })
            .catch((error) => {
                console.log('<--error-->', error);
                this.error = error;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error Submitting Project Application!',
                        message: error.message,
                        variant: 'error',
                    }),
                );
            });

    }
    handleTM2Next() {
        const isInputsCorrect = [...this.template.querySelectorAll('input')]
            .reduce((validSoFar, inputField) => {
                inputField.reportValidity();
                return validSoFar && inputField.checkValidity();
            }, true);
        if (isInputsCorrect) {
            if (this.noOfTeamMember == "2") {
                this.has2TeamMember = false;
                this.showNext1 = true;
            } else {
                this.has2TeamMember = false;
                this.has3TeamMember = true;
            }
        }
    }
    handleSave4() {
        updateTeamMember2Info({
                projectApplicationId: this.projectApplicationId,
                noOfTeamMember: this.noOfTeamMember,
                tm2FirstName: this.tm2FirstName,
                tm2Surname: this.tm2Surname,
                tm2JobTitle: this.tm2JobTitle,
                tm2WorkEmail: this.tm2WorkEmail,
                tm2HomeOfficeCity: this.tm2HomeOfficeCity,
                tm2HomeOfficeCountry: this.tm2HomeOfficeCountry,
                tm2OtherHomeOfficeCountry: this.tm2OtherHomeOfficeCountry,
                tm2CompanyAffiliation: this.tm2CompanyAffiliation,
                tm2BusinessUnitAA: this.tm2BusinessUnitAA,
                tm2OtherBusinessUnitAA: this.tm2OtherBusinessUnitAA,
                tm2BusinessUnitDB: this.tm2BusinessUnitDB,
                tm2OtherBusinessUnitDB: this.tm2OtherBusinessUnitDB,
                tm2MfullName: this.tm2MfullName,
                tm2MworkEmailLM: this.tm2MworkEmailLM
            })
            .then((result) => {
                console.log('result ', result);
                if(result === 'Error'){
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error',
                            message: 'Something went wrong while saving the details. Please fill the details carefully!',
                            variant: 'error',
                        }),
                    );
                }else if(result === 'Success'){
                    if (this.noOfTeamMember == "2") {
                        this.has2TeamMember = false;
                        this.showNext1 = true;
                    } else {
                        this.has2TeamMember = false;
                        this.has3TeamMember = true;
                    }
                }
            })
            .catch((error) => {
                console.log('<--error-->', error);
                this.error = error;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error Submitting Project Application!',
                        message: error.message,
                        variant: 'error',
                    }),
                );
            });
        //}
    }
    handleSaveAndContinue4() {
        updateTeamMember2Info({
                projectApplicationId: this.projectApplicationId,
                noOfTeamMember: this.noOfTeamMember,
                tm2FirstName: this.tm2FirstName,
                tm2Surname: this.tm2Surname,
                tm2JobTitle: this.tm2JobTitle,
                tm2WorkEmail: this.tm2WorkEmail,
                tm2HomeOfficeCity: this.tm2HomeOfficeCity,
                tm2HomeOfficeCountry: this.tm2HomeOfficeCountry,
                tm2OtherHomeOfficeCountry: this.tm2OtherHomeOfficeCountry,
                tm2CompanyAffiliation: this.tm2CompanyAffiliation,
                tm2BusinessUnitAA: this.tm2BusinessUnitAA,
                tm2OtherBusinessUnitAA: this.tm2OtherBusinessUnitAA,
                tm2BusinessUnitDB: this.tm2BusinessUnitDB,
                tm2OtherBusinessUnitDB: this.tm2OtherBusinessUnitDB,
                tm2MfullName: this.tm2MfullName,
                tm2MworkEmailLM: this.tm2MworkEmailLM
            })
            .then((result) => {
                console.log('result ', result);
                this.projectApplicationId = result;
                /*if (this.noOfTeamMember == "2") {
                    this.has2TeamMember = false;
                    this.showNext1 = true;
                } else {
                    this.has2TeamMember = false;
                    this.has3TeamMember = true;
                }*/
            })
            .catch((error) => {
                console.log('<--error-->', error);
                this.error = error;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error Submitting Project Application!',
                        message: error.message,
                        variant: 'error',
                    }),
                );
            });
    }
    handleTM3Next() {
        const isInputsCorrect = [...this.template.querySelectorAll('input')]
            .reduce((validSoFar, inputField) => {
                inputField.reportValidity();
                return validSoFar && inputField.checkValidity();
            }, true);
        if (isInputsCorrect) {
            if (this.noOfTeamMember == "3") {
                this.has3TeamMember = false;
                this.showNext1 = true;
            } else {
                this.has3TeamMember = false;
                this.has4TeamMember = true;
            }
        }
    }
    handleSave5() {
        updateTeamMember3Info({
                projectApplicationId: this.projectApplicationId,
                noOfTeamMember: this.noOfTeamMember,
                tm3FirstName: this.tm3FirstName,
                tm3Surname: this.tm3Surname,
                tm3JobTitle: this.tm3JobTitle,
                tm3WorkEmail: this.tm3WorkEmail,
                tm3HomeOfficeCity: this.tm3HomeOfficeCity,
                tm3HomeOfficeCountry: this.tm3HomeOfficeCountry,
                tm3OtherHomeOfficeCountry: this.tm3OtherHomeOfficeCountry,
                tm3CompanyAffiliation: this.tm3CompanyAffiliation,
                tm3BusinessUnitAA: this.tm3BusinessUnitAA,
                tm3OtherBusinessUnitAA: this.tm3OtherBusinessUnitAA,
                tm3BusinessUnitDB: this.tm3BusinessUnitDB,
                tm3OtherBusinessUnitDB: this.tm3OtherBusinessUnitDB,
                tm3MfullName: this.tm3MfullName,
                tm3MworkEmailLM: this.tm3MworkEmailLM
            })
            .then((result) => {
                console.log('result ', result);
                if(result === 'Error'){
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error',
                            message: 'Something went wrong while saving the details. Please fill the details carefully!',
                            variant: 'error',
                        }),
                    );
                }else if(result === 'Success'){
                    if (this.noOfTeamMember == "3") {
                        this.has3TeamMember = false;
                        this.showNext1 = true;
                    } else {
                        this.has3TeamMember = false;
                        this.has4TeamMember = true;
                    }
                }
            })
            .catch((error) => {
                console.log('<--error-->', error);
                this.error = error;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error Submitting Project Application!',
                        message: error.message,
                        variant: 'error',
                    }),
                );
            });
        //}
    }
    handleSaveAndContinue5() {
        updateTeamMember3Info({
                projectApplicationId: this.projectApplicationId,
                noOfTeamMember: this.noOfTeamMember,
                tm3FirstName: this.tm3FirstName,
                tm3Surname: this.tm3Surname,
                tm3JobTitle: this.tm3JobTitle,
                tm3WorkEmail: this.tm3WorkEmail,
                tm3HomeOfficeCity: this.tm3HomeOfficeCity,
                tm3HomeOfficeCountry: this.tm3HomeOfficeCountry,
                tm3OtherHomeOfficeCountry: this.tm3OtherHomeOfficeCountry,
                tm3CompanyAffiliation: this.tm3CompanyAffiliation,
                tm3BusinessUnitAA: this.tm3BusinessUnitAA,
                tm3OtherBusinessUnitAA: this.tm3OtherBusinessUnitAA,
                tm3BusinessUnitDB: this.tm3BusinessUnitDB,
                tm3OtherBusinessUnitDB: this.tm3OtherBusinessUnitDB,
                tm3MfullName: this.tm3MfullName,
                tm3MworkEmailLM: this.tm3MworkEmailLM
            })
            .then((result) => {
                console.log('result ', result);
                this.projectApplicationId = result;
                /*if (this.projectApplicationId != null || this.projectApplicationId != undefined) {
                    if (this.noOfTeamMember == "3") {
                        this.has3TeamMember = false;
                        this.showNext1 = true;
                    } else {
                        this.has3TeamMember = false;
                        this.has4TeamMember = true;
                    }
                }*/
            })
            .catch((error) => {
                console.log('<--error-->', error);
                this.error = error;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error Submitting Project Application!',
                        message: error.message,
                        variant: 'error',
                    }),
                );
            });
    }
    handleTM4Next() {
        const isInputsCorrect = [...this.template.querySelectorAll('input')]
            .reduce((validSoFar, inputField) => {
                inputField.reportValidity();
                return validSoFar && inputField.checkValidity();
            }, true);
        if (isInputsCorrect) {
            this.has4TeamMember = false;
            this.showNext1 = true;
        }
    }
    handleSave6() {
        updateTeamMember4Info({
                projectApplicationId: this.projectApplicationId,
                noOfTeamMember: this.noOfTeamMember,
                tm4FirstName: this.tm4FirstName,
                tm4Surname: this.tm4Surname,
                tm4JobTitle: this.tm4JobTitle,
                tm4WorkEmail: this.tm4WorkEmail,
                tm4HomeOfficeCity: this.tm4HomeOfficeCity,
                tm4HomeOfficeCountry: this.tm4HomeOfficeCountry,
                tm4OtherHomeOfficeCountry: this.tm4OtherHomeOfficeCountry,
                tm4CompanyAffiliation: this.tm4CompanyAffiliation,
                tm4BusinessUnitAA: this.tm4BusinessUnitAA,
                tm4OtherBusinessUnitAA: this.tm4OtherBusinessUnitAA,
                tm4BusinessUnitDB: this.tm4BusinessUnitDB,
                tm4OtherBusinessUnitDB: this.tm4OtherBusinessUnitDB,
                tm4MfullName: this.tm4MfullName,
                tm4MworkEmailLM: this.tm4MworkEmailLM
            })
            .then((result) => {
                console.log('result ', result);
                if(result === 'Error'){
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error',
                            message: 'Something went wrong while saving the details. Please fill the details carefully!',
                            variant: 'error',
                        }),
                    );
                }else if(result === 'Success'){
                    this.has4TeamMember = false;
                    this.showNext1 = true;
                }
            })
            .catch((error) => {
                console.log('<--error-->', error);
                this.error = error;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error Submitting Project Application!',
                        message: error.message,
                        variant: 'error',
                    }),
                );
            });
        //}
    }
    handleSaveAndContinue6() {
        updateTeamMember4Info({
                projectApplicationId: this.projectApplicationId,
                noOfTeamMember: this.noOfTeamMember,
                tm4FirstName: this.tm4FirstName,
                tm4Surname: this.tm4Surname,
                tm4JobTitle: this.tm4JobTitle,
                tm4WorkEmail: this.tm4WorkEmail,
                tm4HomeOfficeCity: this.tm4HomeOfficeCity,
                tm4HomeOfficeCountry: this.tm4HomeOfficeCountry,
                tm4OtherHomeOfficeCountry: this.tm4OtherHomeOfficeCountry,
                tm4CompanyAffiliation: this.tm4CompanyAffiliation,
                tm4BusinessUnitAA: this.tm4BusinessUnitAA,
                tm4OtherBusinessUnitAA: this.tm4OtherBusinessUnitAA,
                tm4BusinessUnitDB: this.tm4BusinessUnitDB,
                tm4OtherBusinessUnitDB: this.tm4OtherBusinessUnitDB,
                tm4MfullName: this.tm4MfullName,
                tm4MworkEmailLM: this.tm4MworkEmailLM
            })
            .then((result) => {
                console.log('result ', result);
                this.projectApplicationId = result;
                /*if (this.projectApplicationId != null || this.projectApplicationId != undefined) {
                    this.has4TeamMember = false;
                    this.showNext1 = true;
                }*/
            })
            .catch((error) => {
                console.log('<--error-->', error);
                this.error = error;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error Submitting Project Application!',
                        message: error.message,
                        variant: 'error',
                    }),
                );
            });
    }
    handleSave7() {
        updateOrganizationAddress({
                street: this.street,
                cityTown: this.cityTown,
                stateProvCountry: this.stateProvCountry,
                postCode: this.postCode,
                fullOrgName: this.fullOrgName,
                country: this.country,
                otherCountry: this.otherCountry,
                firstNamePOC: this.firstNamePOC,
                websiteURL: this.websiteURL,
                isRegisteredEntity: this.isRegisteredEntity,
                participatedBefore: this.participatedBefore,
                surnamePOC: this.surnamePOC,
                titlePOC: this.titlePOC,
                workEmailPOC: this.workEmailPOC,
                phoneNumberPOC: this.phoneNumberPOC,
                missionAndVision: this.missionAndVision,
                sectorActivites: this.sectorActivites,
                otherSectorAC: this.otherSectorAC,
                geographicCoverage: this.geographicCoverage,
                targetBeneficiaries: this.targetBeneficiaries,
                otherTargetBenef: this.otherTargetBenef,
                partnerOrgComm: this.partnerOrgComm,
                levelOfCommitment: this.levelOfCommitment,
                projectApplicationId: this.projectApplicationId
            })
            .then((result) => {
                console.log('result ', result);
                if(result === 'Error'){
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error',
                            message: 'Something went wrong while saving the details. Please fill the details carefully!',
                            variant: 'error',
                        }),
                    );
                }else if(result === 'Success'){
                    this.showNext1 = false;
                    this.showNext2 = true;
                }
            })
            .catch((error) => {
                console.log('<--error-->', error);
                this.error = error;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error Submitting Project Application!',
                        message: error.message,
                        variant: 'error',
                    }),
                );
            });
        //}
    }
    handleSaveAndContinue7() {
        updateOrganizationAddress({
                street: this.street,
                cityTown: this.cityTown,
                stateProvCountry: this.stateProvCountry,
                postCode: this.postCode,
                fullOrgName: this.fullOrgName,
                country: this.country,
                otherCountry: this.otherCountry,
                firstNamePOC: this.firstNamePOC,
                websiteURL: this.websiteURL,
                isRegisteredEntity: this.isRegisteredEntity,
                participatedBefore: this.participatedBefore,
                surnamePOC: this.surnamePOC,
                titlePOC: this.titlePOC,
                workEmailPOC: this.workEmailPOC,
                phoneNumberPOC: this.phoneNumberPOC,
                missionAndVision: this.missionAndVision,
                sectorActivites: this.sectorActivites,
                otherSectorAC: this.otherSectorAC,
                geographicCoverage: this.geographicCoverage,
                targetBeneficiaries: this.targetBeneficiaries,
                otherTargetBenef: this.otherTargetBenef,
                partnerOrgComm: this.partnerOrgComm,
                levelOfCommitment: this.levelOfCommitment,
                projectApplicationId: this.projectApplicationId
            })
            .then((result) => {
                console.log('result ', result);
                this.projectApplicationId = result;
                /*if (this.projectApplicationId != null || this.projectApplicationId != undefined) {
                    this.showNext1 = false;
                    this.showNext2 = true;
                }*/
            })
            .catch((error) => {
                console.log('<--error-->', error);
                this.error = error;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error Submitting Project Application!',
                        message: error.message,
                        variant: 'error',
                    }),
                );
            });

    }
    handleSave8() {
        updateProjectInformation({
                projectObjective: this.projectObjective,
                projectBackground: this.projectBackground,
                activitesToObtain: this.activitesToObtain,
                projectType: this.projectTypeString,
                corpSocialInvst: this.corpSocialInvst,
                otherSocialInvest: this.otherSocialInvest,
                projectSustainability: this.projectSustainability,
                teamSkills: this.teamSkills,
                levelOfEffort: this.levelOfEffort,
                teamDiversity: this.teamDiversity,
                projectBeneficiaries: this.projectBeneficiaries,
                alignMiningPlan: this.alignMiningPlan,
                projectApplicationId: this.projectApplicationId

            })
            .then((result) => {
                console.log('result ', result);
                if(result === 'Error'){
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error',
                            message: 'Something went wrong while saving the details. Please fill the details carefully!',
                            variant: 'error',
                        }),
                    );
                }else if(result === 'Success'){
                    this.showNext2 = false;
                    this.showNext3 = true;
                }

            })
            .catch((error) => {
                console.log('<--error-->', error);
                this.error = error;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error Submitting Project Application!',
                        message: error.message,
                        variant: 'error',
                    }),
                );
            });
    }
    handleSaveAndContinue8() {
        updateProjectInformation({
                projectObjective: this.projectObjective,
                projectBackground: this.projectBackground,
                activitesToObtain: this.activitesToObtain,
                projectType: this.projectTypeString,
                corpSocialInvst: this.corpSocialInvst,
                otherSocialInvest: this.otherSocialInvest,
                projectSustainability: this.projectSustainability,
                teamSkills: this.teamSkills,
                levelOfEffort: this.levelOfEffort,
                teamDiversity: this.teamDiversity,
                projectBeneficiaries: this.projectBeneficiaries,
                alignMiningPlan: this.alignMiningPlan,
                projectApplicationId: this.projectApplicationId

            })
            .then((result) => {
                console.log('result ', result);
                this.projectApplicationId = result;
                /*if (this.projectApplicationId != null || this.projectApplicationId != undefined) {
                    this[NavigationMixin.Navigate]({
                        "type": "standard__webPage",
                        "attributes": {
                            "url": '/s/detail/' + this.projectApplicationId
                        }
                    });
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Congratulations! You have successfully submitted your 2021 Ambassadors for Good project application. If you have any inquiries about the next steps, please reach out to info@ambassadorsforgood.org. We wish you the best of luck with your application!',
                            variant: 'success',
                        }),
                    );
                }*/
            })
            .catch((error) => {
                console.log('<--error-->', error);
                this.error = error;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error Submitting Project Application!',
                        message: error.message,
                        variant: 'error',
                    }),
                );
            });
    }
    handleSubmit() {
        //if (this.grantUse != null && this.grantNarrative != null) {
        updateGrantInfo({
                grantUse: this.grantUse,
                howMuchFunding: this.howMuchFunding,
                grantNarrative: this.grantNarrative,
                projectApplicationId: this.projectApplicationId
            })
            .then((result) => {
                console.log('result --- unique '+ result);
                this.error = undefined;
                if (result === 'Success') {
                    this[NavigationMixin.Navigate]({
                        "type": "standard__webPage",
                        "attributes": {
                            "url": '/s/detail/' + this.projectApplicationId
                        }
                    });
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Congratulations! You have successfully submitted your 2021 Ambassadors for Good project application. If you have any inquiries about the next steps, please reach out to info@ambassadorsforgood.org. We wish you the best of luck with your application!',
                            variant: 'success',
                        }),
                    );
                }else if(result === 'Error'){
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error',
                            message: 'Something went wrong while saving the details. Please fill the details carefully!',
                            variant: 'error',
                        }),
                    );
                }
            })
            .catch((error) => {
                console.log('<--error-->', error);
                this.error = error;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error Submitting Project Application!',
                        message: 'Some Error Occured',
                        variant: 'error',
                    }),
                );
            });
        /*const home = 'home';
        this[NavigationMixin.GenerateUrl]({
            type: 'comm__namedPage',
            attributes: {
                url: ''
            }
        }).then(url => {
            window.open(window.location.href = home);
        });*/
        /*this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'home'
            }
        });*/
        /*var home = 'home';
        window.location.href = home;*/

        /*} else {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Please Fill out all the Input Fields on this page!!',
                    message: 'All the Input Fields on this page are mandatory',
                    variant: 'error',
                }),
            );
        }*/
    }
}