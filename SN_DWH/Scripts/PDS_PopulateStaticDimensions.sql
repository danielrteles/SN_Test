
DECLARE @Date   DATE = '18530101'

DELETE FROM olap.DimDate

WHILE @Date <= '20301231'
BEGIN
    INSERT  INTO olap.DimDate (DateKey, FullDate, CalendarYear, CalendarMonth, CalendarDay, WeekDayNumber, WeekDayName)
    SELECT  CONVERT(INT, CONVERT(CHAR(8), @Date, 112))  AS DateKey
    ,       @Date                                       AS FullDate
    ,       DATEPART(YEAR, @Date)                       AS CalendarYear
    ,       DATEPART(MONTH, @Date)                      AS CalendarMonth
    ,       DATEPART(DAY, @Date)                        AS CalendarDay
    ,       DATEPART(WEEKDAY, @Date)                    AS WeekDayNumber
    ,       CASE DATEPART(WEEKDAY, @Date)
                WHEN 1 THEN 'Sunday'
                WHEN 2 THEN 'Monday'
                WHEN 3 THEN 'Tuesday'
                WHEN 4 THEN 'Wednesday'
                WHEN 5 THEN 'Thursday'
                WHEN 6 THEN 'Friday'
                ELSE 'Saturday'
            END                                         AS WeekDayName

    SET @Date = DATEADD(DAY, 1, @Date)
END
GO
DELETE FROM olap.DimTime

INSERT INTO olap.DimTime (TimeKey, StartTime, EndTime, PeriodOfDay)
VALUES  (0, '00:00:00', '02:59:59', 'AM')
,       (3, '03:00:00', '05:59:59', 'AM')
,       (6, '06:00:00', '08:59:59', 'AM')
,       (9, '09:00:00', '11:59:59', 'AM')
,       (12, '12:00:00', '14:59:59', 'PM')
,       (15, '15:00:00', '17:59:59', 'PM')
,       (18, '18:00:00', '20:59:59', 'PM')
,       (21, '21:00:00', '23:59:59', 'PM')
GO


