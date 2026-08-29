/*
Uses a bulk insert to load full data into the respective table. 
Truncates table if it already exists. 
*/
USE hr_datawarehouse;
GO

CREATE OR ALTER PROCEDURE bronze.load_data AS
BEGIN
	BEGIN TRY

		IF OBJECT_ID('bronze.emp_data', 'U') IS NOT NULL
			TRUNCATE TABLE bronze.emp_data;

		PRINT('Loading bronze employee data. ');
		BULK INSERT bronze.emp_data
		FROM 'C:\Users\letov\Projects\hr_warehouse\hr_fast.csv'
		WITH (
			FIELDTERMINATOR = ',', 
			ROWTERMINATOR = '\n', 
			FIRSTROW = 2, 
			TABLOCK
		);
		PRINT('Employee bronze data loaded succesfully. ');


		PRINT('Loading bronze holiday data. ');
		IF OBJECT_ID('bronze.api_holiday_data', 'U') IS NOT NULL
			TRUNCATE TABLE bronze.api_holiday_data;

		BULK INSERT bronze.api_holiday_data
		FROM 'C:\Users\letov\Projects\hr_warehouse\holidays.csv'
		WITH (
			FIELDTERMINATOR=',', 
			ROWTERMINATOR='\n', 
			FIRSTROW = 2, 
			TABLOCK
		);
		PRINT('Holiday bronze data loaded succesfully. ');
	END TRY
	BEGIN CATCH
	PRINT('Issues with loading data');
	PRINT(ERROR_MESSAGE())
	END CATCH
END;