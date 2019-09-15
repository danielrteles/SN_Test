/*
Post-Deployment Script Template                            
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.        
 Use SQLCMD syntax to include a file in the post-deployment script.            
 Example:      :r .\myfile.sql                                
 Use SQLCMD syntax to reference a variable in the post-deployment script.        
 Example:      :setvar TableName MyTable                            
               SELECT * FROM [$(TableName)]                    
--------------------------------------------------------------------------------------
*/
DELETE FROM config.CityFiles
DELETE FROM config.DataProviders
DELETE FROM config.Cities

SET IDENTITY_INSERT config.Cities ON
GO
INSERT INTO config.Cities (CityId, CityName, CountryName)
VALUES  (1, 'Oxford', 'United Kingdom')
,       (2, 'Cambridge', 'United Kingdom')
,       (3, 'Bradford', 'United Kingdom')
,       (4, 'Southampton', 'United Kingdom')
,       (5, 'Chivenor', 'United Kingdom')
GO
SET IDENTITY_INSERT config.Cities OFF
GO

SET IDENTITY_INSERT config.DataProviders ON
GO
INSERT INTO config.DataProviders (ProviderId, ProviderName)
VALUES  (1, 'MetOffice')
,       (2, 'OpenWeather_Current')
,       (3, 'OpenWeather_Forecast')
GO
SET IDENTITY_INSERT config.DataProviders OFF
GO

INSERT INTO config.CityFiles
VALUES  (1, 1, 'http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/oxforddata.txt')
,       (2, 1, 'http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/cambridgedata.txt')
,       (3, 1, 'http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/bradforddata.txt')
,       (4, 1, 'http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/southamptondata.txt')
,       (5, 1, 'http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/chivenordata.txt')
,       (1, 2, 'https://api.openweathermap.org/data/2.5/weather?id=2640729')
,       (2, 2, 'https://api.openweathermap.org/data/2.5/weather?id=2653941')
,       (3, 2, 'https://api.openweathermap.org/data/2.5/weather?id=2654993')
,       (4, 2, 'https://api.openweathermap.org/data/2.5/weather?id=2637487')
,       (5, 2, 'https://api.openweathermap.org/data/2.5/weather?id=2656281')
,       (1, 3, 'https://api.openweathermap.org/data/2.5/forecast?id=2640729')
,       (2, 3, 'https://api.openweathermap.org/data/2.5/forecast?id=2653941')
,       (3, 3, 'https://api.openweathermap.org/data/2.5/forecast?id=2654993')
,       (4, 3, 'https://api.openweathermap.org/data/2.5/forecast?id=2637487')
,       (5, 3, 'https://api.openweathermap.org/data/2.5/forecast?id=2656281')
GO

