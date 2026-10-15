#include <cstdlib>
#include <iostream>
#include <stdexcept>
#include <string>

#include <mysqlx/xdevapi.h>

namespace {
std::string envOr(const char* key, const std::string& fallback = "") {
    const char* value = std::getenv(key);
    return value ? std::string(value) : fallback;
}

void listEmployees(mysqlx::Session& session) {
    auto result = session.sql(
        "SELECT employee_id, first_name, last_name, email, job_title "
        "FROM employee_workforce_analytics.employees "
        "ORDER BY employee_id"
    ).execute();

    std::cout << "\nEmployees\n";
    std::cout << "-------------------------------------------------------------\n";
    for (const auto& row : result.fetchAll()) {
        std::cout << row[0] << " | " << row[1] << " " << row[2]
                  << " | " << row[3] << " | " << row[4] << '\n';
    }
}

void addEmployee(mysqlx::Session& session) {
    std::string firstName, lastName, email, jobTitle;
    int departmentId = 0;

    std::cout << "First name (no spaces): ";
    std::cin >> firstName;
    std::cout << "Last name (no spaces): ";
    std::cin >> lastName;
    std::cout << "Email: ";
    std::cin >> email;
    std::cout << "Job title (use underscores instead of spaces): ";
    std::cin >> jobTitle;
    std::cout << "Department ID: ";
    std::cin >> departmentId;

    // Bound parameters avoid concatenating user data into the SQL statement.
    session.sql(
        "INSERT INTO employee_workforce_analytics.employees "
        "(first_name, last_name, email, job_title, department_id, hire_date) "
        "VALUES (?, ?, ?, ?, ?, CURRENT_DATE())"
    ).bind(firstName, lastName, email, jobTitle, departmentId).execute();

    std::cout << "Employee added successfully.\n";
}
}

int main() {
    const std::string host = envOr("DB_HOST", "127.0.0.1");
    const std::string user = envOr("DB_USER", "root");
    const std::string password = envOr("DB_PASSWORD");
    const unsigned int port = static_cast<unsigned int>(
        std::stoi(envOr("DB_PORT", "33060"))
    );

    if (password.empty()) {
        std::cerr << "Set DB_PASSWORD before running the application.\n";
        return 1;
    }

    try {
        mysqlx::Session session(host, port, user, password);

        while (true) {
            std::cout << "\nEmployee Workforce Analytics\n"
                      << "1. List employees\n"
                      << "2. Add employee\n"
                      << "0. Exit\n"
                      << "Choice: ";

            int choice = -1;
            if (!(std::cin >> choice)) {
                std::cerr << "Invalid input.\n";
                return 1;
            }

            if (choice == 0) break;
            if (choice == 1) listEmployees(session);
            else if (choice == 2) addEmployee(session);
            else std::cout << "Choose 0, 1, or 2.\n";
        }
    } catch (const std::exception& ex) {
        std::cerr << "Database error: " << ex.what() << '\n';
        return 1;
    }

    return 0;
}
