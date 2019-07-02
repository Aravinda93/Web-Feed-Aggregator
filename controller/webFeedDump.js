const 	db 			=	require("../core/db");
let 	Parser 		= 	require('rss-parser');
var 	util		=	require("util");
let 	parser		= 	new Parser();
var 	response;
var		Movie_Data	=	[];

//Get the time of the Last DB Refresh
exports.Last_Refresh_Time	=	function(callback){

	var 	sql		=	" SELECT TOP 1 * FROM TBL_WEB_FEED_REFRESH ORDER BY REFRESH_TIME DESC ";

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
					TIME 	: data.recordset[index].REFRESH_TIME
				});
				itemsProcessed++;
				if(itemsProcessed === array.length)
				{
	      			callback(jsonArr)
	      		}
			});
		}
	});
};

//Get the value from the various Web Feeds and dump into the DB
exports.dumpdata	=	function(Time_Interval,User_Delete_End_Date,callback){
	Check_Last_Feed_Time(Time_Interval,User_Delete_End_Date,function(data){
		if(data.data === 0)
		{
			callback('{"success" : "Could not Update the DB", "status" : 303, "time":'+data.time+'}');
		}
		if(data.data === 1)
		{
			callback('{"success" : "New Data has been inserted", "status" : 200, "Count":'+data.count+'}');
		}
	});
};

function Check_Last_Feed_Time(Time_Interval,User_Delete_End_Date,callback)
{
	var SP_Name		=	"WEB_DATA_REFRESH_TIME";
	db.executeSql_SP(SP_Name, function(data, err){
		if(err)
		{
			console.log(err);
		}
		else
		{
			//If dummy then refresh based on the button for everyy 10 min 
			if(Time_Interval == 'dummy')
			{
				//Do  not allow the refresh if the time is less than 10 min
				if(data.TIME_DIFFERENCE > 10)
				{
					console.log("\n Updating the DB with the values from RSS \n");
					Get_RSS_URL_List(User_Delete_End_Date,function(data){
						callback(data);
					});
				}
				else
				{
					console.log("Cannot Update the DB because last update was within 10 mins");
					response = 0;
					var return_val = {data:response, time:data.TIME_DIFFERENCE}
					callback(return_val);			
				}
			}
			else
			{
				//Refresh the data for every time interval
				Get_RSS_URL_List(User_Delete_End_Date,function(data){
					callback(data);
				});
			}
		}
	});
}

//Populate the array Movie_Data from various RSS Feeds
function Get_RSS_URL_List(User_Delete_End_Date,callback)
{
	var	RSS				=	[];
	var Item_Processed	=	0;
	var 	sql			=	" SELECT PROVIDER_NAME, PROVIDER_URL FROM WEB_FEED_PROVIDERS ";
	db.executeSql(sql, function(data, err){
		if(err){
			console.log(err);
		}
		else
		{
			data.recordset.forEach((item, index, array) => {
				RSS.push({"Provider":data.recordset[index].PROVIDER_NAME,"RSS":data.recordset[index].PROVIDER_URL});
				Item_Processed++;
				if(Item_Processed == array.length){
					Read_RSS_Data(RSS,User_Delete_End_Date,function(data){
						callback(data)
					});
				}
			});
		}
	});
}

function Read_RSS_Data(RSS,User_Delete_End_Date,callback)
{
	var Item_Processed 	= 	0;
	RSS.forEach(function(rss){	
		var Provider	=	rss.Provider;
		let URL_feed	= 	parser.parseURL(rss.RSS, function(err,data){

			data.items.forEach(function(entry){
				var date1 	 	= new Date(entry.pubDate);
				var Pub_Date 	= date1.toISOString().replace('Z', ' ').replace('T', ' ');
				var date		= new Date();
				date.setDate(date.getDate()-30);
				var today_date 	= date.toISOString().replace('Z', ' ').replace('T', ' ');

				if(User_Delete_End_Date != "")
				{
					if(Pub_Date > User_Delete_End_Date && Pub_Date>today_date)
					{
						Movie_Data.push({"Title" : entry.title, "Link" : entry.link, "Publish_Date" : Pub_Date, "Provider" : Provider});
					}	
				}
				else
				{
					if(Pub_Date>today_date)
					{
						Movie_Data.push({"Title" : entry.title, "Link" : entry.link, "Publish_Date" : Pub_Date, "Provider" : Provider});	
					}	
				}
					
			});
			Item_Processed++;
			if(Item_Processed == RSS.length)
			{
					//Get the Count of the Previous Records
					Old_Record_Count(function(old_count){
						DB_Populator(function(data){
							Old_Record_Count(function(new_count){
								var Final_Count = new_count - old_count;
								var return_val = {data:response, count:Final_Count};
								callback(return_val);
							});
						});
					});
			}
		});
	});

}

//Once we have read the data from all the RSS then we call below function to populate in the db.
function DB_Populator(callback)
{
	console.log("Size of the Movie_Data : " + Movie_Data.length);
	
	var sql		=	" INSERT INTO TBL_WEB_FEED (TITLE, URL, PUBLISH_TIME, PROVIDER) VALUES ";
	for(i = 0; i < Movie_Data.length; i++)
	{
		Movie_Data[i].Title 			= 	Movie_Data[i].Title.replace(/['.?*&+^$[\]\\(){}|-]/g, " ").trim();
		Movie_Data[i].Provider 			= 	Movie_Data[i].Provider.replace(/[:'?*&+^$[\]\\(){}]/g, " ").trim();
		//Movie_Data[i].Title 			= 	Movie_Data[i].Title.replace("'", "''",'g');
		//Movie_Data[i].Provider 		= 	Movie_Data[i].Provider.replace(/[^A-Za-z0-9\+\-\_]+/g, " ");
		//Movie_Data[i].Publish_Date 	=	Movie_Data[i].Publish_Date.replace(/[^A-Za-z0-9\+\-\_]+/g, " ");
		// Movie_Data[i].Link 			=	Movie_Data[i].Link.replace(/[^A-Za-z0-9\+\-\_]+/g, " ");
		sql	 +=	util.format("('%s', '%s', '%s', '%s')", Movie_Data[i].Title, Movie_Data[i].Link, Movie_Data[i].Publish_Date,Movie_Data[i].Provider)+',';
	}

	sql 		= 	sql.slice(0, sql.length-1);
	db.executeSql(sql, function(data, err){
		if(err){
			console.log(err);
		}
		else{
			Movie_Data	=	[];
			var sql_refresh 	=	" INSERT INTO TBL_WEB_FEED_REFRESH(REFRESH_TIME) VALUES(GETDATE()) ";
			db.executeSql(sql_refresh, function(data, err){
				if(err){
					console.log(err);
				}
				else{
					console.log("\n New Data has been inserted into the Database");
					response = 1;
					//var return_val = {data:response}
					//Call the function which can store the new Count data in the WEB_FEED_PROVIDERS table
					Populate_Providers_Count(function(data){
						callback(response);
					});
						

				}
			});
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

//Function to get the count of Old Records before the Insert.
function Old_Record_Count(callback)
{
	var sql	=	" SELECT COUNT(*) AS COUNT FROM TBL_WEB_FEED ";
	db.executeSql(sql, function(data, err){
		if(err){
			console.log(err);
		}
		else
		{
			callback(data.recordset[0].COUNT);
		}
	});

	var sql	=	"  UPDATE TBL_WEB_FEED SET VOTE = 0 ";
	db.executeSql(sql, function(data, err){
		if(err){
			console.log(err);
		}
		else
		{
			console.log("VOTE COLUMN HAS BEEN UPDATED TO 0")
		}
	});
}

//After the Addition of the New Provider Read the Data and Insert into the DB
exports.New_Provider_Data_Insert	=	function(User_Delete_End_Date,callback){
	Get_RSS_URL_List(User_Delete_End_Date,function(data){
		if(data.data === 0)
		{
			callback('{"failure" : "New Provider Feed Data Could not be Inserted Into the DB", "status" : 303}');
		}
		if(data.data === 1)
		{
			callback('{"success" : "New Provider Feed Data has been Inserted Into the DB", "status" : 200}');
		}
	});
}
	
