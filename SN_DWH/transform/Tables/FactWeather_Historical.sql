CREATE TABLE [transform].[FactWeather_Historical] (
    [RecordAction]   CHAR (1)       NOT NULL,
    [CityName]       VARCHAR (50)   NOT NULL,
    [CountryName]    VARCHAR (50)   NOT NULL,
    [FullDate]       DATE           NOT NULL,
    [MinTemperature] DECIMAL (4, 1) NULL,
    [MaxTemperature] DECIMAL (4, 1) NULL,
    [AirFrostDays]   TINYINT        NULL,
    [RainMm]         DECIMAL (4, 1) NULL,
    [SunHours]       DECIMAL (4, 1) NULL
);

