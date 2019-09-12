CREATE TABLE [logs].[ImportLog] (
    [CityFileId]       INT      NOT NULL,
    [StartTime]        DATETIME NOT NULL,
    [FileDownloadTime] DATETIME NULL,
    [EndTime]          DATETIME NULL,
    CONSTRAINT [FK_ImportLog_CityFilesId] FOREIGN KEY ([CityFileId]) REFERENCES [config].[CityFiles] ([CityFileId])
);



