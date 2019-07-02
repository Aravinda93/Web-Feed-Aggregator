var 	sqlDb 		=	require('mssql');
var 	settings	=	require('../settings');

//Run normal execute querY
exports.executeSql	=	function(sql, callback){
	var 	conn 	=	new sqlDb.ConnectionPool(settings.dbConfig);
	conn.connect().then(function(){
		//console.log("Connection Successful for Dumping the Data");
		var req 	=	new sqlDb.Request(conn);
		req.query(sql).then(function(recordset){
			callback(recordset);
		}).catch(function(err){
			//console.log("**** Query Execution Failed ****");
			//console.log(err);
			callback(null, err);
		});
	}).catch(function(err){
		console.log("**** Connection Failed ****");
		console.log(err);
		callback(null, err);
	});
};

exports.executeSql_SP	= function(SP_Name, callback){

	var 	conn 	= new sqlDb.ConnectionPool(settings.dbConfig);
	conn.connect().then(function(conn){
		var request = new sqlDb.Request(conn);
		request.output('LAST_REFRESH_TIME',sqlDb.Datetime);
		request.output('CURRENT_TIME', sqlDb.DATETIME);
		request.execute(SP_Name).then(function(recordsets, err, returnValue, affected) {
			callback(recordsets.recordset[0]);
		}).catch(function(err) {
      		console.log(err);
    	});
	});
};

//Database Execute function to delete the rows based on provided date range
exports.executeSql_SP_Delete	=	function(SP_Name,Start_Date,End_Date,callback){
	var 	conn 	= new sqlDb.ConnectionPool(settings.dbConfig);
	conn.connect().then(function(conn){
		var request = new sqlDb.Request(conn);
		request.input('Start_Time',Start_Date);
		request.input('End_Time',End_Date);
		request.output('Return',sqlDb.INT);
		request.output('COUNT',sqlDb.INT);
		request.execute(SP_Name).then(function(recordsets, err, returnValue, affected) {
			var Return_Val = {"Return":recordsets.recordset[0].Return_Value, "Count":recordsets.recordset[0].Total};
			callback(Return_Val);
		}).catch(function(err) {
      		console.log(err);
    	});
	});
};

//Stored Procedure Execution for the Insertion of Providers
exports.Execute_SP_Insert_Provider	=	function(SP_Name,Provider_Name,Provider_URL,callback){
	var 	conn 	= new sqlDb.ConnectionPool(settings.dbConfig);
	conn.connect().then(function(conn){
		var request = new sqlDb.Request(conn);
		request.input('Provider_Name',Provider_Name);
		request.input('Provider_URL',Provider_URL);
		request.output('RETURN',sqlDb.INT);
		request.execute(SP_Name).then(function(recordsets, err, returnValue, affected) {
			var Return_Val = {"Return":recordsets.recordset[0].RETURN_VAL};
			callback(Return_Val);
		}).catch(function(err) {
      		console.log("Something Went Wrong during the Stored Procedure Exection: "+SP_Name+" "+err);
    	});
	});
};

//Update the Edited Provider Information in the DB
exports.Provider_Edit_Insert	=	function(SP_Name,req,callback){
	var Provider_Name	= req.Provider_Name_Edit;
	var Provider_URL	= req.Provider_URL_Edit;
	var Provider_Id		= req.Provider_Id;
	console.log(Provider_Id);
	var 	conn 		= new sqlDb.ConnectionPool(settings.dbConfig);
	conn.connect().then(function(conn){
		var request 	= new sqlDb.Request(conn);
		request.input('Provider_Name',Provider_Name);
		request.input('Provider_URL',Provider_URL);
		request.input('Provider_Id',Provider_Id);
		request.output('RETURN',sqlDb.INT);
		request.execute(SP_Name).then(function(recordsets, err, returnValue, affected) {
			var Return_Val = {"Return":recordsets.recordset[0].RETURN_VAL};
			callback(Return_Val);
		}).catch(function(err) {
      		console.log("Something Went Wrong during the Stored Procedure Exection: "+SP_Name+" "+err);
    	});
	});
}

//Delete the Provider Information when User Clicks on the Delete Button for the respective Provider
exports.Delete_Provider	=	function(SP_Name,Provider_Id,callback){
	var 	conn 		= new sqlDb.ConnectionPool(settings.dbConfig);
	conn.connect().then(function(conn){
		var request 	= new sqlDb.Request(conn);
		request.input('Provider_Id',Provider_Id);
		request.output('RETURN',sqlDb.INT);
		request.execute(SP_Name).then(function(recordsets, err, returnValue, affected) {
			var Return_Val = {"Return":recordsets.recordset[0].RETURN_VAL};
			callback(Return_Val);
		}).catch(function(err) {
      		console.log("Something Went Wrong during the Stored Procedure Exection: "+SP_Name+" "+err);
    	});
	});
}

//Update the Fetch_Coutn and the Refresh time for each provider
// THIS FUNCTION CAN ALSO RUN ANY STORED PROCEDURE WITHOUT THE PARAMETER
exports.Run_Stored_Proc	=	function(SP_Name,callback){
	var 	conn 		= new sqlDb.ConnectionPool(settings.dbConfig);
	conn.connect().then(function(conn){
		var request 	= new sqlDb.Request(conn);
		request.execute(SP_Name).then(function(recordsets, err, returnValue, affected) {
			callback(recordsets.returnValue)
		}).catch(function(err) {
      		console.log("Something Went Wrong during the Stored Procedure Exection: "+SP_Name+" "+err);
    	});
	});
}