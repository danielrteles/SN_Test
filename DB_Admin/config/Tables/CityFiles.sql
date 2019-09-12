CREATE TABLE [config].[CityFiles] (
    [CityFileId] INT           IDENTITY (1, 1) NOT NULL,
    [CityId]     INT           NOT NULL,
    [ProviderId] INT           NOT NULL,
    [FileUrl]    VARCHAR (255) NOT NULL,
    CONSTRAINT [PK_CityFiles] PRIMARY KEY CLUSTERED ([CityFileId] ASC),
    CONSTRAINT [FK_CityFiles_Cities] FOREIGN KEY ([CityId]) REFERENCES [config].[Cities] ([CityId]),
    CONSTRAINT [FK_CityFiles_DataProviders] FOREIGN KEY ([ProviderId]) REFERENCES [config].[DataProviders] ([ProviderId]),
    CONSTRAINT [UK_CityFiles] UNIQUE NONCLUSTERED ([CityId] ASC, [ProviderId] ASC)
);



