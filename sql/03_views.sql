USE employee_workforce_analytics;

CREATE OR REPLACE VIEW vw_current_employee_directory AS
SELECT
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    e.email,
    e.job_title,
    d.department_name,
    d.location,
    e.hire_date,
    e.employment_status
FROM employees e
JOIN departments d ON d.department_id = e.department_id;

CREATE OR REPLACE VIEW vw_department_salary_summary AS
SELECT
    d.department_id,
    d.department_name,
    COUNT(DISTINCT e.employee_id) AS employee_count,
    ROUND(AVG(sh.annual_salary), 2) AS average_annual_salary,
    SUM(sh.annual_salary) AS total_annual_salary
FROM departments d
LEFT JOIN employees e
    ON e.department_id = d.department_id
   AND e.employment_status <> 'Resigned'
LEFT JOIN salary_history sh
    ON sh.employee_id = e.employee_id
   AND sh.effective_to IS NULL
GROUP BY d.department_id, d.department_name;

CREATE OR REPLACE VIEW vw_employee_attendance_summary AS
SELECT
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.department_name,
    COUNT(a.attendance_id) AS recorded_days,
    SUM(a.attendance_status IN ('Present', 'Remote')) AS attended_days,
    SUM(a.attendance_status = 'Absent') AS absent_days,
    ROUND(
        100.0 * SUM(a.attendance_status IN ('Present', 'Remote'))
        / NULLIF(COUNT(a.attendance_id), 0), 2
    ) AS attendance_percentage
FROM employees e
JOIN departments d ON d.department_id = e.department_id
LEFT JOIN attendance a ON a.employee_id = e.employee_id
GROUP BY e.employee_id, employee_name, d.department_name;
