# Employee Management & Workforce Analytics System

A SQL-focused portfolio project using **MySQL 8.0+** to manage employee information and produce workforce analytics. The repository includes relational database design, sample data, reusable reports, and an optional C++ command-line application using MySQL Connector/C++.

## Features

- Relational schema for departments, employees, attendance, salary history, and performance reviews
- Primary keys, foreign keys, unique constraints, checks, and indexes
- Sample dataset for testing
- SQL reports using joins, aggregate functions, subqueries, CTEs, and window functions
- Views for common HR reports
- Optional C++ CLI for listing employees and adding employees with parameterized SQL

## Repository structure

```text
employee-workforce-analytics/
├── sql/
│   ├── 01_schema.sql
│   ├── 02_sample_data.sql
│   ├── 03_views.sql
│   └── 04_analytics_queries.sql
├── cpp/
│   ├── main.cpp
│   └── CMakeLists.txt
├── .gitignore
└── README.md
```

## Requirements

- MySQL 8.0 or newer
- MySQL Workbench or MySQL command-line client
- Optional C++ application: C++17 compiler, CMake, and MySQL Connector/C++

## Run the SQL project

1. Start your local MySQL server.
2. Open MySQL Workbench and run the following scripts in order:
   - `sql/01_schema.sql`
   - `sql/02_sample_data.sql`
   - `sql/03_views.sql`
3. Run selected reports from `sql/04_analytics_queries.sql`.

You can also run scripts in a terminal:

```bash
mysql -u root -p < sql/01_schema.sql
mysql -u root -p employee_workforce_analytics < sql/02_sample_data.sql
mysql -u root -p employee_workforce_analytics < sql/03_views.sql
```

## Optional C++ command-line app

The C++ application is an optional layer; the MySQL database is the core of this project.

1. Install MySQL Connector/C++ and CMake.
2. Check the connector's installed CMake package and target names; they can differ by version.
3. Set these environment variables before running the app: `DB_HOST` (default `127.0.0.1`), `DB_USER` (default `root`), `DB_PASSWORD` (required), `DB_NAME` (default `employee_workforce_analytics`), and `DB_PORT` (default `33060` for X Protocol).
4. Configure and build:

```bash
cmake -S cpp -B cpp/build
cmake --build cpp/build
```

Do not commit passwords, API keys, or other credentials to GitHub.

## Data model

- `departments`: department master data
- `employees`: employee details and department assignment
- `attendance`: daily attendance records
- `salary_history`: salary changes over time
- `performance_reviews`: periodic employee performance ratings

## Example business questions

- What is the average salary by department?
- Who are the top-paid employees in each department?
- Which employees have low attendance percentages?
- How has salary changed over time?
- Which departments have the largest headcount?
- What is the attendance status breakdown by month?

## Resume wording

Use only after running and testing the project:

**Employee Management & Workforce Analytics System** | MySQL, SQL, C++

- Designed a normalized MySQL database for employee records, departments, attendance, salary history, and performance reviews with relational constraints.
- Developed analytical SQL reports using joins, CTEs, subqueries, and window functions to generate workforce and salary insights.

If you complete and test the C++ integration, you can also mention the C++ command-line interface.
