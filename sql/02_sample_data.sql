USE employee_workforce_analytics;

INSERT INTO departments (department_name, location, annual_budget) VALUES
('Engineering', 'Chennai', 18000000),
('IT Support', 'Bengaluru', 8500000),
('Human Resources', 'Chennai', 6000000),
('Finance', 'Hyderabad', 7500000),
('Data Analytics', 'Bengaluru', 12000000);

INSERT INTO employees
(first_name, last_name, email, job_title, department_id, hire_date, employment_status, manager_id)
VALUES
('Priya', 'Raman', 'priya.raman@example.com', 'Engineering Manager', 1, '2020-04-13', 'Active', NULL),
('Arun', 'Kumar', 'arun.kumar@example.com', 'Software Engineer', 1, '2022-06-20', 'Active', 1),
('Meena', 'Sundar', 'meena.sundar@example.com', 'Firmware Engineer', 1, '2023-01-09', 'Active', 1),
('Rahul', 'Shah', 'rahul.shah@example.com', 'Support Lead', 2, '2021-03-15', 'Active', NULL),
('Kavya', 'Nair', 'kavya.nair@example.com', 'Support Analyst', 2, '2024-02-05', 'Active', 4),
('Divya', 'Iyer', 'divya.iyer@example.com', 'HR Specialist', 3, '2022-08-01', 'Active', NULL),
('Vikram', 'Rao', 'vikram.rao@example.com', 'Financial Analyst', 4, '2021-11-17', 'Active', NULL),
('Nisha', 'Menon', 'nisha.menon@example.com', 'Data Analyst', 5, '2023-07-10', 'Active', NULL),
('Sanjay', 'Das', 'sanjay.das@example.com', 'Data Engineer', 5, '2022-09-26', 'On Leave', 8),
('Ananya', 'Krishnan', 'ananya.krishnan@example.com', 'Junior Analyst', 5, '2025-01-06', 'Active', 8);

INSERT INTO salary_history (employee_id, annual_salary, effective_from, effective_to) VALUES
(1, 1500000, '2020-04-13', NULL),
(2, 850000, '2022-06-20', '2024-06-30'),
(2, 980000, '2024-07-01', NULL),
(3, 920000, '2023-01-09', NULL),
(4, 1100000, '2021-03-15', NULL),
(5, 620000, '2024-02-05', NULL),
(6, 780000, '2022-08-01', NULL),
(7, 900000, '2021-11-17', NULL),
(8, 1050000, '2023-07-10', NULL),
(9, 1250000, '2022-09-26', NULL),
(10, 550000, '2025-01-06', NULL);

INSERT INTO attendance (employee_id, attendance_date, attendance_status, hours_worked) VALUES
(1, '2026-10-01', 'Present', 8.0),
(1, '2026-10-02', 'Remote', 8.0),
(1, '2026-10-05', 'Present', 8.5),
(2, '2026-10-01', 'Present', 8.0),
(2, '2026-10-02', 'Absent', 0.0),
(2, '2026-10-05', 'Present', 7.5),
(3, '2026-10-01', 'Remote', 8.0),
(3, '2026-10-02', 'Present', 8.0),
(3, '2026-10-05', 'Leave', 0.0),
(4, '2026-10-01', 'Present', 8.0),
(4, '2026-10-02', 'Present', 8.0),
(5, '2026-10-01', 'Absent', 0.0),
(5, '2026-10-02', 'Present', 8.0),
(6, '2026-10-01', 'Present', 8.0),
(7, '2026-10-01', 'Present', 8.0),
(8, '2026-10-01', 'Remote', 8.0),
(8, '2026-10-02', 'Present', 8.0),
(9, '2026-10-01', 'Leave', 0.0),
(10, '2026-10-01', 'Present', 8.0);

INSERT INTO performance_reviews (employee_id, review_date, rating, reviewer_comments) VALUES
(1, '2026-03-31', 4.8, 'Strong leadership and delivery'),
(2, '2026-03-31', 4.2, 'Consistent engineering contribution'),
(3, '2026-03-31', 4.5, 'Strong debugging and testing'),
(4, '2026-03-31', 4.1, 'Reliable support operations'),
(5, '2026-03-31', 3.7, 'Developing technical skills'),
(6, '2026-03-31', 4.0, 'Good stakeholder coordination'),
(7, '2026-03-31', 3.9, 'Accurate financial reporting'),
(8, '2026-03-31', 4.6, 'Strong analytical skills'),
(9, '2026-03-31', 4.3, 'Good data pipeline ownership'),
(10, '2026-03-31', 3.8, 'Good progress for a junior analyst');
