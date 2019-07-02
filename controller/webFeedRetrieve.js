const 	db 			=	require("../core/db");

//Get all the WebFeed data from the table
exports.Web_Feed_Data 	=	function(callback){
	db.executeSql(" SELECT * FROM TBL_WEB_FEED WHERE ACTIVE_IND = 1 ORDER BY DB_ENTRY_TIME DESC ", function(data, err){
		if(err)
		{
			console.log(err);
		}
		else
		{
			var jsonArr 		= [];
			var itemsProcessed 	= 0;
			if(data.recordset.length > 0)
			{
				data.recordset.forEach((item, index, array) => {
					jsonArr.push({
						ID 				: data.recordset[index].ID,
						TITLE 			: data.recordset[index].TITLE,
						PUBLISH_TIME	: data.recordset[index].PUBLISH_TIME,
						DB_ENTRY_TIME	: data.recordset[index].DB_ENTRY_TIME,
						URL				: data.recordset[index].URL,
						PROVIDER		: data.recordset[index].PROVIDER
					});
					itemsProcessed++;
					if(itemsProcessed === array.length)
					{
	      				callback(jsonArr);
	      			}
				});
			}
			else
			{
				jsonArr.push({});
				callback(jsonArr);
			}
		}
	});
};