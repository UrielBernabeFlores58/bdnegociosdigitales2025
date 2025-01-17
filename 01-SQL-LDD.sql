-- Creacion de base de datos en sql server
-- En Construccion


docker run -e "ACCEPT_EULA=Y" `
-e "MSSQL_SA_PASSWORD=123456" `
   -p 1435:1433 --name sqlserver `
   -d `
   mcr.microsoft.com/mssql/server:2022-latest