EXEC [SSISDB].[catalog].[create_environment] @environment_name=N'DEV_TEST', @environment_description=N'', @folder_name=N'SN'
GO


DECLARE @var sql_variant = N'$(AdminDB)'
EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'AdminDB', @sensitive=False, @description=N'', @environment_name=N'DEV_TEST', @folder_name=N'SN', @value=@var, @data_type=N'String'
GO
DECLARE @var sql_variant = N'e8e87e1380909a80579b9f1c923602b1'
EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'ApiId', @sensitive=False, @description=N'', @environment_name=N'DEV_TEST', @folder_name=N'SN', @value=@var, @data_type=N'String'
GO
DECLARE @var sql_variant = N'$(DataWarehouseDB)'
EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'DataWarehouseDB', @sensitive=False, @description=N'', @environment_name=N'DEV_TEST', @folder_name=N'SN', @value=@var, @data_type=N'String'
GO
DECLARE @var sql_variant = N'$(SQLServerName)'
EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'ServerName', @sensitive=False, @description=N'', @environment_name=N'DEV_TEST', @folder_name=N'SN', @value=@var, @data_type=N'String'
GO
DECLARE @var sql_variant = N'$(StagingDB)'
EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'StagingDB', @sensitive=False, @description=N'', @environment_name=N'DEV_TEST', @folder_name=N'SN', @value=@var, @data_type=N'String'
GO
DECLARE @var sql_variant = N'C:\TEMP\SN_Test\'
EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'TempFolder', @sensitive=False, @description=N'', @environment_name=N'DEV_TEST', @folder_name=N'SN', @value=@var, @data_type=N'String'
GO


Declare @reference_id bigint
EXEC [SSISDB].[catalog].[create_environment_reference] @environment_name=N'DEV_TEST', @reference_id=@reference_id OUTPUT, @project_name=N'SN_ETL', @folder_name=N'SN', @reference_type=R
Select @reference_id

GO
EXEC [SSISDB].[catalog].[set_object_parameter_value] @object_type=20, @parameter_name=N'AdminDB', @object_name=N'SN_ETL', @folder_name=N'SN', @project_name=N'SN_ETL', @value_type=R, @parameter_value=N'AdminDB'
GO
EXEC [SSISDB].[catalog].[set_object_parameter_value] @object_type=20, @parameter_name=N'ApiId', @object_name=N'SN_ETL', @folder_name=N'SN', @project_name=N'SN_ETL', @value_type=R, @parameter_value=N'ApiId'
GO
EXEC [SSISDB].[catalog].[set_object_parameter_value] @object_type=20, @parameter_name=N'DataWarehouseDB', @object_name=N'SN_ETL', @folder_name=N'SN', @project_name=N'SN_ETL', @value_type=R, @parameter_value=N'DataWarehouseDB'
GO
EXEC [SSISDB].[catalog].[set_object_parameter_value] @object_type=20, @parameter_name=N'ServerName', @object_name=N'SN_ETL', @folder_name=N'SN', @project_name=N'SN_ETL', @value_type=R, @parameter_value=N'ServerName'
GO
EXEC [SSISDB].[catalog].[set_object_parameter_value] @object_type=20, @parameter_name=N'StagingDB', @object_name=N'SN_ETL', @folder_name=N'SN', @project_name=N'SN_ETL', @value_type=R, @parameter_value=N'StagingDB'
GO
EXEC [SSISDB].[catalog].[set_object_parameter_value] @object_type=20, @parameter_name=N'TempFolder', @object_name=N'SN_ETL', @folder_name=N'SN', @project_name=N'SN_ETL', @value_type=R, @parameter_value=N'TempFolder'
GO

GO

