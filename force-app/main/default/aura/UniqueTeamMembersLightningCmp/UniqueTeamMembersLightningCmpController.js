({
    scriptsLoaded : function(component, event, helper) {
        console.log('Script loaded..');
        component.set("v.Spinner",  false);
    },
    onChangeForInput:function(component, event, helper) {
        event.preventDefault();
        //component.set('v.searchKeyword','');
    	//component.set('v.searchKeywordCA','');  
     },
    refreshViewPage:function(component, event, helper) {
        //component.find("Id_spinner").set("v.class" , 'slds-show');
        event.preventDefault();
        var spinner =component.find("Id_spinner");
        $A.util.toggleClass(spinner, "slds-hide");
        component.set("v.Spinner",  true);
        $A.get('e.force:refreshView').fire();
        /*var action = component.get('c.loadData');
        component.get('c.spinnerDisplayHandler');
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.searchKeyword',null);
            }
            
         });
        
        $A.enqueueAction(action);*/
        //component.find("Id_spinner").set("v.class" , 'slds-show');
        //this.loadData(component, event, helper);
        
    },
    spinnerDisplayHandler : function(component, event, helper) {
        console.log('show spinner value changes');
        helper.showHideSpinner(component); 
    },
    
    loadData: function(component, event, helper) {
      //call apex class method
      //var pageNumber = component.get("v.PageNumber");  
        //var pageSize = component.find("pageSize").get("v.value"); 
      component.set("v.Spinner",  false);  
      var action = component.get('c.initMethod');
        
      action.setCallback(this, function(response) {
        //store state of response
        var state = response.getState();
        if (state === "SUCCESS") {
          //set response value in wrapperList attribute on component.
          //helper.getContactList(component, pageNumber, pageSize);
          console.log('----state--',state);
            var rows = response.getReturnValue();
                console.log('----rows--',rows);
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
            
                
         console.log('----modelList--',modelList);
         
          
            // when response successfully return from server then apply jQuery dataTable after 500 milisecond
            setTimeout(function(){
                //$.noConflict();
                $('#tableId').DataTable({"iDisplayLength": 50});
                // add lightning class to search filter field with some bottom margin..  
                $('div.dataTables_filter input').addClass('slds-input');
                $('div.dataTables_filter input').css("marginBottom", "10px"); 
            }, 1400); 
           component.set("v.Spinner",  false);
        }
          
          component.set("v.UniqueMMList",  modelList);
          component.set("v.ShowTableByDefault",  true);
          component.set("v.ShowTableForFilter",  false);
          
          
         //console.log('----UniqueMMList--',component.get("v.UniqueMMList"));
         //console.log('----v.fullMap--',component.get("v.fullMap"));  
          
      });
      $A.enqueueAction(action);
    },
    doInit : function(component, event, helper) {
        
        var actions = [
            { label: 'Edit', name: 'edit' },
            { label: 'View', name: 'view' } ];
        
        component.set('v.columns', [
            {label: 'Id', fieldName: 'Id', editable: false, type: 'text',sortable:'true'},
            {label: 'Name', fieldName: 'Name', editable: false, type: 'text',sortable:'true'},
            {label: 'Account Id', fieldName: 'AccountId', editable: false, type: 'text',sortable:'true'},
            {label: 'Account Name', fieldName: 'Account_Name__c', type: 'text',sortable:'true'},
            {label: 'Company Affiliation', fieldName: 'Company_Affiliation__c', editable: false, type: 'text',sortable:'true'},
            { type: 'action', typeAttributes: { rowActions: actions } } ] );
        
        component.set('v.columnsParticipants', [
            {label: 'Name', fieldName: 'Name', editable: false, type: 'text',sortable:'true'},
            {label: '# Times Participated In', fieldName: 'Counter__c', editable: false, type: 'text',sortable:'true'},
            {label: 'Participation Year', fieldName: 'Participation_Year__c', type: 'text',sortable:'true'},
            { type: 'action', typeAttributes: { rowActions: actions } } ] );
        
        
        var action=component.get('c.initMethod');
        action.setParams({
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log('----i am in--',state);
                var rows = response.getReturnValue();
                console.log('----rows--',rows);
                
                component.set('v.wrapperList', rows);
                component.set("v.showdiv", false);
                
            }
        });
        $A.enqueueAction(action);
    },
    handleRowAction: function ( cmp, event, helper ) {
       
        var action = event.getParam( 'action' );
        var row = event.getParam( 'row' );
        var recId = row.Id;

        switch ( action.name ) {
            case 'edit':
                var editRecordEvent = $A.get("e.force:editRecord");
                editRecordEvent.setParams({
                    "recordId": recId
                });
                editRecordEvent.fire();
                break;
            case 'view':
                var viewRecordEvent = $A.get("e.force:navigateToURL");
                viewRecordEvent.setParams({
                    "url": "/" + recId
                });
                viewRecordEvent.fire();
                break;
        }
    },
    Clicked : function(component, event, helper){
        var ctarget = event.currentTarget;
        var id_str = ctarget.dataset.value;
        console.log(id_str);

        var action = component.get("c.getAnnualParRecords");
        action.setParams({ ConId :  id_str});
        action.setCallback(this, function(response) {
            var state = response.getState(); //Checking response status
            console.log("state... ",state);
            console.log("contactsss... "+response.getReturnValue());
            if (component.isValid() && state === "SUCCESS"){
                component.set("v.AnnualPartList", response.getReturnValue());  // Adding values in Aura attribute variable.   
            }
            var getList = component.get('v.wrapperList.lstContact'); 
            console.log('getList',getList);
            //var tmid = component.find('tmid').get("v.value");
            //console.log('tmid',tmid);
            /*if(component.get("{!v.wrapperList.lstContact}")){
                component.set("v.showdiv", true);
            }else{
                component.set("v.showdiv", false);
            }*/
        });
        $A.enqueueAction(action);
    },
    getSelectedName: function (component, event) {
        var selectedRows = event.getParam('selectedRows');
        // Display that fieldName of the selected rows
        for (var i = 0; i < selectedRows.length; i++){
            alert("You selected: " + selectedRows[i].id);
        }
    },
    Search: function(component, event, helper) {
        var searchField = component.find('searchField');
        var isValueMissing = searchField.get('v.validity').valueMissing;
        // if value is missing show error message and focus on field
        if(isValueMissing) {
            searchField.showHelpMessageIfInvalid();
            
        }else{
          // else call helper function 
            helper.SearchHelper(component, event);
            
        }
    },
    
    onChange: function (cmp, evt, helper) {
    
    cmp.set('v.searchKeyword',null);
    cmp.set('v.searchKeywordCA',null);    
        
    },
     
    handleNext: function(component, event, helper) {
        var pageNumber = component.get("v.PageNumber");  
        var pageSize = component.find("pageSize").get("v.value");
        pageNumber++;
        helper.getContactList(component, pageNumber, pageSize);
    },
     
    handlePrev: function(component, event, helper) {
        var pageNumber = component.get("v.PageNumber");  
        var pageSize = component.find("pageSize").get("v.value");
        pageNumber--;
        helper.getContactList(component, pageNumber, pageSize);
    },
     
    onSelectChange: function(component, event, helper) {
        var page = 1
        var pageSize = component.find("pageSize").get("v.value");
        helper.getContactList(component, page, pageSize);
    },
    // ## function call on Click on the "Download As CSV" Button. 
    downloadCsv : function(component,event,helper){
        
        // get the Records [contact] list from 'ListOfContact' attribute 
        var stockData = component.get("v.UniqueMMList");
        console.log('--stockData--',stockData);
        // call the helper function which "return" the CSV data as a String   
        var csv = helper.convertArrayOfObjectsToCSV(component,stockData);   
         if (csv == null){return;} 
        
        // ####--code for create a temp. <a> html tag [link tag] for download the CSV file--####     
	     var hiddenElement = document.createElement('a');
          hiddenElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csv);
          hiddenElement.target = '_self'; // 
          hiddenElement.download = 'AlumniTeamMembersReport.csv';  // CSV file Name* you can change it.[only name not .csv] 
          document.body.appendChild(hiddenElement); // Required for FireFox browser
    	  hiddenElement.click(); // using click() js function to download csv file
        },
    download_csv: function(component,csv, filename) {
    var csvFile;
    var downloadLink;

    // CSV FILE
    csvFile = new Blob([csv], {type: "text/csv"});

    // Download link
    downloadLink = document.createElement("a");

    // File name
    downloadLink.download = filename;

    // We have to create a link to the file
    downloadLink.href = window.URL.createObjectURL(csvFile);

    // Make sure that the link is not displayed
    downloadLink.style.display = "none";

    // Add the link to your DOM
    document.body.appendChild(downloadLink);

    // Lanzamos
    downloadLink.click();
},
    export_table_to_csv:function (component,html, filename) {
	var csv = [];
	var rows = document.querySelectorAll("table tr");
	
    for (var i = 0; i < rows.length; i++) {
		var row = [], cols = rows[i].querySelectorAll("td, th");
		
        for (var j = 0; j < cols.length; j++) 
            row.push(cols[j].innerText);
        
		csv.push(row.join(","));		
	}

    // Download CSV
    this.download_csv(component,csv.join("\n"), filename);
},
    // this function automatic call by aura:waiting event  
    showSpinner: function(component, event, helper) {
       // make Spinner attribute true for display loading spinner
        component.set("v.Spinner", true);
   },
    
// this function automatic call by aura:doneWaiting event
    hideSpinner : function(component,event,helper){
     // make Spinner attribute to false for hide loading spinner    
       component.set("v.Spinner", false);
    }
    
})