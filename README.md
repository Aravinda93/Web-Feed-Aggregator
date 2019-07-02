# Web-Feed-Aggregator
Web Feed Aggregator
As the name indicates, the application web feed aggregator combines the web feed data from various providers and display’s in common structured format to the user. This particular application combines the movie news data from various web feed URLs and stores them in the database, then these data are pulled from the database and displayed to you.
Following are the software/application which is required for running this application:
	MS SQL Server
	Node.js

MS SQL Server: 
I have used the Relational Database Management System (RDBMS) for storing the web feed data in this application. Make sure you have installed the MS SQL Server management studio. Once the SQL Server Management Studio is available in the system, just copy paste the contents of the file Data_And_Web_SS19.sql present in the application folder SQL Server Database Schema and just execute them. This file contains all the table structure, stored procedure, and data which are used by the application. Once you have the database ready, open the settings.js  file present in the application and enter the MS SQL Server database credentials so that application can access the database and the related data.

Node.jS:
Once we have the database ready with required data, we need Server Side language to pull this data. Open the URL https://nodejs.org/en/ in your favorite browser and download the latest version Node.js LTS file based on your operating system. Follow the easy steps of installation to get the Node.js in your local system.

Running the application:
Since most of the other required elements are included in the application itself, you do not need anything else. Once we have the required database and Node.js, we are good to start the application. Open the command prompt and navigate to the folder where the application is present. Inside the application run the command nodemon app.js. App.js is the root file which will start the server and trigger the application. This application by default runs on the port 9000 which is normally not assigned to any of the application. If the port is used by any other application and if you receive the error or run into any other issue then open the file settings.js  and change the port number which is assigned to the variable exports.webPort. Now again try to run the command nodemon app.js, the command prompt will display a success message indicating the web feed aggregator is running at 9000!. If you want to run this application in other devices as well then open another command prompt and run the command lt –port 9000, this will provide you another URL which you can use to access the application from any of the other devices.
After the server is up and running, navigate to the URL localhost:9000 (change the port number accordingly if you have changed in the settings.js file).

Table:
The table provides essential information related to the web feed data such as Title, Provider, Published Date, Fetch date. The URL is embedded to the Title so if you want to read more about any particular news then click on the Title which will take you to the Providers page where you can read more about the same. You can filter for any of the providers and get only the news data from those providers.

Refresh Web Feed Data:
If you want to refresh the web feed data with new information then click on the Refresh button present on top of the table which will read the new data from the providers and write into the database. If any duplicate data is found then it will not be written into the database. Also, web feed data which are older than 30 days will not be written into the database. Once the refresh has been done then the refresh button will be inactive for the next 10 mins. You can see the last refresh time next to the Refresh button. 
Delete Web Feed Data:
If you want to delete any of the data then you can make use of the Delete Old Records feature which will delete the web feed data from all the providers whose published date lies between the provided Start date and End date.

Automatic Refresh Web Feed Data:
You can set the time interval for the automatic refresh of the web feed data. If the time has been set then after every particular set time the web feed data will be refreshed and if any new data is found then it will be written into the database and table will be refreshed automatically to reflect the changes.

Export Data:
You can export the Web Feed data present in this application into human readable Excel format or machine-readable RSS format. To make use of this functionality you can click on the respective button present on the bottom-left of the table, which will read all the data and create Excel file or RSS file depending on your choice.

Web Feed Providers:
You can view the provider information from whom you are receiving the web feed data in the Providers view, which will show the information such as Provider Name, URL, number of new feeds found during the last refresh and date time of the last refresh.

Provider addition, modification, and deletion:
If you are interested in receiving information from the new web feed URL
(provider) which is in either RSS or ATOM format then you can add them to the
application using the add provider feature present above the provider table. If you want to modify the provider information then click on the modify button present against each of the providers and update the information of the provider accordingly. If you are not interested in receiving the data from any of the existing providers then you can remove the provider by clicking on the delete button present against the particular provider. If the provider is deleted then the respective provider's web data will also be deleted permanently from the database. Later this provider can be added to receive the web feed data again. If the new provider is added then automatically the data from the provider is read and it will be inserted into the database.



