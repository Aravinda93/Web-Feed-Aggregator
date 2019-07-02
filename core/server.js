const	http 			=	require("http");
const 	settings		=	require("../settings");
const 	webFeedDump		=	require("../controller/webFeedDump");
const 	webFeedRetrieve	=	require("../controller/webFeedRetrieve");
const	webFeedExport	=	require("../controller/webFeedExport");
const	webFeedDelete	=	require("../controller/webFeedDelete");
const	webFeedProviders=	require("../controller/webFeedProviders");
const 	express 		= 	require('express');
const	port			= 	9000;
const   bodyParser 		= 	require('body-parser');

//To get the HTML page
const 	basePath 		= 	__dirname;
const 	path 			= 	require('path');
const 	reqPath 		= 	path.join(__dirname, '../');
const 	fs				=	require('fs');
const 	app 			= 	express();

app.set('views', reqPath + "/public/views");
app.engine('html', require('ejs').renderFile);
app.set('view engine', 'html');
app.use(express.static(path.join(reqPath, '/public/views')));
app.use(bodyParser.json()); 
app.use(bodyParser.urlencoded({ extended: true }));

//Display the Index page when user hits the URL in browser
app.get('/', function(req,res){
	res.render('index.html');
});

//Refresh the Database with fresh data onclick of the REFRESH button
app.post('/Refresh_Data', function(req,res){
	var Time_Interval = req.body.Refresh_Time;
	var User_Delete_End_Date = req.body.User_Delete_End_Date;
	webFeedDump.dumpdata(Time_Interval,User_Delete_End_Date,function(data){
		res.end(data);
	});
});

//Display the data in JQGRID on page load
app.get('/Web_Feed_Data', function(req,res){
	webFeedRetrieve.Web_Feed_Data(function(data){
		res.send(data);
	});
});

//Onclick of the Export button Export the Data into Excel
app.get('/Export_Movie_Data', function(req,res){
	webFeedExport.Export_Movie_Data(req,res);
});

//Delete the Data from DB as per the Date provided by the user
app.delete('/Delete_Data', function(req,res){
	var Start_Date 	= req.body.Start_Date;
    var End_Date 	= req.body.End_Date;
    webFeedDelete.deletedata(Start_Date,End_Date,function(data){
    	res.send(data);
    });
});

//Get the Last refresh time of the Database
app.get('/Last_Refresh_Time',function(req,res){
	webFeedDump.Last_Refresh_Time(function(data){
		res.send(data);
	});
});

//On Load Delete records from the Replica Table so that only original RSS data is displayed
// app.delete('/DELETE_REPLICA_TABLE_DATA',function(req,res){
//     webFeedDelete.Delte_Replica_Table(function(data){
//     	res.send(data);
//     });
// });

//Refresh the Data of the table based on time interver provided by user
app.post('/Refresh_Data_Time_Interval',function(req,res){
	var Time_Interval = req.body.Refresh_Time;
	var User_Delete_End_Date = req.body.User_Delete_End_Date;
	webFeedDump.dumpdata(Time_Interval,User_Delete_End_Date,function(data){
		res.send(data);
	});
});

//Get the Provider Information for the Providers JQGRID
app.get("/Provider_Info",function(req,res){
	webFeedProviders.Provider_Table_Load(function(data){
		res.send(data);
	});
});

//Add the items data (Title, Provider, URL) of new URL to Database
app.post('/ADD_NEW_URL', function(req,res){
	var Provider_Name 	= 	req.body.Provider_Name;
	var Provider_URL	=	req.body.Provider_URL;
	webFeedProviders.New_Provider_Info(Provider_Name,Provider_URL,function(data){
		res.send(data);
	});
});

//After the Addition of the New Provider Read the Data and Insert into the DB
app.post("/New_Provider_Data_Insert",function(req,res){
	var User_Delete_End_Date = req.body.User_Delete_End_Date;
	webFeedDump.New_Provider_Data_Insert(User_Delete_End_Date,function(data){
		res.send(data);
	});
});

//Fetch the Provider Details for the Modifications
app.post("/Fetch_Provider_Details",function(req,res){
	var Provider_Id	= req.body.Provider_Id;
	webFeedProviders.Provider_Details_Fetch(Provider_Id,function(data){
		res.send(data);
	});
});

//Insert the Edited Information of the Provider
app.post("/Provider_Edit_Insert",function(req,res){
	webFeedProviders.Provider_Edit_Insert(req.body,function(data){
		res.send(data);
	});
});

//Delete the Provider From the table and its related Information
app.post("/Delete_Provider",function(req,res){
	var Provider_Id	= req.body.Provider_Id;
	webFeedProviders.Delete_Provider(Provider_Id,function(data){
		res.send(data);
	});
});

//Onclick of the Export RSS button Export the Data into RSS
app.get('/Export_RSS', function(req,res){
	webFeedExport.Export_Movie_Data_RSS(req,res);
});


//Make NodeJS to Listen to a particular Port in Localhost
app.listen(port, function(){
	console.log(`Web Feed aggregator running at: ${port}!`)
});
// app.listen(9000, '0.0.0.0', function() {
//     console.log('Listening to port:  ' + 3000);
// });

