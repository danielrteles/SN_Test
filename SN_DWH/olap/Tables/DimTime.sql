CREATE TABLE olap.DimTime
(
    TimeKey         INT         NOT NULL CONSTRAINT PK_DimTime PRIMARY KEY CLUSTERED
,   StartTime       TIME        NOT NULL
,   EndTime         TIME        NOT NULL
,   PeriodOfDay     CHAR(2)     NOT NULL
)
GO

