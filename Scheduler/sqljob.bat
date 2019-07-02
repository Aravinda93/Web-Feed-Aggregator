sqlcmd -S BVBALIGA\SQLExpress -U sa -P Fifa@2014 -d Data_And_Web_SS19 -Q " EXEC DELETE_OLD_RECORDS "

echo Data Older Than 30 are deleted from the table

pause