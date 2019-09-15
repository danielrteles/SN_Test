# SN_Test

## Deployment

This project was developed using SQL Server 2017.

**1. Deploy SSIS project**

1.1. Right-click on the project name (SN_ETL) and then on Deploy
1.2. Type the name of the server that will host the SSIS packages and click on Connect
1.3. Click on "Browse..." and create a new folder named "SN" under SSISDB and click ok. At this point, the path should be "/SSISDB/SN/SN_ETL".
1.4. Click on "Next" and then "Deploy".

**2. Deploy SQL Server databases:**

IMPORTANT: If you're using a local instance, do not use a dot to indicate localhost.

- Order of deployment: DB_Admin, DB_Staging and DB_DWH
- For each database project above-mentioned, right-click on their names and then click on "Publish..."
- On the Publish screen, click on "Edit..." and add server name, name of database to be created and click on "OK."
- For the database DB_DWH, in thesection SQL CMD Variables, a few variables need to be informed before publish:
	- AdminDB, DataWarehouseDB and StagingDB correspond to the names of the databases you're using. These are required for creating the SSIS environment.
	- SQLServerName corresponds to the name of the SQL Server instance you're using for this test. It will be used in the SQL Agent Jobs.


## SQL Agent jobs

**- SN_Test_Historical_Job**: job to load historical data from UK MetOffice. This job doesn't have any schedule and will have to be executed manually as a one-off.

**- SN_Test_Incremental_Job**: job to load incremental data from OpenWeather. This job runs every 10 minutes.


## Relevant Tables:

- **olap.DimGeography**: stores cities and countries names.
- **olap.DimDate**: stores dates since 1853 until 2030
- **olap.DimTime**: stores time information in interval of 3h as per requirements.
- **olap.FactWeather_Historical**: stores historical information from MetOffice
- **olap.FactWeather_Forecast**: stores forecasted information from OpenWeather, based on https://openweathermap.org/forecast5
- **olap.FactWeather_Current**: stores current information from OpenWeather, based on https://openweathermap.org/current
- **olap.FactWeather_Daily**: stores daily summary from OpenWeather "current" API. This is just an aggregation of the data in the Current API because the daily forecast data (https://openweathermap.org/forecast16) is not available in the free subscription.

Please note that:
- I've considered the Current data as the most accurate and, therefore, used it to populate the Daily fact table. 
- The housekeeping tasks to delete old data is part of the ETL packages/SQL procedures.

## Final Considerations

This test took me more than 4h, mostly because I had never had to ingest data from APIs and tried a couple of different approaches before sticking to the simplest one, considering that SQL Server supports JSON natively from version 2016 onwards.

I also spent some time testing the deployment scripts and, for various reasons, I didn't manage to sit down and do it only in one go. Unfortunately I had to do parts of it in different days.
