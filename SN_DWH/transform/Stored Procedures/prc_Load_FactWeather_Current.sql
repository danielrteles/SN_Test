CREATE   PROCEDURE transform.prc_Load_FactWeather_Current
AS
BEGIN

    INSERT INTO olap.FactWeather_Current
    SELECT  dg.GeographyKey
    ,       dd.DateKey
    ,       dt.TimeKey
    ,       t.MinTemperature
    ,       t.MaxTemperature
    ,       t.Humidity
    FROM    transform.FactWeather_Current t
    JOIN    olap.DimDate dd         ON dd.FullDate = CONVERT(DATE, t.CurrentDate)
    JOIN    olap.DimTime dt         ON dt.TimeKey = t.CurrentHour
    JOIN    olap.DimGeography dg    ON dg.CityName = t.CityName
                                    AND dg.CountryName = t.CountryName
    WHERE   t.RecordAction = 'I'


    UPDATE  fwf
    SET     MinTemperature  = t.MinTemperature
    ,       MaxTemperature  = t.MaxTemperature
    ,       Humidity        = t.Humidity
    FROM    transform.FactWeather_Current t
    JOIN    olap.DimDate dd                 ON dd.FullDate = CONVERT(DATE, t.CurrentDate)
    JOIN    olap.DimTime dt                 ON dt.TimeKey = t.CurrentHour
    JOIN    olap.DimGeography dg            ON dg.CityName = t.CityName
                                            AND dg.CountryName = t.CountryName
    JOIN    olap.FactWeather_Current fwf   ON fwf.GeographyKey = dg.GeographyKey
                                            AND fwf.DateKey = dd.DateKey
                                            AND fwf.TimeKey = dt.TimeKey
    WHERE   t.RecordAction = 'U'

END