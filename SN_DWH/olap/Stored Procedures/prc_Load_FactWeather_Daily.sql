CREATE   PROCEDURE olap.prc_Load_FactWeather_Daily
AS
BEGIN

    DECLARE @CutOffDateKey INT
    SELECT  @CutOffDateKey = MAX(DateKey)
    FROM    olap.DimDate
    WHERE   FullDate <= DATEADD(MONTH, -1, CONVERT(DATE, GETDATE()))

    DELETE  
    FROM    olap.FactWeather_Daily
    WHERE   DateKey < @CutOffDateKey

    DROP TABLE IF EXISTS #TempDailyWeather
    SELECT  GeographyKey
    ,       DateKey
    ,       MIN(MinTemperature)                     AS MinTemperature
    ,       MAX(MaxTemperature)                     AS MaxTemperature
    ,       CONVERT(DECIMAL(5, 2), AVG(Humidity))   AS Humidity
    INTO    #TempDailyWeather
    FROM    olap.FactWeather_Current
    GROUP BY GeographyKey
    ,       DateKey
    
    INSERT INTO olap.FactWeather_Daily (GeographyKey, DateKey, MinTemperature, MaxTemperature, Humidity)
    SELECT      t.GeographyKey
    ,           t.DateKey
    ,           t.MinTemperature
    ,           t.MaxTemperature
    ,           t.Humidity
    FROM        #TempDailyWeather t
    LEFT JOIN   olap.FactWeather_Daily fwd  ON t.GeographyKey = fwd.GeographyKey
                                            AND t.DateKey = fwd.DateKey
    WHERE       fwd.GeographyKey IS NULL

    UPDATE  fwd
    SET     MinTemperature  = t.MinTemperature
    ,       MaxTemperature  = t.MaxTemperature
    ,       Humidity        = t.Humidity
    FROM    #TempDailyWeather t
    JOIN    olap.FactWeather_Daily fwd  ON t.GeographyKey = fwd.GeographyKey
                                        AND t.DateKey = fwd.DateKey
    WHERE   fwd.MinTemperature  <> t.MinTemperature
    OR      fwd.MaxTemperature  <> t.MaxTemperature
    OR      fwd.Humidity        <> t.Humidity

END