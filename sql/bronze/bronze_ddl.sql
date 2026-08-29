/*
---------------------------------------------------------------------------------
This script creates the schema of the two tables for the bronze layer. 
Idempotency is ensure by first dropping the table if it exists, 
and then recreating it. 

No transformations would be carried out here. Just raw data. 

Always uses the same database, depending on the server environment. 
---------------------------------------------------------------------------------
*/

USE hr_datawarehouse;
GO

DROP TABLE IF EXISTS bronze.emp_data;
GO

CREATE TABLE bronze.emp_data (
employee_id INT PRIMARY KEY, 
first_name NVARCHAR(200), 
last_name NVARCHAR(200), 
email NVARCHAR(200), 
gender VARCHAR(20), 
birth_date DATE, 
hire_date DATE, 
department VARCHAR(100), 
job_title VARCHAR(100), 
salary DECIMAL(9, 2), 
province CHAR(2), 
city VARCHAR(20), 
manager_id INT, 
status VARCHAR(20), 
created_at DATETIME2, 
updated_at DATETIME2
);
GO

DROP TABLE IF EXISTS bronze.api_holiday_data;
GO

CREATE TABLE bronze.api_holiday_data (
id INT PRIMARY KEY, 
date DATE, 
nameEn NVARCHAR(200), 
nameFr NVARCHAR(200), 
federal INT, 
observedDate DATE, 
province_id CHAR(2), 
province_nameEn NVARCHAR(200)
);
GO