CREATE TABLE [olap].[FactWeather_Historical] (
    [GeographyKey]   INT            NOT NULL,
    [DateKey]        INT            NOT NULL,
    [MinTemperature] DECIMAL (4, 1) NULL,
    [MaxTemperature] DECIMAL (4, 1) NULL,
    [AirFrostDays]   TINYINT        NULL,
    [RainMm]         DECIMAL (4, 1) NULL,
    [SunHours]       DECIMAL (4, 1) NULL,
    CONSTRAINT [FK_FactWeather_Historical_Date] FOREIGN KEY ([DateKey]) REFERENCES [olap].[DimDate] ([DateKey]),
    CONSTRAINT [FK_FactWeather_Historical_Geography] FOREIGN KEY ([GeographyKey]) REFERENCES [olap].[DimGeography] ([GeographyKey]),
    CONSTRAINT [PK_FactWeather_Historical] PRIMARY KEY CLUSTERED (GeographyKey, DateKey) 
);

