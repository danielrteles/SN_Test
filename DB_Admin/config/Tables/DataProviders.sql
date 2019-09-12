CREATE TABLE [config].[DataProviders] (
    [ProviderId]   INT          IDENTITY (1, 1) NOT NULL,
    [ProviderName] VARCHAR (20) NOT NULL,
    CONSTRAINT [PK_DataProviders] PRIMARY KEY CLUSTERED ([ProviderId] ASC)
);

