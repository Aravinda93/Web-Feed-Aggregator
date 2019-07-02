$(document).ready(function(){

	//On Load delete the Data from the TBL_WEB_FEED_REPLICA
	// Delete_Replica_Records();

	//On Load Call the function to display the table with the data
	Grid_Table_Populator();
	$("#Web_Feed_Home").css('background', 'red');

	//On load inform the user about the time at which Database was last refreshed
	Last_Refresh_time();

	var User_Delete_End_Date = "";

	//On Click of the refresh button Load fresh data into the Database
	$("#refresh_data").click(function(){
		$("#home_div").hide();
		$("#Refresh_Time").hide();
		$("#Loader_Logo").show();
		var dummy = "dummy";
		$.ajax({
			type: 'POST',
			url: '/Refresh_Data',
			data:{"Refresh_Time":dummy,"User_Delete_End_Date":User_Delete_End_Date},
			dataType: 'json',
			success: function(data){
				if(data.status == 303)
				{
					$("#Loader_Logo").hide();
		       		$("#home_div").show();
		       		$("#Refresh_Time").show();
					var Time = 10 - data.time;
		            alertify.alert("Error during DB Refresh:","Data can be refreshed once in every 10 mins. <br/> Please try again after <b>"+Time+"</b> mins.");
		        	//alert("Data can be refreshed once in every 10 mins. Please try again after "+Time+"	mins.");
		        }
		        if(data.status == 200)
		        {
		        	clear_search();
		        	Last_Refresh_time();
		        	Reload_Provider_Grid();	
		        	$("#Loader_Logo").hide();
		       		$("#home_div").show();
		       		$("#Refresh_Time").show();
		        	alertify.alert("Web feed data updated successfully:"," Total of <b>"+data.Count+ "</b> new data found and written into the Database.");
		        }
			}
		});
	});


	//FUNCTION TO POPULATE THE TABLE WITH THE DATA
	function Grid_Table_Populator()
	{
		var dataInitMultiselect = function (elem, searchOptions) {
      var $grid = $(this);
      setTimeout(function() {
        var $elem = $(elem),
          id = elem.id,
          inToolbar = searchOptions.mode === "filter",
          options = {
            selectedList: 2,
            height: "auto",
            checkAllText: "Select All",
            uncheckAllText: "Select None",
            noneSelectedText: "All Providers",
            // autoOpen: true,
            open: function() {
              $(".ui-multiselect-menu:visible").width("auto");
            },
          },
          $options = $elem.find("option");
        if ($options.length > 0 && $options[0].selected) {
          $options[0].selected = false; // unselect the first selected option

        }
        if (inToolbar) {
          options.minWidth = "auto";
        }
        $grid.triggerHandler("jqGridRefreshFilterValues");
        $elem.multiselect(options);
		
		// next lines are optional and needed only if one uses
		// fontawesome
		  var $header = $elem.data("echMultiselect").header;
		  $header.find("span.ui-icon.ui-icon-check")
			  .removeClass("ui-icon ui-icon-check")
			  .addClass("fa fa-fw fa-check");
		  $header.find("span.ui-icon.ui-icon-closethick")
			  .removeClass("ui-icon ui-icon-closethick")
			  .addClass("fa fa-fw fa-times");
		  $header.find("span.ui-icon.ui-icon-circle-close")
			  .removeClass("ui-icon ui-icon-circle-close")
			  .addClass("fa fa-times-circle");
		  $elem.data("echMultiselect")
			  .button
			  .find("span.ui-icon.ui-icon-triangle-1-s")
			  .removeClass("ui-icon ui-icon-triangle-1-s")
			  .addClass("fa fa-caret-down")
			  .css({
			  float: "right",
			  marginRight: "5px"
		  });
      }, 50);
    };

		//Populdate the Datatable with the WEB Feed data
		$("#home_grid").jqGrid({
			url: "/Web_Feed_Data",
			datatype: "json",
			mtype: "GET",
			iconSet: "fontAwesome",
			colNames: ["ID", "PROVIDER", "Title","Published Time", "Fetch Date", "URL"],
			colModel:
			[
				{
					name	: "ID",
					align	: "center",
					search	: true,
					hidden	: true
				},
				{
	                name	: "PROVIDER",
	                align	: "center",
	                width	: "120%",
	                type	: "text", 
					search	: true,	
					stype : "select",
					searchoptions: {
					    generateValue: true,
					    sopt: ["in"],
					    attr: { multiple: "multiple", size: 10 },
					    dataInit: dataInitMultiselect
					}		
	            },
				{
	                name	: "TITLE",
	                align	: "center",
					search	: true,
					width	: "250%",
					formatter: Title_Url_Bind 
	            },
	            {
	                name		: "PUBLISH_TIME",
	                align		: "center",
	                width		: "130%",
					search		: true,
					sorttype	: "datetime",
	                formatter	: 'date',
					formatoptions: { srcformat: "Y/m/d h:i:s A", newformat: "Y-m-d h:i:s A" }
					
	            },
	            {
	                name		: "DB_ENTRY_TIME",
	                align		: "center",
	                width		: "130%",
	                sortable	: true,
	                sorttype	: "datetime",
	                formatter	: 'date',
					formatoptions: { srcformat: "Y/m/d h:i:s A", newformat: "Y-m-d h:i:s A" }
	            },
	            {
	                name		: "URL",
	                align		: "center",
					search		: true,
					hidden		: true
	            }
			],
			pager		: "#home_pager",
	        loadonce	: true,
	        shrinkToFit	: true,
	        rowNum		: 10,
	        autoHeight	: true,
	        rowList		: [10, 15, 20, 25, 50],
	        sortable	: true,
	        sortname	: "DB_ENTRY_TIME",
	        sortorder	: "desc",
	        viewrecords	: true,
	        toolbar		: [true, "top"],
	        autowidth	: true,
	        caption		: 'Web Feed Movie Data',
	        loadComplete: function(data)
	        {
	        	if ($('#home_grid').getGridParam('records') === 1)
	        	{
	        		$("#home_div").hide();
                    $("#home_grid").hide();
                    $('#home_pager').hide();
                    $("#No_Result").show();
	        	}
	        	else
	        	{
                    $("#No_Result").hide();
                    $("#home_div").show();
                    $("#home_grid").show();
                    $('#home_pager').show();
                }
                $(this).jqGrid("destroyFilterToolbar");

                if (!this.ftoolbar) {
        			// create filter toolbar if it isn't exist 
       	 			$(this).jqGrid("filterToolbar", {		
            			defaultSearch: "cn",
            			beforeClear: function() {
		                $(this.grid.hDiv)
		                    .find(".ui-search-toolbar button.ui-multiselect")
		                    .each(function() {
		                    	$(this).prev("select[multiple]").multiselect("refresh");
		                	});
            			}
        			});
	        		$(this).triggerHandler("jqGridRefreshFilterValues");
			        $(this.grid.hDiv)
			            .find(".ui-search-toolbar button.ui-multiselect")
			            .each(function() {
			            $(this).prev("select[multiple]")
			                .multiselect("refresh");
			        });        
    			}
	        },
	        beforeClear: function () {
			    $(this.grid.hDiv)
			        .find(".ui-search-toolbar .ui-search-input>select[multiple] option")
			        .each(function () {
			            // unselect all options in <select>
			            this.selected = false; 
			        }
			    );

			    $(this.grid.hDiv)
			        .find(".ui-search-toolbar button.ui-multiselect")
			        .each(function () {
			            // synchronize jQuery UI Multiselect with <select>
			            $(this).prev("select[multiple]").multiselect("refresh");
			        }
			    ).css({
			        width: "98%",
			        marginTop: "1px",
			        marginBottom: "1px",
			        paddingTop: "3px"
			    });
			},
	    //   beforeProcessing: beforeProcessingHandler1,
	   //      beforeProcessing: function(data){
	   //      	var ProviderMap 	= {};
	   //      	var ProviderValues 	= ":All";
	   //      	var i, provider;
				// for (i = 0; i < data.length; i++)
				// {
  		// 			provider = data[i].PROVIDER;
  		// 			if (!ProviderMap.hasOwnProperty(provider))
	  	// 			{
	  	// 					ProviderMap[provider] = 1;
	  	// 					ProviderValues += ";" + provider + ":" + provider;
	  	// 			}
  		// 		}

  		// 		$(this).jqGrid("setColProp", 'PROVIDER', {
		  //           stype: "select",
		  //           searchoptions: {
		  //           	sopt:['eq'],
		  //           	value: ProviderValues
		  //           }
		  //       	}).jqGrid('destroyFilterToolbar')
	   //      		.jqGrid('filterToolbar', {
			 //            stringResult: true,
			 //            searchOnEnter: false,
			 //            defaultSearch : "cn"
	   //      	});
	   //      },
		});	
	 //    jQuery("#home_grid").jqGrid('filterToolbar', {
		//     stringResult: true,
		//     searchOnEnter: false,
		//     defaultSearch: "cn"
		// });
	}





	//Reload the JQGRID table on the Database Refresh
    function clear_search()
	{
		var $home_grid = $("#home_grid");
        if ($home_grid[0].ftoolbar) {
            $home_grid[0].clearToolbar();
        }

        $("#home_grid").jqGrid('setGridParam', {
            datatype: 'json'
        }).trigger('reloadGrid');
    }

    //Remove the T and Z from the received time form the Database
    // function Time_Formatter(cellvalue, options, rowObject)
    // {
    // 	if(cellvalue === undefined || cellvalue === 'NULL' || cellvalue === '') 
    // 	{
    //     	cellvalue = '';
    // 	}
    // 	else
    // 	{
	   //  	if(cellvalue.indexOf('Z') !== -1)
	   //  	{
	   //  		return cellvalue.replace('Z', '').replace('T', ' ');
	   //  	} 
	   //  	else
	   //  	{
	   //  		return cellvalue;
	   //  	}
    // 	}
    // }



	//Re-Size the Jqgrid based on the Zoom level to the Parent DIV
    $(window).resize(function() {
        var outerwidth = $('#Home_Jqgrid').width();
        $('#home_grid').setGridWidth(outerwidth); // setGridWidth method sets a new width to the grid dynamically
    });

    $(window).unbind('resize.myEvents').bind('resize.myEvents', function() {
        var outerwidth = $('#Home_Jqgrid').width();
        $('#home_grid').setGridWidth(outerwidth);
    });

    //Change the column height
    var home_grid1 = $("#home_grid");
    //$("thead:first tr.ui-jqgrid-labels", home_grid1[0].grid.hDiv).height(27);

    //Change the Caption height
    $("div#gview_" + home_grid1[0].id + " > div.ui-jqgrid-titlebar").height(17);

    //Center the Team Title
    $("#home_grid").closest("div.ui-jqgrid-view")
        .children("div.ui-jqgrid-titlebar")
        .css("text-align", "center")
        .children("span.ui-jqgrid-title")
        .css("float", "none");

    //Footer height
    $('#home_pager').css({
        "height": "27px"
    });

    //Bind the title with the URL
    function Title_Url_Bind(cellvalue, options, rowObject)
    {
    	return '<a target="_blank" href='+rowObject.URL+'>'+cellvalue+'</a>';
    }

    //Export the Details to Excel - button
   	$("#home_grid").jqGrid('navGrid', '#home_pager', {
        view: false,
        del: false,
        add: false,
        edit: false,
        excel: true,
        search: false,
        refresh: false
    })
    .navButtonAdd('#home_pager', {
	    caption: '<i class="fa fa-file-excel-o" aria-hidden="true" style="font-size:15px;"></i>',
	    id: "Export_Movie_Data",
	    title: "Export Excel : Web Feed Data",
	    onClickButton: function() {
	        window.location.href = 'Export_Movie_Data';
	    },
	    position: "right"
	})
	.navButtonAdd('#home_pager', {
	    caption: '<i class="fa fa-rss" aria-hidden="true" style="font-size:15px;"></i>',
	    id: "Export_RSS",
	    title: "Export RSS : Web Feed Data",
	    onClickButton: function() {
	        window.location.href = 'Export_RSS';
	    },
	    position: "right"
	});

	//To Remove the uparrow in the add button grid
    $("div.ui-pg-div >span").removeClass("ui-icon ui-icon-save");
    $("div.ui-pg-div >span").removeClass("fa fa-lg fa-fw fa-external-link")

    //Date Range Picker
    $('.daterange').daterangepicker();

    $('.daterange').daterangepicker({
    	opens: 'left'
  		}, function(start, end, label) {	
    	//console.log("A new date selection was made: " + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'));
  		var Start_Date 	= start.format('YYYY-MM-DD 00:00:00.000');
  		var End_Date 	= end.format('YYYY-MM-DD 23:59:59.000');
  		User_Delete_End_Date = End_Date;
  		let today 	= new Date().toISOString().replace('Z', '').replace('T', ' ');
  		var diff 	=  Math.floor(( (Date.parse(today)-1) - Date.parse(End_Date) ) / 86400000); 
  		if(diff > 6)
  		{
  			Delete_Old_Records(Start_Date,End_Date);
  		}
  		else
  		{
  			alertify.alert("Error during deletion of records:","Cannot delete web feed data of last 7 days.");
  		}
  	});


  	//Function to Delete the old Records which were inserted b/w the dates provided by user
  	function Delete_Old_Records(Start_Date,End_Date)
  	{
  		$("#home_div").hide();
		$("#Refresh_Time").hide();
		$("#Loader_Logo").show();
  		$.ajax({
			type: 'DELETE',
			url: '/Delete_Data',
			data:{"Start_Date":Start_Date,"End_Date":End_Date},
			dataType: 'json',
			success: function(data){
				if(data.Status === 200)
				{
					$("#home_div").show();
					$("#Refresh_Time").show();
					$("#Loader_Logo").hide();
					alertify.alert("Data deleted from DB:","Total of <b>"+data.Count+"</b> entries found for the given data range and deleted them.");
					clear_search();
				}
				else
				{
					$("#home_div").show();
					$("#Refresh_Time").show();
					$("#Loader_Logo").hide();
					alertify.alert("Could not delete any records:","No Data Found for the given date range.<br/>Hence could not delete any entries.");
				}
			}
		});
  	}

  	//Function to get information about the Last refresh time
  	function Last_Refresh_time()
  	{
  		$.ajax({
			type: 'GET',
			url: '/Last_Refresh_Time',
			dataType: 'json',
			success: function(data){
				var time 	=	data[0].TIME.replace('Z', '').replace('T', ' ');
				$("#last_refresh").text(time);
			}
		});
  	}

  	//Set the refresh time based on the data provided by the user
  	$("#Refresh_Time_Button").click(function(){
  		var Refresh_Time = $("#Refresh_Time_Text").val();
  		
  		if(Refresh_Time == '' || Refresh_Time < 5 || Refresh_Time > 60)
  		//if(Refresh_Time == '')
  		{

  			alertify.alert("Error during automatic refresh:","Please enter refresh time greater than 5 mins and less than 60 mins");
  		}
  		else
  		{
  			alertify.alert("Automatic web feed refresh:","Web feed data will be refreshed for every <b>"+Refresh_Time+"</b> mins.");
  			Refresh_Time = Refresh_Time * 60000;
  			setInterval(function() {
			 	$.ajax({
					type: 'POST',
					url: '/Refresh_Data_Time_Interval',
					data:{"Refresh_Time":Refresh_Time,User_Delete_End_Date:User_Delete_End_Date},
					dataType: 'json',
					success: function(result){
				        if(result.status == 200)
				        {
				        	clear_search();
				        	Reload_Provider_Grid();
				        	Last_Refresh_time();	
				        	alertify.alert("Database Updated Successfully:"," Total of <b>"+result.Count+ "</b> new data found and written into the database.");
				        }
					}
				});
			}, Refresh_Time);
  		}
  	})

  	//Providers View for addition of provider and other information
  	$("#Providers").click(function(){
  		$("#Web_Feed_Home").css("background-color", "");
  		$("#Providers").css("background-color", "red");
  		$('#Web_Feed_View').hide();
  		$('#Provider_View').show();
  		//Call the function to load JQGRID for the Providers
  		Provider_Grid();
  	});

  	//Home of Web Feed Data view on click of logo
  	$("#Web_Feed_Home").click(function(){
  		$("#Providers").css("background-color", "");
  		$("#Web_Feed_Home").css('background', 'red');	
  		$(this).css('background', 'red');	
  		$('#Provider_View').hide();
  		$('#Web_Feed_View').show();
  	});

  	  //Add the new URL to the Array of Web Feed URL
  	$("#New_URL_Click").click(function(){
  		var Provider_Name 	=	$("#New_Provider_Name").val();
  		var Provider_URL	=	$("#New_Provider_URL").val();
  		Provider_URL 		=	Provider_URL.trim();
  		if(Provider_Name == '' || Provider_URL == '')
  		{
  			alertify.alert("Error during new provider addition:","Please enter Provider Name and Provider URL.");
  		}
  		else
  		{
  			$("#Provider_Div").hide();
  			$("#Loader_Logo1").show();
  			$.ajax({
  				url: 'https://api.rss2json.com/v1/api.json',
  				type: 'GET',
  				data: {
		            rss_url: Provider_URL,
		            api_key: 'pitn8kqc0wibx5jkgkdl9lbv4olgoc9jvbjimrpj', // put your api key here
		            // count: 2
        		},
 				dataType: 'jsonp',
  				success: function(result) {
    				//Call function to write the Provided URL into the Database
    				Provider_Insert(Provider_Name, Provider_URL);
  				},
  				error: function(err)
  				{
  					console.log(err);
  					alertify.alert("Incorrect Web Feed URL:","You have provided invalid Web Feed URL. \nPlease check and try again.")
  					$("#Loader_Logo1").hide();
  					$("#Provider_Div").show();
  				}
			});
  		}
  	});

  	//On Load Delete records from the Replica Table so that only original RSS data is displayed
  // 	function Delete_Replica_Records(){
		// $.ajax({
		// 	type: 'DELETE',
		// 	url: '/DELETE_REPLICA_TABLE_DATA',
		// 	dataType: 'json',
		// 	success: function(data){
		// 		if(data.status === 200)
		// 		{
		// 			console.log("Successfully Deleted Replica Table Data");
		// 		}
		// 	}
		// });
  // 	}

  	//Function Which will write the Provider name and Provider URL into the Providers Table
  	function Provider_Insert(Provider_Name, Provider_URL)
  	{
		$.ajax({
				type: 'POST',
				url: '/ADD_NEW_URL',
				data:{Provider_Name:Provider_Name, Provider_URL:Provider_URL},
				dataType: 'json',
				success: function(data){
					console.log(data);
					if(data.status === 200)
					{
						alertify.alert("New Provider Addition Success:", "New Provider <b>"+Provider_Name+"</b> has been added successfully.");
						$('#New_Provider_URL').val('');
						$('#New_Provider_Name').val('');

						//Call function to insert the data of new provider into the table
						New_Provider_Data_Insert(Provider_Name,Provider_URL);

					}
					if(data.status === 303)
					{
						alertify.alert("New Provider Addition Failure:", "The Provider URL/Name already exist!!! <br/> Please Check and Try again.");
						$("#Loader_Logo1").hide();
  						$("#Provider_Div").show();
					}
				}
		});
  	}

  	//function to Read the NEW RSS Provider and Insert the Data into the DB
  	function New_Provider_Data_Insert(Provider_Name,Provider_URL)
  	{
  		$.ajax({
            url: "/New_Provider_Data_Insert",
            type: "POST",
            data:{User_Delete_End_Date:User_Delete_End_Date},
            dataType: "json",
            success: function(data){
            	Reload_Provider_Grid();
            	clear_search();
            	Last_Refresh_time();
            	$("#Loader_Logo1").hide();
            	$("#Provider_Div").show();	
            }
        });
  	}

  	//Function to Populate the Provider Grid and Display the Data in Providers Page
  	var Provider_Name = "";
  	function Provider_Grid()
  	{
  		$("#Provider_Grid").jqGrid({
  			url: "/Provider_Info",
			datatype: "json",
			mtype: "GET",
			colNames: ["Provider Name",  "Provider URL", "Newly Found", "Last Refresh", "Edit", "Delete"],
			colModel:
			[
				{
					name	: "PROVIDER_NAME",
					align	: "center",
					search	: true,
					width	: "80%"
				},
				{
					name	: "PROVIDER_URL",
					align	: "center",
					search	: true,
					formatter :  Provider_URL,
					width	: "150%"
				},
				{
					name	: "FEED_COUNT",
					align	: "center",
					search	: true,
					width	: "50%"
				},
				{
					name	: "LAST_REFRESH_TIME",
					align	: "center",
					search	: true,
					width	: "100%",
					sorttype	: "datetime",
	                formatter	: 'date',
					formatoptions: { srcformat: "Y/m/d h:i:s A", newformat: "Y-m-d h:i:s A" }
				},
				{
					name	: "DUMMY",
					align	: "center",
					formatter : Provider_Options,
					width	: "60%"
				},
				{
					name	: "DUMMY1",
					align	: "center",
					search	: true,
					hidden	: true
				}
			],
			pager		: "#Provider_Pager",
	        loadonce	: true,
	        shrinkToFit	: true,
	        rowNum		: 5,
	       	sortname	: "LAST_REFRESH_TIME",
	        sortorder	: "desc",
	        autoHeight	: true,
	        rowList		: [5, 10, 15],
	        sortable	: true,
	        viewrecords	: true,
	        toolbar		: [true, "top"],
	        autowidth	: true,
	        caption		: 'Web Feed Providers',
	        onSelectRow: function(rowId) { 
	        	var rowData 	=	jQuery(this).getRowData(rowId);
	        	Provider_Name 	=	rowData["PROVIDER_NAME"];
	        },
	       	loadComplete: function(data)
	        {
	        	// if ($('#Provider_Grid').getGridParam('records') === 0)
	        	// {
	        	// 	$("#Provider_Div").hide();
          //           $("#Provider_Grid").hide();
          //           $('#Provider_Pager').hide();
          //           $("#Provider_Message").show();
	        	// }
	        	// else
	        	// {
          //           $("#Provider_Message").hide();
          //           $("#Provider_Grid").show();
          //           $("#Provider_Pager").show();
          //           $('#Provider_Div').show();
          //       }
	        },

  		});

  		$("#Provider_Grid").jqGrid('filterToolbar', {
		    stringResult: true,
		    searchOnEnter: false,
		    defaultSearch: "cn"
		});
  	}

  	//Make the URL clickable from JQGIRD
    function Provider_URL(cellvalue, options, rowObject)
    {
    	return '<a target="_blank" href='+cellvalue+'>'+cellvalue+'</a>';
    }

  	//Reload the PROVIDERS JQGRID table on the Addition or Modification of Providers
    function Reload_Provider_Grid(){
        $("#Provider_Grid").jqGrid('setGridParam', {
            datatype: 'json'
        }).trigger('reloadGrid');

        var $Provider_Grid = $("#Provider_Grid");

        if ($Provider_Grid[0].ftoolbar) {
            $Provider_Grid[0].clearToolbar();
        }
    }

	// jQuery("#Provider_Grid").jqGrid('filterToolbar', {
	// 	    stringResult: true,
	// 	    searchOnEnter: false,
	// 	    defaultSearch: "cn"
	// });

    //Club Modify and Delete Button into a single Jqgrid Cell for the Provider
    function Provider_Options(cellvalue, options, rowObject) {
        return cellvalue + " " + rowObject.DUMMY1;
    }

    //Fetch the Provider Information for the Edit Modal
    $(document).on('click', '.edit_data', function() {
    	event.preventDefault();
   		if ($(this).val() != "Provider_Edit")
        	return;

    	var Provider_Id = $(this).attr("id");
    	$.ajax({
            url: "/Fetch_Provider_Details",
            type: "POST",
            data: {Provider_Id: Provider_Id},
            dataType: "json",
            success: function(data){
            	$("#Provider_Name_Edit").val(data[0].PROVIDER_NAME);
            	$("#Provider_URL_Edit").val(data[0].PROVIDER_URL);
            	$("#Provider_Id").val(data[0].PROVIDER_ID);
               	$('#Edit_Provider').modal('show');
            }
        });
    });

    //Insert the Edited Modal Information after Modal Insert
    $("#Edit_Provider").on("submit", function(event) {
    	event.preventDefault();
    	var New_Provider_Name = $("#Provider_Name_Edit").val();
    	var New_Provider_URL  = $("#Provider_URL_Edit").val();
    	$("#Provider_Div").hide();
  		$("#Loader_Logo1").show();
    	$.ajax({
    			url: 'https://api.rss2json.com/v1/api.json',
  				type: 'GET',
  				data: {
		            rss_url: New_Provider_URL,
		            api_key: 'pitn8kqc0wibx5jkgkdl9lbv4olgoc9jvbjimrpj', // put your api key here
		            // count: 2
        		},
 				dataType: 'jsonp',
  				success: function(result) {
  					//Call The Function to Updated the Existing Provider Information
  					$.ajax({
			            url: "/Provider_Edit_Insert",
			            type: "POST",
			            dataType: "json",
			            data: $('#Provider_Edit').serialize(),
			            success: function(data) {
			                if(data.status == 200)
			                {
			                	$("#Edit_Provider").modal("hide");
			                	$('#Provider_Edit')[0].reset();
			                	//Reload_Provider_Grid();
            					//clear_search();
			                	New_Provider_Data_Insert(New_Provider_Name,New_Provider_URL)
			                	alertify.alert("Updation success:","Provider information updated successfully.");	
			                }
			                else if(data.status == 303)
			                {
			                	$("#Edit_Provider").modal("show");
			                	$("#Loader_Logo1").hide();
            					$("#Provider_Div").show();
            					alertify.alert("Updation failure:","Provider URL or Name already exists \nPlease check and try again.");
            					
			                }
			            }
			        });
  				},
  				error: function(err)
  				{
  					$("#Edit_Provider").modal("show");
  					$("#Loader_Logo1").hide();
            		$("#Provider_Div").show();	
            		alertify.alert("Incorrect web feed URL:","Seems like you have provided invalid web feed URL \nPlease check and try again.");
  				}
		});
    });


    //DELETE THE PROVIDER FROM THE PROVIDER TABLE
    $(document).on('click', '.edit_data', function() {
    	event.preventDefault();
   		if ($(this).val() != "Provider_Delete")
        	return;
        var Provider_Id = $(this).attr("id");
        alertify.confirm("Delete Provider:",'Do you wish to delete the provider <b>'+Provider_Name+'</b>? <br/><b>Note :</b> All Data from this Provider will also be deleted.',function(){ 
        	$.ajax({
	            url: "/Delete_Provider",
	            type: "POST",
	            data: {Provider_Id: Provider_Id},
	            dataType: "json",
	            success: function(data){
					if(data.status == 200)
	                {
	                	alertify.alert("Deletion Success:","Provider information deleted successfully.");	
	                	Reload_Provider_Grid();
	                	clear_search();

	                }
	                else if(data.status == 303)
	                {
	                	alertify.alert("Deletion Failure","Provider information could not be Deleted.");	
	                }
	            }
	        });
        },function(){ 
        	alertify.alert("Deletion Aborted","You have cancelled your action.");
        });
    });


});