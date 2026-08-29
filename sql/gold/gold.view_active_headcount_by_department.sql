
CREATE OR ALTER VIEW gold.view_active_headcount_by_department AS 
	SELECT
		d.department, 
		COUNT (*) AS headcount
	FROM silver.dim_employees ee
	LEFT JOIN silver.dim_department d
		ON ee.department_id = d.department_id
	WHERE ee.[status] = 'Active'
	GROUP BY d.department;