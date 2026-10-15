CREATE DATABASE IF NOT EXISTS employee_workforce_analytics;
USE employee_workforce_analytics;

SET FOREIGN_KEY_CHECKS = 0;
DROP VIEW IF EXISTS vw_current_employee_directory;
DROP VIEW IF EXISTS vw_department_salary_summary;
DROP VIEW IF EXISTS vw_employee_attendance_summary;
DROP TABLE IF EXISTS performance_reviews;
DROP TABLE IF EXISTS salary_history;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(80) NOT NULL UNIQUE,
    location VARCHAR(100) NOT NULL,
    annual_budget DECIMAL(14,2) NOT NULL DEFAULT 0,
    CONSTRAINT chk_department_budget CHECK (annual_budget >= 0)
);

CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(60) NOT NULL,
    last_name VARCHAR(60) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    job_title VARCHAR(100) NOT NULL,
    department_id INT NOT NULL,
    hire_date DATE NOT NULL,
    employment_status ENUM('Active', 'On Leave', 'Resigned') NOT NULL DEFAULT 'Active',
    manager_id INT NULL,
    CONSTRAINT fk_employee_department
        FOREIGN KEY (department_id) REFERENCES departments(department_id),
    CONSTRAINT fk_employee_manager
        FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
        ON DELETE SET NULL,
    INDEX idx_employee_department (department_id),
    INDEX idx_employee_status (employment_status),
    INDEX idx_employee_hire_date (hire_date)
);

CREATE TABLE attendance (
    attendance_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    attendance_date DATE NOT NULL,
    attendance_status ENUM('Present', 'Absent', 'Leave', 'Holiday', 'Remote') NOT NULL,
    hours_worked DECIMAL(4,2) NOT NULL DEFAULT 0,
    CONSTRAINT fk_attendance_employee
        FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
        ON DELETE CASCADE,
    CONSTRAINT chk_hours_worked CHECK (hours_worked >= 0 AND hours_worked <= 24),
    CONSTRAINT uq_employee_attendance_date UNIQUE (employee_id, attendance_date),
    INDEX idx_attendance_date_status (attendance_date, attendance_status)
);

CREATE TABLE salary_history (
    salary_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    annual_salary DECIMAL(12,2) NOT NULL,
    effective_from DATE NOT NULL,
    effective_to DATE NULL,
    CONSTRAINT fk_salary_employee
        FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
        ON DELETE CASCADE,
    CONSTRAINT chk_annual_salary CHECK (annual_salary >= 0),
    CONSTRAINT chk_salary_dates CHECK (effective_to IS NULL OR effective_to >= effective_from),
    INDEX idx_salary_employee_dates (employee_id, effective_from, effective_to)
);

CREATE TABLE performance_reviews (
    review_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    review_date DATE NOT NULL,
    rating DECIMAL(3,1) NOT NULL,
    reviewer_comments VARCHAR(500),
    CONSTRAINT fk_review_employee
        FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
        ON DELETE CASCADE,
    CONSTRAINT chk_review_rating CHECK (rating >= 1.0 AND rating <= 5.0),
    INDEX idx_review_employee_date (employee_id, review_date)
);
