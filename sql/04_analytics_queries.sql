USE employee_workforce_analytics;

-- 1. Current employee directory
SELECT * FROM vw_current_employee_directory
ORDER BY department_name, employee_name;

-- 2. Department headcount and salary summary
SELECT * FROM vw_department_salary_summary
ORDER BY total_annual_salary DESC;

-- 3. Current highest-paid employee(s) in each department. RANK() returns ties.
WITH current_salaries AS (
    SELECT employee_id, annual_salary
    FROM salary_history
    WHERE effective_to IS NULL
),
ranked_employees AS (
    SELECT
        d.department_name,
        CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
        cs.annual_salary,
        RANK() OVER (
            PARTITION BY d.department_id
            ORDER BY cs.annual_salary DESC
        ) AS salary_rank
    FROM employees e
    JOIN departments d ON d.department_id = e.department_id
    JOIN current_salaries cs ON cs.employee_id = e.employee_id
    WHERE e.employment_status = 'Active'
)
SELECT department_name, employee_name, annual_salary
FROM ranked_employees
WHERE salary_rank = 1
ORDER BY department_name;

-- 4. Employees whose current salary is above the company average
SELECT
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.department_name,
    sh.annual_salary
FROM employees e
JOIN departments d ON d.department_id = e.department_id
JOIN salary_history sh ON sh.employee_id = e.employee_id
WHERE sh.effective_to IS NULL
  AND sh.annual_salary > (
      SELECT AVG(annual_salary)
      FROM salary_history
      WHERE effective_to IS NULL
  )
ORDER BY sh.annual_salary DESC;

-- 5. Attendance summary
SELECT *
FROM vw_employee_attendance_summary
WHERE recorded_days > 0
ORDER BY attendance_percentage ASC;

-- 6. Latest performance review for each employee
WITH latest_review AS (
    SELECT
        pr.*,
        ROW_NUMBER() OVER (
            PARTITION BY pr.employee_id
            ORDER BY pr.review_date DESC, pr.review_id DESC
        ) AS row_num
    FROM performance_reviews pr
)
SELECT
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.department_name,
    lr.review_date,
    lr.rating,
    lr.reviewer_comments
FROM latest_review lr
JOIN employees e ON e.employee_id = lr.employee_id
JOIN departments d ON d.department_id = e.department_id
WHERE lr.row_num = 1
ORDER BY lr.rating DESC;

-- 7. Salary history and salary growth per employee
WITH salary_changes AS (
    SELECT
        employee_id,
        annual_salary,
        effective_from,
        LAG(annual_salary) OVER (
            PARTITION BY employee_id
            ORDER BY effective_from
        ) AS previous_salary
    FROM salary_history
)
SELECT
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    sc.effective_from,
    sc.previous_salary,
    sc.annual_salary AS new_salary,
    CASE
        WHEN sc.previous_salary IS NULL OR sc.previous_salary = 0 THEN NULL
        ELSE ROUND(
            100.0 * (sc.annual_salary - sc.previous_salary) / sc.previous_salary,
            2
        )
    END AS salary_change_percentage
FROM salary_changes sc
JOIN employees e ON e.employee_id = sc.employee_id
ORDER BY employee_name, sc.effective_from;

-- 8. Monthly attendance breakdown
SELECT
    DATE_FORMAT(attendance_date, '%Y-%m') AS attendance_month,
    attendance_status,
    COUNT(*) AS record_count,
    ROUND(AVG(hours_worked), 2) AS average_hours
FROM attendance
GROUP BY DATE_FORMAT(attendance_date, '%Y-%m'), attendance_status
ORDER BY attendance_month, attendance_status;

-- 9. Departments whose current average salary exceeds 800,000
SELECT department_name, employee_count, average_annual_salary
FROM vw_department_salary_summary
WHERE average_annual_salary > 800000
ORDER BY average_annual_salary DESC;

-- 10. Example query for examining index usage
EXPLAIN
SELECT employee_id, attendance_date, attendance_status
FROM attendance
WHERE attendance_date = '2026-10-01'
  AND attendance_status = 'Present';

-- 11. Parameterized-query example for application code
-- SELECT employee_id, first_name, last_name, email
-- FROM employees
-- WHERE department_id = ? AND employment_status = ?;
