const 	db 		=	require("../core/db");
var 	fs 		= 	require('fs');
var		csv		=	require('fast-csv');	
const 	path 	= 	require('path');
const 	reqPath = 	path.join(__dirname, '../');
const 	Feed 	= 	require('feed').Feed;
var 	orm     = 	require('orm');


//Get Data from the table which needs to be exported
exports.Export_Movie_Data 	=	function(req,res){
	var columnHeader		=	"MOVIE_ID,PROVIDER,TITLE,PUBLISH TIME,DB ENTRY TIME,URL \n";
	var Web_Feed_File		= 	"WebFeed_Movie_Data.csv";
	var sql					=	" SELECT * FROM TBL_WEB_FEED WHERE ACTIVE_IND = 1 ORDER BY PUBLISH_TIME DESC ";
	db.executeSql(sql, function(data, err){
		if(err)
		{
			console.log(err);
		}
		else
		{
			var itemsProcessed	=	1;
			var csv_data		=	"";
			fs.writeFile(Web_Feed_File,columnHeader,(err)=>{
				if (err)
			    {
			    	console.log("Error While Adding the CSV Header");
			        console.log(err);
			    }
			    else
			    {
					data.recordset.forEach((item, index, array) => {
						data.recordset[index].TITLE 	 	= data.recordset[index].TITLE.replace(/,/g, '');
						//data.recordset[index].URL		 	= data.recordset[index].URL.replace(/,/g, '');

						csv_data = csv_data	 + itemsProcessed + "," + data.recordset[index].PROVIDER + "," + data.recordset[index].TITLE + "," + data.recordset[index].PUBLISH_TIME + "," + data.recordset[index].DB_ENTRY_TIME + "," + data.recordset[index].URL + "\n";
						
						itemsProcessed++;
						if(itemsProcessed-1 === data.recordset.length)
						{
							fs.appendFile(Web_Feed_File,csv_data, (err) => {
								if (err)
							    {
							    	console.log("Error While Creating and Downloading the File");
							        console.log(err);
							    }
							    else
							    {
							    	const FilePath = reqPath+'\WebFeed_Movie_Data.csv';
				        			res.download(FilePath);
							    }
							});
				      	}
					});
			    }
			});
		}
	});
};

exports.Export_Movie_Data_RSS 	=	function(req,res){
	var sql					=	" SELECT * FROM TBL_WEB_FEED WHERE ACTIVE_IND = 1 ORDER BY PUBLISH_TIME DESC ";
	db.executeSql(sql, function(data, err){
		if(err)
		{
			console.log(err);
		}
		else
		{
			var Web_Feed_File_RSS		= 	"Web_Feed_RSS.xml";
			let feed = new Feed({
			  title: 'Movie Web Feed Aggregator',
			  description: 'Web Feed Data from Various Movie News Sources',
			  author: {
			    name: 'BA$VB',
			    link: 'localhost:9000'
			  }
			});

			var itemsProcessed	=	0;

			data.recordset.forEach((item, index, array) => {
				var title		=	data.recordset[index].TITLE;
				var provider	=	data.recordset[index].PROVIDER;
				var pub_date	=	data.recordset[index].PUBLISH_TIME;
				var db_date		=	data.recordset[index].DB_ENTRY_TIME;
				var url			=	data.recordset[index].URL;
				//pub_date		=	pub_date.toISOString().replace('Z', ' ').replace('T', ' ');
				//db_date			=	db_date.toISOString().replace('Z', ' ').replace('T', ' ');
				
				feed.addItem({
	              title: title,
	              link:url,
	              pubDate:pub_date,
	              date:pub_date,
	              description: "Movie News",
	              author: [{
	                name: 'BA$VB',
	                email: 'BA$VB',
	                link: 'localhost:9000'
	              }]
	            });
				itemsProcessed++;

				if(itemsProcessed === data.recordset.length)
				{

					var rssdoc = feed.rss2();
					fs.writeFile(Web_Feed_File_RSS,rssdoc,function(err){
						if(err)
						{
							console.log(err);
						}
						else
						{
							const FilePath = reqPath+'\Web_Feed_RSS.xml';
				        	res.download(FilePath);
						}
					});
		      	}

			});
		}
	});
};