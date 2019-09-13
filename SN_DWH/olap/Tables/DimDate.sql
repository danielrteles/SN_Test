CREATE TABLE [olap].[DimDate] (
    [DateKey]       INT          NOT NULL,
    [FullDate]      DATE         NOT NULL,
    [CalendarYear]  SMALLINT     NOT NULL,
    [CalendarMonth] TINYINT      NOT NULL,
    [CalendarDay]   TINYINT      NOT NULL,
    [WeekDayNumber] TINYINT      NOT NULL,
    [WeekDayName]   VARCHAR (10) NOT NULL,
    CONSTRAINT [PK_DimDate] PRIMARY KEY CLUSTERED ([DateKey] ASC)
);

