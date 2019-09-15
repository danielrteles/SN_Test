CREATE TABLE staging.OpenWeather_Current
(
    CityName            VARCHAR(50)
,   CountryName         VARCHAR(50)
,   DateTimeStamp       DATETIME
,   MinTemp             DECIMAL(5, 2)
,   MaxTemp             DECIMAL(5, 2)
,   Humidity            DECIMAL(5, 2)
)
GO
CREATE CLUSTERED INDEX IX_OpenWeather_Current ON staging.OpenWeather_Current (CityName, CountryName, DateTimeStamp)
