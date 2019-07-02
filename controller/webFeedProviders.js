const 	db 			=	require("../core/db");

//Get all the  Provider Information and Load the table
exports.Provider_Table_Load	=	function(callback){
	var 	sql		=	" SELECT PROVIDER_ID,PROVIDER_NAME, PROVIDER_URL, ACTIVITY_DT_TM, PROVIDER_ID AS DUMMY, PROVIDER_ID AS DUMMY1, FEED_COUNT,LAST_REFRESH_TIME  FROM WEB_FEED_PROVIDERS ORDER BY ACTIVITY_DT_TM DESC ";
	
	db.executeSql(sql, function(data, err){
		if(err){
			console.log(err);
		}
		else
		{
			var jsonArr 		= [];
			var itemsProcessed 	= 0;
			data.recordset.forEach((item, index, array) => {
				jsonArr.push({
					PROVIDER_ID 		: data.recordset[index].PROVIDER_ID,
					PROVIDER_NAME 		: data.recordset[index].PROVIDER_NAME,
					PROVIDER_URL 		: data.recordset[index].PROVIDER_URL,
					ACTIVITY_DT_TM 		: data.recordset[index].ACTIVITY_DT_TM,
					LAST_REFRESH_TIME	: data.recordset[index].LAST_REFRESH_TIME,
					FEED_COUNT			: data.recordset[index].FEED_COUNT,
					DUMMY				: '<button title="Edit Provider" type="button" value="Provider_Edit" name="DUMMY" class="btn btn-info btn-xs edit_data" id="' + data.recordset[index].DUMMY + '"><span class="fa fa-pencil-square-o fa-xs" aria-hidden="true"></span></button>',
					DUMMY1				: '<button title="Delete Provider" type="button" value="Provider_Delete" name="DUMMY1" class="btn btn-warning btn-xs edit_data" id="' + data.recordset[index].DUMMY1 + '"><span class="fa fa-trash-o fa-xs" aria-hidden="true"></span></button>' 
				});
				itemsProcessed++;
				if(itemsProcessed === array.length)
				{
	      			callback(jsonArr)
	      		}
			});
		}
	});
}

//Fetch the Provider Details during the Edit
exports.Provider_Details_Fetch	=	function(Provider_Id,callback){
	var 	sql		=	" SELECT * FROM WEB_FEED_PROVIDERS WHERE PROVIDER_ID =  "+Provider_Id;
	db.executeSql(sql, function(data, err){
		if(err){
			console.log(err);
		}
		else
		{
			var Provider_Array 		= [];
			var itemsProcessed 		= 0;
			Provider_Array.push({
				PROVIDER_ID 	: data.recordset[0].PROVIDER_ID,
				PROVIDER_NAME 	: data.recordset[0].PROVIDER_NAME,
				PROVIDER_URL 	: data.recordset[0].PROVIDER_URL,
				ACTIVITY_DT_TM 	: data.recordset[0].ACTIVITY_DT_TM,
			});
      		
      		callback(Provider_Array)
		}
	});
}

//Updated the Edited Provider Details in the DB
exports.Provider_Edit_Insert	=	function(req,callback){
	var SP_Name		=	"PROVIDER_EDIT_INSERT";
	db.Provider_Edit_Insert(SP_Name,req, function(data, err){
		if(err)
		{
			console.log(err);
		}
		else
		{
			if(data.Return === 0)
			{
				callback('{"Failure" : "Could not Update Provider Information as already exists", "status" : 303}');
			}
			if(data.Return === 1)
			{
				callback('{"success" : "Provider Information Updated", "status" : 200}');
			}
		}
	});
}

//Delete the Provider Information when User Clicks on the Delete Button for the respective Provider
exports.Delete_Provider	=	function(Provider_Id,callback){
	var SP_Name		=	"PROVIDER_DELETE";
	db.Delete_Provider(SP_Name,Provider_Id, function(data, err){
		if(err)
		{
			console.log(err);
		}
		else
		{
			if(data.Return === 0)
			{
				callback('{"Failure" : "Could not Delete Provider", "status" : 303}');
			}
			if(data.Return === 1)
			{
				callback('{"success" : "Provider Deleted", "status" : 200}');
			}
		}
	});
}

// ADD NEW PROVIDER INFORMATION INTO THE PROVIDERS TABLE
exports.New_Provider_Info	=	function(Provider_Name,Provider_URL,callback){
	var SP_Name		=	"Insert_New_Provider";
	db.Execute_SP_Insert_Provider(SP_Name,Provider_Name,Provider_URL, function(data, err)
	{
		if(err)
		{
			console.log("Something went wrong during execution of Providers Insertion"+err)
		}
		if(data)
		{
			if(data.Return === 1)
			{
				//Call the function which can store the new Count data in the WEB_FEED_PROVIDERS table
				Populate_Providers_Count(function(data){
					callback('{"success" : "New Provider Added", "status" : 200}');
				});
			}
			else
			{
				callback('{"failure" : "New Provider Could Not be Added", "status" : 303}');
			}
		}
	});

}

//Function Which will calculate the news entry for each provider and store in PROVIDERS table
function Populate_Providers_Count(callback)
{
	var SP_Name	=	"PROVIDER_COUNT_REFRESH_TIME";
	db.Run_Stored_Proc(SP_Name, function(data, err){
		if(err){
			console.log(err);
		}
		else
		{
			callback();
		}
	});

}
