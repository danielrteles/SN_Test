CREATE TABLE [olap].[DimGeography] (
    [GeographyKey] INT          IDENTITY (1, 1) NOT NULL,
    [CityName]     VARCHAR (50) NOT NULL,
    [CountryName]  VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_DimGeography] PRIMARY KEY CLUSTERED ([GeographyKey] ASC),
    CONSTRAINT [UK_DimGeography_CityCountry] UNIQUE NONCLUSTERED ([CityName] ASC, [CountryName] ASC)
);

