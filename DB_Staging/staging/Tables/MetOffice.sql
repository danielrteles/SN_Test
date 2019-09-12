CREATE TABLE [staging].[MetOffice] (
    [CityName]  VARCHAR (20)   NULL,
    [Year_yyyy] SMALLINT       NULL,
    [Month_mm]  TINYINT        NULL,
    [TMaxDegC]  DECIMAL (4, 1) NULL,
    [TMinDegC]  DECIMAL (4, 1) NULL,
    [AFDays]    TINYINT        NULL,
    [RainMm]    DECIMAL (4, 1) NULL,
    [SunHours]  DECIMAL (4, 1) NULL
);

