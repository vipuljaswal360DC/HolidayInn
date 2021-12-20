({
    SearchHelper: function(component, event) {
        // show spinner message
        //component.find("Id_spinner").set("v.class" , 'slds-show');
        component.set("v.ShowTableByDefault",  false);
        component.set("v.ShowTableForFilter",  true);
        component.set("v.Spinner",  true);
        
        var filter = component.find("selectfilter").get('v.value');
        var filterCA = component.find("selectfilterProj").get('v.value');
        console.log('----filter--',component.get("v.searchKeyword"),component.get("v.searchKeyword"));
        console.log('----filterCA--',component.get("v.searchKeywordCA"));
        
        if(filter == "Application Year" && filterCA == "Company Affiliation")
        {
            console.log('--filterBoth--',filter,filterCA);
            var action = component.get("c.searchByAppYearAndCA");
            action.setParams({
                'searchKeyWord': component.get("v.searchKeyword"),
                'searchKeywordCA': component.get("v.searchKeywordCA")
            });
            
        }
        if(filterCA == "Company Affiliation" && component.get("v.searchKeyword") == undefined && component.get("v.searchKeywordCA") != undefined)
        {
            var action = component.get("c.searchByCA");
            action.setParams({
                'searchKeyWord': component.get("v.searchKeywordCA")	
            });
        
        }
        if(filter == "Application Year" && (component.get("v.searchKeywordCA") == undefined && component.get("v.searchKeyword") != undefined))
        {
            console.log('--filterAY--',filter);
            var action = component.get("c.searchByApplicationYear");
            action.setParams({
                'searchKeyWord': component.get("v.searchKeyword")	
            });
        }
        
        if(filter == "Application Year" && filterCA == "Company Affiliation" && component.get("v.searchKeywordCA") == undefined && component.get("v.searchKeyword") == undefined)
        {
            console.log('--filterAYBothNULL--',filter);
            var action = component.get('c.initMethod');
            
        }
        
        action.setCallback(this, function(response) {
            // hide spinner when response coming from server 
            //component.find("Id_spinner").set("v.class" , 'slds-hide');
            var state = response.getState();
            if (state === "SUCCESS") {
                var rows = response.getReturnValue();
                component.set('v.wrapperList', rows);
                var modelList = [];
                for(var i=0; i<rows.length;i++){
                    var Con=rows[i].Con;
                    
                    var APList=rows[i].AnnualParticipationList;
                    //var PjList=rows[i].ProjectsList;
                    var projCount=rows[i].ProjCount;
                    var APSize=rows[i].APCount;
                    var contactCount=rows[i].contactCount;
                    var TMList=rows[i].lstApplications;
                    var JSONInfoForAPP=rows[i].JSONInfoForAPP;
                    
                    modelList.push({Con:Con,AnnualParticipationList:APList,ProjCount:projCount,APCount:APSize,contactCount:contactCount,lstApplications:TMList,JSONInfoForAPP:JSONInfoForAPP});
                }
                console.log('----modelListSearch--',modelList);
                component.set("v.UniqueMMList",  modelList);
                $('#tableId').DataTable().clear().destroy();
                $('#tableIdFilter').DataTable().clear().destroy();
                
                setTimeout(function(){
                    //$.noConflict();
                    $('#tableIdFilter').DataTable({"iDisplayLength": 50});
                    // add lightning class to search filter field with some bottom margin..  
                    $('div.dataTables_filter input').addClass('slds-input');
                    $('div.dataTables_filter input').css("marginBottom", "10px"); 
                }, 2000);     
            }else if (state === "INCOMPLETE") {
                //alert('Response is Incompleted');
            }else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        //alert("Error message: " + 
                        //errors[0].message);
                    }
                } else {
                    //alert("Unknown error");
                }
            }
        });
        
        $A.enqueueAction(action);
    },
    getContactList: function(component, pageNumber, pageSize) {
        var action = component.get("c.getContactData");
        action.setParams({
            "pageNumber": pageNumber,
            "pageSize": pageSize
        });
        action.setCallback(this, function(result) {
            var state = result.getState();
            if (component.isValid() && state === "SUCCESS"){
                var resultData = result.getReturnValue();
                component.set("v.ContactList", resultData.contactList);
                component.set("v.PageNumber", resultData.pageNumber);
                component.set("v.TotalRecords", resultData.totalRecords);
                component.set("v.RecordStart", resultData.recordStart);
                component.set("v.RecordEnd", resultData.recordEnd);
                component.set("v.TotalPages", Math.ceil(resultData.totalRecords / pageSize));
            }
        });
        $A.enqueueAction(action);
    },
    onLoad: function(component, event, sortField) {
        //call apex class method
        var action = component.get('c.sortByCname');
        
        // pass the apex method parameters to action 
        action.setParams({
            'sortField': sortField,
            'isAsc': component.get("v.isAsc")
        });
        action.setCallback(this, function(response) {
            //store state of response
            var state = response.getState();
            if (state === "SUCCESS") {
                var rows = response.getReturnValue();
                component.set('v.wrapperList', rows);
                var modelList = [];
                for(var i=0; i<rows.length;i++){
                    var Con=rows[i].Con;
                    
                    var APList=rows[i].AnnualParticipationList;
                    //var PjList=rows[i].ProjectsList;
                    var projCount=rows[i].ProjCount;
                    var APSize=rows[i].APCount;
                    var contactCount=rows[i].contactCount;
                    
                    modelList.push({Con:Con,AnnualParticipationList:APList,ProjCount:projCount,APCount:APSize,contactCount:contactCount});
                }
                console.log('----modelListSearch--',modelList);
                component.set("v.UniqueMMList",  modelList);
            }
        });
        $A.enqueueAction(action);
    },
    
    sortHelper: function(component, event, sortFieldName) {
        var currentDir = component.get("v.arrowDirection");
        
        if (currentDir == 'arrowdown') {
            // set the arrowDirection attribute for conditionally rendred arrow sign  
            component.set("v.arrowDirection", 'arrowup');
            // set the isAsc flag to true for sort in Assending order.  
            component.set("v.isAsc", true);
        } else {
            component.set("v.arrowDirection", 'arrowdown');
            component.set("v.isAsc", false);
        }
        // call the onLoad function for call server side method with pass sortFieldName 
        this.onLoad(component, event, sortFieldName);
    },
    convertArrayOfObjectsToCSV : function(component,objRecords) {
        var csvStringResult,counter,keys,lineDivider,columnDivider;
        if(objRecords==null || !objRecords.length)
        {
            return null;         
        }
        columnDivider=',';
        lineDivider='\n';
        keys=['Team Member ID','Team Member Name','Org Country Location','Company Affiliation','Total Applications','List Of App Year With Participation'];
        csvStringResult='';
        csvStringResult+=keys.join(columnDivider);
        csvStringResult+=lineDivider;
        for(var i=0;i<objRecords.length;i++)
        {
            counter=0;
            for(var tempKey in keys)
            {
                var skey=keys[tempKey];
                if(counter>0)
                {
                    csvStringResult+=columnDivider;
                }
                //console.log('--objRecords[i]--',objRecords[i].Con.Name);
                // Querying standard related object field
                if(skey==='Team Member ID' && objRecords[i].Con.Id != 'undefined'){
                    //console.log('--skey--',skey);
                    //console.log('--objRecords[i]--',objRecords[i].Con.Name);
                    csvStringResult+='"'+objRecords[i].Con.Id+'"';
                    counter ++;
                }else if(skey==='Team Member Name' && objRecords[i].Con.Name != 'undefined'){
                    //console.log('--skey--',skey);
                    //console.log('--objRecords[i]--',objRecords[i].Con.Name);
                    csvStringResult+='"'+objRecords[i].Con.Name+'"';
                    counter ++;
                }
                // Querying custom related object field
                    else if(skey==='Org Country Location' && objRecords[i].Con.Account.BillingCountry !="undefined"){
                        csvStringResult+='"'+objRecords[i].Con.Account.BillingCountry+'"';
                        counter ++;
                        
                    }else if(skey==='Company Affiliation' && objRecords[i].Con.Company_Affiliation__c != 'undefined'){
                        csvStringResult+='"'+objRecords[i].Con.Company_Affiliation__c+'"';
                        counter ++;
                        
                    }else if(skey==='Total Applications' && objRecords[i].ProjCount != 'undefined'){
                        csvStringResult+='"'+objRecords[i].ProjCount+'"';
                        counter ++;
                        
                    }else if(skey==='List Of App Year With Participation'){
                        for(var j=0;j<objRecords[i].AnnualParticipationList.length;j++)
                        {	
                            //console.log('--apKey.Participation_Year__c--',objRecords[i].AnnualParticipationList[j].Participation_Year__c+'-'+objRecords[i].AnnualParticipationList[j].Counter__c);
                            csvStringResult+='"'+[objRecords[i].AnnualParticipationList[j].Participation_Year__c,objRecords[i].AnnualParticipationList[j].Counter__c]+'"';
                            counter ++;
                        }
                        
                    }
                // Querying same object field
                        else{
                            csvStringResult+='"'+objRecords[i][skey]+'"';
                            counter ++;
                        }
                
            }
            csvStringResult+=lineDivider;
            
        }
        
        return csvStringResult
    },
    showHideSpinner : function(component) {
        var showValue = component.get('v.show');
        
        if(showValue) {
            console.log('showValue'+showValue);
            var spinner = component.find("Id_spinner");
            console.log('spinner'+spinner);
            $A.util.removeClass(spinner, "slds-hide");
        } else {
            console.log('showValue'+showValue);
            var spinner = component.find("Id_spinner");
            console.log('spinner'+spinner);
            $A.util.addClass(spinner, "slds-hide");
        }
    }
})