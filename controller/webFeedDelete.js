const 	db 			=	require("../core/db");

exports.deletedata	=	function(Start_Date,End_Date,callback){

	var SP_Name		=	"DELETE_DATA";
	db.executeSql_SP_Delete(SP_Name,Start_Date,End_Date,function(data,err){
		if(err)
		{
			console.log(err);
		}
		else
		{
			if(data.Return == 1)
			{
				//Call the function which can store the new Count data in the WEB_FEED_PROVIDERS table
				var Delete_Count = data.Count;
				Populate_Providers_Count(function(data){
					callback({"Status":200,"Count":Delete_Count});
				});
				
			}
			else
			{
				callback({"Status":303});
			}
		}
	});
};

exports.Delte_Replica_Table	=	function(callback){
	var sql		=	" TRUNCATE TABLE TBL_WEB_FEED_REPLICA ";
		db.executeSql(sql, function(data, err){
		if(err)
		{
			console.log(err);
		}
		else
		{
			callback('{"success" : "Replica Table Truncated", "status" : 200}');
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