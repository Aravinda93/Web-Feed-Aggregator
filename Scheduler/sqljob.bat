sqlcmd -S Server_Name -U sa -P mypass -d Data_And_Web_SS19 -Q " EXEC DELETE_OLD_RECORDS "

echo Data Older Than 30 are deleted from the table

pause
