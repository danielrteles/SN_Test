USE [msdb]
GO

DECLARE @ServerName SYSNAME = N'[$(SQLServerName)]'
DECLARE @SQLCommand NVARCHAR(MAX);


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

SET @SQLCommand = N'/ISSERVER "\"\SSISDB\SN\SN_ETL\Staging_OpenWeather_Current.dtsx\"" /SERVER ' + @ServerName + ' /ENVREFERENCE 5 /Par "\"$ServerOption::LOGGING_LEVEL(Int16)\"";1 /Par "\"$ServerOption::SYNCHRONIZED(Boolean)\"";True /CALLERINFO SQLAGENT /REPORTING E'
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

SET @SQLCommand = N'/ISSERVER "\"\SSISDB\SN\SN_ETL\Staging_OpenWeather_Forecast.dtsx\"" /SERVER ' + @ServerName + ' /ENVREFERENCE 5 /Par "\"$ServerOption::LOGGING_LEVEL(Int16)\"";1 /Par "\"$ServerOption::SYNCHRONIZED(Boolean)\"";True /CALLERINFO SQLAGENT /REPORTING E'
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

SET @SQLCommand = N'/ISSERVER "\"\SSISDB\SN\SN_ETL\DWH_Load_DimGeography.dtsx\"" /SERVER ' + @ServerName + ' /ENVREFERENCE 5 /Par "\"$ServerOption::LOGGING_LEVEL(Int16)\"";1 /Par "\"$ServerOption::SYNCHRONIZED(Boolean)\"";True /CALLERINFO SQLAGENT /REPORTING E'
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

SET @SQLCommand = N'/ISSERVER "\"\SSISDB\SN\SN_ETL\DWH_Load_FactWeather_Current.dtsx\"" /SERVER ' + @ServerName + ' /ENVREFERENCE 5 /Par "\"$ServerOption::LOGGING_LEVEL(Int16)\"";1 /Par "\"$ServerOption::SYNCHRONIZED(Boolean)\"";True /CALLERINFO SQLAGENT /REPORTING E'
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

SET @SQLCommand = N'/ISSERVER "\"\SSISDB\SN\SN_ETL\DWH_Load_FactWeather_Forecast.dtsx\"" /SERVER ' + @ServerName + ' /ENVREFERENCE 5 /Par "\"$ServerOption::LOGGING_LEVEL(Int16)\"";1 /Par "\"$ServerOption::SYNCHRONIZED(Boolean)\"";True /CALLERINFO SQLAGENT /REPORTING E'
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
GO
