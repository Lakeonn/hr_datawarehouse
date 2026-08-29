/* 

*/

-- Using same database. -----------------------------------------------
USE hr_datawarehouse;
GO

-- Department. --------------------------------------------------------
PRINT ('Creating department dimension table');
GO

DROP TABLE IF EXISTS silver.dim_department;
GO

CREATE TABLE silver.dim_department (
department_id INT IDENTITY(1,1) PRIMARY KEY, 
department NVARCHAR(200), 
dwh_date_created DATETIME2 DEFAULT SYSUTCDATETIME()
);
GO

PRINT ('Created locations dimension table');
GO


-- Locations. --------------------------------------------------------
PRINT ('Creating locations dimension table');
GO

DROP TABLE IF EXISTS silver.dim_location;
GO

CREATE TABLE silver.dim_location (
location_id INT IDENTITY(1,1) PRIMARY KEY, 
province NVARCHAR(2), 
city NVARCHAR(50), 
country NVARCHAR(6), 
dwh_date_created DATETIME2 DEFAULT SYSUTCDATETIME()
);
GO

PRINT ('Created locations dimension table');
GO



-- Job title. --------------------------------------------------------
PRINT ('Creating job title dimension table');
GO

DROP TABLE IF EXISTS silver.dim_job_title;
GO

CREATE TABLE silver.dim_job_title (
job_id INT IDENTITY(1,1) PRIMARY KEY, 
job_title NVARCHAR(200), 
dwh_date_created DATETIME2 DEFAULT SYSUTCDATETIME()
);
GO

PRINT ('Created job title dimension table');
GO



-- Employees. --------------------------------------------------------
PRINT ('Creating employees dimension table');
GO

DROP TABLE IF EXISTS silver.dim_employees;
GO

CREATE TABLE silver.dim_employees (
employee_id INT PRIMARY KEY, 
first_name NVARCHAR(200), 
last_name NVARCHAR(200), 
email NVARCHAR(200), 
gender VARCHAR(20), 
birth_date DATE, 
hire_date DATE, 
manager_id INT, 
[status] VARCHAR(20), 
department_id INT, 
location_id INT, 
job_id INT, 
dwh_date_created DATETIME2 DEFAULT SYSUTCDATETIME()
);
GO

PRINT ('Created employees dimension table');
GO



-- Salary. --------------------------------------------------------
PRINT ('Creating salary fact table');
GO

DROP TABLE IF EXISTS silver.fact_salary;
GO

CREATE TABLE silver.fact_salary (
employee_id INT NOT NULL, 
salary DECIMAL(9, 2), 
dwh_date_created DATETIME2 DEFAULT SYSUTCDATETIME()
);
GO

PRINT ('Created salary fact table');
GO