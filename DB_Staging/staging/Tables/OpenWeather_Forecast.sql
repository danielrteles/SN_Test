CREATE TABLE staging.OpenWeather_Forecast
(
    CityName            VARCHAR(50)
,   CountryName         VARCHAR(50)
,   ForecastDateTime    DATETIME
,   MinTemp             DECIMAL(5, 2)
,   MaxTemp             DECIMAL(5, 2)
,   Humidity            DECIMAL(5, 2)
)
GO
CREATE CLUSTERED INDEX IX_OpenWeather_Forecast ON staging.OpenWeather_Forecast (CityName, CountryName, ForecastDateTime)
