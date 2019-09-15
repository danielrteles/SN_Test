USE [msdb]
GO


IF EXISTS(  SELECT * FROM msdb.dbo.sysjobs
            WHERE name = N'SN_Test_Incremental_Job')
    EXEC msdb.dbo.sp_delete_job @job_name = N'SN_Test_Incremental_Job'
GO

DECLARE @SQLCommand NVARCHAR(MAX);
DECLARE @EnvReferenceId BIGINT;
SELECT  @EnvReferenceId = reference_id
FROM    ssisdb.catalog.environment_references r
JOIN    SSISDB.catalog.environments e ON e.name = r.environment_name
JOIN    SSISDB.catalog.folders f ON e.folder_id = f.folder_id
WHERE   f.name = 'SN'
AND     e.name = 'DEV_Test';




DECLARE @jobId BINARY(16)
EXEC  msdb.dbo.sp_add_job @job_name=N'SN_Test_Incremental_Job', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT

EXEC msdb.dbo.sp_add_jobserver @job_name=N'SN_Test_Incremental_Job', @server_name = @@SERVERNAME




SET @SQLCommand = N'/ISSERVER "\"\SSISDB\SN\SN_ETL\Staging_OpenWeather_Current.dtsx\"" /SERVER $(SQLServerName) /ENVREFERENCE ' + CONVERT(VARCHAR(10), @EnvReferenceId) + ' /Par "\"$ServerOption::LOGGING_LEVEL(Int16)\"";1 /Par "\"$ServerOption::SYNCHRONIZED(Boolean)\"";True /CALLERINFO SQLAGENT /REPORTING E'
EXEC msdb.dbo.sp_add_jobstep @job_name=N'SN_Test_Incremental_Job', @step_name=N'Staging - OpenWeather - Current', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_fail_action=3, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'SSIS', 
		@command=@SQLCommand, 
		@database_name=N'master', 
		@flags=0

SET @SQLCommand = N'/ISSERVER "\"\SSISDB\SN\SN_ETL\Staging_OpenWeather_Forecast.dtsx\"" /SERVER $(SQLServerName) /ENVREFERENCE ' + CONVERT(VARCHAR(10), @EnvReferenceId) + ' /Par "\"$ServerOption::LOGGING_LEVEL(Int16)\"";1 /Par "\"$ServerOption::SYNCHRONIZED(Boolean)\"";True /CALLERINFO SQLAGENT /REPORTING E'
EXEC msdb.dbo.sp_add_jobstep @job_name=N'SN_Test_Incremental_Job', @step_name=N'Staging - OpenWeather - Forecast', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_fail_action=3, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'SSIS', 
		@command=@SQLCommand, 
		@database_name=N'master', 
		@flags=0

SET @SQLCommand = N'/ISSERVER "\"\SSISDB\SN\SN_ETL\DWH_Load_DimGeography.dtsx\"" /SERVER $(SQLServerName) /ENVREFERENCE ' + CONVERT(VARCHAR(10), @EnvReferenceId) + ' /Par "\"$ServerOption::LOGGING_LEVEL(Int16)\"";1 /Par "\"$ServerOption::SYNCHRONIZED(Boolean)\"";True /CALLERINFO SQLAGENT /REPORTING E'
EXEC msdb.dbo.sp_add_jobstep @job_name=N'SN_Test_Incremental_Job', @step_name=N'DWH - Load DimGeography', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_fail_action=3, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'SSIS', 
		@command=@SQLCommand, 
		@database_name=N'master', 
		@flags=0

SET @SQLCommand = N'/ISSERVER "\"\SSISDB\SN\SN_ETL\DWH_Load_FactWeather_Current.dtsx\"" /SERVER $(SQLServerName) /ENVREFERENCE ' + CONVERT(VARCHAR(10), @EnvReferenceId) + ' /Par "\"$ServerOption::LOGGING_LEVEL(Int16)\"";1 /Par "\"$ServerOption::SYNCHRONIZED(Boolean)\"";True /CALLERINFO SQLAGENT /REPORTING E'
EXEC msdb.dbo.sp_add_jobstep @job_name=N'SN_Test_Incremental_Job', @step_name=N'DWH - Load FactWeaher_Current', 
		@step_id=4, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_fail_action=3, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'SSIS', 
		@command=@SQLCommand, 
		@database_name=N'master', 
		@flags=0

SET @SQLCommand = N'/ISSERVER "\"\SSISDB\SN\SN_ETL\DWH_Load_FactWeather_Forecast.dtsx\"" /SERVER $(SQLServerName) /ENVREFERENCE ' + CONVERT(VARCHAR(10), @EnvReferenceId) + ' /Par "\"$ServerOption::LOGGING_LEVEL(Int16)\"";1 /Par "\"$ServerOption::SYNCHRONIZED(Boolean)\"";True /CALLERINFO SQLAGENT /REPORTING E'
EXEC msdb.dbo.sp_add_jobstep @job_name=N'SN_Test_Incremental_Job', @step_name=N'DWH - Load FactWeather_Forecast', 
		@step_id=5, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_fail_action=2, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'SSIS', 
		@command=@SQLCommand, 
		@database_name=N'master', 
		@flags=0

EXEC msdb.dbo.sp_update_job @job_name=N'SN_Test_Incremental_Job', 
		@enabled=1, 
		@start_step_id=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', 
		@notify_email_operator_name=N'', 
		@notify_page_operator_name=N''

DECLARE @scheduleid INT;
EXEC msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'SN Incremental Job', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=10, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20190915, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, @schedule_id = @scheduleid OUTPUT
