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

SET IDENTITY_INSERT config.Cities ON
GO
INSERT INTO config.Cities (CityId, CityName)
VALUES  (1, 'Oxford')
,       (2, 'Cambridge')
,       (3, 'Bradford')
,       (4, 'Southampton')
,       (5, 'Whitby')
GO
SET IDENTITY_INSERT config.Cities OFF
GO

SET IDENTITY_INSERT config.DataProviders ON
GO
INSERT INTO config.DataProviders (ProviderId, ProviderName)
VALUES  (1, 'MetOffice')
,       (2, 'OpenWeather')
GO
SET IDENTITY_INSERT config.DataProviders OFF
GO

INSERT INTO config.CityFiles
VALUES  (1, 1, 'http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/oxforddata.txt')
,       (2, 1, 'http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/cambridgedata.txt')
,       (3, 1, 'http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/bradforddata.txt')
,       (4, 1, 'http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/southamptondata.txt')
,       (5, 1, 'http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/whitbydata.txt')
,       (1, 2, 'https://openweathermap.org/city/2640729')
,       (2, 2, 'https://openweathermap.org/city/2653941')
,       (3, 2, 'https://openweathermap.org/city/2654993')
,       (4, 2, 'https://openweathermap.org/city/2637487')
,       (5, 2, 'https://openweathermap.org/city/2634135')
GO
