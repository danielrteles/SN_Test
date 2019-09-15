CREATE TABLE [olap].[FactWeather_Daily] (
    [GeographyKey]   INT            NOT NULL,
    [DateKey]        INT            NOT NULL,
    [TimeKey]        INT            NOT NULL,
    [MinTemperature] DECIMAL (5, 2) NULL,
    [MaxTemperature] DECIMAL (5, 2) NULL,
    [Humidity]       DECIMAL (5, 2) NULL,
    CONSTRAINT [FK_FactWeather_Daily_Date] FOREIGN KEY ([DateKey]) REFERENCES [olap].[DimDate] ([DateKey]),
    CONSTRAINT [FK_FactWeather_Daily_Geography] FOREIGN KEY ([GeographyKey]) REFERENCES [olap].[DimGeography] ([GeographyKey]),
    CONSTRAINT [FK_FactWeather_Daily_Time] FOREIGN KEY ([TimeKey]) REFERENCES [olap].[DimTime] ([TimeKey])
);

