/* 
Employee profile view. 
*/

CREATE OR ALTER VIEW gold.view_active_employee_profile AS 
	SELECT
		ee.employee_id, 
		ee.first_name, 
		ee.last_name, 
		ee.email, 
		ee.gender, 
		ee.birth_date, 
		ee.hire_date, 
		ee.manager_id, 
		ee.[status], 
		d.department, 
		dj.job_title, 
		dl.province, 
		dl.city, 
		dl.country, 
		ee.dwh_date_created
	FROM silver.dim_employees ee
	LEFT JOIN silver.dim_department d
		ON ee.department_id = d.department_id
	LEFT JOIN silver.dim_job_title dj
		ON ee.job_id = dj.job_id
	LEFT JOIN silver.dim_location dl
		ON ee.location_id = dl.location_id
	WHERE ee.[status] = 'Active'
;