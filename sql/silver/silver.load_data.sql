/*
Uses a insert to load full data into the respective table. 
Truncates table if it already exists. 
*/

USE hr_datawarehouse;
GO

CREATE OR ALTER PROCEDURE silver.load_data_procedure AS
BEGIN
	BEGIN TRY
		-- Department. -----------------------------------------------------------
		PRINT('Loading data into silver_dim_department');

		IF OBJECT_ID ('silver.dim_department', 'U') IS NOT NULL
			TRUNCATE TABLE silver.dim_department;

		INSERT INTO silver.dim_department (
		department
		)

		SELECT 
			DISTINCT department
		FROM bronze.emp_data
		ORDER BY department ASC;

		PRINT('Data loaded into silver.dim_department')


		-- Locations. -----------------------------------------------------------
		PRINT('Loading data into silver.dim_location');

		IF OBJECT_ID ('silver.dim_location', 'U') IS NOT NULL
			TRUNCATE TABLE silver.dim_location;

		INSERT INTO silver.dim_location (
		province, 
		city, 
		country
		)

		SELECT 
			DISTINCT TRIM(province) AS province, 
			'Unknown' AS city, 
			'Canada' AS country
		FROM bronze.emp_data
		ORDER BY province ASC;

		PRINT('Data loaded into silver.dim_location')



		-- Job title. -----------------------------------------------------------
		PRINT('Loading data into silver.dim_job_title');

		IF OBJECT_ID ('silver.dim_job_title', 'U') IS NOT NULL
			TRUNCATE TABLE silver.dim_job_title;


		INSERT INTO silver.dim_job_title (
		job_title
		)

		SELECT 
			DISTINCT job_title
		FROM bronze.emp_data
		ORDER BY job_title ASC;

		PRINT('Data loaded into silver.dim_job_title');



		-- Employees. -----------------------------------------------------------
		PRINT('Loading data into silver.dim_employees');

		IF OBJECT_ID('silver.dim_employees', 'U') IS NOT NULL
			TRUNCATE TABLE silver.dim_employees;

		INSERT INTO silver.dim_employees (
		employee_id, 
		first_name, 
		last_name, 
		email, 
		gender, 
		birth_date, 
		hire_date, 
		manager_id, 
		[status], 
		department_id, 
		location_id, 
		job_id
		)

		SELECT
			e.employee_id, 
			e.first_name, 
			e.last_name, 
			e.email, 
			e.gender, 
			e.birth_date, 
			e.hire_date, 
			e.manager_id, 
			e.[status], 
			dd.department_id, 
			dl.location_id, 
			dj.job_id
		FROM bronze.emp_data e
		LEFT JOIN silver.dim_department dd
			ON e.department = dd.department
		LEFT JOIN silver.dim_location dl
			ON e.province = dl.province
		LEFT JOIN silver.dim_job_title dj
			ON e.job_title = dj.job_title;

		PRINT('Data loaded into silver.dim_employees');



		-- Fact salary. -----------------------------------------------------------
		PRINT('Loading data into silver.fact_salary');

		IF OBJECT_ID ('silver.fact_salary', 'U') IS NOT NULL
			TRUNCATE TABLE silver.fact_salary;


		INSERT INTO silver.fact_salary (
		employee_id, 
		salary
		)

		SELECT 
			employee_id, 
			salary
		FROM bronze.emp_data;

		PRINT('Data loaded into silver.fact_salary');
	END TRY
	BEGIN CATCH
	PRINT('Issues with loading data');
	PRINT(ERROR_MESSAGE());
	END CATCH
END
;