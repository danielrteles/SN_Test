CREATE TABLE [config].[Cities] (
    [CityId]        INT             IDENTITY (1, 1) NOT NULL,
    [CityName]      VARCHAR (50)    NOT NULL,
    [CountryName]   VARCHAR (50)    NOT NULL
    CONSTRAINT [PK_Cities] PRIMARY KEY CLUSTERED ([CityId] ASC),
    CONSTRAINT [UK_Cities] UNIQUE NONCLUSTERED ([CityName] ASC)
);

