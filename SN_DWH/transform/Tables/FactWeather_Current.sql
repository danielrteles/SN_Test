﻿CREATE TABLE [transform].[FactWeather_Current] (
    [RecordAction]   CHAR (1)       NOT NULL,
    [CityName]       VARCHAR (50)   NOT NULL,
    [CountryName]    VARCHAR (50)   NOT NULL,
    [CurrentDate]    DATE           NOT NULL,
    [CurrentHour]    INT            NOT NULL,
    [MinTemperature] DECIMAL (5, 2) NULL,
    [MaxTemperature] DECIMAL (5, 2) NULL,
    [Humidity]       DECIMAL (5, 2) NULL
);



