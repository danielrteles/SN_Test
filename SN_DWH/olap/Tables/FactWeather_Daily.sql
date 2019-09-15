CREATE TABLE [olap].[FactWeather_Daily] (
    [GeographyKey]   INT            NOT NULL,
    [DateKey]        INT            NOT NULL,
    [MinTemperature] DECIMAL (5, 2) NULL,
    [MaxTemperature] DECIMAL (5, 2) NULL,
    [Humidity]       DECIMAL (5, 2) NULL,
    CONSTRAINT [PK_FactWeather_Daily] PRIMARY KEY CLUSTERED ([GeographyKey] ASC, [DateKey] ASC),
    CONSTRAINT [FK_FactWeather_Daily_Date] FOREIGN KEY ([DateKey]) REFERENCES [olap].[DimDate] ([DateKey]),
    CONSTRAINT [FK_FactWeather_Daily_Geography] FOREIGN KEY ([GeographyKey]) REFERENCES [olap].[DimGeography] ([GeographyKey]),
);



