CREATE PROCEDURE transform.prc_Load_FactWeather_Historical
AS
BEGIN

    INSERT INTO olap.FactWeather_Historical
    SELECT  dg.GeographyKey
    ,       dd.DateKey
    ,       t.MinTemperature
    ,       t.MaxTemperature
    ,       t.AirFrostDays
    ,       t.RainMm
    ,       t.SunHours
    FROM    transform.FactWeather_Historical t
    JOIN    olap.DimDate dd         ON t.FullDate = dd.FullDate
    JOIN    olap.DimGeography dg    ON dg.CityName = t.CityName
                                    AND dg.CountryName = t.CountryName
    WHERE   t.RecordAction = 'I'


    UPDATE fwh
    SET     MinTemperature  = t.MinTemperature
    ,       MaxTemperature  = t.MaxTemperature
    ,       AirFrostDays    = t.AirFrostDays
    ,       RainMm          = t.RainMm
    ,       SunHours        = t.SunHours
    FROM    transform.FactWeather_Historical t
    JOIN    olap.DimDate dd                 ON t.FullDate = dd.FullDate
    JOIN    olap.DimGeography dg            ON dg.CityName = t.CityName
                                            AND dg.CountryName = t.CountryName
    JOIN    olap.FactWeather_Historical fwh ON fwh.GeographyKey = dg.GeographyKey
                                            AND fwh.DateKey = dd.DateKey
    WHERE   t.RecordAction = 'U'

END